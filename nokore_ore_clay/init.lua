--
-- NoKore - Ore / Clay
--
-- Adds clay ores to the world gen
local mod = foundation.new_module("nokore_ore_clay", "0.1.0")

minetest.register_ore({
  ore_type        = "blob",
  ore             = "nokore_world_clay:block",
  wherein         = {"nokore_world_standard:sand"},
  clust_scarcity  = 16 * 16 * 16,
  clust_size      = 5,
  y_max           = 0,
  y_min           = -15,
  noise_threshold = 0.0,
  noise_params    = {
    offset = 0.5,
    scale = 0.2,
    spread = {x = 5, y = 5, z = 5},
    seed = -316,
    octaves = 1,
    persist = 0.0
  },
})
