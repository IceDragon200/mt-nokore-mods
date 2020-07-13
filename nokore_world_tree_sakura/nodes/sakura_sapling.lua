local mod = nokore_world_tree_sakura

mod:register_node("sakura_sapling", {
  description = mod.S("Sakura Sapling"),

  groups = {
    snappy = 2,
    dig_immediate = 3,
    flammable = 2,
    attached_node = 1,
    sapling = 1,
  },

  drawtype = "plantlike",
  tiles = {
    "nokore_sapling_sakura.png"
  },
  inventory_image = "nokore_sapling_sakura.png",
  wield_image = "nokore_sapling_sakura.png",

  selection_box = {
    type = "fixed",
    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
  },

  paramtype = "light",

  sunlight_propagates = true,
  walkable = false,

  sounds = nokore.node_sounds:build("leaves"),
})
