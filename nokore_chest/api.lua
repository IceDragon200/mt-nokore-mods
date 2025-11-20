--- @namespace nokore_chest
local mod = assert(nokore_chest)
local get_meta = assert(tetra.get_meta)
local node_dig = assert(tetra.node_dig)
local get_node_or_nil = assert(tetra.get_node_or_nil)
local swap_node = assert(tetra.swap_node)

local fspec = assert(foundation.com.formspec.api)

--- @const open_chests: { [Integer]: Any }
mod.open_chests = {}

--- @overridable
--- @spec get_chest_inventory_size(): Integer
function mod.get_chest_inventory_size()
  return nokore_player_inv.player_hotbar_size * 4
end

--- @spec chest_on_construct(pos): void
function mod.chest_on_construct(pos)
  local meta = get_meta(pos)
  local inv = meta:get_inventory()

  inv:set_size("main", mod.get_chest_inventory_size())
end

function mod.chest_after_destruct(pos)
  --
end

function mod.chest_can_dig(pos)
  local meta = get_meta(pos)
  local inv = meta:get_inventory()

  if not inv:is_empty("main") then
    return false
  end

  return node_dig(pos, node, puncher)
end

--- @overridable
--- @spec render_formspec(pos: Vector3, PlayerRef): String
function mod.render_formspec(pos, player)
  local spos = pos.x..","..pos.y..","..pos.z

  local pinv = player:get_inventory()

  local meta = get_meta(pos)
  local inv = meta:get_inventory()
  local inv_size = inv:get_size("main")

  local cio = fspec.calc_inventory_offset
  local cis = fspec.calc_inventory_size

  local padding = 0.5

  local cols = nokore_player_inv.player_hotbar_size
  local cw = cis(cols)

  local irows = math.ceil(inv_size / cols)
  local prows = math.ceil(pinv:get_size("main") / cols)

  local fw = cw + padding * 2
  local fh = cis(irows + prows) + padding * 4

  local formspec =
    fspec.formspec_version(6)
    .. fspec.size(fw, fh)
    .. fspec.list(
      "nodemeta:" .. spos,
      "main",
      padding,
      padding,
      cols,
      irows
    )
    .. nokore_player_inv.player_inventory_lists_fragment(
      player,
      padding,
      cis(irows) + padding * 3
    )
    .. fspec.list_ring()

  return formspec
end

function mod.on_formspec_quit(player, form_name, fields, state)
  local player_name = player:get_player_name()
  local chest_id = state.chest_id

  if mod.open_chests[chest_id] then
    mod.open_chests[chest_id][player_name] = nil

    if not next(mod.open_chests[chest_id]) then
      mod.open_chests[chest_id] = nil

      local node = get_node_or_nil(state.pos)
      if node then
        local nodedef = core.registered_nodes[node.name]
        swap_node(state.pos, { name = nodedef.node_states.closed, param2 = node.param2 })

        core.log("action", player:get_player_name() .. " closed chest at=" .. chest_id)
      end
    else
      -- there are still
      print("someone is still looking in the chest")
    end
  end
end

function mod.maybe_open_chest(pos, player)
  local chest_id = core.pos_to_string(pos)

  if not mod.open_chests[chest_id] then
    mod.open_chests[chest_id] = {}

    local node = get_node_or_nil(pos)
    if node then
      local nodedef = core.registered_nodes[node.name]
      swap_node(pos, { name = nodedef.node_states.opened, param2 = node.param2 })

      core.log("action", player:get_player_name() .. " opened chest at=" .. chest_id)
    end
  end
  mod.open_chests[chest_id][player:get_player_name()] = true
end

function mod.chest_on_rightclick(pos, _node, player, item_stack, _pointed_thing)
  --
  local chest_id = core.pos_to_string(pos)
  local options = {
    state = {
      pos = pos,
      chest_id = chest_id,
    },
    on_quit = mod.on_formspec_quit,
  }
  nokore.formspec_bindings:show_formspec(
    player:get_player_name(),
    "nokore_chest:chest",
    mod.render_formspec(pos, player),
    options
  )

  mod.maybe_open_chest(pos, player)
  return item_stack
end

--- @spec #register_chest(name: String, base: Table): void
function mod:register_chest(name, base)
  local def = table.copy(base)

  def.paramtype = "light"
  def.paramtype2 = "facedir"
  def.is_ground_content = false

  def.description = def.description or self.S("Chest")

  def.on_construct = def.on_construct or mod.chest_on_construct
  def.after_destruct = def.after_destruct or mod.chest_after_destruct
  def.can_dig = def.can_dig or mod.chest_can_dig
  def.on_rightclick = def.on_rightclick or mod.chest_on_rightclick

  def.node_states = {
    closed = name .. "_closed",
    opened = name .. "_opened",
  }

  local closed_def = table.copy(def)
  local opened_def = table.copy(def)

  opened_def.visual = "mesh"
  opened_def.drawtype = "mesh"
  opened_def.mesh = "nokore_chest_open.obj"

  for i = 1, #opened_def.tiles do
    if type(opened_def.tiles[i]) == "string" then
      opened_def.tiles[i] = {
        name = opened_def.tiles[i],
        backface_culling = true
      }
    elseif opened_def.tiles[i].backface_culling == nil then
      opened_def.tiles[i].backface_culling = true
    end
  end

  opened_def.drop = def.node_states.closed

  opened_def.groups.not_in_creative_inventory = 1

  opened_def.selection_box = {
    type = "fixed",
    fixed = { -1/2, -1/2, -1/2, 1/2, 3/16, 1/2 },
  }

  opened_def.can_dig = function()
    return false
  end

  opened_def.on_blast = function()
    --
  end

  closed_def.tiles[6] = def.tiles[5] -- swap textures around for "normal"
  closed_def.tiles[5] = def.tiles[3] -- drawtype to make them match the mesh
  closed_def.tiles[3] = def.tiles[3].."^[transformFX"

  core.register_node(def.node_states.closed, closed_def)
  core.register_node(def.node_states.opened, opened_def)
end
