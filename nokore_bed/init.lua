--
-- NoKore - Bed
--
-- Beds allow players to set their spawn point upon sleeping in one
-- If nokore_dye is installed, it will add the additional color variants
local mod = nokore.new_module("nokore_bed", "0.1.0")

dofile(mod.modpath .. "/api.lua")

dofile(mod.modpath .. "/nodes/bed.lua")
