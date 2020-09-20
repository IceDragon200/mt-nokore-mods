--
-- NoKore - Mapgen Decoration / Giant Mushroom
--
local mod = foundation.new_module("nokore_mapgen_decor_giant_mushroom", "0.1.0")

--dofile(mod.modpath .. "/schematics.lua")

local seed = 0x4D555348

minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:blue_cap_mushroom_small",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = 0.002,
    spread = {x = 250, y = 250, z = 250},
    seed = seed,
    octaves = 5,
    persist = 0.66
  },
  biomes = {"mushroom_forest", "coniferous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_blue_giant_mushroom_small.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:blue_cap_mushroom_normal",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = 0.002,
    spread = {x = 250, y = 250, z = 250},
    seed = seed,
    octaves = 3,
    persist = 0.66
  },
  biomes = {"mushroom_forest", "coniferous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_blue_giant_mushroom.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:blue_cap_mushroom_large",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = 0.002,
    spread = {x = 512, y = 512, z = 512},
    seed = seed,
    octaves = 2,
    persist = 0.66
  },
  biomes = {"mushroom_forest", "coniferous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_blue_giant_mushroom_large.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

--
-- Brown Caps
--
minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:brown_cap_mushroom_small",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = -0.002,
    spread = {x = 250, y = 250, z = 250},
    seed = seed,
    octaves = 5,
    persist = 0.66
  },
  biomes = {"mushroom_forest", "deciduous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_brown_giant_mushroom_small.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:brown_cap_mushroom_normal",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = -0.002,
    spread = {x = 250, y = 250, z = 250},
    seed = seed,
    octaves = 3,
    persist = 0.66
  },
  biomes = {"mushroom_forest", "deciduous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_brown_giant_mushroom.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:brown_cap_mushroom_large",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = -0.002,
    spread = {x = 512, y = 512, z = 512},
    seed = seed,
    octaves = 2,
    persist = 0.66
  },
  biomes = {"mushroom_forest", "deciduous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_brown_giant_mushroom_large.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

--
-- Purple Caps
--
minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:purple_cap_mushroom_small",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = -0.002,
    spread = {x = 250, y = 250, z = 250},
    seed = seed,
    octaves = 5,
    persist = 0.66
  },
  biomes = {"mushroom_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_purple_giant_mushroom_small.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:purple_cap_mushroom_normal",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = -0.002,
    spread = {x = 250, y = 250, z = 250},
    seed = seed,
    octaves = 3,
    persist = 0.66
  },
  biomes = {"mushroom_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_purple_giant_mushroom.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:purple_cap_mushroom_large",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = -0.002,
    spread = {x = 512, y = 512, z = 512},
    seed = seed,
    octaves = 2,
    persist = 0.66
  },
  biomes = {"mushroom_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_purple_giant_mushroom_large.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

--
-- Red Caps
--
minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:red_cap_mushroom_small",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = 0.002,
    spread = {x = 250, y = 250, z = 250},
    seed = seed,
    octaves = 5,
    persist = 0.66
  },
  biomes = {"mushroom_forest", "deciduous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_red_giant_mushroom_small.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:red_cap_mushroom_normal",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = 0.002,
    spread = {x = 250, y = 250, z = 250},
    seed = seed,
    octaves = 3,
    persist = 0.66
  },
  biomes = {"mushroom_forest", "deciduous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_red_giant_mushroom.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_giant_mushroom:red_cap_mushroom_large",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = 0.002,
    spread = {x = 512, y = 512, z = 512},
    seed = seed,
    octaves = 2,
    persist = 0.66
  },
  biomes = {"mushroom_forest", "deciduous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_red_giant_mushroom_large.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})
