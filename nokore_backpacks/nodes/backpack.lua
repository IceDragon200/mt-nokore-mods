local mod = assert(nokore_backpacks)

local is_blank = assert(foundation.com.is_blank)
local InventorySerializer = assert(foundation.com.InventorySerializer)

local function on_construct(pos)
  local meta = core.get_meta(pos)
  local inv = meta:get_inventory()

  inv:set_size("main", mod.get_backpack_inventory_size())
end

local function after_place_node(pos, placer, item_stack, pointed_thing)
  local target_meta = core.get_meta(pos)
  local source_meta = item_stack:get_meta()

  local target_inv = target_meta:get_inventory()

  local source_inv_list = source_meta:get_string("inventory_dump")

  if not is_blank(source_inv_list) then
    local dumped = core.deserialize(source_inv_list)
    local list = target_inv:get_list("main")
    list = InventorySerializer.load_list(dumped, list)
    target_inv:set_list("main", list)
  end
end

local function preserve_metadata(pos, _old_node, _old_meta_table, drops)
  local stack = drops[1]

  local old_meta = core.get_meta(pos)
  local new_meta = stack:get_meta()

  local old_inv = old_meta:get_inventory()
  local list = old_inv:get_list("main")

  local dumped = InventorySerializer.dump_list(list)

  --print("preserve_metadata", dump(dumped))
  new_meta:set_string("inventory_dump", core.serialize(dumped))
  local description = "Backpack (" .. InventorySerializer.description(dumped) .. ")"
  new_meta:set_string("description", description)
end

local function on_blast(pos)
  local drops = {}
  drops[1] = mod:make_name("backpack")
  foundation.com.get_inventory_drops(pos, "main", drops)
  core.remove_node(pos)
  return drops
end

local function on_rightclick(pos, node, player, itemstack, pointed_thing)
  nokore.formspec_bindings:show_formspec(
    player:get_player_name(),
    "nokore_backpacks:backpack",
    mod.render_formspec(pos, player)
  )
  return itemstack
end

-- Just a general purpose backpack
mod:register_node("backpack", {
  description = mod.S("Backpack"),

  groups = {
    cracky = nokore.dig_class("copper"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
    --
    backpack = 1,
  },

  stack_max = 1,

  paramtype = "light",
  paramtype2 = "facedir",

  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      {-7/16,-8/16,-6/16,7/16,8/16,7/16}, -- body
      {-5/16,-6/16,-8/16,5/16,2/16,-6/16}, -- front pocket
      {-6/16,-7/16,7/16,-4/16,7/16,8/16}, -- left strap
      {4/16,-7/16,7/16,6/16,7/16,8/16}, -- right strap
    }
  },

  tiles = {
    "nokore_backpack_top.png",
    "nokore_backpack_bottom.png",
    "nokore_backpack_side.png",
    "nokore_backpack_side.png^[transformFX",
    "nokore_backpack_back.png",
    "nokore_backpack_front.png",
  },

  on_construct = on_construct,

  after_place_node = after_place_node,

  preserve_metadata = preserve_metadata,

  on_blast = on_blast,

  on_rightclick = on_rightclick,
})
