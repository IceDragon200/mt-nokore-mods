--
-- Brown, harmless and still oversized
--
local mod = nokore_world_giant_mushroom

mod:register_node("brown_cap", {
  description = mod.S("Mushroom Brown Cap"),

  groups = {
    crumbly = nokore.dig_class("stone"),
  },

  tiles = {
    "mushroom_block_skin_brown.png",
  }
})
