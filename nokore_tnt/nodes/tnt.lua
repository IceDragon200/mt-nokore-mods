local mod = assert(nokore_tnt)

mod:register_node("tnt", {
  description = mod.S("TNT"),

  groups = {
    cracky = nokore.dig_class("wme"),
  },

  tiles = {
    "tnt_top.png",
    "tnt_bottom.png",
    "tnt_side.png",
    "tnt_side.png",
    "tnt_side.png",
    "tnt_side.png",
  },

  paramtype2 = "facedir",
})
