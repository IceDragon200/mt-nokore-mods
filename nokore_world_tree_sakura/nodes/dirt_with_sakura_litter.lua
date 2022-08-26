local mod = nokore_world_tree_sakura

mod:register_node("dirt_with_sakura_litter", {
  description = mod.S("Dirt with Sakura Litter"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    --
    soil = 1,
    spreading_dirt_type = 1,
  },

  tiles = {
    "world_sakura_litter.png",
    "world_dirt.png",
    {
      name = "world_dirt.png^world_sakura_litter_side.png",
      tileable_vertical = false,
    },
  },

  drop = "nokore_world_standard:dirt",

  sounds = nokore.node_sounds:build("dirt", {
    sounds = {
      footstep = { name = "default_grass_footstep", gain = 0.4 },
    },
  }),
})
