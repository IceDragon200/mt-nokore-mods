--
-- Nokore - World - Clay
--
local mod = nokore.new_module("nokore_world_clay", "0.1.0")

nokore.node_sounds:register("clay", {})
nokore.node_sounds:register("clay_brick", {})
nokore.node_sounds:register("hardened_clay", {})

dofile(mod.modpath .. "/nodes/clay.lua")
dofile(mod.modpath .. "/nodes/clay_brick.lua")
dofile(mod.modpath .. "/nodes/hardened_clay.lua")
