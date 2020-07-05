local mod = nokore_world_bone

mod:register_node("bone", {
  description = mod.S("Bone"),

  groups = {
    cracky = 1,
    bone = 1,
  },

  tiles = {
    "world_bone_block_top.png",
    "world_bone_block_top.png",
    "world_bone_block_side.png",
  }
})
