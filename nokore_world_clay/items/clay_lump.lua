local mod = assert(nokore_world_clay)

mod:register_craftitem("clay_lump", {
  description = mod.S("Clay Lump"),

  groups = {
    clay = 1,
  },

  inventory_image = "world_clay_lump.png",
})
