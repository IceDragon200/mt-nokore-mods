local mod = nokore_world_clay

-- boring clay brick
mod:register_node("brick", {
  description = mod.S("Brick Block"),

  groups = {cracky = 3},

  paramtype2 = "facedir",
  place_param2 = 0,
  tiles = {
    "world_clay_brick.png^[transformFX",
    "world_clay_brick.png",
  },
  is_ground_content = false,
  sounds = nokore.node_sounds:build("clay_brick"),
})
