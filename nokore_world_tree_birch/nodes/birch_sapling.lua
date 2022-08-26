local mod = nokore_world_tree_birch

mod:register_node("birch_sapling", {
  description = mod.S("Birch Sapling"),

  groups = {
    snappy = nokore.dig_class("wme"),
    choppy = nokore.dig_class("wme"),
    snippy = nokore.dig_class("wme"),
    dig_immediate = 3,
    --
    flammable = 2,
    attached_node = 1,
    sapling = 1,
  },

  drawtype = "plantlike",
  tiles = {
    "nokore_sapling_birch.png"
  },
  inventory_image = "nokore_sapling_birch.png",
  wield_image = "nokore_sapling_birch.png",

  selection_box = {
    type = "fixed",
    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
  },

  paramtype = "light",

  sunlight_propagates = true,
  walkable = false,

  sounds = nokore.node_sounds:build("leaves"),
})
