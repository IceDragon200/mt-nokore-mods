--
-- NoKore - Ore / Gold
--
-- Adds gold ores to the world gen
local mod = nokore.new_module("nokore_ore_gold", "0.1.0")

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "nokore_world_gold:stone_with_gold",
  wherein        = "nokore_world_standard:stone",
  clust_scarcity = 13 * 13 * 13,
  clust_num_ores = 5,
  clust_size     = 3,
  y_max          = 31000,
  y_min          = 1025,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "nokore_world_gold:stone_with_gold",
  wherein        = "nokore_world_standard:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_max          = -256,
  y_min          = -511,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "nokore_world_gold:stone_with_gold",
  wherein        = "nokore_world_standard:stone",
  clust_scarcity = 13 * 13 * 13,
  clust_num_ores = 5,
  clust_size     = 3,
  y_max          = -512,
  y_min          = -31000,
})
