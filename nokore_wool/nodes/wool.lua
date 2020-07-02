local mod = nokore_bed

local colors = {
  {"white", "White"}
}

if rawget(_G, "dye") then
  colors = dye.dyes
end

for _, row in ipairs(colors) do
  local color = row[1]
  local description = row[2]

  mod:register_bed("wool_" .. color, {
    description = m.S(description .. " Wool"),

    groups = {
      wool = 1,
      ["wool_" .. color] = 1,
    }
  })
end
