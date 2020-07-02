local mod = nokore_world_standard

mod:register_node("gravel", {
  description = mod.S("Gravel"),

  groups = { crumbly = 2, falling_node = 1 },

  tiles = {
    "world_gravel.png",
  },

  sounds = nokore.node_sounds:build("gravel"),

  drop = {
    max_items = 1,
    items = {
      {items = {"nokore_world_standard:flint"}, rarity = 16},
      {items = {"nokore_world_standard:gravel"}}
    }
  }
})
