local mod = nokore_world_coal

mod:register_craftitem("coal_lump", {
  description = mod.S("Coal Lump"),

  groups = {
    coal = 1,
    solid_fuel = 1,
  },

  inventory_image = "world_coal_lump.png",
})
