--
-- NoKore - Glass
--
-- This mod adds Glass (and stained glass if dye is available)
local mod = nokore.new_module("nokore_glass", "0.1.0")

nokore.node_sounds:register("glass", {})

dofile(mod.modpath .. "/nodes/glass.lua")
