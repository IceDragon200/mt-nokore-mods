local _ = {name = "air", prob = 0}
local Y = {name = "nokore_world_tree_big_oak:big_oak_log", prob = 255, force_place = true}
local L = {name = "nokore_world_tree_big_oak:big_oak_leaves", prob = 255}
local l = {name = "nokore_world_tree_big_oak:big_oak_leaves", prob = 233}

local schematic = foundation.com.schematic_helpers.from_y_slices{
  size = { x = 5, y = 9, z = 5 },
  data = {
    -- base
    _,_,_,_,_,
    _,_,_,_,_,
    _,_,Y,_,_,
    _,_,_,_,_,
    _,_,_,_,_,

    _,_,_,_,_,
    _,_,_,_,_,
    _,_,Y,_,_,
    _,_,_,_,_,
    _,_,_,_,_,

    _,_,_,_,_,
    _,_,_,_,_,
    _,_,Y,_,_,
    _,_,_,_,_,
    _,_,_,_,_,

    _,_,_,_,_,
    _,_,l,_,_,
    _,l,Y,l,_,
    _,_,l,_,_,
    _,_,_,_,_,

    _,_,_,_,_,
    _,L,L,L,_,
    _,L,Y,L,_,
    _,L,L,L,_,
    _,_,_,_,_,

    l,L,L,L,l,
    L,L,L,L,L,
    L,L,L,L,L,
    L,L,L,L,L,
    l,L,L,L,l,

    l,L,L,L,l,
    L,L,L,L,L,
    L,L,L,L,L,
    L,L,L,L,L,
    l,L,L,L,l,

    _,_,_,_,_,
    _,l,L,l,_,
    _,L,L,L,_,
    _,l,L,l,_,
    _,_,_,_,_,

    _,_,_,_,_,
    _,_,l,_,_,
    _,l,l,l,_,
    _,_,l,_,_,
    _,_,_,_,_,
  },
}

local result = minetest.serialize_schematic(schematic, 'mts', {})

minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_big_oak_tree.mts", result)
