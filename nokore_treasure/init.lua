--
-- NoKore - Treasure
--
-- Adds the placeholder treasure node which is replaced by an LBM on load
-- Treasure nodes are intended to be used by worldgen to generate containers.
local mod = foundation.new_module("nokore_treasure", "0.1.0")

mod:require("treasure_registry.lua")

-- The treasure system allows mod creators to register various treasure lists.
-- Treasure lists are weighted lists containing various item stacks.
-- They can be bound to a treasure group which is denoted by the params in the treasure node
-- the container for a treasure can be randomized as well (i.e. crypt vs chest)
nokore = rawget(_G, "nokore") or {}

nokore.treasure = mod.TreasureRegistry:new()
