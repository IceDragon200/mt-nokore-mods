local mod = nokore_world_vine

mod:register_node("vine", {
  description = mod.S("Vine"),

  groups = {
    snappy = nokore.dig_class("wme"),
    snippy = nokore.dig_class("wme"),
    --
    vine = 1,
    flammable = 2,
  },

  drawtype = "signlike",
  tiles = {
    "world_vine.png",
  },
  inventory_image = "world_vine.png",
  wield_image = "world_vine.png",

  paramtype = "light",
  paramtype2 = "wallmounted",

  sunlight_propagates = true,
  walkable = false,
  climbable = true,
  is_ground_content = false,
  selection_box = {
    type = "wallmounted",
  },

  sounds = nokore.node_sounds:build("vine"),
})
