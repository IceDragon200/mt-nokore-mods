local mod = nokore_rail
local rails = nokore.rails

-- Detector rail
--   Emits a signal whenever a cart crosses over it
rails:register_rail_node(mod:make_name("rail_detector_off"), {
  description = mod.S("Dectector Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail_detector.png",
    "nokore_rail_detector.corner.png",
    "nokore_rail_detector.tee.png",
    "nokore_rail_detector.cross.png"
  },
})

rails:register_rail_node(mod:make_name("rail_detector_on"), {
  description = mod.S("Dectector Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail_detector.png",
    "nokore_rail_detector.corner.png",
    "nokore_rail_detector.tee.png",
    "nokore_rail_detector.cross.png"
  },
})
