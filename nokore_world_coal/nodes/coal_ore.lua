local mod = nokore_world_coal

mod:register_node("stone_with_coal", {
  description = mod.S("Coal Ore"),

  groups = {
    cracky = 2,
  },

  drop = "nokore_world_coal:coal_lump",

  tiles = {
    "world_stone.png^world_mineral_coal.png",
  },
})
