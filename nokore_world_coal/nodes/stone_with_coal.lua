local mod = assert(nokore_world_coal)

mod:register_node("stone_with_coal", {
  description = mod.S("Coal Ore"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  drop = "nokore_world_coal:coal_lump",

  tiles = {
    "world_stone.png^world_mineral_coal.png",
  },
})
