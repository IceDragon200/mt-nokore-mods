local mod = nokore_rail
local rails = nokore.rails

-- Launch Rail
--   Launches a cart into the air forward, the distance can be configured.
rails:register_rail_node(mod:make_name("launch_rail_off"), {
  description = mod.S("Launch Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail_launch.png",
    "nokore_rail_launch.corner.png",
    "nokore_rail_launch.tee.png",
    "nokore_rail_launch.cross.png"
  },

  inventory_image = "nokore_rail_launch.png",
  wield_image = "nokore_rail_launch.png",
})

rails:register_rail_node(mod:make_name("launch_rail_on"), {
  description = mod.S("Launch Rail"),

  groups = rails:build_rail_groups({
    not_in_creative_inventory = 1,
  }),

  tiles = {
    "nokore_rail_launch.on.png",
    "nokore_rail_launch.on.corner.png",
    "nokore_rail_launch.on.tee.png",
    "nokore_rail_launch.on.cross.png"
  },

  inventory_image = "nokore_rail_launch.on.png",
  wield_image = "nokore_rail_launch.on.png",
})
