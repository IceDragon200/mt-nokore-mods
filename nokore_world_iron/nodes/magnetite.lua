local mod = assert(nokore_world_iron)

mod:register_node("magnetite", {
  description = mod.S("Magnetite"),

  groups = {
    cracky = nokore.dig_class("bronze"),
  },

  drop = "nokore_world_iron:iron_lump 4",

  tiles = {
    "world_magnetite.png",
  },
})
