--
-- NoKore - Biome : Sakura Forest
--
-- This module adds the sakura forest biome(s)
local mod = nokore.new_module("nokore_biome_sakura_forest", "0.1.0")

minetest.register_biome({
  name = "sakura_forest",
  node_top = "nokore_world_standard:dirt_with_grass",
  depth_top = 1,
  node_filler = "nokore_world_standard:dirt",
  depth_filler = 3,
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  --node_dungeon_stair = "stairs:stair_cobble",
  y_max = 31000,
  y_min = 6,
  heat_point = 45,
  humidity_point = 75,
})

minetest.register_decoration({
  name = "nokore_biome_sakura_forest:sakura_tree",
  deco_type = "schematic",
  place_on = {"default:dirt_with_grass"},
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
  schematic = "nokore_world_tree_sakura:sakura_tree",
  flags = "place_center_x, place_center_z",
  rotation = "random",
})
