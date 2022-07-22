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
        choppy = 1,
        wood_door = 1,
      },
    },
    bottom = {
      tiles = {
        "nokore_door_" .. wood_name .. "_top.png",
        "nokore_door_" .. wood_name .. "_top.png",
        "nokore_door_" .. wood_name .. "_side.png^[transformFX",
        "nokore_door_" .. wood_name .. "_side.png",
        "nokore_door_" .. wood_name .. "_bottom_front.png^[transformFX",
        "nokore_door_" .. wood_name .. "_bottom_front.png",
      },
    },
    top = {
      tiles = {
        "nokore_door_" .. wood_name .. "_top.png",
        "nokore_door_" .. wood_name .. "_top.png",
        "nokore_door_" .. wood_name .. "_side.png^[transformFX",
        "nokore_door_" .. wood_name .. "_side.png",
        "nokore_door_" .. wood_name .. "_top_front.png^[transformFX",
        "nokore_door_" .. wood_name .. "_top_front.png",
      },
    },
    item = {
      inventory_image = "nokore_door_" .. wood_name .. ".png",

      description = mod.S(description .. " Door"),
    },
  })
end
