--- Amethyst = SiO2
local mod = assert(nokore_world_gemstone)

mod:register_node("amethyst_block", {
  description = mod.S("Amethyst Block"),

  groups = {
    emerald = 1,
    cracky = nokore.dig_class("bronze"),
  },

  tiles = {
    "world_amethyst_block.png",
  }
})
