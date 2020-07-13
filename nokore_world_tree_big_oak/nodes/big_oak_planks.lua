local mod = nokore_world_tree_big_oak

mod:register_node("big_oak_planks", {
  description = mod.S("Big Oak Planks"),

  groups = {
    choppy = 2,
    oddly_breakable_by_hand = 2,
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_big_oak.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})
