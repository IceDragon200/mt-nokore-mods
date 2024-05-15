--- Emerald = Be3Al2(SiO3)6
local mod = assert(nokore_world_gemstone)

mod:register_node("emerald_block", {
  description = mod.S("Emerald Block"),

  groups = {
    emerald = 1,
    cracky = nokore.dig_class("bronze"),
  },

  tiles = {
    "world_emerald_block.png",
  }
})
