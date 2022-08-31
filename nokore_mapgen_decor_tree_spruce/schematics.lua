local b = foundation.com.schematic_helpers.build()
local v = vector.new

local _ = {name = "air", prob = 0}
local Y = b:add_palette_node(
  {name = "nokore_world_tree_spruce:spruce_log", prob = 255, force_place = true}
)
local L = b:add_palette_node(
  {name = "nokore_world_tree_spruce:spruce_leaves", prob = 255}
)
local l = b:add_palette_node(
  {name = "nokore_world_tree_spruce:spruce_leaves", prob = 233}
)

local function fill_plus(bld, size, y, swatch_id)
  for z = 0,size do
    for x = 0,size do
      if (x + z) <= size then
        bld:put_node(v(x,y,z), swatch_id)
        bld:put_node(v(-x,y,z), swatch_id)
        bld:put_node(v(x,y,-z), swatch_id)
        bld:put_node(v(-x,y,-z), swatch_id)
      end
    end
  end
end

-- Small Spruce
b:clear_data()
fill_plus(b, 1, 3, l)
b:fill_range(v(-2,4,-2), v(2,4,2), L)
fill_plus(b, 1, 5, l)
b:fill_range(v(-1,7,-1), v(1,7,1), L)
b:put_node(v(0,8,0), L)
b:fill_range(v(0,0,0), v(0,7,0), Y)

local schematic
local result

schematic = b:to_schematic()
schematic.yslice_prob = {
  {ypos = 2, prob = 127},
}

result = minetest.serialize_schematic(schematic, 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_spruce_small_tree.mts", result)

-- Really Tall Spruce
b:clear_data()
fill_plus(b, 1, 7, l)
b:fill_range(v(-3,8,-3), v(3,8,3), L)
b:fill_range(v(-2,9,-2), v(2,9,2), L)
b:fill_range(v(-1,10,-1), v(1,10,1), L)
b:fill_range(v(0,0,0), v(0,9,0), Y)

schematic = b:to_schematic()
schematic.yslice_prob = {
  {ypos = 2, prob = 127},
  {ypos = 3, prob = 97},
}

result = minetest.serialize_schematic(schematic, 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_spruce_tall_tree.mts", result)

-- Medium Spruce
b:clear_data()
fill_plus(b, 1, 3, l) -- optional ring
fill_plus(b, 3, 3, L) -- major
fill_plus(b, 2, 4, L) -- minor
fill_plus(b, 3, 5, L) -- major
fill_plus(b, 2, 6, L) -- minor
fill_plus(b, 1, 7, L) -- minor
b:put_node(v(0,8,0), L) -- top-top
b:fill_range(v(0,0,0), v(0,7,0), Y)

schematic = b:to_schematic()
schematic.yslice_prob = {
  {ypos = 2, prob = 127},
}

result = minetest.serialize_schematic(schematic, 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_spruce_tree.mts", result)


-- Large Spruce
b:clear_data()
fill_plus(b, 1, 3, l) -- optional ring
fill_plus(b, 4, 4, L) -- largest base ring
fill_plus(b, 2, 5, L) -- minor
fill_plus(b, 3, 6, L) -- next major ring
fill_plus(b, 2, 7, L) -- minor
fill_plus(b, 3, 8, L) -- next major ring
fill_plus(b, 2, 9, L) -- major
fill_plus(b, 1, 10, L) -- minor
fill_plus(b, 2, 9, L) -- major
fill_plus(b, 1, 10, L) -- minor
-- space
fill_plus(b, 1, 12, L) -- top
b:put_node(v(0,13,0), L) -- the cream of the crop
b:fill_range(v(0,0,0), v(0,12,0), Y)

schematic = b:to_schematic()
schematic.yslice_prob = {
  {ypos = 2, prob = 127},
}

result = minetest.serialize_schematic(schematic, 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_spruce_large_tree.mts", result)
