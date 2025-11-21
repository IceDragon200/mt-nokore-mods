--- @namespace nokore_furnace
local mod = assert(nokore_furnace)
local get_meta = assert(tetra.get_meta)
local get_node_or_nil = assert(tetra.get_node_or_nil)
local swap_node = assert(tetra.swap_node)
local sound_play = assert(tetra.sound_play)
local find_node_near = assert(tetra.find_node_near)
local get_craft_result = assert(core.get_craft_result)
local fspec = assert(foundation.com.formspec.api)
local maybe_start_node_timer = assert(foundation.com.maybe_start_node_timer)
local Directions = assert(foundation.com.Directions)
local table_merge = assert(foundation.com.table_merge)
local ItemInterface
if rawget(_G, "yatm") then
  ItemInterface = yatm.items and yatm.items.ItemInterface
end

local FURNACE_ON_NAME = mod:make_name("furnace_on")
local FURNACE_OFF_NAME = mod:make_name("furnace_off")

--- @spec refresh_infotext(pos: Vector3)
function mod.refresh_infotext(pos)
  local meta = get_meta(pos)

  infotext = string.format("", "")

  meta:set_string("infotext", infotext)
end

--- @spec render_formspec(pos: Vector3, player: PlayerRef): String
function mod.render_formspec(pos, player)
  local spos = pos.x..","..pos.y..","..pos.z

  local pinv = player:get_inventory()

  local meta = get_meta(pos)

  local cio = fspec.calc_inventory_offset
  local cis = fspec.calc_inventory_size

  local padding = 0.5

  local cols = nokore_player_inv.player_hotbar_size
  local cw = cis(cols)

  local irows = 3
  local prows = math.ceil(pinv:get_size("main") / cols)

  local fw = cw + padding * 2
  local fh = cis(irows + prows) + padding * 4

  local iox = (fw - cio(3)) / 2

  local formspec =
    fspec.formspec_version(6)
    .. fspec.size(fw, fh)
    .. fspec.list(
      "nodemeta:" .. spos,
      "src",
      iox,
      padding,
      1,
      1
    )
    .. fspec.list(
      "nodemeta:" .. spos,
      "dst",
      iox + cio(2),
      padding,
      1,
      1
    )
    .. fspec.list(
      "nodemeta:" .. spos,
      "fuel",
      iox,
      padding + cis(2),
      1,
      1
    )
    .. nokore_player_inv.player_inventory_lists_fragment(
      player,
      padding,
      cis(irows) + padding * 3
    )
    .. fspec.list_ring()

  return formspec
end

local function migrate_inventory(pos)
  local meta = get_meta(pos)
  local inv = meta:get_inventory()

  local ver = meta:get_int("ver")

  if ver < 1 then
    --- we'll borrow minetest game's furnace conventions
    inv:set_size("src", 1)
    inv:set_size("fuel", 1)
    inv:set_size("dst", 1)
    ver = 1
  end
  meta:set_int("ver", ver)
end

local function add_or_drop_item(inv, pos, item_stack)
  local leftover = inv:add_item("dst", item_stack)
  if not leftover:is_empty() then
    local above = vector.offset(pos, 0, 1, 0)
    local drop_pos = find_node_near(pos, 1, {"air"}) or above
    core.item_drop(leftover, nil, drop_pos)
  end
end

--- @private:spec maybe_swap_node(pos: Vector3, node: NodeRef, new_name: String): void
local function maybe_swap_node(pos, node, new_name)
  if node.name ~= new_name then
    local new_node = {
      name = new_name,
      param1 = node.param1,
      param2 = node.param2,
    }

    swap_node(pos, new_node)
  end
end

local function on_furnace_cooked(pos, node, count)
  sound_play(
    "furnace_on_cooked",
    { pos = pos, max_hear_distance = 16, gain = 0.07 * math.min(count, 7) },
    true
  )
end

local function on_timer(pos, elapsed)
::setup::
  local node = get_node_or_nil(pos)
  local meta = get_meta(pos)
  local inv = meta:get_inventory()

  local has_recipe = meta:get_int("has_recipe")
  local has_fuel = meta:get_int("has_fuel")
  local dst_is_full = meta:get_int("dst_is_full")

  -- fuel time counts down
  local fuel_time = meta:get_float("fuel_time")
  local fuel_duration = meta:get_float("fuel_duration")
  local fuel_progress = meta:get_float("fuel_progress")

  local cook_time = meta:get_float("cook_time")
  local cook_duration = meta:get_float("cook_duration")

  -- Accumulated time allows us some error correction by "holding" time for use next tick
  -- If all goes well, this rarely grows, if not, well... we tick like a madman
  local acc_time = meta:get_float("acc_time")
  acc_time = acc_time + elapsed

  -- work time is how much the furnace is actually allowed to apply to cook_time, it is affected
  -- by the fuel's burn time (how much was actually burned this tick)
  local work_time = 0
  -- only allow 1 second per loop
  local burn_time = 0
  local src_list
  local cooked
  local after_cooked

  local cooked_count = 0

::prepare_recipe::
  src_list = inv:get_list("src")
  cooked, after_cooked = get_craft_result({
    method = "cooking",
    width = 1,
    items = src_list,
  })

  if cooked.time > 0 or not cooked.item:is_empty() then
    cook_duration = cooked.time
    has_recipe = 1
  else
    cook_duration = 0
    has_recipe = 0
  end

::prepare_burn_time::
  burn_time = math.min(acc_time, 1)
  acc_time = acc_time - burn_time

::burn_fuel::
  -- As long as the fuel time is non-zero, continue burning the fuel, we aren't factorio sadly.
  if has_fuel > 0 then
    local new_fuel_time = fuel_time + burn_time
    if new_fuel_time >= fuel_duration then
      -- leave only the excess fuel time
      new_fuel_time = new_fuel_time - fuel_duration
      -- with the excess left, take that from the burn time, which gives us how much was actually
      -- used, and add that to the available work time
      work_time = work_time + (burn_time - new_fuel_time)
      -- restore the excess burn time from the new_fuel_time
      burn_time = new_fuel_time
      new_fuel_time = 0
      -- and zero the fuel time, since we've exhausted it
      fuel_time = 0
      has_fuel = 0
    else
      fuel_time = new_fuel_time
      new_fuel_time = 0
      work_time = work_time + burn_time
      burn_time = 0
    end
  elseif burn_time > 0 then
    -- check if we actually need to burn fuel and the destination isn't jammed
    if has_recipe > 0 and dst_is_full == 0 then
      -- if we still have burn time, try consuming more fuel
      local fuel_list = inv:get_list("fuel")
      local fuel, after_fuel =
        get_craft_result({ method = "fuel", width = 1, items = fuel_list })

      -- fuel is only useful if it has a time, the resulant item doesn't matter unlike with cooking
      if fuel.time > 0 then
        -- we have valid fuel!
        local alt_fuel =
          get_craft_result({
            method = "fuel",
            width = 1,
            items = {after_fuel.items[1]:to_string()}
          })

        if alt_fuel and alt_fuel.time > 0 then
          -- okay so the after fuel is still fuel, good to know
          inv:set_stack("fuel", 1, after_fuel.items[1])
        else
          -- nope, it's not fuel, so we'll need to clear our existing fuel and dump the rest
          add_or_drop_item(inv, pos, after_fuel.items[1])
          inv:set_stack("fuel", 1, "")
        end

        if next(fuel.replacements) then
          for _, item in ipairs(fuel.replacements) do
            add_or_drop_item(inv, pos, item)
          end
        end

        fuel_duration = fuel.time
        -- fuel_time should reset
        fuel_time = 0
        has_fuel = 1
        -- repeat this burn logic until we run out of burn time
        goto burn_fuel
      else
        -- no fuel
        has_fuel = 0
        fuel_duration = 0
        fuel_time = 0
      end
    else
      -- No fuel needed, or the destination is full
      has_fuel = 0
      fuel_duration = 0
      fuel_time = 0
    end
  end

  -- informational
  if fuel_duration > 0 then
    fuel_progress = fuel_time / fuel_duration
  else
    fuel_progress = 0.0
  end

::cook_src::
  if has_recipe > 0 and work_time > 0 then
    local new_cook_time = cook_time + work_time
    if new_cook_time >= cook_duration then
      -- we are cooked, like in a good way
      new_cook_time = new_cook_time - cook_duration
      cook_time = cook_duration
      work_time = new_cook_time
      goto cook_finalize
    else
      -- we are still cooking...
      cook_time = new_cook_time
      work_time = 0
      goto check_loop
    end
  end

  goto commit

::cook_finalize::
  if inv:room_for_item("dst", cooked.item) then
    dst_is_full = 0
    inv:add_item("dst", cooked.item)

    local leftover = after_cooked.items[1]

    if leftover:is_empty() then
      inv:set_stack("src", 1, leftover)
    else
      local cookable = get_craft_result({
        method = "cooking",
        width = 1,
        items = {leftover:to_string()}
      })

      if cookable.time > 0 or not cookable.item:is_empty() then
        inv:set_stack("src", 1, leftover)
      else
        inv:set_stack("src", 1, "")
        add_or_drop_item(inv, pos, leftover)
      end
    end

    if next(cooked.replacements) then
      for _, item in ipairs(cooked.replacements) do
        add_or_drop_item(inv, pos, item)
      end
    end

    cooked_count = cooked_count + 1
  else
    dst_is_full = 1
    goto commit
  end

::check_loop::
  if acc_time > 0 then
    goto prepare_recipe
  end

::commit::
  meta:set_int("has_fuel", has_fuel)
  meta:set_int("has_recipe", has_recipe)
  meta:set_int("dst_is_full", dst_is_full)
  meta:set_float("fuel_time", fuel_time)
  meta:set_float("fuel_duration", fuel_duration)
  meta:set_float("fuel_progress", fuel_progress)
  meta:set_float("cook_time", cook_time)
  meta:set_float("cook_duration", cook_duration)
  meta:set_float("acc_time", acc_time)

  if cooked_count > 0 then
    --
    on_furnace_cooked(pos, node, cooked_count)
  end

  if fuel_duration > 0 then
    maybe_swap_node(pos, node, FURNACE_ON_NAME)
    -- as long as we have fuel to burn, keep going
    return true
  else
    maybe_swap_node(pos, node, FURNACE_OFF_NAME)
    return false
  end
end

local function on_construct(pos)
  migrate_inventory(pos)
  on_timer(pos, 0)
end

local function on_destruct(pos)
  --
end

local function on_rightclick(pos, node, player, item_stack, pointed_thing)
  local id = core.pos_to_string(pos)
  local options = {
    state = {
      pos = pos,
      id = id,
    },
  }
  migrate_inventory(pos)
  nokore.formspec_bindings:show_formspec(
    player:get_player_name(),
    mod:make_name("furnace"),
    mod.render_formspec(pos, player),
    options
  )
  return item_stack
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
  if listname == "fuel" then
    if mod.is_item_stack_fuel(stack) then
      return stack:get_count()
    end
    return 0
  elseif listname == "dst" then
    return 0
  end
  return stack:get_count()
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
  return stack:get_count()
end

local function allow_metadata_inventory_move(
  pos,
  from_list,
  from_index,
  to_list,
  to_index,
  count,
  player
)
  if to_list == "dst" then
    return 0
  elseif to_list == "fuel" then
    -- TODO: maybe check that the item being moved is a valid fuel,
    -- unless put and take trigger here for movement within the same inventory, unlikely.
    return count
  end
  return count
end

local function on_metadata_inventory_move(
  pos,
  from_list,
  from_index,
  to_list,
  to_index,
  count,
  player
)
  maybe_start_node_timer(pos, 1.0)
end

local function on_metadata_inventory_put(pos, listname, index, stack, player)
  maybe_start_node_timer(pos, 1.0)
end

local function on_metadata_inventory_take(pos, listname, index, stack, player)
  maybe_start_node_timer(pos, 1.0)
end

local groups = {
  cracky = nokore.dig_class("wood"),
  furnace = 1,
  mat_stone = 1,
}

local item_interface
if ItemInterface then
  item_interface = ItemInterface.new_directional(function (self, pos, dir)
    local node = get_node_or_nil(pos)
    local new_dir = Directions.facedir_to_face(node.param2, dir)

    if new_dir == Directions.D_UP then
      return "src"
    elseif new_dir == Directions.D_DOWN then
      return "fuel"
    else
      return "dst"
    end
  end)

  function item_interface:allow_insert_item(pos, dir, item_stack)
    local node = get_node_or_nil(pos)
    local new_dir = Directions.facedir_to_face(node.param2, dir)

    if new_dir == Directions.D_UP then
      -- input_slot
      local result, leftovers =
        core.get_craft_result({
          method = "cooking",
          width = 1,
          items = {item_stack}
        })

      return not result.item:is_empty()
    elseif new_dir == Directions.D_DOWN then
      local result, leftovers =
        core.get_craft_result({
          method = "fuel",
          width = 1,
          items = {item_stack}
        })

      return result.time > 0
    end

    -- only the src and fuel can be inserted to, deny everything else
    return false
  end

  function item_interface:allow_extract_item(pos, dir, item_stack)
    -- All directions can be extracted from, if need be
    return true
  end

  -- enable the item interface groups
  groups.item_interface_in = 1
  groups.item_interface_out = 1
end

mod:register_node("furnace_off", {
  base_description = mod.S("Furnace"),
  description = mod.S("Furnace"),

  groups = groups,

  is_ground_content = false,

  tiles = {
    "nokore_furnace_top.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_front_off.png",
  },
  use_texture_alpha = "opaque",

  paramtype2 = "facedir",

  on_timer = on_timer,

  on_construct = on_construct,
  on_destruct = on_destruct,

  on_rightclick = on_rightclick,

  allow_metadata_inventory_move = allow_metadata_inventory_move,
  allow_metadata_inventory_put = allow_metadata_inventory_put,
  allow_metadata_inventory_take = allow_metadata_inventory_take,

  on_metadata_inventory_move = on_metadata_inventory_move,
  on_metadata_inventory_put = on_metadata_inventory_put,
  on_metadata_inventory_take = on_metadata_inventory_take,
})

mod:register_node("furnace_on", {
  base_description = mod.S("Furnace"),
  description = mod.S("Furnace"),

  groups = table_merge(groups, {
    not_in_creative_inventory = 1,
  }),

  is_ground_content = false,

  tiles = {
    "nokore_furnace_top.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_front_on.png",
  },
  use_texture_alpha = "opaque",

  paramtype = "light",
  paramtype2 = "facedir",
  sunlight_propagates = false,
  light_source = 10,

  on_timer = on_timer,

  on_construct = on_construct,
  on_destruct = on_destruct,

  on_rightclick = on_rightclick,

  allow_metadata_inventory_move = allow_metadata_inventory_move,
  allow_metadata_inventory_put = allow_metadata_inventory_put,
  allow_metadata_inventory_take = allow_metadata_inventory_take,

  on_metadata_inventory_move = on_metadata_inventory_move,
  on_metadata_inventory_put = on_metadata_inventory_put,
  on_metadata_inventory_take = on_metadata_inventory_take,
})
