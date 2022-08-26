local mod = nokore_world_tree_birch

mod:register_node("birch_planks", {
  description = mod.S("Birch Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    --
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_birch.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})
