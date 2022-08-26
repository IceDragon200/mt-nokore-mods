local mod = nokore_world_pumpkin

mod:register_node("pumpkin", {
  description = mod.S("Pumpkin"),

  groups = {
    choppy = nokore.dig_class("wme"),
    hacky = nokore.dig_class("wme"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
  },

  tiles = {
    "world_pumpkin_top.png",
    "world_pumpkin_top.png",
    "world_pumpkin_side.png",
  },

  paramtype2 = "facedir",
})
