--
-- Nokore - World - Bamboo
--
local mod = nokore.new_module("nokore_world_bamboo", "0.1.0")

nokore.node_sounds:register("bamboo_leaves", {})
nokore.node_sounds:register("bamboo", {})

dofile(mod.modpath .. "/nodes/bamboo_stalk.lua")
dofile(mod.modpath .. "/nodes/bamboo_leaves.lua")
dofile(mod.modpath .. "/nodes/bamboo_shoot.lua")
