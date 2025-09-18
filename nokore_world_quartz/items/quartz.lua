local mod = assert(nokore_world_quartz)

mod:register_craftitem("quartz", {
  description = mod.S("Quartz"),

  groups = {
    mat_quartz = 1,
  },

  inventory_image = "quartz.png",
})
