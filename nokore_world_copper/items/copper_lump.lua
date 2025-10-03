local mod = assert(nokore_world_copper)

mod:register_craftitem("copper_lump", {
  description = mod.S("Copper Lump"),

  groups = {
    mat_lump = 1,
    mat_lump_copper = 1,
  },

  inventory_image = "world_copper_lump.lua"
})
