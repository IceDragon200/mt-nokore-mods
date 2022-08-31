--
-- NoKore - Mapgen Snow
--
-- Adds the snow nodes as mapgen aliases
foundation.new_module("nokore_mapgen_snow", "0.1.0")

-- Mapgen V6
minetest.register_alias("mapgen_snow", "nokore_world_snow:snow")
minetest.register_alias("mapgen_dirt_with_snow", "nokore_world_snow:dirt_with_snow")
minetest.register_alias("mapgen_snowblock", "nokore_world_snow:snow_block")
minetest.register_alias("mapgen_ice", "nokore_world_snow:ice")
