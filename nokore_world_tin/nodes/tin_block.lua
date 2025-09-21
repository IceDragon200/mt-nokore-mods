local mod = assert(nokore_world_tin)

mod:register_node("tin_block", {
  description = mod.S("Tin Block"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  tiles = {
    "world_tin_block.png",
  },
})
