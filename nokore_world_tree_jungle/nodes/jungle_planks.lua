local mod = nokore_world_tree_jungle

mod:register_node("jungle_planks", {
  description = mod.S("Jungle Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    --
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_jungle.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})
