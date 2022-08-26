local mod = nokore_world_lava

mod:register_node("lava_source", {
  description = mod.S("Lava"),

  groups = {
    lava = 3,
    liquid = 2,
    igniter = 1,
  },

  paramtype = "light",
  light_source = minetest.LIGHT_MAX - 1,

  walkable = false,
  pointable = false,
  diggable = false,
  buildable_to = true,
  is_ground_content = false,
  drop = "",
  drowning = 1,

  liquidtype = "source",
  liquid_alternative_flowing = "nokore_world_lava:lava_flowing",
  liquid_alternative_source = "nokore_world_lava:lava_source",
  liquid_viscosity = 7,
  liquid_renewable = false,
  damage_per_second = 4 * 2,

  drawtype = "liquid",
  tiles = {
    {
      name = "world_lava_source_animated.png",
      backface_culling = false,
      animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 3.0,
      },
    },
    {
      name = "world_lava_source_animated.png",
      backface_culling = true,
      animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 3.0,
      },
    },
  },
  post_effect_color = {a = 191, r = 255, g = 64, b = 0},
})

mod:register_node("lava_flowing", {
  description = mod.S("Lava (Flowing)"),

  drawtype = "flowingliquid",
  tiles = {"world_lava.png"},
  special_tiles = {
    {
      name = "world_lava_flowing_animated.png",
      backface_culling = false,
      animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 3.3,
      },
    },
    {
      name = "world_lava_flowing_animated.png",
      backface_culling = true,
      animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 3.3,
      },
    },
  },
  paramtype = "light",
  paramtype2 = "flowingliquid",
  light_source = minetest.LIGHT_MAX - 1,
  walkable = false,
  pointable = false,
  diggable = false,
  buildable_to = true,
  is_ground_content = false,
  drop = "",
  drowning = 1,
  liquidtype = "flowing",
  liquid_alternative_flowing = "nokore_world_lava:lava_flowing",
  liquid_alternative_source = "nokore_world_lava:lava_source",
  liquid_viscosity = 7,
  liquid_renewable = false,
  damage_per_second = 4 * 2,
  post_effect_color = {a = 191, r = 255, g = 64, b = 0},
  groups = {
    lava = 3,
    liquid = 2,
    igniter = 1,
    not_in_creative_inventory = 1,
  },
})
