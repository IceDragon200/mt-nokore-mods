--
-- NoKore - Mapgen Water
--
-- Adds the water nodes as mapgen aliases
local mod = foundation.new_module("nokore_mapgen_water", "0.1.0")

minetest.register_alias("mapgen_water_source", "nokore_world_water:fresh_water_source")
minetest.register_alias("mapgen_river_water_source", "nokore_world_water:river_water_source")
