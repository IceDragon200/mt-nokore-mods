--
-- NoKore - Mapgen / Sand
--
-- For general mapgen related changes with sand
foundation.new_module("nokore_mapgen_sand", "0.1.0")

-- Silver sandstone

minetest.register_ore({
  ore_type        = "stratum",
  ore             = "nokore_world_standard:silver_sandstone",
  wherein         = {"nokore_world_standard:stone"},
  clust_scarcity  = 1,
  y_max           = 46,
  y_min           = 10,
  noise_params    = {
    offset = 28,
    scale = 16,
    spread = {x = 128, y = 128, z = 128},
    seed = 90122,
    octaves = 1,
  },
  stratum_thickness = 4,
  biomes = {"cold_desert"},
})

minetest.register_ore({
  ore_type        = "stratum",
  ore             = "nokore_world_standard:silver_sandstone",
  wherein         = {"nokore_world_standard:stone"},
  clust_scarcity  = 1,
  y_max           = 42,
  y_min           = 6,
  noise_params    = {
    offset = 24,
    scale = 16,
    spread = {x = 128, y = 128, z = 128},
    seed = 90122,
    octaves = 1,
  },
  stratum_thickness = 2,
  biomes = {"cold_desert"},
})

-- Desert Sandstone
minetest.register_ore({
  ore_type        = "stratum",
  ore             = "nokore_world_standard:desert_sandstone",
  wherein         = {"nokore_world_standard:desert_stone"},
  clust_scarcity  = 1,
  y_max           = 46,
  y_min           = 10,
  noise_params    = {
    offset = 28,
    scale = 16,
    spread = {x = 128, y = 128, z = 128},
    seed = 90122,
    octaves = 1,
  },
  stratum_thickness = 4,
  biomes = {"desert"},
})

minetest.register_ore({
  ore_type        = "stratum",
  ore             = "nokore_world_standard:desert_sandstone",
  wherein         = {"nokore_world_standard:desert_stone"},
  clust_scarcity  = 1,
  y_max           = 42,
  y_min           = 6,
  noise_params    = {
    offset = 24,
    scale = 16,
    spread = {x = 128, y = 128, z = 128},
    seed = 90122,
    octaves = 1,
  },
  stratum_thickness = 2,
  biomes = {"desert"},
})

-- Sandstone

minetest.register_ore({
  ore_type        = "stratum",
  ore             = "nokore_world_standard:sandstone",
  wherein         = {"nokore_world_standard:desert_stone"},
  clust_scarcity  = 1,
  y_max           = 39,
  y_min           = 3,
  noise_params    = {
    offset = 21,
    scale = 16,
    spread = {x = 128, y = 128, z = 128},
    seed = 90122,
    octaves = 1,
  },
  stratum_thickness = 2,
  biomes = {"desert"},
})

--
-- Blob Ore
--

minetest.register_ore({
  ore_type        = "blob",
  ore             = "nokore_world_standard:silver_sand",
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
    seed = 2316,
    octaves = 1,
    persist = 0.0
  },
})
