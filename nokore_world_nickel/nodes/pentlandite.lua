local mod = assert(nokore_world_nickel)

-- also contains iron, fyi
mod:register_node("pentlandite", {
  description = mod.S("Pentlandite"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  drop = "nokore_world_nickel:nickel_lump 4",

  tiles = {
    "world_pentlandite.png",
  },
})

