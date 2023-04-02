local table_copy = assert(foundation.com.table_copy)
local Vector3 = assert(foundation.com.Vector3)
local Directions = assert(foundation.com.Directions)
local V3_UP = assert(Directions.V3_UP)
local V3_DOWN = assert(Directions.V3_DOWN)

local MAX_HEIGHT = 24

minetest.register_abm({
  label = "Bamboo Growth",

  nodenames = {"nokore_world_bamboo:bamboo_stalk"},
  neighbours = {"air"},

  interval = 30,
  chance = 10,

  action = function(pos, node)
    local can_grow = true
    local down_pos = Vector3.copy(pos)
    local down_node
    local h = 0
    for _y = 1,MAX_HEIGHT do
      down_node = minetest.get_node_or_nil(down_pos)
      down_pos = Vector3.add(down_pos, down_pos, V3_DOWN)
      if down_node then
        if down_node.name == node.name then
          h = h + 1
        else
          break
        end
      else
        can_grow = false
        break
      end
    end

    if can_grow and h < MAX_HEIGHT then
      local up_pos = Vector3.add({}, pos, V3_UP)

      local neighbor = minetest.get_node_or_nil(up_pos)
      if neighbor then
        if neighbor.name == "air" then
          minetest.set_node(up_pos, table_copy(node))
        end
      end
    end
  end,
})

minetest.register_abm({
  label = "Bamboo Shoot Growth",

  nodenames = {"nokore_world_bamboo:bamboo_shoot"},
  neighbours = {"air"},

  interval = 10,
  chance = 10,

  action = function(pos, node)
    local up_pos = Vector3.add({}, pos, V3_UP)

    local neighbor = minetest.get_node_or_nil(up_pos)
    if neighbor then
      if neighbor.name == "air" then
        minetest.set_node(pos, { name = "nokore_world_bamboo:bamboo_stalk" })
      end
    end
  end,
})
