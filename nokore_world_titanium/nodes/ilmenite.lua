local mod = assert(nokore_world_titanium)

-- Also contains iron
mod:register_node("ilmenite", {
  description = mod.S("Ilmenite"),

  groups = {
    cracky = nokore.dig_class("steel"),
  },

  drop = "nokore_world_titanium:titanium_lump 4",

  tiles = {
    "world_ilmenite.png",
  },
})

