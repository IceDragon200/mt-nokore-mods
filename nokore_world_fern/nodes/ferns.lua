local mod = nokore_world_fern

mod:register_node("fern", {
  description = mod.S("Fern"),

  groups = {
    snippy = nokore.dig_class("wme"),
    snappy = nokore.dig_class("wme"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
    bush = 1,
  },

  drawtype = "plantlike",
  tiles = {
    "world_fern.png"
  },
})

mod:register_node("fern_short", {
  description = mod.S("Short Fern"),

  groups = {
    snippy = nokore.dig_class("wme"),
    snappy = nokore.dig_class("wme"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
    bush = 1,
  },

  drawtype = "plantlike",
  tiles = {
    "world_fern_short.png"
  },
})
