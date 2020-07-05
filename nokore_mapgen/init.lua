--
-- NoKore - Mapgen
--
-- This module handles clearing the core mapgen before allowing the other mapgen mods from updating it
local mod = nokore.new_module("nokore_mapgen", "0.1.0")

-- Clear existing registration
minetest.clear_registered_ores()
minetest.clear_registered_decorations()
