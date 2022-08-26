local mod = nokore_world_cobweb

mod:register_node("cobweb", {
  description = mod.S("Cobweb"),

  groups = {
    snappy = nokore.dig_class("wme"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
  },

  drawtype = "plantlike",
  tiles = {
    "world_cobweb.png",
  },
  use_texture_alpha = "clip",

  paramtype = "light",

  walkable = false,
})
