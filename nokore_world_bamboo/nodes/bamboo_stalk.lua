local mod = nokore_world_bamboo
local table_copy = assert(foundation.com.table_copy)
local Cuboid = assert(foundation.com.Cuboid)
local ng = assert(Cuboid.new_fast_node_box)
local Vector3 = assert(foundation.com.Vector3)
local Directions = assert(foundation.com.Directions)
local V3_UP = assert(Directions.V3_UP)

mod:register_node("bamboo_stalk", {
  description = mod.S("Bamboo Stalk"),

  groups = {
    stalk = 1,
    choppy = 2,
    oddly_breakable_by_hand = 1,
    flammable = 2,
  },

  drawtype = "nodebox",

  node_box = {
    type = "fixed",
    fixed = {
      ng(5, 0, 5, 6, 16, 6),
    }
  },

  selection_box = {
    type = "fixed",
    fixed = {
      ng(4, 0, 4, 8, 16, 8),
    }
  },

  use_texture_alpha = "opaque",
  tiles = {
    "nokore_bamboo_stalk_top.png",
    "nokore_bamboo_stalk_top.png",
    "nokore_bamboo_stalk.png",
  },

  paramtype = "light",
  paramtype2 = "facedir",

  is_ground_content = false,

  sunlight_propagates = true,

  sounds = nokore.node_sounds:build("bamboo"),

  on_place = minetest.rotate_node,

  after_dig_node = function (pos, old_node, _old_meta, digger)
    local next_pos = Vector3.add(table_copy(pos), pos, V3_UP)
    local next_node = minetest.get_node_or_nil(next_pos)
    if next_node.name == old_node.name then
      minetest.node_dig(next_pos, next_node, digger)
    end
  end,
})
