local mod = assert(nokore_world_silver)

mod:register_node("silver_block", {
  description = mod.S("Silver Block"),

  groups = {
    cracky = nokore.dig_class("bronze"),
  },

  tiles = {
    "world_silver_block.png",
  },
})
