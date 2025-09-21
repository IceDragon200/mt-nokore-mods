local mod = assert(nokore_world_copper)

mod:register_node("copper_block", {
  description = mod.S("Copper Block"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  tiles = {
    "world_copper_block.png",
  },
})
