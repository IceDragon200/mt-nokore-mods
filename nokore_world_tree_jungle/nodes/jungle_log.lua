local mod = nokore_world_tree_jungle

mod:register_node("jungle_log", {
  description = mod.S("Jungle Log"),

  groups = {
    choppy = nokore.dig_class("wme"),
    log = 1,
    flammable = 2,
  },

  tiles = {
    "nokore_log_jungle_top.png",
    "nokore_log_jungle_top.png",
    "nokore_log_jungle.png",
  },

  paramtype2 = "facedir",

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),

  on_place = minetest.rotate_node,
})
