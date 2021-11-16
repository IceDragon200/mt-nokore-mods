local mod = nokore_rail
local rails = nokore.rails

-- Activator rail
--   Activates the contents of a cart that passes over it
rails:register_rail_node(mod:make_name("rail_activator_off"), {
  description = mod.S("Activator Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail_activator.png",
    "nokore_rail_activator.corner.png",
    "nokore_rail_activator.tee.png",
    "nokore_rail_activator.cross.png"
  },
})

rails:register_rail_node(mod:make_name("rail_activator_on"), {
  description = mod.S("Activator Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail_activator.on.png",
    "nokore_rail_activator.on.corner.png",
    "nokore_rail_activator.on.tee.png",
    "nokore_rail_activator.on.cross.png"
  },
})
