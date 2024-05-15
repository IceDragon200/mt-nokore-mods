--- Sapphire = Al2O3
local mod = assert(nokore_world_gemstone)

mod:register_node("sapphire_block", {
  description = mod.S("Sapphire Block"),

  groups = {
    sapphire = 1,
    cracky = nokore.dig_class("bronze"),
  },

  tiles = {
    "world_sapphire_block.png",
  }
})
