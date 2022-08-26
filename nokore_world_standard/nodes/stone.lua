local mod = nokore_world_standard

mod:register_node("stone", {
  description = mod.S("Stone"),

  groups = {
    cracky = nokore.dig_class("wood"),
    stone = 1
  },

  tiles = {
    "world_stone.png"
  },

  drop = "nokore_world_standard:cobblestone",

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("stone_brick", {
  description = mod.S("Stone Brick"),

  groups = {
    cracky = nokore.dig_class("wood"),
    stone = 1
  },

  tiles = {
    "world_stone_brick.png"
  },

  drop = "nokore_world_standard:cobblestone",

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("desert_stone", {
  description = mod.S("Desert Stone"),

  groups = {
    cracky = nokore.dig_class("wood"),
    stone = 1
  },

  tiles = {
    "world_desert_stone.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("desert_stone_brick", {
  description = mod.S("Desert Stone Brick"),

  groups = {
    cracky = nokore.dig_class("wood"),
    stone = 1
  },

  tiles = {
    "world_desert_stone_brick.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})

if foundation.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes("nokore_world_standard:stone_brick", {
    -- base
    _ = {
      groups = {
        cracky = nokore.dig_class("wood"),
        stone = 1
      },
      tiles = "world_stone_brick.png",
      sounds = nokore.node_sounds:build("stone"),
    },
    column = {
      description = mod.S("Stone Brick Column"),
    },
    plate = {
      description = mod.S("Stone Brick Plate"),
    },
    slab = {
      description = mod.S("Stone Brick Slab"),
    },
    stair = {
      description = mod.S("Stone Brick Stair"),
    },
    stair_inner = {
      description = mod.S("Stone Brick Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Stone Brick Stair Outer"),
    },
  })

  nokore_stairs.build_and_register_nodes("nokore_world_standard:desert_stone_brick", {
    -- base
    _ = {
      groups = {
        cracky = nokore.dig_class("wood"),
        stone = 1
      },
      tiles = "world_desert_stone_brick.png",
      sounds = nokore.node_sounds:build("stone"),
    },
    column = {
      description = mod.S("Desert Stone Brick Column"),
    },
    plate = {
      description = mod.S("Desert Stone Brick Plate"),
    },
    slab = {
      description = mod.S("Desert Stone Brick Slab"),
    },
    stair = {
      description = mod.S("Desert Stone Brick Stair"),
    },
    stair_inner = {
      description = mod.S("Desert Stone Brick Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Desert Stone Brick Stair Outer"),
    },
  })
end
