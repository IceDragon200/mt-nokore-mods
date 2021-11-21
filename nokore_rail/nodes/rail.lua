local mod = nokore_rail
local rails = nokore.rails

-- Normal rails
rails:register_rail_node(mod:make_name("rail_normal"), {
  description = mod.S("Rail"),

  groups = rails:build_rail_groups(),

  tiles = {
    "nokore_rail.png",
    "nokore_rail.corner.png",
    "nokore_rail.tee.png",
    "nokore_rail.cross.png"
  },

  inventory_image = "nokore_rail.png",
  wield_image = "nokore_rail.png",
})
