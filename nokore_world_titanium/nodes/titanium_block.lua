local mod = assert(nokore_world_titanium)

mod:register_node("titanium_block", {
  description = mod.S("Titanium Block"),

  groups = {
    cracky = nokore.dig_class("carbon_steel"),
  },

  tiles = {
    "world_titanium_block.png",
  },
})
