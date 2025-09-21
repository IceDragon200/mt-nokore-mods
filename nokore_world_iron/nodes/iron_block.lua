local mod = assert(nokore_world_iron)

mod:register_node("iron_block", {
  description = mod.S("Iron Block"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  tiles = {
    "world_iron_block.png",
  },
})
