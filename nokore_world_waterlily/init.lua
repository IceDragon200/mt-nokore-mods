--
-- NoKore - World - Waterlily
--
local mod = foundation.new_module("nokore_world_waterlily", "0.1.0")

nokore.node_sounds:register("waterlily", {
  extends = {},
  sounds = {},
})

dofile(mod.modpath .. "/nodes/waterlily.lua")
