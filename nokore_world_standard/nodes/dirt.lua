local mod = nokore_world_standard

mod:register_node("dirt", {
  description = mod.S("Dirt"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    soil = 1,
  },

  tiles = {
    "world_dirt.png"
  },

  sounds = nokore.node_sounds:build("dirt"),
})

mod:register_node("dry_dirt", {
  description = mod.S("Savanna Dirt"),

  groups = {
    crumbly = nokore.dig_class("stone"),
    soil = 1,
  },

  tiles = {
    "world_dry_dirt.png",
  },
  sounds = nokore.node_sounds:build("dirt"),
})
