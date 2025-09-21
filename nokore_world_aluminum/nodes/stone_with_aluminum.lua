local mod = assert(nokore_world_aluminum)

mod:register_node("stone_with_aluminum", {
  description = mod.S("Stone with Aluminum"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  drop = "nokore_world_aluminum:aluminum_lump",

  tiles = {
    "world_stone.png^world_mineral_aluminum.png",
  },
})
