local mod = nokore_stockpile

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

for key, description in pairs(wood) do
  nokore.register_stockpile("nokore_stockpile:stockpile_wood_" .. key, {
    description = mod.S(description .. " Wood Stockpile"),

    groups = {
      cracky = 1,
      oddly_breakable_by_hand = 1,
      stockpile = 1,
      wood_stockpile = 1,
      flammable = 1,
    },

    tiles = {
      "nokore_planks_" .. key .. ".png",
    },

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
