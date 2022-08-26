local mod = nokore_world_cactus

mod:register_node("cactus", {
  description = mod.S("Cactus"),

  groups = {
    choppy = nokore.dig_class("wood"),
  },

  use_texture_alpha = "clip",
  tiles = {
    "world_cactus_top.png",
    "world_cactus_bottom.png",
    "world_cactus_side.png",
  },

  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      {-7/16, -8/16, -7/16, 7/16, 8/16, 7/16}
    },
  },

  paramtype = "light",
  paramtype2 = "facedir",

  sounds = nokore.node_sounds:build("cactus"),

  on_place = minetest.rotate_node,
})
