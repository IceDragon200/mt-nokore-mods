--
-- A magical looking mushroom
--
local mod = nokore_world_giant_mushroom

mod:register_node("blue_cap", {
  description = mod.S("Mushroom Blue Cap"),

  groups = {
    crumbly = 1,
  },

  tiles = {
    "mushroom_block_skin_blue.png",
  }
})
