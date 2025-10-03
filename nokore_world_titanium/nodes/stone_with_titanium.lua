local mod = assert(nokore_world_titanium)

mod:register_node("stone_with_titanium", {
  description = mod.S("Stone with Titanium"),

  groups = {
    cracky = nokore.dig_class("carbon_steel"),
  },

  drop = "nokore_world_titanium:titanium_lump",

  tiles = {
    "world_stone.png^world_mineral_titanium.png",
  },
})
