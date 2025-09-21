local mod = assert(nokore_world_tungsten)

--- Also contains iron, manganese (we don't have that)
mod:register_node("wolframite", {
  description = mod.S("Wolframite"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  drop = "nokore_world_tungsten:tungsten_lump 4",

  tiles = {
    "world_wolframite.png",
  },
})

