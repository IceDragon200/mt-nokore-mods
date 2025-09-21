local mod = assert(nokore_world_standard)

mod:register_node("andesite", {
  description = mod.S("Andesite"),

  groups = {
    cracky = nokore.dig_class("wood"),
    --
    stone = 2,
  },

  tiles = {
    "world_andesite.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})
