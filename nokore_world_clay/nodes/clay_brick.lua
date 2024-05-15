local mod = nokore_world_clay

-- boring clay brick
mod:register_node("brick", {
  description = mod.S("Brick Block"),

  groups = {
    cracky = nokore.dig_class("stone"),
    clay_brick = 1,
  },

  paramtype2 = "facedir",
  place_param2 = 0,
  tiles = {
    "world_clay_brick.png^[transformFX",
    "world_clay_brick.png",
  },
  is_ground_content = true,
  sounds = nokore.node_sounds:build("clay_brick"),
})
