local mod = nokore_world_copper

mod:register_node("stone_with_copper", {
  description = mod.S("Stone with Copper"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  drop = "nokore_world_copper:copper_lump",

  tiles = {
    "world_stone.png^world_mineral_copper.png",
  },
})
