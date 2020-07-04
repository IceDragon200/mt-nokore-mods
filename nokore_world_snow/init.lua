--
--
--
local mod = nokore.new_module("nokore_world_snow", "0.1.0")

nokore.node_sounds:register("snow", {})
nokore.node_sounds:register("ice", {})

dofile(mod.modpath .. "/nodes.lua")
