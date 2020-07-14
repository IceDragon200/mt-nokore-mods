local mod = nokore_world_fern

mod:register_mod("fern", {
  description = mod.S("Fern"),

  groups = {
    bush = 1,
  },

  drawtype = "plantlike",
  tiles = {
    "world_fern.png"
  },
})

mod:register_mod("fern_short", {
  description = mod.S("Short Fern"),

  groups = {
    bush = 1,
  },

  drawtype = "plantlike",
  tiles = {
    "world_fern_short.png"
  },
})
