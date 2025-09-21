local mod = assert(nokore_world_silver)

mod:register_node("stone_with_silver", {
  description = mod.S("Stone with Silver"),

  groups = {
    cracky = nokore.dig_class("bronze"),
  },

  drop = "nokore_world_silver:silver_lump",

  tiles = {
    "world_stone.png^world_mineral_silver.png",
  },
})
