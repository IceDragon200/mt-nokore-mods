local mod = assert(nokore_world_quartz)

mod:register_node("stone_with_quartz", {
  description = mod.S("Quartz Ore"),

  groups = {
    cracky = nokore.dig_class("bronze"),
  },

  drop = "nokore_world_quartz:quartz",

  tiles = {
    "world_stone.png^world_mineral_quartz.png",
  },
})
