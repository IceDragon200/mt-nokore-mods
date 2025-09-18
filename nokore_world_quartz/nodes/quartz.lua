local mod = assert(nokore_world_quartz)

mod:register_node("quartz_block", {
  description = mod.S("Quartz Block"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  tiles = {
    "quartz_block_bottom.png",
  },
})

mod:register_node("quartz_chiseled_block", {
  description = mod.S("Quartz Chiseled Block"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  tiles = {
    "quartz_block_chiseled_top.png",
    "quartz_block_chiseled_top.png",
    "quartz_block_chiseled.png",
  },
})

mod:register_node("quartz_brick", {
  description = mod.S("Quartz Brick"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  tiles = {
    "quartz_block_side.png",
  },
})

mod:register_node("quartz_pillar", {
  description = mod.S("Quartz Pillar"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  tiles = {
    "quartz_block_lines_top.png",
    "quartz_block_lines_top.png",
    "quartz_block_lines.png",
  },

  paramtype2 = "facedir",
})

mod:register_node("quartz_slab", {
  description = mod.S("Quartz Slab"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  tiles = {
    "quartz_block_side.png",
  },

  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      -8 / 16, -8 / 16, -8 / 16, 8 / 16, 0, 8 / 16
    }
  }
})

mod:register_node("quartz_tile", {
  description = mod.S("Quartz Tile"),

  groups = {
    cracky = nokore.dig_class("stone"),
  },

  tiles = {
    "quartz_block_top.png",
    "quartz_block_top.png",
    "quartz_block_bottom.png",
  },

  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      -8 / 16, -8 / 16, -8 / 16, 8 / 16, -7 / 16, 8 / 16
    }
  }
})
