local mod = nokore_world_tree_willow

mod:register_node("willow_log", {
  description = mod.S("Willow Log"),

  groups = {
    choppy = nokore.dig_class("wme"),
    log = 1,
    flammable = 2,
  },

  tiles = {
    "nokore_log_willow_top.png",
    "nokore_log_willow_top.png",
    "nokore_log_willow.png",
  },

  paramtype2 = "facedir",

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),

  on_place = minetest.rotate_node,
})
