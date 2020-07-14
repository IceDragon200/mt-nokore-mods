local mod = nokore_world_cactus

mod:register_node("cactus", {
  description = mod.S("Cactus"),

  groups = {
    choppy = 3,
  },

  tiles = {
    "world_cactus_top.png",
    "world_cactus_bottom.png",
    "world_cactus_side.png",
  },

  paramtype2 = "facedir",

  sounds = nokore.node_sounds:build("wood"),

  on_place = minetest.rotate_node,
})
