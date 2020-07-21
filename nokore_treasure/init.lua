--
-- NoKore - Treasure
--
-- Adds the placeholder treasure node which is replaced by an LBM on load
-- Treasure nodes are intended to be used by worldgen to generate containers.
local mod = nokore.new_module("nokore_treasure", "0.1.0")

-- The treasure system allows mod creators to register various treasure lists
-- treasure lists are weighted lists containing various item stacks
-- those treasure lists can be bound to a treasure group which is denoted by the params in the treasure node
-- the container for a treasure can be randomized as well (i.e. crypt vs chest)
