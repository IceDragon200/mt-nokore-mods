local mod = nokore_world_standard

-- Normal everyday sandstone
mod:register_node("sandstone", {
  description = mod.S("Sandstone"),

  groups = { cracky = 3, stone = 1 },

  tiles = {
    "world_sandstone.png",
  },

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("silver_sandstone", {
  description = mod.S("Silver Sandstone"),

  groups = { cracky = 3, stone = 1 },

  tiles = {
    "world_silver_sandstone.png",
  },

  sounds = nokore.node_sounds:build("stone"),
})
