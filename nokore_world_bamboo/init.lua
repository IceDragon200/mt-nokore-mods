--
-- Nokore - World - Bamboo
--
local mod = foundation.new_module("nokore_world_bamboo", "0.1.0")

nokore.node_sounds:register("bamboo_leaves", {})
nokore.node_sounds:register("bamboo", {})

mod:require("nodes/bamboo_stalk.lua")
mod:require("nodes/bamboo_leaves.lua")
mod:require("nodes/bamboo_shoot.lua")

mod:require("abm.lua")
