local mod = nokore_world_snow

-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
mod:register_node("ice", {
  description = mod.S("Ice"),

  groups = {
    cracky = 3,
    ice = 1,
    cools_lava = 1,
    slippery = 3,
  },

  use_texture_alpha = "opaque",
  tiles = {"world_ice.png"},

  is_ground_content = false,
  paramtype = "light",

  sounds = nokore.node_sounds:build("ice"),
})

-- Mapgen-placed ice with 'is ground content = true' to contain tunnels
mod:register_node("cave_ice", {
  description = mod.S("Cave Ice"),

  groups = {
    cracky = 3,
    ice = 1,
    cools_lava = 1,
    slippery = 3,
    not_in_creative_inventory = 1,
  },

  use_texture_alpha = "opaque",
  tiles = {"world_ice.png"},

  paramtype = "light",

  drop = "nokore_world_snow:ice",

  sounds = nokore.node_sounds:build("ice"),
})

if foundation.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes("nokore_world_snow:ice", {
    -- base
    _ = {
      groups = {cracky = 3, ice = 1, cools_lava = 1, slippery = 3},
      use_texture_alpha = "opaque",
      tiles = "world_ice.png",
      sounds = nokore.node_sounds:build("ice"),
    },
    column = {
      description = mod.S("Ice Column"),
    },
    plate = {
      description = mod.S("Ice Plate"),
    },
    slab = {
      description = mod.S("Ice Slab"),
    },
    stair = {
      description = mod.S("Ice Stair"),
    },
    stair_inner = {
      description = mod.S("Ice Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Ice Stair Outer"),
    },
  })
end
