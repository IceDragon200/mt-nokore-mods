local mod = nokore_world_bone

mod:register_craftitem("bone", {
  description = mod.S("Bone"),

  groups = {
    bone = 1,
  },

  inventory_image = "world_item_bone.png",
})
