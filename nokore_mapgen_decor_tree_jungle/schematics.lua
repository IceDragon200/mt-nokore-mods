local _ = {name = "air", prob = 0}
local Y = {name = "nokore_world_tree_jungle:jungle_log", prob = 255, force_place = true}
local y = {name = "nokore_world_tree_jungle:jungle_log", prob = 127, force_place = true}
local L = {name = "nokore_world_tree_jungle:jungle_leaves", prob = 255}
local l = {name = "nokore_world_tree_jungle:jungle_leaves", prob = 233}
local i = {name = "nokore_world_tree_jungle:jungle_leaves", prob = 191}

local result
local schematic

schematic = foundation.com.schematic_helpers.from_y_slices{
  size = { x = 5, y = 17, z = 5 },
  data = {
    -- base
    _,_,_,_,_,
    _,_,Y,_,_,
    _,Y,Y,Y,_,
    _,_,Y,_,_,
    _,_,_,_,_,

    _,_,_,_,_,
    _,_,Y,_,_,
    _,Y,Y,Y,_,
    _,_,Y,_,_,
    _,_,_,_,_,

    _,_,_,_,_,
    _,_,y,_,_,
    _,y,Y,y,_,
    _,_,y,_,_,
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

    i,l,l,l,i,
    l,Y,L,Y,l,
    l,L,L,L,l,
    l,Y,L,Y,l,
    i,l,l,l,i,

    i,l,l,l,i,
    l,L,L,L,l,
    l,L,L,L,l,
    l,L,L,L,l,
    i,l,l,l,i,

    _,_,_,_,_,
    _,l,L,l,_,
    _,L,L,L,_,
    _,l,L,l,_,
    _,_,_,_,_,
  },
  yslice_prob = {
    {ypos=6, prob=191},
    {ypos=7, prob=191},
    {ypos=8, prob=191},
    {ypos=9, prob=191},
    {ypos=10, prob=191},
  },
}

result = minetest.serialize_schematic(schematic, 'mts', {})

minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_jungle_tree.mts", result)

Y = {
    name = "nokore_world_tree_jungle:jungle_log",
    param2 = 12,
    prob = 255,
    force_place = true
}

schematic = foundation.com.schematic_helpers.from_y_slices{
  size = { x = 3, y = 1, z = 1 },
  data = {
    Y,Y,Y,
  },
}

result = minetest.serialize_schematic(schematic, 'mts', {})

minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_jungle_fallen_log.mts", result)
