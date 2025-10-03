local mod = assert(nokore_world_lead)

mod:register_node("lead_block", {
  description = mod.S("Lead Block"),

  groups = {
    cracky = nokore.dig_class("iron"),
  },

  tiles = {
    "world_lead_block.png",
  },
})
