local mod = nokore_world_standard

mod:register_node("cobblestone", {
  description = mod.S("Cobblestone"),

  groups = {
    cracky = 3,
    stone = 2,
  },

  tiles = {
    "world_cobblestone.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})

mod:register_node("mossy_cobblestone", {
  description = mod.S("Mossy Cobblestone"),

  groups = {
    cracky = 3,
    stone = 2,
    mossy_stone = 1,
  },

  tiles = {
    "world_mossy_cobblestone.png"
  },

  sounds = nokore.node_sounds:build("stone"),
})

if nokore.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes("nokore_world_standard:cobblestone", {
    -- base
    _ = {
      groups = {cracky = 3, stone = 2},
      tiles = "world_cobblestone.png",
      sounds = nokore.node_sounds:build("stone"),
    },
    plate = {
      description = mod.S("Cobblestone Plate"),
    },
    slab = {
      description = mod.S("Cobblestone Slab"),
    },
    stair = {
      description = mod.S("Cobblestone Stair"),
    },
    stair_inner = {
      description = mod.S("Cobblestone Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Cobblestone Stair Outer"),
    },
  })

  nokore_stairs.build_and_register_nodes("nokore_world_standard:mossy_cobblestone", {
    -- base
    _ = {
      groups = {cracky = 3, stone = 2, mossy_stone = 1},
      tiles = "world_mossy_cobblestone.png",
      sounds = nokore.node_sounds:build("stone"),
    },
    plate = {
      description = mod.S("Mossy Cobblestone Plate"),
    },
    slab = {
      description = mod.S("Mossy Cobblestone Slab"),
    },
    stair = {
      description = mod.S("Mossy Cobblestone Stair"),
    },
    stair_inner = {
      description = mod.S("Mossy Cobblestone Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Mossy Cobblestone Stair Outer"),
    },
  })
end
