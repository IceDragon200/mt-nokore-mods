local mod = nokore_world_melon

mod:register_node("melon", {
  description = mod.S("Melon"),

  groups = {
    cracky = 2,
    oddly_breakable_by_hand = 1,
  },

  tiles = {
    "world_melon_top.png",
    "world_melon_top.png",
    "world_melon_side.png",
  },

  paramtype2 = "facedir",
})
