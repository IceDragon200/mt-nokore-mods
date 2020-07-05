--
-- NoKore - Mapgen Standard
--
-- Adds the standard nodes as mapgen aliases
local mod = nokore.new_module("nokore_mapgen_standard", "0.1.0")

-- Common
minetest.register_alias("mapgen_stone", "nokore_world_standard:stone")

-- Mapgen V6
minetest.register_alias("mapgen_dirt", "nokore_world_standard:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "nokore_world_standard:dirt_with_grass")
minetest.register_alias("mapgen_sand", "nokore_world_standard:sand")
minetest.register_alias("mapgen_gravel", "nokore_world_standard:gravel")
minetest.register_alias("mapgen_desert_stone", "nokore_world_standard:desert_stone")
minetest.register_alias("mapgen_desert_sand", "nokore_world_standard:desert_sand")
minetest.register_alias("mapgen_cobble", "nokore_world_standard:cobblestone")
minetest.register_alias("mapgen_mossycobble", "nokore_world_standard:mossy_cobblestone")
