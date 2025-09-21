local mod = assert(nokore_world_lead)

-- Also contains silver
mod:register_node("galena", {
  description = mod.S("Galena"),

  groups = {
    cracky = nokore.dig_class("iron"),
  },

  drop = "nokore_world_lead:lead_lump 4",

  tiles = {
    "world_galena.png",
  },
})

