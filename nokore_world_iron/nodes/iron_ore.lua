local mod = nokore_world_iron

mod:register_node("stone_with_iron", {
  description = mod.S("Iron Ore"),

  groups = {
    cracky = 2,
  },

  drop = "nokore_world_iron:iron_lump",

  tiles = {
    "world_stone.png^world_mineral_iron.png",
  },
})
