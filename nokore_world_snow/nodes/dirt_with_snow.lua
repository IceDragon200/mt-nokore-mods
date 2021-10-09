local mod = nokore_world_snow

mod:register_node("dirt_with_snow", {
  description = mod.S("Dirt with Snow"),

  groups = {
    crumbly = 3,
    soil = 1,
    spreading_dirt_type = 1,
    snowy = 1,
  },

  use_texture_alpha = "opaque",
  tiles = {
    "world_snow.png",
    "world_dirt.png",
    {
      name = "world_dirt.png^world_snow_side.png",
      tileable_vertical = false
    }
  },

  drop = "nokore_world_standard:dirt",

  sounds = nokore.node_sounds:build("dirt", {
    sounds = {
      footstep = { name = "default_snow_footstep", gain = 0.4 },
    },
  }),
})
