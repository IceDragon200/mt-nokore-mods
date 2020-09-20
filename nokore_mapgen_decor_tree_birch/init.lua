--
-- NoKore - Mapgen Decoration / Tree / Birch
--
local mod = foundation.new_module("nokore_mapgen_decor_tree_birch", "0.1.0")

--dofile(mod.modpath .. "/schematics.lua")

local seed = nokore_mapgen.tree_seed

minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_birch:birch_tree",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0.0,
    scale = -0.017,
    spread = {x = 250, y = 250, z = 250},
    seed = seed,
    octaves = 3,
    persist = 0.66
  },
  biomes = {"deciduous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_birch_tree.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_birch:small_birch_tree",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0.0,
    scale = -0.017,
    spread = {x = 250, y = 250, z = 250},
    seed = seed,
    octaves = 3,
    persist = 0.66
  },
  biomes = {"deciduous_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_birch_small_tree.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})
