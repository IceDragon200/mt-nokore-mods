--
-- NoKore - Biome : Savanna
--
-- This module adds the savanna biome(s)
local mod = nokore.new_module("nokore_biome_savanna", "0.1.0")

minetest.register_biome({
  name = "savanna",
  node_top = "nokore_world_standard:dry_dirt_with_dry_grass",
  depth_top = 1,
  node_filler = "nokore_world_standard:dry_dirt",
  depth_filler = 1,
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  --node_dungeon_stair = "stairs:stair_cobble",
  y_max = 31000,
  y_min = 1,
  heat_point = 89,
  humidity_point = 42,
})

minetest.register_biome({
  name = "savanna_shore",
  node_top = "nokore_world_standard:dry_dirt",
  depth_top = 1,
  node_filler = "nokore_world_standard:dry_dirt",
  depth_filler = 3,
  node_riverbed = "nokore_world_standard:sand",
  depth_riverbed = 2,
  node_dungeon = "nokore_world_standard:cobblestone",
  node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
  --node_dungeon_stair = "stairs:stair_cobble",
  y_max = 0,
  y_min = -1,
  heat_point = 89,
  humidity_point = 42,
})

if nokore.is_module_present("nokore_world_water") then
  minetest.register_biome({
    name = "savanna_ocean",
    node_top = "nokore_world_standard:sand",
    depth_top = 1,
    node_filler = "nokore_world_standard:sand",
    depth_filler = 3,
    node_riverbed = "nokore_world_standard:sand",
    depth_riverbed = 2,
    node_cave_liquid = "nokore_world_water:sea_water_source",
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    --node_dungeon_stair = "stairs:stair_cobble",
    vertical_blend = 1,
    y_max = -2,
    y_min = -255,
    heat_point = 89,
    humidity_point = 42,
  })
end

if nokore.is_module_present("nokore_world_water") and
   nokore.is_module_present("nokore_world_lava") then
  minetest.register_biome({
    name = "savanna_under",
    node_cave_liquid = {
      "nokore_world_water:fresh_water_source",
      "nokore_world_lava:lava_source",
    },
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    --node_dungeon_stair = "stairs:stair_cobble",
    y_max = -256,
    y_min = -31000,
    heat_point = 89,
    humidity_point = 42,
  })
end
