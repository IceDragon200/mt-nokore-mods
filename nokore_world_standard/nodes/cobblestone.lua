local mod = nokore_world_standard

mod:register_node("cobblestone", {
  description = mod.S("Stone"),

  groups = {cracky = 3, stone = 2},

  tiles = {
    "world_cobblestone.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})
