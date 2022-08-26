local mod = nokore_world_tree_birch

mod:register_node("birch_log", {
  description = mod.S("Birch Log"),

  groups = {
    choppy = nokore.dig_class("wme"),
    log = 1,
    flammable = 2,
  },

  tiles = {
    "nokore_log_birch_top.png",
    "nokore_log_birch_top.png",
    "nokore_log_birch.png",
  },

  paramtype2 = "facedir",

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),

  on_place = minetest.rotate_node,
})
