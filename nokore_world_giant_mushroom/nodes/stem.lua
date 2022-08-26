local mod = nokore_world_giant_mushroom

mod:register_node("stem", {
  description = mod.S("Mushroom Stem"),

  groups = {
    crumbly = nokore.dig_class("stone"),
  },

  tiles = {
    "mushroom_block_inside.png",
    "mushroom_block_inside.png",
    "mushroom_block_skin_stem.png",
    "mushroom_block_skin_stem.png",
    "mushroom_block_skin_stem.png",
    "mushroom_block_skin_stem.png",
  }
})
