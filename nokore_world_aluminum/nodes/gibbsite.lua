local mod = assert(nokore_world_aluminum)

mod:register_node("gibbsite", {
  description = mod.S("Gibbsite"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  drop = "nokore_world_aluminum:aluminum_lump 4",

  tiles = {
    "world_gibbsite.png",
  },
})

