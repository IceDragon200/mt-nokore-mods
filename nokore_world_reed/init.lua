--
-- NoKore - World - Reed
--
local mod = nokore.new_module("nokore_world_reed", "0.1.0")

nokore.node_sounds:register("reeds", {})

dofile(mod.modpath .. "/nodes/reed.lua")
