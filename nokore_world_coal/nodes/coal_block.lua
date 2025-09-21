local mod = assert(nokore_world_coal)

mod:register_node("coal_block", {
  description = mod.S("Coal Block"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  tiles = {
    "world_coal_block.png",
  },
})
