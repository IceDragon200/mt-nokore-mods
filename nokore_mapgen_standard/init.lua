--
-- NoKore - Mapgen Standard
--
-- Adds the standard nodes as mapgen aliases
local mod = foundation.new_module("nokore_mapgen_standard", "0.1.0")

-- Common
minetest.register_alias("mapgen_stone", "nokore_world_standard:stone")

-- Mapgen V6
minetest.register_alias("mapgen_dirt", "nokore_world_standard:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "nokore_world_standard:dirt_with_grass")
minetest.register_alias("mapgen_sand", "nokore_world_standard:sand")
minetest.register_alias("mapgen_gravel", "nokore_world_standard:gravel")
minetest.register_alias("mapgen_desert_stone", "nokore_world_standard:desert_stone")
minetest.register_alias("mapgen_desert_sand", "nokore_world_standard:desert_sand")
minetest.register_alias("mapgen_cobble", "nokore_world_standard:cobblestone")
minetest.register_alias("mapgen_mossycobble", "nokore_world_standard:mossy_cobblestone")

minetest.register_ore({
  ore_type        = "blob",
  ore             = "nokore_world_standard:dirt",
  wherein         = {"nokore_world_standard:stone"},
  clust_scarcity  = 16 * 16 * 16,
  clust_size      = 5,
  y_max           = 31000,
  y_min           = -31,
  noise_threshold = 0.0,
  noise_params    = {
    offset = 0.5,
    scale = 0.2,
    spread = {x = 5, y = 5, z = 5},
    seed = 17676,
    octaves = 1,
    persist = 0.0
  },
  -- Only where nokore_world_standard:dirt is present as surface material
  biomes = {
    "taiga",
    "snowy_grassland",
    "grassland",
    "coniferous_forest",
    "deciduous_forest",
    "deciduous_forest_shore",
    "rainforest",
    "rainforest_swamp"
  }
})

-- Gravel
minetest.register_ore({
  ore_type        = "blob",
  ore             = "nokore_world_standard:gravel",
  wherein         = {"nokore_world_standard:stone"},
  clust_scarcity  = 16 * 16 * 16,
  clust_size      = 5,
  y_max           = 31000,
  y_min           = -31000,
  noise_threshold = 0.0,
  noise_params    = {
    offset = 0.5,
    scale = 0.2,
    spread = {x = 5, y = 5, z = 5},
    seed = 766,
    octaves = 1,
    persist = 0.0
  },
})
