--
--
--
local mod = nokore.new_module("nokore_world_standard", "0.1.0")

nokore.node_sounds:register("dirt", {})
nokore.node_sounds:register("stone", {})
nokore.node_sounds:register("gravel", {})
nokore.node_sounds:register("sand", {})

dofile(mod.modpath .. "/nodes.lua")
dofile(mod.modpath .. "/items.lua")
