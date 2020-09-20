--
-- NoKore - World - Vine
--
local mod = foundation.new_module("nokore_world_vine", "0.1.0")

nokore.node_sounds:register("vine", {
  extends = {},
  sounds = {},
})

dofile(mod.modpath .. "/nodes/vine.lua")
