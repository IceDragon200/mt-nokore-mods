local mod = assert(nokore_world_standard)

mod:register_node("diorite", {
  description = mod.S("Diorite"),

  groups = {
    cracky = nokore.dig_class("wood"),
    --
    stone = 2,
  },

  tiles = {
    "world_diorite.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})
