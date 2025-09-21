local mod = assert(nokore_world_zinc)

mod:register_node("sphalerite", {
  description = mod.S("Sphalerite"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  drop = "nokore_world_zinc:zinc_lump 4",

  tiles = {
    "world_sphalerite.png",
  },
})

