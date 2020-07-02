local mod = nokore_world_snow

-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
mod:register_node("ice", {
  description = mod.S("Ice"),

  groups = {
    cracky = 3,
    cools_lava = 1,
    slippery = 3,
  },

  tiles = {"world_ice.png"},

  is_ground_content = false,
  paramtype = "light",

  sounds = nokore.node_sounds:build("ice"),
})

-- Mapgen-placed ice with 'is ground content = true' to contain tunnels
mod:register_node("cave_ice", {
  description = S("Cave Ice"),

  groups = {
    cracky = 3,
    cools_lava = 1,
    slippery = 3,
    not_in_creative_inventory = 1,
  },

  tiles = {"world_ice.png"},

  paramtype = "light",

  drop = "nokore_world_snow:ice",

  sounds = nokore.node_sounds:build("ice"),
})
