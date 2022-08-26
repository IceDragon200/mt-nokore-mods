local mod = nokore_world_tree_fir

mod:register_node("fir_log", {
  description = mod.S("Fir Log"),

  groups = {
    choppy = nokore.dig_class("wme"),
    log = 1,
    flammable = 2,
  },

  tiles = {
    "nokore_log_fir_top.png",
    "nokore_log_fir_top.png",
    "nokore_log_fir.png",
  },

  paramtype2 = "facedir",

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),

  on_place = minetest.rotate_node,
})
