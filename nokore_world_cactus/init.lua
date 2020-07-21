--
-- Nokore - Cactus
--
-- Adds a cactus node
local mod = nokore.new_module("nokore_world_cactus", "0.1.0")

nokore.node_sounds:register("cactus", {})

dofile(mod.modpath .. "/nodes.lua")
