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
    base_description = "Wood Door",

    description = mod.S(description .. " Door"),

    groups = {
      cracky = 1,
      chest = 1,
      wood_door = 1,
    },

    tiles = {
      "door_wood_" .. wood_name .. "_top.png",
      "door_wood_" .. wood_name .. "_top.png",
      "door_wood_" .. wood_name .. "_side.png",
      "door_wood_" .. wood_name .. "_side.png",
      "door_wood_" .. wood_name .. "_front.png",
      "door_wood_" .. wood_name .. "_inside.png",
    },
  })
end
