--
-- NoKore - Mapgen Decoration / Tree / Spruce
--
local mod = nokore.new_module("nokore_mapgen_decor_tree_spruce", "0.1.0")

--dofile(mod.modpath .. "/schematics.lua")

minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_spruce:spruce_tree",
  deco_type = "schematic",
  place_on = {"nokore_world_snow:dirt_with_snow", "nokore_world_standard:dirt_with_coniferous_litter"},
  sidelen = 16,
  noise_params = {
    offset = 0.010,
    scale = 0.048,
    spread = {x = 250, y = 250, z = 250},
    seed = 2,
    octaves = 3,
    persist = 0.66
  },
  biomes = {"taiga", "coniferous_forest"},
  y_max = 31000,
  y_min = 4,
  schematic = mod.modpath .. "/schematics/nokore_spruce_tree.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_spruce:small_spruce_tree",
  deco_type = "schematic",
  place_on = {"nokore_world_snow:dirt_with_snow", "nokore_world_standard:dirt_with_coniferous_litter"},
  sidelen = 16,
  noise_params = {
    offset = 0.010,
    scale = -0.048,
    spread = {x = 250, y = 250, z = 250},
    seed = 2,
    octaves = 3,
    persist = 0.66
  },
  biomes = {"taiga", "coniferous_forest"},
  y_max = 31000,
  y_min = 4,
  schematic = mod.modpath .. "/schematics/nokore_spruce_small_tree.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})
