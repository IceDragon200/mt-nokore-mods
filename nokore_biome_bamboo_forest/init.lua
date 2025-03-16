--
-- NoKore - Biome : Bamboo Forest
--
-- This module adds the bamboo forest biome(s)
foundation.new_module("nokore_biome_bamboo_forest", "0.1.0")

--
-- Schematic
local stalk = { name = "nokore_world_bamboo:bamboo_stalk" }

local bamboo_schematic = {
  size = vector.new(1, 16, 1),
  yslice_prob = {
    { ypos =  7, prob = 240},
    { ypos =  8, prob = 224},
    { ypos =  9, prob = 208},
    { ypos = 10, prob = 192},
    { ypos = 11, prob = 176},
    { ypos = 12, prob = 160},
    { ypos = 13, prob = 144},
    { ypos = 14, prob = 128},
    { ypos = 15, prob = 112},
    { ypos = 16, prob =  96},
  },
  data = {
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
    stalk,
  },
}

core.register_biome({
  name = "bamboo_forest",
  node_top = "nokore_world_standard:dirt_with_grass",
  depth_top = 1,
  node_filler = "nokore_world_standard:dirt",
  depth_filler = 3,
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
  y_max = 31000,
  y_min = 6,
  heat_point = 45,
  humidity_point = 75,
})

core.register_decoration({
  name = "nokore_biome_bamboo_forest:bamboo_tree",
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
  biomes = {"bamboo_forest"},
  y_max = 31000,
  y_min = 1,
  schematic = bamboo_schematic,
  flags = "place_center_x, place_center_z",
  rotation = "random",
})
