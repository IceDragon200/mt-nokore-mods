--
-- NoKore - Ore / Coal
--
-- Adds clay ores to the world gen
local mod = foundation.new_module("nokore_ore_coal", "0.1.0")

-- Coal
minetest.register_ore({
  ore_type       = "scatter",
  ore            = "nokore_world_coal:stone_with_coal",
  wherein        = "nokore_world_standard:stone",
  clust_scarcity = 8 * 8 * 8,
  clust_num_ores = 9,
  clust_size     = 3,
  y_max          = 31000,
  y_min          = 1025,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "nokore_world_coal:stone_with_coal",
  wherein        = "nokore_world_standard:stone",
  clust_scarcity = 8 * 8 * 8,
  clust_num_ores = 8,
  clust_size     = 3,
  y_max          = 64,
  y_min          = -127,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "nokore_world_coal:stone_with_coal",
  wherein        = "nokore_world_standard:stone",
  clust_scarcity = 12 * 12 * 12,
  clust_num_ores = 30,
  clust_size     = 5,
  y_max          = -128,
  y_min          = -31000,
})
