local mod = nokore_world_standard

-- Normal everyday sandstone
mod:register_node("sandstone", {
  description = mod.S("Sandstone"),

  groups = { cracky = 3, stone = 1 },

  tiles = {
    "world_sandstone.png",
  },

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("sandstone_brick", {
  description = mod.S("Sandstone Brick"),

  groups = { cracky = 3, stone = 1 },

  tiles = {
    "world_sandstone_brick.png",
  },

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("desert_sandstone", {
  description = mod.S("Desert Sandstone"),

  groups = { cracky = 3, stone = 1 },

  tiles = {
    "world_desert_sandstone.png",
  },

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("silver_sandstone", {
  description = mod.S("Silver Sandstone"),

  groups = { cracky = 3, stone = 1 },

  tiles = {
    "world_silver_sandstone.png",
  },

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("silver_sandstone_brick", {
  description = mod.S("Silver Sandstone Brick"),

  groups = { cracky = 3, stone = 1 },

  tiles = {
    "world_silver_sandstone_brick.png",
  },

  sounds = nokore.node_sounds:build("stone"),
})

if nokore.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes("nokore_world_standard:sandstone", {
    -- base
    _ = {
      groups = {cracky = 3, stone = 1},
      tiles = "world_sandstone.png",
      sounds = nokore.node_sounds:build("stone"),
    },
    plate = {
      description = mod.S("Sandstone Plate"),
    },
    slab = {
      description = mod.S("Sandstone Slab"),
    },
    stair = {
      description = mod.S("Sandstone Stair"),
    },
    stair_inner = {
      description = mod.S("Sandstone Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Sandstone Stair Outer"),
    },
  })

  nokore_stairs.build_and_register_nodes("nokore_world_standard:sandstone_brick", {
    -- base
    _ = {
      groups = {cracky = 3, stone = 1},
      tiles = "world_sandstone_brick.png",
      sounds = nokore.node_sounds:build("stone"),
    },
    plate = {
      description = mod.S("Sandstone Brick Plate"),
    },
    slab = {
      description = mod.S("Sandstone Brick Slab"),
    },
    stair = {
      description = mod.S("Sandstone Brick Stair"),
    },
    stair_inner = {
      description = mod.S("Sandstone Brick Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Sandstone Brick Stair Outer"),
    },
  })

  nokore_stairs.build_and_register_nodes("nokore_world_standard:desert_sandstone", {
    -- base
    _ = {
      groups = {cracky = 3, stone = 1},
      tiles = "world_desert_sandstone.png",
      sounds = nokore.node_sounds:build("stone"),
    },
    plate = {
      description = mod.S("Desert Sandstone Plate"),
    },
    slab = {
      description = mod.S("Desert Sandstone Slab"),
    },
    stair = {
      description = mod.S("Desert Sandstone Stair"),
    },
    stair_inner = {
      description = mod.S("Desert Sandstone Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Desert Sandstone Stair Outer"),
    },
  })

  nokore_stairs.build_and_register_nodes("nokore_world_standard:silver_sandstone", {
    -- base
    _ = {
      groups = {cracky = 3, stone = 1},
      tiles = "world_silver_sandstone.png",
      sounds = nokore.node_sounds:build("stone"),
    },
    plate = {
      description = mod.S("Silver Sandstone Plate"),
    },
    slab = {
      description = mod.S("Silver Sandstone Slab"),
    },
    stair = {
      description = mod.S("Silver Sandstone Stair"),
    },
    stair_inner = {
      description = mod.S("Silver Sandstone Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Silver Sandstone Stair Outer"),
    },
  })

  nokore_stairs.build_and_register_nodes("nokore_world_standard:silver_sandstone_brick", {
    -- base
    _ = {
      groups = {cracky = 3, stone = 1},
      tiles = "world_silver_sandstone_brick.png",
      sounds = nokore.node_sounds:build("stone"),
    },
    plate = {
      description = mod.S("Silver Sandstone Brick Plate"),
    },
    slab = {
      description = mod.S("Silver Sandstone Brick Slab"),
    },
    stair = {
      description = mod.S("Silver Sandstone Brick Stair"),
    },
    stair_inner = {
      description = mod.S("Silver Sandstone Brick Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Silver Sandstone Brick Stair Outer"),
    },
  })
end
