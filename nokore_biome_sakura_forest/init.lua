--
-- NoKore - Biome : Sakura Forest
--
-- This module adds the sakura forest biome(s)
local mod = nokore.new_module("nokore_biome_sakura_forest", "0.1.0")

minetest.register_biome({
  name = "sakura_forest",
  node_top = "nokore_world_tree_sakura:dirt_with_sakura_litter",
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

minetest.register_biome({
  name = "sakura_forest_shore",
  node_top = "nokore_world_standard:dirt",
  depth_top = 1,
  node_filler = "nokore_world_standard:dirt",
  depth_filler = 3,
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
  y_max = 0,
  y_min = -1,
  heat_point = 45,
  humidity_point = 75,
})

if nokore.is_module_present("nokore_world_water") then
  minetest.register_biome({
    name = "sakura_forest_ocean",
    node_top = "nokore_world_standard:sand",
    depth_top = 1,
    node_filler = "nokore_world_standard:sand",
    depth_filler = 3,
    node_riverbed = "nokore_world_standard:sand",
    depth_riverbed = 2,
    node_cave_liquid = "nokore_world_water:sea_water_source",
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    vertical_blend = 1,
    y_max = -2,
    y_min = -255,
    heat_point = 45,
    humidity_point = 75,
  })
end

if nokore.is_module_present("nokore_world_water") and
   nokore.is_module_present("nokore_world_lava") then
  minetest.register_biome({
    name = "sakura_forest_under",
    node_cave_liquid = {
      "nokore_world_standard:fresh_water_source",
      "nokore_world_lava:lava_source",
    },
    node_dungeon = "nokore_world_standard:cobble",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    y_max = -256,
    y_min = -31000,
    heat_point = 45,
    humidity_point = 75,
  })
end
