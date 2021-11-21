local mod = nokore_rail
local rails = nokore.rails

-- Detector rail
--   Emits a signal whenever a cart crosses over it
rails:register_rail_node(mod:make_name("rail_detector_off"), {
  description = mod.S("Detector Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail_detector.png",
    "nokore_rail_detector.corner.png",
    "nokore_rail_detector.tee.png",
    "nokore_rail_detector.cross.png"
  },

  inventory_image = "nokore_rail_detector.png",
  wield_image = "nokore_rail_detector.png",
})

rails:register_rail_node(mod:make_name("rail_detector_on"), {
  description = mod.S("Detector Rail"),

  groups = rails:build_rail_groups({
    not_in_creative_inventory = 1,
  }),

  drop = mod:make_name("rail_detector_off"),

  tiles = {
    "nokore_rail_detector.on.png",
    "nokore_rail_detector.on.corner.png",
    "nokore_rail_detector.on.tee.png",
    "nokore_rail_detector.on.cross.png"
  },

  inventory_image = "nokore_rail_detector.on.png",
  wield_image = "nokore_rail_detector.on.png",
})
