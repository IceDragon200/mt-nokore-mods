local mod = nokore_wool

local colors = {
  {"white", "White"}
}

if rawget(_G, "dye") then
  colors = dye.dyes
end

for _, row in ipairs(colors) do
  local color = row[1]
  local description = row[2]

  mod:register_node("wool_" .. color, {
    description = mod.S(description .. " Wool"),

    groups = {
      snappy = nokore.dig_class("wme"),
      choppy = nokore.dig_class("wme"),
      oddly_breakable_by_hand = nokore.dig_class("hand"),
      --
      wool = 1,
      wool_block = 1,
      ["wool_block_" .. color] = 1,
    },

    tiles = {
      "wool_" .. color .. ".png",
    },

    sounds = nokore.node_sounds:build("wool"),
  })
end
