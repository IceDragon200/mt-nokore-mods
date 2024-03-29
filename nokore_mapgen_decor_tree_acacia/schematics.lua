local _ = {name = "air", prob = 0}
local Y = {name = "nokore_world_tree_acacia:acacia_log", prob = 255, force_place = true}
local L = {name = "nokore_world_tree_acacia:acacia_leaves", prob = 255}
local l = {name = "nokore_world_tree_acacia:acacia_leaves", prob = 233}

local schematic = foundation.com.schematic_helpers.from_y_slices{
  size = { x = 9, y = 8, z = 9 },
  data = {
    -- base
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,Y,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,

    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,Y,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,

    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,Y,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,

    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,Y,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,

    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,Y,l,Y,_,_,_,
    _,_,_,l,Y,l,_,_,_,
    _,_,_,Y,l,Y,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,

    _,_,_,_,_,_,_,_,_,
    _,_,l,_,_,_,l,_,_,
    _,l,Y,l,l,l,Y,l,_,
    _,_,l,l,l,l,l,_,_,
    _,_,l,l,Y,l,l,_,_,
    _,_,l,l,l,l,l,_,_,
    _,l,Y,l,l,l,Y,l,_,
    _,_,l,_,_,_,l,_,_,
    _,_,_,_,_,_,_,_,_,

    _,_,_,_,_,_,_,_,_,
    _,l,l,l,l,l,l,l,_,
    _,l,L,L,L,L,L,l,_,
    _,l,L,L,L,L,L,l,_,
    _,l,L,L,L,L,L,l,_,
    _,l,L,L,L,L,L,l,_,
    _,l,L,L,L,L,L,l,_,
    _,l,l,l,l,l,l,l,_,
    _,_,_,_,_,_,_,_,_,

    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,l,l,l,_,_,_,
    _,_,l,L,L,L,l,_,_,
    _,_,l,L,L,L,l,_,_,
    _,_,l,L,L,L,l,_,_,
    _,_,_,l,l,l,_,_,_,
    _,_,_,_,_,_,_,_,_,
    _,_,_,_,_,_,_,_,_,
  },
  yslice_prob = {
    {ypos = 2, prob = 127},
    {ypos = 3, prob = 127},
  },
}

local result = minetest.serialize_schematic(schematic, 'mts', {})

minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_acacia_tree.mts", result)
