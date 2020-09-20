--
-- NoKore - Biome : Mushroom Forest
--
-- This module adds the mushroom forest biome(s)
local mod = foundation.new_module("nokore_biome_mushroom_forest", "0.1.0")

minetest.register_biome({
  name = "mushroom_forest",
  node_top = "nokore_world_standard:dirt_with_grass",
  depth_top = 1,
  node_filler = "nokore_world_standard:dirt",
  depth_filler = 3,
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 3,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
  y_max = 31000,
  y_min = 1,
  heat_point = 55,
  humidity_point = 40,
})

minetest.register_biome({
  name = "mushroom_forest_shore",
  node_top = "nokore_world_standard:dirt",
  depth_top = 1,
  node_filler = "nokore_world_standard:dirt",
  depth_filler = 3,
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 3,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
  y_max = 0,
  y_min = -1,
  heat_point = 55,
  humidity_point = 40,
})

if foundation.is_module_present("nokore_world_water") then
  minetest.register_biome({
    name = "mushroom_forest_ocean",
    node_top = "nokore_world_standard:sand",
    depth_top = 1,
    node_filler = "nokore_world_standard:sand",
    depth_filler = 3,
    node_riverbed = "nokore_world_standard:sand",
    depth_riverbed = 3,
    node_cave_liquid = "nokore_world_water:sea_water_source",
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    vertical_blend = 1,
    y_max = -2,
    y_min = -255,
    heat_point = 55,
    humidity_point = 40,
  })
end

if foundation.is_module_present("nokore_world_water") and
   foundation.is_module_present("nokore_world_lava") then
  minetest.register_biome({
    name = "mushroom_forest_under",
    node_cave_liquid = {
      "nokore_world_standard:fresh_water_source",
      "nokore_world_lava:lava_source",
    },
    node_dungeon = "nokore_world_standard:cobble",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    y_max = -256,
    y_min = -31000,
    heat_point = 55,
    humidity_point = 40,
  })
end
