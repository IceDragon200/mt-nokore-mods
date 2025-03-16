--
-- NoKore - Mapgen Decoration / Tree / Big Oak
--
local mod = foundation.new_module("nokore_mapgen_decor_tree_big_oak", "0.1.0")

local seed = nokore_mapgen.tree_seed
--dofile(mod.modpath .. "/schematics.lua")

if nokore_mapgen.enable_trees then
  minetest.register_decoration({
    name = "nokore_mapgen_decor_tree_big_oak:big_oak_tree",
    deco_type = "schematic",
    place_on = {"nokore_world_standard:dirt_with_grass"},
    sidelen = 16,
    noise_params = {
      offset = 0.024,
      scale = 0.015,
      spread = {x = 256, y = 256, z = 256},
      seed = seed,
      octaves = 3,
      persistence = 0.66,
      lacunarity = 2.0,
    },
    biomes = {"big_oak_forest"},
    y_max = 31000,
    y_min = 1,
    schematic = mod.modpath .. "/schematics/nokore_big_oak_tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
  })
end
