local mod = nokore_world_clay

-- boring clay block
mod:register_node("block", {
  description = mod.S("Clay"),

  groups = {crumbly = 3},

  tiles = {
    "world_clay.png"
  },

  drop = "default:clay_lump 4",
  sounds = nokore.node_sounds:build("clay"),
})
