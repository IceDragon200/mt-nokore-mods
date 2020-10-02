local mod = nokore_sieve

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

for basename,name in pairs(wood) do
  mod:register_node(basename .. "_sieve", {
    description = mod.S(name .. " Sieve"),

    groups = {
      sieve = 1,
      choppy = 1,
      oddly_breakable_by_hand = 2,
    },

    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        -- corners
        {-1/2, 2/16, -1/2, 1/2, 1/2, -7/16}, -- horz top
        {-1/2, 2/16,  7/16, 1/2, 1/2,  1/2}, -- horz bottom
        {-1/2, 2/16, -1/2, -7/16, 1/2, 1/2}, -- vert left
        {7/16, 2/16, -1/2, 1/2, 1/2, 1/2}, -- vert right

        {-7/16, 6/32, -7/16, 7/16, 7/32, 7/16}, -- mesh
        -- legs
        {-7/16, -1/2, -7/16, -6/16, 1/2, -6/16},
        {6/16, -1/2, -6/16, 7/16, 1/2, -7/16},
        {-7/16, -1/2, 6/16, -6/16, 1/2, 7/16},
        {6/16, -1/2, 6/16, 7/16, 1/2, 7/16},
      }
    },
    use_texture_alpha = true,
    tiles = {
      "nokore_sieve_wood_" .. basename .. "_top.png",
      "nokore_sieve_wood_" .. basename .. "_top.png",
      "nokore_sieve_wood_" .. basename .. "_side.png",
      "nokore_sieve_wood_" .. basename .. "_side.png",
      "nokore_sieve_wood_" .. basename .. "_side.png",
      "nokore_sieve_wood_" .. basename .. "_side.png",
    },

    paramtype = "light",
  })
end
