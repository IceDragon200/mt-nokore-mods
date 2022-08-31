local _ = {name = "air", prob = 0}
local Y = {name = "nokore_world_tree_oak:oak_log", prob = 255, force_place = true}
local L = {name = "nokore_world_tree_oak:oak_leaves", prob = 255}
local l = {name = "nokore_world_tree_oak:oak_leaves", prob = 233}

local result
local schematic

schematic = foundation.com.schematic_helpers.from_y_slices{
  size = { x = 3, y = 7, z = 3 },
  data = {
    -- base
    _,_,_,
    _,Y,_,
    _,_,_,

    _,_,_,
    _,Y,_,
    _,_,_,

    _,l,_,
    l,Y,l,
    _,l,_,

    L,L,L,
    L,Y,L,
    L,L,L,

    L,L,L,
    L,L,L,
    L,L,L,

    L,L,L,
    L,L,L,
    L,L,L,

    _,l,_,
    l,L,l,
    _,l,_,
  },
  yslice_prob = {
    {ypos = 2, prob = 127},
  },
}

result = minetest.serialize_schematic(schematic, 'mts', {})

minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_oak_small_tree.mts", result)

schematic = foundation.com.schematic_helpers.from_y_slices{
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
  yslice_prob = {
    {ypos = 2, prob = 127},
  },
}

result = minetest.serialize_schematic(schematic, 'mts', {})

minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_oak_tree.mts", result)
