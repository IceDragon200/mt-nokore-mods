local mod = nokore_world_tree_big_oak

mod:register_node("big_oak_log", {
  description = mod.S("Big Oak Log"),

  groups = {
    log = 1,
    choppy = 2,
    oddly_breakable_by_hand = 1,
    flammable = 2,
  },

  tiles = {
    "nokore_log_big_oak_top.png",
    "nokore_log_big_oak_top.png",
    "nokore_log_big_oak.png",
  },

  paramtype2 = "facedir",

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),

  on_place = minetest.rotate_node,
})
