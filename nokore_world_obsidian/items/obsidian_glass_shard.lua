local mod = assert(nokore_world_obsidian)

mod:register_craftitem("obsidian_glass_shard", {
  description = mod.S("Obsidian Glass Shard"),

  groups = {
    obsidian_glass_shard = 1,
  },

  inventory_image = "world_obsidian_glass_shard.png",
})
