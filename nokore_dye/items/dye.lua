local mod = nokore_dye
for _, color in ipairs(nokore_dye.colors) do
  mod:register_craftitem("dye_" .. color.name, {
    basename = "nokore_dye:dye",
    base_description = mod.S("Dye"),

    description = mod.S(color.description .. " Dye"),

    groups = {
      dye = 1,
      ["dye_" .. color.name] = 1,
    },

    dye_color = color.name,

    inventory_image = "dye_" .. color.name .. ".png",
  })
end
