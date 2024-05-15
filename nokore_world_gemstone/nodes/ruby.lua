--- Ruby = Al2O3:Cr
local mod = assert(nokore_world_gemstone)

mod:register_node("ruby_block", {
  description = mod.S("Ruby Block"),

  groups = {
    ruby = 1,
    cracky = nokore.dig_class("bronze"),
  },

  tiles = {
    "world_ruby_block.png",
  }
})
