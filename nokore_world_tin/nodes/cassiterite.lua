local mod = assert(nokore_world_tin)

mod:register_node("cassiterite", {
  description = mod.S("Cassiterite"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  drop = "nokore_world_tin:tin_lump 4",

  tiles = {
    "world_cassiterite.png",
  },
})

