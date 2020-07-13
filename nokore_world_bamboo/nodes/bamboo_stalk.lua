local mod = nokore_world_bamboo

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
      -5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16
    }
  },

  selection_box = {
    type = "fixed",
    fixed = {
      -7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16
    }
  },

  tiles = {
    "nokore_bamboo_stalk_top.png",
    "nokore_bamboo_stalk_top.png",
    "nokore_bamboo_stalk.png",
  },

  paramtype2 = "facedir",

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),

  on_place = minetest.rotate_node,
})
