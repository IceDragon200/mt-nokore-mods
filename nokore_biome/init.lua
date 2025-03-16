--
-- NoKore - Biome
--
-- This module handles clearing the core biomes before allowing the other biome mods
-- from updating it
foundation.new_module("nokore_biome", "0.1.0")

core.clear_registered_biomes()
