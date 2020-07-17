--
-- NoKore - Mapgen Lava
--
-- Adds the lava nodes as mapgen aliases
local mod = nokore.new_module("nokore_mapgen_lava", "0.1.0")

-- Mapgen V6
minetest.register_alias("mapgen_lava_source", "nokore_world_lava:lava_source")
