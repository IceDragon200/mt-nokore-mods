--
-- NoKore - Biome : Tundra
--
-- This module adds the tundra biome(s)
local mod = foundation.new_module("nokore_biome_tundra", "0.1.0")

minetest.register_biome({
  name = "tundra_highland",
  node_dust = "nokore_world_snow:snow",
  node_riverbed = "nokore_world_standard:gravel",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
  y_max = 31000,
  y_min = 47,
  heat_point = 0,
  humidity_point = 40,
})

minetest.register_biome({
  name = "tundra",
  node_top = "nokore_world_snow:permafrost_with_stones",
  depth_top = 1,
  node_filler = "nokore_world_snow:permafrost",
  depth_filler = 1,
  node_riverbed = "nokore_world_standard:gravel",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
  vertical_blend = 4,
  y_max = 46,
  y_min = 2,
  heat_point = 0,
  humidity_point = 40,
})

minetest.register_biome({
  name = "tundra_beach",
  node_top = "nokore_world_standard:gravel",
  depth_top = 1,
  node_filler = "nokore_world_standard:gravel",
  depth_filler = 2,
  node_riverbed = "nokore_world_standard:gravel",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
  vertical_blend = 1,
  y_max = 1,
  y_min = -3,
  heat_point = 0,
  humidity_point = 40,
})

if foundation.is_module_present("nokore_world_water") then
  minetest.register_biome({
    name = "tundra_ocean",
    node_top = "nokore_world_standard:sand",
    depth_top = 1,
    node_filler = "nokore_world_standard:sand",
    depth_filler = 3,
    node_riverbed = "nokore_world_standard:gravel",
    depth_riverbed = 2,
    node_cave_liquid = "nokore_world_water:sea_water_source",
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    vertical_blend = 1,
    y_max = -4,
    y_min = -255,
    heat_point = 0,
    humidity_point = 40,
  })
end

if foundation.is_module_present("nokore_world_water") and
   foundation.is_module_present("nokore_world_lava") then
  minetest.register_biome({
    name = "tundra_under",
    node_cave_liquid = {
      "nokore_world_water:water_source",
      "nokore_world_lava:lava_source",
    },
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    y_max = -256,
    y_min = -31000,
    heat_point = 0,
    humidity_point = 40,
  })
end

minetest.register_decoration({
  deco_type = "simple",
  place_on = {
    "nokore_world_snow:permafrost_with_moss",
    "nokore_world_snow:permafrost_with_stones",
    "nokore_world_standard:stone",
    "nokore_world_standard:gravel"
  },
  sidelen = 4,
  noise_params = {
    offset = 0,
    scale = 1.0,
    spread = {x = 100, y = 100, z = 100},
    seed = 172555,
    octaves = 3,
    persist = 1.0
  },
  biomes = {"tundra", "tundra_beach"},
  y_max = 50,
  y_min = 1,
  decoration = "nokore_world_snow:snow",
})
