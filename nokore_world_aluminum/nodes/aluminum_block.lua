local mod = assert(nokore_world_aluminum)

mod:register_node("aluminum_block", {
  description = mod.S("Aluminum Block"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  tiles = {
    "world_aluminum_block.png",
  },
})
