--
-- NoKore - Ore / Copper
--
-- Adds copper ores to the world gen
local mod = nokore.new_module("nokore_ore_copper", "0.1.0")

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "nokore_world_copper:stone_with_copper",
  wherein        = "nokore_world_standard:stone",
  clust_scarcity = 9 * 9 * 9,
  clust_num_ores = 5,
  clust_size     = 3,
  y_max          = 31000,
  y_min          = 1025,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "nokore_world_copper:stone_with_copper",
  wherein        = "nokore_world_standard:stone",
  clust_scarcity = 12 * 12 * 12,
  clust_num_ores = 4,
  clust_size     = 3,
  y_max          = -64,
  y_min          = -127,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "nokore_world_copper:stone_with_copper",
  wherein        = "nokore_world_standard:stone",
  clust_scarcity = 9 * 9 * 9,
  clust_num_ores = 5,
  clust_size     = 3,
  y_max          = -128,
  y_min          = -31000,
})
