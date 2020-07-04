local mod = nokore_bed

local colors = {
  {"red", "Red"}
}

if rawget(_G, "dye") then
  colors = dye.dyes
end

for _, row in ipairs(colors) do
  local color = row[1]
  local description = row[2]

  mod:register_bed("bed_" .. color, {
    description = mod.S(description .. " Bed"),

    groups = {
      bed = 1,
    }
  })
end
