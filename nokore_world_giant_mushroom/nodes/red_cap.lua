--
-- A red skinned oversized mushroom
--
local mod = nokore_world_giant_mushroom

mod:register_node("red_cap", {
  description = mod.S("Mushroom Red Cap"),

  groups = {
    crumbly = nokore.dig_class("stone"),
  },

  tiles = {
    "mushroom_block_skin_red.png",
  }
})
