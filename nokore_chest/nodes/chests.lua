local mod = nokore_chest

function nokore_chest.chest_on_construct(pos)
  local meta = minetest.get_meta(pos)
  local inv = meta:get_inventory()

  inv:set_size("main", 10 * 4)
end

mod:register_node("chest_oak_closed", {
  description = mod.S("Oak Chest"),

  groups = {
    cracky = 1,
    chest = 1,
    wood_chest = 1,
  },

  tiles = {
    "chest_top.png",
    "chest_top.png",
    "chest_side.png",
    "chest_side.png",
    "chest_front.png",
    "chest_inside.png",
  },
  drawtype = "node",

  on_construct = nokore_chest.chest_on_construct,
})
