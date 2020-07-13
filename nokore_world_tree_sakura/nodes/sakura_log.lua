local mod = nokore_world_tree_sakura

mod:register_node("sakura_log", {
  description = mod.S("Sakura Log"),

  groups = {
    log = 1,
    choppy = 2,
    oddly_breakable_by_hand = 1,
    flammable = 2,
  },

  tiles = {
    "nokore_log_sakura_top.png",
    "nokore_log_sakura_top.png",
    "nokore_log_sakura.png",
  },

  paramtype2 = "facedir",

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),

  on_place = minetest.rotate_node,
})
