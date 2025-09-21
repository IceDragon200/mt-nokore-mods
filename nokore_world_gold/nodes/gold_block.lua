local mod = assert(nokore_world_gold)

mod:register_node("gold_block", {
  description = mod.S("Gold Block"),

  groups = {
    cracky = nokore.dig_class("bronze"),
  },

  tiles = {
    "world_gold_block.png",
  },
})
