--
-- Nokore - World - Clay
--
local mod = foundation.new_module("nokore_world_clay", "0.1.0")

nokore.node_sounds:register("clay", {})
nokore.node_sounds:register("clay_brick", {})
nokore.node_sounds:register("terracota", {})

mod:require("nodes.lua")
mod:require("items.lua")
