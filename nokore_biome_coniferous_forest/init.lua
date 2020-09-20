--
-- NoKore - Biome : Coniferous Forest
--
-- This module adds the coniferous forest biome(s)
local mod = foundation.new_module("nokore_biome_coniferous_forest", "0.1.0")

minetest.register_biome({
  name = "coniferous_forest",
  node_top = "nokore_world_standard:dirt_with_coniferous_litter",
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
  humidity_point = 70,
})

minetest.register_biome({
  name = "coniferous_forest_dunes",
  node_top = "nokore_world_standard:sand",
  depth_top = 1,
  node_filler = "nokore_world_standard:sand",
  depth_filler = 3,
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
  vertical_blend = 1,
  y_max = 5,
  y_min = 4,
  heat_point = 45,
  humidity_point = 70,
})

if foundation.is_module_present("nokore_world_water") then
  minetest.register_biome({
    name = "coniferous_forest_ocean",
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
    y_max = 3,
    y_min = -255,
    heat_point = 45,
    humidity_point = 70,
  })
end

if foundation.is_module_present("nokore_world_water") and
   foundation.is_module_present("nokore_world_lava") then
  minetest.register_biome({
    name = "coniferous_forest_under",
    node_cave_liquid = {
      "nokore_world_water:fresh_water_source",
      "nokore_world_lava:lava_source",
    },
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    y_max = -256,
    y_min = -31000,
    heat_point = 45,
    humidity_point = 70,
  })
end
