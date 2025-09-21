local mod = assert(nokore_world_zinc)

mod:register_node("stone_with_zinc", {
  description = mod.S("Stone with Zinc"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  drop = "nokore_world_zinc:zinc_lump",

  tiles = {
    "world_stone.png^world_mineral_zinc.png",
  },
})
