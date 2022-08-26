local mod = nokore_world_tin

mod:register_node("stone_with_tin", {
  description = mod.S("Tin Ore"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  drop = "nokore_world_tin:tin_lump",

  tiles = {
    "world_stone.png^world_mineral_tin.png",
  },
})
