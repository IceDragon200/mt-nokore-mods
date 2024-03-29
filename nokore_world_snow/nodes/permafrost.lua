local mod = nokore_world_snow

mod:register_node("permafrost", {
  description = mod.S("Permafrost"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  use_texture_alpha = "opaque",
  tiles = {
    "world_permafrost.png",
  },

  sounds = nokore.node_sounds:build("dirt"),
})

mod:register_node("permafrost_with_stones", {
  description = mod.S("Permafrost with Stones"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  use_texture_alpha = "opaque",
  tiles = {
    "world_permafrost.png^world_stones.png",
    "world_permafrost.png",
    "world_permafrost.png^world_stones_side.png",
  },

  sounds = nokore.node_sounds:build("gravel"),
})
