local mod = nokore_world_tree_acacia

mod:register_node("acacia_planks", {
  description = mod.S("Acacia Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_acacia.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})
