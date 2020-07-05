local mod = nokore_world_standard

mod:register_node("cobblestone", {
  description = mod.S("Cobblestone"),

  groups = {cracky = 3, stone = 2},

  tiles = {
    "world_cobblestone.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("mossy_cobblestone", {
  description = mod.S("Mossy Cobblestone"),

  groups = {cracky = 3, stone = 2},

  tiles = {
    "world_mossy_cobblestone.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})
