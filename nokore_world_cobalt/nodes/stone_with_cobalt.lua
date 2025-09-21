local mod = assert(nokore_world_cobalt)

mod:register_node("stone_with_cobalt", {
  description = mod.S("Stone with Cobalt"),

  groups = {
    cracky = nokore.dig_class("carbon_steel"),
  },

  drop = "nokore_world_cobalt:cobalt_lump",

  tiles = {
    "world_stone.png^world_mineral_cobalt.png",
  },
})
