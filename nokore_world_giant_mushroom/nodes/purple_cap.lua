--
-- Clearly poisonous, clearly, wait why are you still eating it!?
--
local mod = nokore_world_giant_mushroom

mod:register_node("purple_cap", {
  description = mod.S("Mushroom Purple Cap"),

  groups = {
    crumbly = nokore.dig_class("stone"),
  },

  tiles = {
    "mushroom_block_skin_purple.png",
  }
})
