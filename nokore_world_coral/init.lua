--
-- NoKore - World - Coral
--
local mod = foundation.new_module("nokore_world_coral", "0.1.0")

nokore.node_sounds:register("coral", {})

dofile(mod.modpath .. "/nodes/coral.lua")
