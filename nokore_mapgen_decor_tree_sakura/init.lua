--
-- NoKore - Mapgen Decoration / Tree / Sakura
--
local mod = nokore.new_module("nokore_mapgen_decor_tree_sakura", "0.1.0")

--dofile(mod.modpath .. "/schematics.lua")

local seed = nokore_mapgen.tree_seed

minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_sakura:sakura_tree",
  deco_type = "schematic",
  place_on = {"nokore_world_tree_sakura:dirt_with_sakura_litter"},
  sidelen = 16,
  noise_params = {
    offset = 0.0125,
    scale = 0.012,
    spread = {x = 256, y = 256, z = 256},
    seed = seed,
    octaves = 3,
    persist = 0.66
  },
  biomes = {
    "sakura_forest",
  },
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_sakura_tree.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_sakura:small_sakura_tree",
  deco_type = "schematic",
  place_on = {"nokore_world_tree_sakura:dirt_with_sakura_litter"},
  sidelen = 16,
  noise_params = {
    offset = 0.0125,
    scale = -0.012,
    spread = {x = 256, y = 256, z = 256},
    seed = seed,
    octaves = 3,
    persist = 0.66
  },
  biomes = {"sakura_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_sakura_small_tree.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})
