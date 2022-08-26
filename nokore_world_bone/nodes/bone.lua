local mod = nokore_world_bone

mod:register_node("bone_block", {
  description = mod.S("Bone"),

  groups = {
    cracky = nokore.dig_class("stone"),
    --
    bone_block = 1,
  },

  tiles = {
    "world_bone_block_top.png",
    "world_bone_block_top.png",
    "world_bone_block_side.png",
  },
})
