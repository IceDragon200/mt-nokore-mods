local mod = assert(nokore_world_standard)

mod:register_node("granite", {
  description = mod.S("Granite"),

  groups = {
    cracky = nokore.dig_class("wood"),
    --
    stone = 2,
  },

  tiles = {
    "world_granite.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})
