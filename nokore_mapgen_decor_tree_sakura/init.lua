--
-- NoKore - Mapgen Decoration / Tree / Sakura
--
local mod = nokore.new_module("nokore_mapgen_decor_tree_sakura", "0.1.0")

--dofile(mod.modpath .. "/schematics.lua")

minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_sakura:sakura_tree",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0.024,
    scale = 0.015,
    spread = {x = 250, y = 250, z = 250},
    seed = 2,
    octaves = 3,
    persist = 0.66
  },
  biomes = {"sakura_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = mod.modpath .. "/schematics/nokore_sakura_tree.mts",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})

minetest.register_decoration({
  name = "nokore_mapgen_decor_tree_sakura:small_sakura_tree",
  deco_type = "schematic",
  place_on = {"nokore_world_standard:dirt_with_grass"},
  sidelen = 16,
  noise_params = {
    offset = 0.024,
    scale = -0.015,
    spread = {x = 250, y = 250, z = 250},
    seed = 2,
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