--
-- NoKore - Wool
--
local mod = nokore.new_module("nokore_wool", "0.1.0")

nokore.node_sounds:register("wool", {})

dofile(mod.modpath .. "/nodes.lua")
