local mod = assert(nokore_backpacks)

local fspec = assert(foundation.com.formspec.api)
local is_blank = assert(foundation.com.is_blank)
local InventorySerializer = assert(foundation.com.InventorySerializer)

local function render_formspec(pos, player)
  local spos = pos.x..","..pos.y..","..pos.z

  local formspec =
    fspec.formspec_version(6) ..
    fspec.size(13, 13) ..
    fspec.list("nodemeta:"..spos, "main", 0.375, 0.5, 10, 4) ..
    nokore_player_inv.player_inventory_lists_fragment(player, 0.375, 6) ..
    fspec.listring()

  return formspec
end

-- Just a general purpose backpack
mod:register_node("backpack", {
  description = "Backpack",

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

  on_construct = function (pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()

    inv:set_size("main", 40)
  end,

  after_place_node = function (pos, placer, item_stack, pointed_thing)
    local target_meta = minetest.get_meta(pos)
    local source_meta = item_stack:get_meta()

    local target_inv = target_meta:get_inventory()

    local source_inv_list = source_meta:get_string("inventory_dump")

    if not is_blank(source_inv_list) then
      local dumped = minetest.deserialize(source_inv_list)
      local list = target_inv:get_list("main")
      list = InventorySerializer.load_list(dumped, list)
      target_inv:set_list("main", list)
    end
  end,

  preserve_metadata = function (pos, _old_node, _old_meta_table, drops)
    local stack = drops[1]

    local old_meta = minetest.get_meta(pos)
    local new_meta = stack:get_meta()

    local old_inv = old_meta:get_inventory()
    local list = old_inv:get_list("main")

    local dumped = InventorySerializer.dump_list(list)

    --print("preserve_metadata", dump(dumped))
    new_meta:set_string("inventory_dump", minetest.serialize(dumped))
    local description = "Backpack (" .. InventorySerializer.description(dumped) .. ")"
    new_meta:set_string("description", description)
  end,

  on_blast = function (pos)
    local drops = {}
    drops[1] = mod:make_name("backpack")
    foundation.com.get_inventory_drops(pos, "main", drops)
    minetest.remove_node(pos)
    return drops
  end,

  on_rightclick = function (pos, node, player, itemstack, pointed_thing)
    minetest.show_formspec(
      player:get_player_name(),
      "nokore_backpacks:backpack",
      render_formspec(pos, player)
    )
    return itemstack
  end,
})
