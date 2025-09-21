local mod = assert(nokore_world_cobalt)

mod:register_node("cobalt_block", {
  description = mod.S("Cobalt Block"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  tiles = {
    "world_cobalt_block.png",
  },
})
