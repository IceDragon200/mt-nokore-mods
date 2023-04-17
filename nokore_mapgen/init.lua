--
-- NoKore - Mapgen
--
-- This module handles clearing the core mapgen before allowing the other mapgen mods to
-- begin updating it.
-- This ensures that mapgen starts from a clean slate
local mod = foundation.new_module("nokore_mapgen", "0.1.0")

-- Clear existing registration
minetest.clear_registered_ores()
minetest.clear_registered_decorations()

mod.tree_seed = 0x65674436
