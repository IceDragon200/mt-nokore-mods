--
-- NoKore - Mapgen Decoration - Corals
--
foundation.new_module("nokore_mapgen_decor_corals", "0.1.0")

minetest.register_decoration({
  name = "nokore_mapgen_decor_corals:corals",
  deco_type = "simple",
  place_on = {
    "nokore_world_standard:sand"
  },
  place_offset_y = -1,
  sidelen = 4,
  noise_params = {
    offset = -4,
    scale = 4,
    spread = {x = 50, y = 50, z = 50},
    seed = 7013,
    octaves = 3,
    persist = 0.7,
  },
  biomes = {
    "desert_ocean",
    "savanna_ocean",
    "rainforest_ocean",
  },
  y_max = -2,
  y_min = -8,
  flags = "force_placement",
  decoration = {
    "nokore_world_coral:coral_green", "nokore_world_coral:coral_pink",
    "nokore_world_coral:coral_cyan", "nokore_world_coral:coral_brown",
    "nokore_world_coral:coral_orange", "nokore_world_coral:coral_skeleton",
  },
})
