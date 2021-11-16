local mod = nokore_rail
local rails = nokore.rails

-- Powered rail
--   Propels any cart passing over it
rails:register_rail_node(mod:make_name("rail_powered_off"), {
  description = mod.S("Powered Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail_powered.png",
    "nokore_rail_powered.corner.png",
    "nokore_rail_powered.tee.png",
    "nokore_rail_powered.cross.png"
  },
})

rails:register_rail_node(mod:make_name("rail_powered_on"), {
  description = mod.S("Powered Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail_powered.on.png",
    "nokore_rail_powered.on.corner.png",
    "nokore_rail_powered.on.tee.png",
    "nokore_rail_powered.on.cross.png"
  },
})
