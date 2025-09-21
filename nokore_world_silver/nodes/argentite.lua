local mod = assert(nokore_world_silver)

mod:register_node("argentite", {
  description = mod.S("Argentite"),

  groups = {
    cracky = nokore.dig_class("bronze"),
  },

  drop = "nokore_world_silver:silver_lump 4",

  tiles = {
    "world_argentite.png",
  },
})

