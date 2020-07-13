local mod = nokore_world_tree_sakura

mod:register_node("sakura_planks", {
  description = mod.S("Sakura Planks"),

  groups = {
    choppy = 2,
    oddly_breakable_by_hand = 2,
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_sakura.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})
