local mod = assert(nokore_world_obsidian)

mod:register_node("obsidian_glass", {
  description = mod.S("Obsidian Glass"),

  groups = {
    cracky = nokore.dig_class("invar"),
    mat_obsidian_glass = 1,
  },

  drop = mod:make_name("obsidian_glass_shard 4"),

  is_ground_content = false,

  drawtype = "glasslike",
  tiles = {
    "world_obsidian_glass.png",
  },
  use_texture_alpha = "blend",

  paramtype = "light",
  sunlight_propagates = true,
})
