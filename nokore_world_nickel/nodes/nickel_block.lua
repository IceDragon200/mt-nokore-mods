local mod = assert(nokore_world_nickel)

mod:register_node("nickel_block", {
  description = mod.S("Nickel Block"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  tiles = {
    "world_nickel_block.png",
  },
})
