local mod = nokore_world_melon

mod:register_node("melon", {
  description = mod.S("Melon"),

  groups = {
    choppy = nokore.dig_class("wme"),
    hacky = nokore.dig_class("wme"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
  },

  tiles = {
    "world_melon_top.png",
    "world_melon_top.png",
    "world_melon_side.png",
  },

  paramtype2 = "facedir",
})
