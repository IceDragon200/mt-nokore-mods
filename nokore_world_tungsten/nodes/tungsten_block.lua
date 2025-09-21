local mod = assert(nokore_world_tungsten)

mod:register_node("tungsten_block", {
  description = mod.S("Tungsten Block"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  tiles = {
    "world_tungsten_block.png",
  },
})
