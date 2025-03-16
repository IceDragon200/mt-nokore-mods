--
-- NoKore - Mapgen Decoration / Tree / Acacia
--
local mod = foundation.new_module("nokore_mapgen_decor_tree_acacia", "0.1.0")

--dofile(mod.modpath .. "/schematics.lua")

local seed = nokore_mapgen.tree_seed

if nokore_mapgen.enable_trees then
  minetest.register_decoration({
    name = "nokore_mapgen_decor_tree_acacia:acacia_tree",
    deco_type = "schematic",
    place_on = {"nokore_world_standard:dry_dirt_with_dry_grass"},
    sidelen = 16,
    noise_params = {
      offset = 0,
      scale = 0.002,
      spread = {x = 256, y = 256, z = 256},
      seed = seed,
      octaves = 3,
      persistence = 0.66,
      lacunarity = 2.0,
    },
    biomes = {"savanna"},
    y_max = 31000,
    y_min = 1,
    schematic = mod.modpath .. "/schematics/nokore_acacia_tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
  })
end
