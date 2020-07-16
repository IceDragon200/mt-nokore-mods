local mod = nokore_world_copper

mod:register_node("stone_with_copper", {
  description = mod.S("Copper Ore"),

  groups = {
    cracky = 2,
  },

  drop = "nokore_world_copper:copper_lump",

  tiles = {
    "world_stone.png^world_mineral_copper.png",
  },
})

mod:register_node("copper_block", {
  description = mod.S("Copper Block"),

  groups = {
    cracky = 1,
  },

  tiles = {
    "world_copper_block.png",
  },
})
