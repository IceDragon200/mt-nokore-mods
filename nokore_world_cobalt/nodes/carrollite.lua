local mod = assert(nokore_world_cobalt)

-- contains copper and sulfur as well
mod:register_node("carrollite", {
  description = mod.S("Carrollite"),

  groups = {
    cracky = nokore.dig_class("carbon_steel"),
  },

  drop = "nokore_world_cobalt:cobalt_lump 4",

  tiles = {
    "world_carrollite.png",
  },
})

