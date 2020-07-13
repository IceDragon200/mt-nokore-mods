local mod = nokore_furnace

mod:register_node("furnace_off", {
  description = "Furnace",

  groups = {
    cracky = 2,
  },
})

mod:register_node("furnace_on", {
  description = "Furnace",

  groups = {
    cracky = 2,
    not_in_creative_inventory = 1,
  },
})
