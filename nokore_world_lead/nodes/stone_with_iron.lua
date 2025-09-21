local mod = assert(nokore_world_lead)

mod:register_node("stone_with_lead", {
  description = mod.S("Stone with Lead"),

  groups = {
    cracky = nokore.dig_class("iron"),
  },

  drop = "nokore_world_lead:lead_lump",

  tiles = {
    "world_stone.png^world_mineral_lead.png",
  },
})
