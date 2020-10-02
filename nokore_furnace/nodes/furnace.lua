local mod = nokore_furnace

mod:register_node("furnace_off", {
  description = "Furnace",

  groups = {
    cracky = 2,
  },

  tiles = {
    "nokore_furnace_top.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_front_off.png",
  },
})

mod:register_node("furnace_on", {
  description = "Furnace",

  groups = {
    cracky = 2,
    not_in_creative_inventory = 1,
  },

  tiles = {
    "nokore_furnace_top.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_side.png",
    "nokore_furnace_front_on.png",
  },
})
