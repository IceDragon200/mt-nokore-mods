local mod = assert(nokore_world_zinc)

mod:register_node("zinc_block", {
  description = mod.S("Zinc Block"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  tiles = {
    "world_zinc_block.png",
  },
})
