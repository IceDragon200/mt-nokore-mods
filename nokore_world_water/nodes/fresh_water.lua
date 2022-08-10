local mod = nokore_world_water

mod:register_node("fresh_water_source", {
  description = mod.S("Fresh Water"),

  groups = {
    water = 3,
    liquid = 3,
    cools_lava = 1,
  },

  drop = "",

  walkable = false,
  pointable = false,
  diggable = false,
  buildable_to = true,
  is_ground_content = false,
  drowning = 1,

  drawtype = "liquid",
  liquidtype = "source",
  liquid_alternative_flowing = "nokore_world_water:fresh_water_flowing",
  liquid_alternative_source = "nokore_world_water:fresh_water_source",
  liquid_viscosity = 1,
  --liquid_renewable = false,
  --liquid_range = 2,

  tiles = {
    {
      name = "world_fresh_water_source_animated.png",
      backface_culling = false,
      animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 2.0,
      },
    },
    {
      name = "world_fresh_water_source_animated.png",
      backface_culling = true,
      animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 2.0,
      },
    },
  },

  alpha = 160,
  paramtype = "light",

  post_effect_color = {a = 103, r = 30, g = 76, b = 90},
})

mod:register_node("fresh_water_flowing", {
  description = mod.S("Fresh Water (Flowing)"),

  groups = {
    water = 3,
    liquid = 3,
    not_in_creative_inventory = 1,
    cools_lava = 1,
  },

  paramtype = "light",
  paramtype2 = "flowingliquid",
  walkable = false,
  pointable = false,
  diggable = false,
  buildable_to = true,
  is_ground_content = false,
  drop = "",
  drowning = 1,

  drawtype = "flowingliquid",
  tiles = {"world_fresh_water.png"},
  special_tiles = {
    {
      name = "world_fresh_water_flowing_animated.png",
      backface_culling = false,
      animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 0.5,
      },
    },
    {
      name = "world_fresh_water_flowing_animated.png",
      backface_culling = true,
      animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 0.5,
      },
    },
  },
  alpha = 160,

  liquidtype = "flowing",
  liquid_alternative_flowing = "nokore_world_water:fresh_water_flowing",
  liquid_alternative_source = "nokore_world_water:fresh_water_source",
  liquid_viscosity = 1,
  --liquid_renewable = false,
  --liquid_range = 2,
  post_effect_color = {a = 103, r = 30, g = 76, b = 90},

  --sounds = default.node_sound_water_defaults(),
})
