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
})
