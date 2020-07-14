local mod = nokore_world_pumpkin

mod:register_node("pumpkin", {
  description = mod.S("Pumpkin"),

  groups = {
    cracky = 2,
    oddly_breakable_by_hand = 1,
  },

  tiles = {
    "world_pumpkin_top.png",
    "world_pumpkin_top.png",
    "world_pumpkin_side.png",
  },

  paramtype2 = "facedir",
})
