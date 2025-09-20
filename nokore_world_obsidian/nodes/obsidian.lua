local mod = assert(nokore_world_obsidian)

mod:register_node("obsidian", {
  description = mod.S("Obsidian"),

  groups = {
    cracky = nokore.dig_class("invar"),
    mat_obsidian_block = 1,
  },

  is_ground_content = false,

  tiles = {
    "world_obsidian.png",
  },
})
