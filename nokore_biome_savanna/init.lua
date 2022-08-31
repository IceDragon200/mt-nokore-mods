--
-- NoKore - Biome : Savanna
--
-- This module adds the savanna biome(s)
foundation.new_module("nokore_biome_savanna", "0.1.0")

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
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
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
  node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
  y_max = 0,
  y_min = -1,
  heat_point = 89,
  humidity_point = 42,
})

if foundation.is_module_present("nokore_world_water") then
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
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    vertical_blend = 1,
    y_max = -2,
    y_min = -255,
    heat_point = 89,
    humidity_point = 42,
  })
end

if foundation.is_module_present("nokore_world_water") and
   foundation.is_module_present("nokore_world_lava") then
  minetest.register_biome({
    name = "savanna_under",
    node_cave_liquid = {
      "nokore_world_water:fresh_water_source",
      "nokore_world_lava:lava_source",
    },
    node_dungeon = "nokore_world_standard:cobblestone",
    node_dungeon_alt = "nokore_world_standard:mossy_cobblestone",
    node_dungeon_stair = "nokore_world_standard:cobblestone_stair",
    y_max = -256,
    y_min = -31000,
    heat_point = 89,
    humidity_point = 42,
  })
end

minetest.register_decoration({
  deco_type = "simple",
  place_on = {"nokore_world_standard:dry_dirt_with_dry_grass"},
  sidelen = 4,
  noise_params = {
    offset = -1.5,
    scale = -1.5,
    spread = {x = 200, y = 200, z = 200},
    seed = 329,
    octaves = 4,
    persist = 1.0
  },
  biomes = {"savanna"},
  y_max = 31000,
  y_min = 1,
  decoration = "nokore_world_standard:dry_dirt",
  place_offset_y = -1,
  flags = "force_placement",
})
