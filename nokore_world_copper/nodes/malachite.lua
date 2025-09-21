local mod = assert(nokore_world_copper)

mod:register_node("malachite", {
  description = mod.S("Malachite"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  drop = "nokore_world_copper:copper_lump 4",

  tiles = {
    "world_copper_block.png",
  },
})
