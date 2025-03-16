--
-- NoKore - Mapgen Decoration / Tree / Oak
--
local mod = foundation.new_module("nokore_mapgen_decor_tree_oak", "0.1.0")

--dofile(mod.modpath .. "/schematics.lua")

local seed = nokore_mapgen.tree_seed

if nokore_mapgen.enable_trees then
  minetest.register_decoration({
    name = "nokore_mapgen_decor_tree_oak:oak_tree",
    deco_type = "schematic",
    place_on = {"nokore_world_standard:dirt_with_grass"},
    sidelen = 40,
    fill_ratio = 0.010,
    -- noise_params = {
    --   offset = 0.017,
    --   scale = 0.015,
    --   spread = {x = 256, y = 256, z = 256},
    --   seed = seed,
    --   octaves = 3,
    --   persistence = 0.66,
    --   lacunarity = 2.0,
    -- },
    biomes = {"oak_forest"},
    y_max = 31000,
    y_min = 1,
    schematic = mod.modpath .. "/schematics/nokore_oak_tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
  })

  minetest.register_decoration({
    name = "nokore_mapgen_decor_tree_oak:small_oak_tree",
    deco_type = "schematic",
    place_on = {"nokore_world_standard:dirt_with_grass"},
    sidelen = 20,
    fill_ratio = 0.015,
    -- noise_params = {
    --   offset = 0.019,
    --   scale = -0.015,
    --   spread = {x = 256, y = 256, z = 256},
    --   seed = seed,
    --   octaves = 3,
    --   persistence = 0.66,
    --   lacunarity = 2.0,
    -- },
    biomes = {"oak_forest"},
    y_max = 31000,
    y_min = 1,
    schematic = mod.modpath .. "/schematics/nokore_oak_small_tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
  })
end
