local mod = nokore_door

local wood = {
  acacia = "Acacia",
  big_oak = "Big Oak",
  birch = "Birch",
  fir = "Fir",
  jungle = "Jungle",
  oak = "Oak",
  sakura = "Sakura",
  spruce = "Spruce",
  willow = "Willow",
}

for wood_name, description in pairs(wood) do
  mod:register_door("nokore_door:door_wood_" .. wood_name, {
    node = {
      base_description = "Wood Door",

      description = mod.S(description .. " Door"),

      groups = {
        choppy = nokore.dig_class("wme"),
        wood_door = 1,
      },
      use_texture_alpha = "clip",
    },
    bottom = {
      tiles = {
        "nokore_door_" .. wood_name .. "_side.png",
        "nokore_door_" .. wood_name .. "_side.png",
        "nokore_door_" .. wood_name .. "_side.png^[transformFX",
        "nokore_door_" .. wood_name .. "_side.png",
        {
          name = "nokore_door_" .. wood_name .. "_bottom_front.png^[transformFX",
          backface_culling = false,
        },
        {
          name = "nokore_door_" .. wood_name .. "_bottom_front.png",
          backface_culling = false,
        },
      },
    },
    top = {
      tiles = {
        "nokore_door_" .. wood_name .. "_side.png",
        "nokore_door_" .. wood_name .. "_side.png",
        "nokore_door_" .. wood_name .. "_side.png^[transformFX",
        "nokore_door_" .. wood_name .. "_side.png",
        {
          name = "nokore_door_" .. wood_name .. "_top_front.png^[transformFX",
          backface_culling = false,
        },
        {
          name = "nokore_door_" .. wood_name .. "_top_front.png",
          backface_culling = false,
        },
      },
    },
    item = {
      inventory_image = "nokore_door_" .. wood_name .. ".item.png",

      description = mod.S(description .. " Door"),
    },
  })
end
