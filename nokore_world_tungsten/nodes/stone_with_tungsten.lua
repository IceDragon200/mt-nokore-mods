local mod = assert(nokore_world_tungsten)

mod:register_node("stone_with_tungsten", {
  description = mod.S("Stone with Tungsten"),

  groups = {
    cracky = nokore.dig_class("iron"),
  },

  drop = "nokore_world_tungsten:tungsten_lump",

  tiles = {
    "world_stone.png^world_mineral_tungsten.png",
  },
})
