local v = vector.new
local b = nokore.schematic_helpers.build()

--
-- Blue Mushrooms - weeping blue mushroom has an elongated bell shape
--
b:clear()
local S = b:add_palette_node({name = "nokore_world_giant_mushroom:stem", prob = 255, force_place = true})
local I = b:add_palette_node({name = "nokore_world_giant_mushroom:inside", prob = 255})
local F = b:add_palette_node({name = "nokore_world_giant_mushroom:blue_cap", prob = 255, force_place = true})

-- minimal blue mushroom - at this size you don't really get their design
b:clear_data()
-- stem
b:put_node(v(0,0,0), S)
b:fill_range(v(-1,1,-1), v(1,2,1), F) -- the cap itself
b:put_node(v(0,3,0), F)
b:put_node(v(0,1,0), S) -- replace the filled inner part with a stem

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_blue_giant_mushroom_small.mts", result)

-- Normal sized blue mushroom (for a giant mushroom that is)
b:clear_data()
b:fill_range(v(-1,6,-1), v(1,6,1), F) -- a cap
b:fill_range(v(-2,2,-2), v(2,5,2), F) -- fill the entire range with skin
b:fill_range(v(-3,2,-3), v(3,2,3), F) -- add the bell-like frill
b:fill_range(v(-1,2,-1), v(1,4,1), nil) -- clear inside
b:fill_range(v(-1,4,-1), v(1,4,1), I) -- add the fleshy insides a the top
b:fill_range(v(0,0,0), v(0,4,0), S) -- finally add the stem

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_blue_giant_mushroom.mts", result)

-- an extra large blue mushroom - a super sized mushroom, the stem is much thicker than normal
b:clear_data()
-- outer skin
b:fill_range(v(-3,9,-3), v(3,9,3), F) -- a cap
b:fill_range(v(-4,2,-4), v(4,8,4), F) -- fill the entire range with skin
b:fill_range(v(-5,2,-5), v(5,2,5), F) -- add the bell-like frill
b:fill_range(v(-3,2,-3), v(3,7,3), nil) -- clear inside
-- fleshy insides
b:fill_range(v(-3,6,-3), v(3,7,3), I) -- add the fleshy insides a the top
b:fill_range(v(-2,6,-2), v(2,6,2), nil) -- clear a section of the fleshy inside
-- finally the stem
b:fill_range(v(0,0,0), v(0,7,0), S) -- add the stem core
b:fill_range(v(1,0,0), v(1,7,0), S) -- more stem
b:fill_range(v(-1,0,0), v(-1,7,0), S) -- more stem
b:fill_range(v(0,0,1), v(0,7,1), S) -- more stem
b:fill_range(v(0,0,-1), v(0,7,-1), S) -- more stem

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_blue_giant_mushroom_large.mts", result)

--
-- Brown Mushrooms - flat topped mushrooms
--
b:clear()
local S = b:add_palette_node({name = "nokore_world_giant_mushroom:stem", prob = 255, force_place = true})
local I = b:add_palette_node({name = "nokore_world_giant_mushroom:inside", prob = 255})
local F = b:add_palette_node({name = "nokore_world_giant_mushroom:brown_cap", prob = 255, force_place = true})

-- minimal brown mushroom
b:clear_data()
-- stem
b:put_node(v(0,0,0), S)
b:fill_range(v(-1,2,-1), v(1,2,1), F) -- the cap itself
b:put_node(v(0,1,0), S)

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_brown_giant_mushroom_small.mts", result)

-- Normal sized brown mushroom (for a giant mushroom that is)
b:clear_data()
b:fill_range(v(-3,5,-3), v(3,6,3), F) -- the cap itself
b:fill_range(v(-2,5,-2), v(2,5,2), I) -- the fleshy insides itself
b:fill_range(v(-1,5,-1), v(1,5,1), nil) -- carve inside
b:fill_range(v(0,0,0), v(0,5,0), S) -- the stem

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_brown_giant_mushroom.mts", result)

-- an extra large brown mushroom
b:clear_data()
b:fill_range(v(-4,7,-4), v(4,8,4), F) -- the cap itself
b:fill_range(v(-3,7,-3), v(3,7,3), I) -- the fleshy insides itself
b:fill_range(v(-2,7,-2), v(2,7,2), nil) -- carve inside
-- finally the stem
b:fill_range(v(0,0,0), v(0,7,0), S) -- add the stem core
b:fill_range(v(1,0,0), v(1,7,0), S) -- more stem
b:fill_range(v(-1,0,0), v(-1,7,0), S) -- more stem
b:fill_range(v(0,0,1), v(0,7,1), S) -- more stem
b:fill_range(v(0,0,-1), v(0,7,-1), S) -- more stem

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_brown_giant_mushroom_large.mts", result)

--
-- Purple Mushrooms - short but wide mushrooms
--
b:clear()
local S = b:add_palette_node({name = "nokore_world_giant_mushroom:stem", prob = 255, force_place = true})
local I = b:add_palette_node({name = "nokore_world_giant_mushroom:inside", prob = 255})
local F = b:add_palette_node({name = "nokore_world_giant_mushroom:purple_cap", prob = 255, force_place = true})

-- minimal purple mushroom
b:clear_data()
-- stem
b:put_node(v(0,0,0), S)
b:fill_range(v(-1,1,-1), v(1,2,1), F) -- the cap itself
b:put_node(v(0,1,0), S) -- replace the filled inner part with a stem

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_purple_giant_mushroom_small.mts", result)

-- Normal sized purple mushroom (for a giant mushroom that is)
b:clear_data()
b:fill_range(v(-2,4,-2), v(2,4,2), F) -- cap
b:fill_range(v(-3,1,-3), v(3,3,3), F) -- fill the entire range with skin
b:fill_range(v(-2,1,-2), v(2,2,2), I) -- add insides
b:fill_range(v(-1,1,-1), v(1,1,1), nil) -- carve out insides
b:fill_range(v(0,0,0), v(0,2,0), S) -- add the stem core

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_purple_giant_mushroom.mts", result)

-- an extra large purple mushroom
b:clear_data()
b:fill_range(v(-4,5,-4), v(4,5,4), F) -- cap
b:fill_range(v(-5,2,-5), v(5,4,5), F) -- fill the entire range with skin
b:fill_range(v(-4,2,-4), v(4,3,4), I) -- add insides
b:fill_range(v(-3,2,-3), v(3,2,3), nil) -- carve out insides
-- finally the stem
b:fill_range(v(0,0,0), v(0,3,0), S) -- add the stem core
b:fill_range(v(1,0,0), v(1,3,0), S) -- more stem
b:fill_range(v(-1,0,0), v(-1,3,0), S) -- more stem
b:fill_range(v(0,0,1), v(0,3,1), S) -- more stem
b:fill_range(v(0,0,-1), v(0,3,-1), S) -- more stem

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_purple_giant_mushroom_large.mts", result)

--
-- Red Mushrooms - ball shaped
--
b:clear()
local S = b:add_palette_node({name = "nokore_world_giant_mushroom:stem", prob = 255, force_place = true})
local I = b:add_palette_node({name = "nokore_world_giant_mushroom:inside", prob = 255})
local F = b:add_palette_node({name = "nokore_world_giant_mushroom:red_cap", prob = 255, force_place = true})

-- minimal red mushroom
b:clear_data()
-- stem
b:put_node(v(0,0,0), S)
b:fill_range(v(-1,1,-1), v(1,2,1), F) -- the cap itself
b:put_node(v(0,1,0), S) -- replace the filled inner part with a stem

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_red_giant_mushroom_small.mts", result)

-- Normal sized red mushroom (for a giant mushroom that is)
b:clear_data()
b:fill_range(v(-2,5,-2), v(2,5,2), F) -- add cap
b:fill_range(v(-3,2,-3), v(3,4,3), F) -- fill the entire range with skin
b:fill_range(v(-2,2,-2), v(2,4,2), I) -- add insides
b:fill_range(v(-2,2,-2), v(2,3,2), nil) -- carve out insides
b:fill_range(v(0,0,0), v(0,4,0), S) -- add the stem core

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_red_giant_mushroom.mts", result)

-- an extra large red mushroom
b:clear_data()
b:fill_range(v(-3,7,-3), v(3,7,3), F) -- add cap
b:fill_range(v(-4,2,-4), v(4,6,4), F) -- fill the entire range with skin
b:fill_range(v(-3,2,-3), v(3,5,3), I) -- add insides
b:fill_range(v(-2,2,-2), v(2,4,2), nil) -- carve out insides
-- finally the stem
b:fill_range(v(0,0,0), v(0,3,0), S) -- add the stem core
b:fill_range(v(1,0,0), v(1,3,0), S) -- more stem
b:fill_range(v(-1,0,0), v(-1,3,0), S) -- more stem
b:fill_range(v(0,0,1), v(0,3,1), S) -- more stem
b:fill_range(v(0,0,-1), v(0,3,-1), S) -- more stem

local result = minetest.serialize_schematic(b:to_schematic(), 'mts', {})
minetest.safe_file_write(minetest.get_worldpath() .. "/nokore_red_giant_mushroom_large.mts", result)
