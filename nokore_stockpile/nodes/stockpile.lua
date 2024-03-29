local mod = nokore_stockpile

local wood = {}

if rawget(_G, "nokore_world_tree_acacia") then
  wood.acacia = {
    description = "Acacia",

    tiles = {
      "nokore_planks_acacia.png",
    },
    use_texture_alpha = "opaque",
  }
end

if rawget(_G, "nokore_world_tree_big_oak") then
  wood.big_oak = {
    description = "Big Oak",

    tiles = {
      "nokore_planks_big_oak.png",
    },
    use_texture_alpha = "opaque",
  }
end

if rawget(_G, "nokore_world_tree_birch") then
  wood.birch = {
    description = "Birch",

    tiles = {
      "nokore_planks_birch.png",
    },
    use_texture_alpha = "opaque",
  }
end

if rawget(_G, "nokore_world_tree_fir") then
  wood.fir = {
    description = "Fir",

    tiles = {
      "nokore_planks_fir.png",
    },
    use_texture_alpha = "opaque",
  }
end

if rawget(_G, "nokore_world_tree_jungle") then
  wood.jungle = {
    description = "Jungle",

    tiles = {
      "nokore_planks_jungle.png",
    },
    use_texture_alpha = "opaque",
  }
end

if rawget(_G, "nokore_world_tree_oak") then
  wood.oak = {
    description = "Oak",

    tiles = {
      "nokore_planks_oak.png",
    },
    use_texture_alpha = "opaque",
  }
end

if rawget(_G, "nokore_world_tree_sakura") then
  wood.sakura = {
    description = "Sakura",

    tiles = {
      "nokore_planks_sakura.png",
    },
    use_texture_alpha = "opaque",
  }
end

if rawget(_G, "nokore_world_tree_spruce") then
  wood.spruce = {
    description = "Spruce",

    tiles = {
      "nokore_planks_spruce.png",
    },
    use_texture_alpha = "opaque",
  }
end

if rawget(_G, "nokore_world_tree_willow") then
  wood.willow = {
    description = "Willow",

    tiles = {
      "nokore_planks_willow.png",
    },
    use_texture_alpha = "opaque",
  }
end

-- Minetest Game's default
if rawget(_G, "default") then
  wood.oak_wood = {
    description = "Apple Wood",
    tiles = {
      "default_wood.png",
    },
    use_texture_alpha = "opaque",
  }

  wood.jungle_wood = {
    description = "Jungle Wood",
    tiles = {
      "default_junglewood.png",
    },
    use_texture_alpha = "opaque",
  }

  wood.pine_wood   = {
    description = "Pine Wood",
    tiles = {
      "default_pine_wood.png",
    },
    use_texture_alpha = "opaque",
  }

  wood.acacia_wood = {
    description = "Acacia Wood",
    tiles = {
      "default_acacia_wood.png",
    },
    use_texture_alpha = "opaque",
  }

  wood.aspen_wood  = {
    description = "Aspen Wood",
    tiles = {
      "default_aspen_wood.png",
    },
    use_texture_alpha = "opaque",
  }
end

for key, entry in pairs(wood) do
  nokore.register_stockpile("nokore_stockpile:stockpile_wood_" .. key, {
    description = mod.S(entry.description .. " Wood Stockpile"),

    groups = {
      cracky = nokore.dig_class("copper"),
      oddly_breakable_by_hand = nokore.dig_class("hand"),
      --
      oddly_breakable_by_hand = 1,
      stockpile = 1,
      wood_stockpile = 1,
      flammable = 1,
    },

    tiles = entry.tiles,

    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-8/16, -6/16, -8/16,  8/16, -5/16,  8/16}, -- plate
        {-8/16, -8/16, -8/16, -6/16, -2/16, -6/16}, -- leg
        { 6/16, -8/16,  6/16,  8/16, -2/16,  8/16}, -- leg
        { 6/16, -8/16, -8/16,  8/16, -2/16, -6/16}, -- leg
        {-8/16, -8/16,  6/16, -6/16, -2/16,  8/16}, -- leg
      },
    },

    sunlight_propagates = true,
    paramtype = "light",
    paramtype2 = "facedir",
  })
end
