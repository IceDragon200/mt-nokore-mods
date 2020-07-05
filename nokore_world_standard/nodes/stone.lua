local mod = nokore_world_standard

mod:register_node("stone", {
  description = mod.S("Stone"),

  groups = {cracky = 3, stone = 1},

  tiles = {
    "world_stone.png"
  },

  drop = "nokore_world_standard:cobblestone",

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("desert_stone", {
  description = mod.S("Desert Stone"),

  groups = {cracky = 3, stone = 1},

  tiles = {
    "world_desert_stone.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})
