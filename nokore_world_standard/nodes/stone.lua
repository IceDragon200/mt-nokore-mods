local mod = nokore_world_standard

mod:register_node("stone", {
  description = mod.S("Stone"),

  groups = {cracky = 3, stone = 1},

  tiles = {
    "default_stone.png"
  },

  drop = "nokore_world_standard:cobblestone",

  sounds = nokore.node_sounds:build("stone"),
})
