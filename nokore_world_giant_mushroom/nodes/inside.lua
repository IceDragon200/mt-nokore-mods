--
-- The soft squishy insides of the mushroom, normally seen on the underside
--
local mod = nokore_world_giant_mushroom

mod:register_node("inside", {
  description = mod.S("Mushroom Inside"),

  groups = {
    crumbly = 1,
  },

  tiles = {
    "mushroom_block_inside.png",
  }
})
