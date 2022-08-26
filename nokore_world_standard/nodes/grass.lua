local mod = nokore_world_standard

mod:register_node("dirt_with_grass", {
  description = mod.S("Dirt with Grass"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    soil = 1,
    spreading_dirt_type = 1,
  },

  tiles = {
    "world_grass.png",
    "world_dirt.png",
    {
      name = "world_dirt.png^world_grass_side.png",
      tileable_vertical = false,
    },
  },

  drop = "nokore_world_standard:dirt",

  sounds = nokore.node_sounds:build("dirt", {
    sounds = {
      footstep = { name = "default_grass_footstep", gain = 0.25 },
    },
  }),
})

mod:register_node("dirt_with_dry_grass", {
  description = mod.S("Dirt with Savanna Grass"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    soil = 1,
    spreading_dirt_type = 1,
  },

  tiles = {
    "world_dry_grass.png",
    "world_dirt.png",
    {
      name = "world_dirt.png^world_dry_grass_side.png",
      tileable_vertical = false
    }
  },

  drop = "nokore_world_standard:dirt",

  sounds = nokore.node_sounds:build("dirt", {
    sounds = {
      footstep = { name = "default_grass_footstep", gain = 0.4 },
    },
  }),
})

mod:register_node("dirt_with_rainforest_litter", {
  description = mod.S("Dirt with Rainforest Litter"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    soil = 1,
    spreading_dirt_type = 1,
  },

  tiles = {
    "world_rainforest_litter.png",
    "world_dirt.png",
    {
      name = "world_dirt.png^world_rainforest_litter_side.png",
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

mod:register_node("dirt_with_coniferous_litter", {
  description = mod.S("Dirt with Coniferous Litter"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    soil = 1,
    spreading_dirt_type = 1,
  },

  drop = "nokore_world_standard:dirt",

  tiles = {
    "world_coniferous_litter.png",
    "world_dirt.png",
    {
      name = "world_dirt.png^world_coniferous_litter_side.png",
      tileable_vertical = false
    }
  },

  sounds = nokore.node_sounds:build("dirt", {
    sounds = {
      footstep = { name = "default_grass_footstep", gain = 0.4 },
    },
  }),
})

mod:register_node("dry_dirt", {
  description = mod.S("Savanna Dirt"),

  groups = {
    crumbly = nokore.dig_class("stone"),
    soil = 1,
  },

  tiles = {
    "world_dry_dirt.png",
  },

  sounds = nokore.node_sounds:build("dirt"),
})

mod:register_node("dry_dirt_with_dry_grass", {
  description = mod.S("Savanna Dirt with Savanna Grass"),

  groups = {
    crumbly = nokore.dig_class("stone"),
    soil = 1,
  },

  tiles = {
    "world_dry_grass.png",
    "world_dry_dirt.png",
    {
      name = "world_dry_dirt.png^world_dry_grass_side.png",
      tileable_vertical = false,
    }
  },

  drop = "nokore_world_standard:dry_dirt",

  sounds = nokore.node_sounds:build("dirt", {
    sounds = {
      footstep = { name = "default_grass_footstep", gain = 0.4 },
    },
  }),
})
