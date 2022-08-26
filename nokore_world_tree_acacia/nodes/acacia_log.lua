local mod = nokore_world_tree_acacia

mod:register_node("acacia_log", {
  description = mod.S("Acacia Log"),

  groups = {
    choppy = nokore.dig_class("wme"),
    --
    log = 1,
    flammable = 2,
  },

  tiles = {
    "nokore_log_acacia_top.png",
    "nokore_log_acacia_top.png",
    "nokore_log_acacia.png",
  },

  paramtype2 = "facedir",

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),

  on_place = minetest.rotate_node,
})
