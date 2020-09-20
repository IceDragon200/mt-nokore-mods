--
-- NoKore - Biome : Ice Sheet
--
-- This module adds the icesheet biome(s)
local mod = foundation.new_module("nokore_biome_icesheet", "0.1.0")

minetest.register_biome({
  name = "icesheet",
  node_dust = "nokore_world_snow:snow_block",
  node_top = "nokore_world_snow:snow_block",
  depth_top = 1,
  node_filler = "nokore_world_snow:snow_block",
  depth_filler = 3,
  node_stone = "nokore_world_snow:cave_ice",
  node_water_top = "nokore_world_snow:ice",
  depth_water_top = 10,
  node_river_water = "nokore_world_snow:ice",
  node_riverbed = "nokore_world_standard:gravel",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_snow:ice",
  node_dungeon_stair = "nokore_world_snow:ice_stair",
  y_max = 31000,
  y_min = -8,
  heat_point = 0,
  humidity_point = 73,
})

if foundation.is_module_present("nokore_world_water") then
  minetest.register_biome({
    name = "icesheet_ocean",
    node_dust = "nokore_world_snow:snow_block",
    node_top = "nokore_world_standard:sand",
    depth_top = 1,
    node_filler = "nokore_world_standard:sand",
    depth_filler = 3,
    node_water_top = "nokore_world_snow:ice",
    depth_water_top = 10,
    node_cave_liquid = "nokore_world_water:fresh_water_source",
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    y_max = -9,
    y_min = -255,
    heat_point = 0,
    humidity_point = 73,
  })
end

if foundation.is_module_present("nokore_world_water") and
   foundation.is_module_present("nokore_world_lava") then
  minetest.register_biome({
    name = "icesheet_under",
    node_cave_liquid = {
      "nokore_world_water:fresh_water_source",
      "nokore_world_lava:lava_source",
    },
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    y_max = -256,
    y_min = -31000,
    heat_point = 0,
    humidity_point = 73,
  })
end
