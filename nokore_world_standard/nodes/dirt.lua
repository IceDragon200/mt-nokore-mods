local mod = nokore_world_standard

mod:register_node("dirt", {
  description = mod.S("Stone"),

  groups = {crumbly = 3, soil = 1},

  tiles = {
    "world_dirt.png"
  },

  sounds = nokore.node_sounds:build("dirt"),
})
