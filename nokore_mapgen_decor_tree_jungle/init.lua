--
-- NoKore - Mapgen Decoration / Tree / Oak
--
local mod = nokore.new_module("nokore_mapgen_decor_tree_jungle", "0.1.0")

--dofile(mod.modpath .. "/schematics.lua")

-- Jungle tree and log
minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_jungle:jungle_tree",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_rainforest_litter"},
  sidelen = 80,
  fill_ratio = 0.1,
  biomes = {"rainforest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_jungle_tree.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

-- Swamp jungle trees
minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_jungle:jungle_tree(swamp)",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt"},
  sidelen = 16,
  -- Noise tuned to place swamp trees where papyrus is absent
  noise_params = {
    offset = 0.0,
    scale = -0.1,
    spread = {x = 200, y = 200, z = 200},
    seed = 354,
    octaves = 1,
    persist = 0.5
  },
  biomes = {"rainforest_swamp"},
  y_max = 0,
  y_min = -1,
  schematic = mod.modpath .. "/schematics/nokore_jungle_tree.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_jungle:jungle_log",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_rainforest_litter"},
  place_offset_y = 1,
  sidelen = 80,
  fill_ratio = 0.005,
  biomes = {"rainforest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_jungle_fallen_log.mts",
  flags = "place_center_x",
  rotation = "random",
  spawn_by = "nokore_world_standard:dirt_with_rainforest_litter",
  num_spawn_by = 8,
})
