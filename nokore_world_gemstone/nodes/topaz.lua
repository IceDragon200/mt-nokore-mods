--- Topaz = Al2SiO4(F,OH)2
local mod = assert(nokore_world_gemstone)

mod:register_node("topaz_block", {
  description = mod.S("Topaz Block"),

  groups = {
    topaz = 1,
    cracky = nokore.dig_class("bronze"),
  },

  tiles = {
    "world_topaz_block.png",
  }
})
