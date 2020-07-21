--
-- NoKore - Biome : Desert
--
-- This module adds the desert biome(s)
local mod = nokore.new_module("nokore_biome_desert", "0.1.0")

minetest.register_biome({
  name = "desert",
  node_top = "nokore_world_standard:desert_sand",
  depth_top = 1,
  node_filler = "nokore_world_standard:desert_sand",
  depth_filler = 1,
  node_stone = "nokore_world_standard:desert_stone",
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:desert_stone",
  node_dungeon_stair = "nokore_world_standard:desert_stone_stair",
  y_max = 31000,
  y_min = 4,
  heat_point = 92,
  humidity_point = 16,
})

minetest.register_biome({
  name = "sandstone_desert",
  node_top = "nokore_world_standard:sand",
  depth_top = 1,
  node_filler = "nokore_world_standard:sand",
  depth_filler = 1,
  node_stone = "nokore_world_standard:sandstone",
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:sandstone_brick",
  node_dungeon_stair = "nokore_world_standard:sandstone_brick_stair",
  y_max = 31000,
  y_min = 4,
  heat_point = 60,
  humidity_point = 0,
})

minetest.register_biome({
  name = "cold_desert",
  node_top = "nokore_world_standard:silver_sand",
  depth_top = 1,
  node_filler = "nokore_world_standard:silver_sand",
  depth_filler = 1,
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
  y_max = 31000,
  y_min = 4,
  heat_point = 40,
  humidity_point = 0,
})

if nokore.is_module_present("nokore_world_water") then
  minetest.register_biome({
    name = "desert_ocean",
    node_top = "nokore_world_standard:sand",
    depth_top = 1,
    node_filler = "nokore_world_standard:sand",
    depth_filler = 3,
    node_stone = "nokore_world_standard:desert_stone",
    node_riverbed = "nokore_world_standard:sand",
    depth_riverbed = 2,
    node_cave_liquid = "nokore_world_water:fresh_water_source",
    node_dungeon = "nokore_world_standard:desert_stone",
    node_dungeon_stair = "nokore_world_standard:desert_stone_stair",
    vertical_blend = 1,
    y_max = 3,
    y_min = -255,
    heat_point = 92,
    humidity_point = 16,
  })

  minetest.register_biome({
    name = "sandstone_desert_ocean",
    node_top = "nokore_world_standard:sand",
    depth_top = 1,
    node_filler = "nokore_world_standard:sand",
    depth_filler = 3,
    node_stone = "nokore_world_standard:sandstone",
    node_riverbed = "nokore_world_standard:sand",
    depth_riverbed = 2,
    node_cave_liquid = "nokore_world_water:fresh_water_source",
    node_dungeon = "nokore_world_standard:sandstone_brick",
    node_dungeon_stair = "nokore_world_standard:sandstone_brick_stair",
    y_max = 3,
    y_min = -255,
    heat_point = 60,
    humidity_point = 0,
  })

  minetest.register_biome({
    name = "cold_desert_ocean",
    node_top = "nokore_world_standard:sand",
    depth_top = 1,
    node_filler = "nokore_world_standard:sand",
    depth_filler = 3,
    node_riverbed = "nokore_world_standard:sand",
    depth_riverbed = 2,
    node_cave_liquid = "nokore_world_water:fresh_water_source",
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    vertical_blend = 1,
    y_max = 3,
    y_min = -255,
    heat_point = 40,
    humidity_point = 0,
  })
end
