local mod = nokore_world_cobweb

mod:register_node("cobweb", {
  description = mod.S("Cobweb"),

  groups = {
    snappy = 1,
    oddly_breakable_by_hand = 1,
  },

  drawtype = "plantlike",
  tiles = {
    "world_cobweb.png",
  },
  use_texture_alpha = "clip",

  paramtype = "light",

  walkable = false,
})
