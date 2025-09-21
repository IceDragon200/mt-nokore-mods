local mod = assert(nokore_world_nickel)

mod:register_node("stone_with_nickel", {
  description = mod.S("Stone with Nickel"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  drop = "nokore_world_nickel:nickel_lump",

  tiles = {
    "world_stone.png^world_mineral_nickel.png",
  },
})
