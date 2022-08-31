--
-- NoKore - Mapgen Decoration / Flower
--
foundation.new_module("nokore_mapgen_decor_flower", "0.1.0")

local function register_flower(name, seed)
  minetest.register_decoration({
    name = name,
    deco_type = "simple",
    place_on = {"default:dirt_with_grass"},
    sidelen = 16,
    noise_params = {
      offset = -0.02,
      scale = 0.04,
      spread = {x = 200, y = 200, z = 200},
      seed = seed,
      octaves = 3,
      persist = 0.6
    },
    biomes = {"grassland", "deciduous_forest"},
    y_max = 31000,
    y_min = 1,
    decoration = name,
  })
end

register_flower("nokore_world_flower:allium", 8764)
register_flower("nokore_world_flower:blue_orchid", 36662)
register_flower("nokore_world_flower:dandelion", 1220999)
register_flower("nokore_world_flower:houstonia", 800081)
register_flower("nokore_world_flower:oxeye_daisy", 73133)
register_flower("nokore_world_flower:rose", 436)
register_flower("nokore_world_flower:tulip_orange", 19822)
register_flower("nokore_world_flower:tulip_pink", 19823)
register_flower("nokore_world_flower:tulip_red", 19824)
register_flower("nokore_world_flower:tulip_white", 19825)
