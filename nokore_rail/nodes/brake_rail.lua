local mod = nokore_rail
local rails = nokore.rails

-- Brake rail
--   Halts any carts that attempt to pass over the rail
rails:register_rail_node(mod:make_name("rail_brake_off"), {
  description = mod.S("Powered Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail_brake.png",
    "nokore_rail_brake.corner.png",
    "nokore_rail_brake.tee.png",
    "nokore_rail_brake.cross.png"
  },
})

rails:register_rail_node(mod:make_name("rail_brake_on"), {
  description = mod.S("Powered Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail_brake.on.png",
    "nokore_rail_brake.on.corner.png",
    "nokore_rail_brake.on.tee.png",
    "nokore_rail_brake.on.cross.png"
  },
})
