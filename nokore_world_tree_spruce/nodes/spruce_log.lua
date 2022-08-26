local mod = nokore_world_tree_spruce

mod:register_node("spruce_log", {
  description = mod.S("Spruce Log"),

  groups = {
    choppy = nokore.dig_class("wme"),
    log = 1,
    flammable = 2,
  },

  tiles = {
    "nokore_log_spruce_top.png",
    "nokore_log_spruce_top.png",
    "nokore_log_spruce.png",
  },

  paramtype2 = "facedir",

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),

  on_place = minetest.rotate_node,
})
