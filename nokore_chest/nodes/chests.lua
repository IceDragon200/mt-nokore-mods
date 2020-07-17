local mod = nokore_chest

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
  mod:register_chest("nokore_chest:chest_wood_" .. wood_name, {
    description = mod.S(description .. " Chest"),

    groups = {
      cracky = 1,
      chest = 1,
      wood_chest = 1,
    },

    tiles = {
      "chest_top.png",
      "chest_top.png",
      "chest_side.png",
      "chest_side.png",
      "chest_front.png",
      "chest_inside.png",
    },
  })
end
