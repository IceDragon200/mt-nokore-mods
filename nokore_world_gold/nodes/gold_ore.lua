local mod = nokore_world_gold

mod:register_node("stone_with_gold", {
  description = mod.S("Gold Ore"),

  groups = {
    cracky = nokore.dig_class("bronze"),
  },

  drop = "nokore_world_gold:gold_lump",

  tiles = {
    "world_stone.png^world_mineral_gold.png",
  },
})
