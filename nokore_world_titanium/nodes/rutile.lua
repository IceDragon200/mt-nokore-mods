local mod = assert(nokore_world_titanium)

mod:register_node("rutile", {
  description = mod.S("Rutile"),

  groups = {
    cracky = nokore.dig_class("carbon_steel"),
  },

  drop = "nokore_world_titanium:titanium_lump 4",

  tiles = {
    "world_rutile.png",
  },
})

