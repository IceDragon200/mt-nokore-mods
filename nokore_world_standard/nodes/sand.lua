local mod = nokore_world_standard

-- Normal everyday sand
mod:register_node("sand", {
  description = mod.S("Sand"),

  groups = { crumbly = 3, falling_node = 1, sand = 1 },

  tiles = {
    "world_desert_sand.png",
  },

  sounds = nokore.node_sounds:build("sand"),
})

-- Desert sand
mod:register_node("desert_sand", {
  description = mod.S("Desert Sand"),

  groups = { crumbly = 3, falling_node = 1, sand = 1 },

  tiles = {
    "world_desert_sand.png",
  },

  sounds = nokore.node_sounds:build("sand"),
})
