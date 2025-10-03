-- https://forum.luanti.org/viewtopic.php?t=31001
--[[
Template mapgen

(c) 2024 Skamiz Kazzarch
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Updated to be compatible with the new Mapgen Environment:
https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L6768

Can be run as usual with:
-- dofile(modpath .. "/name_of_file.lua")
or in the mapgen env with:
-- minetest.register_mapgen_script(modpath .. "/name_of_file.lua") --prefer this one whenever possible


Chunk generation time is at about 0.04 seconds.
]]

-- minetest.after does not exist in the mapgen environment, thus we can use it
-- to detect whether we are in the main thread or mapgen thread
local IN_MAPGEN_ENVIRONMENT = not minetest.after

-- Content ID's are used during mapgen instead of node names, learn more here:
-- https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L4758
-- change node names as necessary
local c_dirt = minetest.get_content_id("mapgen_dirt")
local c_stone = minetest.get_content_id("mapgen_stone")


--noise parameters of a 3d noise
local noise_parameters_3d = {
  offset = 0,
  scale = 10,
  spread = {x = 10, y = 10, z = 10},
  seed = 0,
  octaves = 1,
  persist = 1.0,
  lacunarity = 1.0,
}

-- Learn more about noise parameters here:
-- https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L4269

-- noise parameters of a 2d noise
local noise_parameters_2d = {
  offset = 0,
  scale = 10,
  spread = {x = 40, y = 40, z = 40},
  seed = 1,
  octaves = 1,
  persist = 1.0,
  lacunarity = 1.0,
  flags = "noeased",
}

-- Explenation of some mapgens terms:
-- https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L1584
--[[
When using perlin noise objects, we need to tell them how many noise values they
should give us at once. This is done through a parameter called 'chunk_size'.
In most cases that will be 80, aka 5 mapblocks of 16 nodes each. But sometimes
it is set lower for performance reasons, so we need to dynamically detect the
correct size
]]
local blocks_per_chunk = tonumber(minetest.settings:get("chunksize")) or 5
local side_length = blocks_per_chunk * 16
local chunk_size = {x = side_length, y = side_length, z = side_length}

-- Learn more about perlin maps:
-- https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L8499
--[[
These perlin maps, also often refered to as noise objects, will be later used to
generate noise values in bulk.
]]
local nobj_3d
local nobj_2d

-- persistent data tables
-- they can be reused, so that they don't need to be created anew for every chunk
-- this saves on memory
local node_data = {}
local noise_values_3d = {}
local noise_values_2d = {}

-- the main function which determines which nodes to place at which positions
local function generate_chunk(vm, minp, maxp, chunkseed)

  -- noise objects need to be initialzed here, because 'minetest.get_perlin_map'
  -- isn't available during load time
  nobj_3d = nobj_3d or minetest.get_perlin_map(noise_parameters_3d, chunk_size)
  nobj_2d = nobj_2d or minetest.get_perlin_map(noise_parameters_2d, chunk_size)


  --[[
  If you need randomness besides the perlin noise, you need to 'seed' your
  noise generator with the chunk seed, so it generates the same way,
  every time a world with the same seed is created.

  Instead of math.random you can also use Minetests PcgRandom:
  https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L8456
  ]]
  math.randomseed(chunkseed)

  -- when the engine loads mapdata into a voxelmanip the area is usually larger
  -- then the mapchunk being generated, so we need to find out the real boundaries
  local emin, emax = vm:get_emerged_area()

  -- VoxelArea is a helper that converts between world position (x, y, z) and
  -- the corresponding index in our node_data tables. More info here:
  -- https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L4922
  local area = VoxelArea(emin, emax)

  -- now we load some actual information into our persistent data tables
  vm:get_data(node_data)
  -- for 3d noise, we can just take the minp as a starting position
  nobj_3d:get_3d_map_flat(minp, noise_values_3d)
  -- since 2d noise uses only the X and Y coordinates, but most mapgens are
  -- horizontal and the engines horizontal directions are X and Z we need to
  -- edit the starting position first
  local minp2 = vector.new(minp.x, minp.z, 0)
  nobj_2d:get_2d_map_flat(minp2, noise_values_2d)

  --[[
  The main loop. It iterates over every position in the mapchunk and
  determines what node should be placed there.
  ]]
  -- noise index, same as noise_index_3d
  local noise_index = 0
  for z = minp.z, maxp.z do
    for y = minp.y, maxp.y do
      for x = minp.x, maxp.x do
        --[[
        Now that we know which position we are currently editing, we need
        to find out the corresponding indeces in our datatables.
        There are several ways of doing this.
        ]]

        -- we can use the VoxelArea object we created beforehand to convert
        -- the coordinates to the appropriate index
        local node_index = area:index(x, y, z)

        -- We can calculate the index ourselves. This is very simmilar
        -- to what the VoxelArea object does internally.

        -- index for flat noise maps, 3d and 2d respectively
        local noise_index_3d = (z - minp.z) * side_length * side_length + (y - minp.y) * side_length + (x - minp.x) + 1
        local noise_index_2d = (z - minp.z) * side_length + (x - minp.x) + 1

        -- As a special case when our main loops are nested as here,
        -- X inside of Y inside of Z, we can use a simple counter,
        -- which will have the same value as the index for 3d noise
        noise_index = noise_index + 1

        --[[
        Could we use a VoxelArea object for the noise indices as well?

        Yes, we can, BUT!!! The node data, 3d noise data, and 2d noise data
        tables each have a different size, so you need to create sepparate
        VoxelArea objects for them, otherwise everything will get messy.
        ]]


        -- now that we know the indices we can use them to retrieve
        -- the noise values at this position
        local noise_value_3d = noise_values_3d[noise_index_3d]
        -- local noise_value_3d = noise_values_3d[noise_index] -- same effect as previous line
        local noise_value_2d = noise_values_2d[noise_index_2d]

        -- and use them to make decisions about what node to place
        -- as a simple example:

        -- 2d noise maps can be used as simple height maps
        if y < noise_value_2d then
          node_data[node_index] = c_dirt
        end

        -- 3d noise is often best thought of as 'density'
        -- in this case we decrease the density as height increases,
        -- as to not end up with infinitely high mountains
        if noise_value_3d - y > 0 then
          node_data[node_index] = c_stone
        end

        --[[
        To make actually good and interesting looking mapgens you will
        need something more coplex then comparing noise values to height,
        but that is a mater of creativity, imagination,
        and translating your ideas into code.
        ]]

      end
    end
  end

  -- at the end we load the node data from our Lua table back into the VoxelManip
  vm:set_data(node_data)
end


--[[
'register_on_generated' works differently depending on wheter we are in the
main environment:
https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L5737
or the mapgen environment:
https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L6790

This will affect what we need/needn't do.
]]
minetest.register_on_generated(function(vm, minp, maxp, chunkseed)
  -- print(vm, minp, maxp, chunkseed)
  if not IN_MAPGEN_ENVIRONMENT then
    -- in the main environment VoxelManip isn't provided for us
    minp, maxp, chunkseed = vm, minp, maxp
  end

  --[[
  Many mapgens don't affect the complete height of the world. If that is the
  case, it's beneficial to abort them early, to no waste resourced on generating
  a chunk full of nothing.
  ]]
  -- adjut the minimum and maximum heights according to your needs
  if maxp.y < -100 or minp.y > 100 then return end

  if not IN_MAPGEN_ENVIRONMENT then
    -- retrieve the VoxelManip ourselves
    vm = minetest.get_mapgen_object("voxelmanip")
    -- VoxelManip documentation:
    -- https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L4642
  end

  -- if you want to know how fast your mapgen is you can track time with this:
  local t0 = minetest.get_us_time()

  generate_chunk(vm, minp, maxp, chunkseed)

  -- Additional VoxelManip operations. They can be enabled / disabled as needed. See here:
  -- https://github.com/minetest/minetest/blob/5.9.0/doc/lua_api.md?plain=1#L4805

  minetest.generate_decorations(vm)
  minetest.generate_ores(vm)
  vm:update_liquids() -- so they start flowing

  vm:set_lighting({day = 0, night = 0})
  vm:calc_lighting() -- necessary after placing glowing nodes

  if not IN_MAPGEN_ENVIRONMENT then
    vm:write_to_map()
  end

  -- uncomment to print chunk generation time to console.
  -- print(((minetest.get_us_time() - t0) / 1000) .. " ms" )

end)

