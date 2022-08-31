--
-- Rail API, mostly borrowed from minetest game's 'carts'
--
local table_merge = assert(foundation.com.table_merge)
local node_sounds = assert(foundation.com.node_sounds)
local Groups = assert(foundation.com.Groups)

nokore = rawget(_G, "nokore") or {}

-- @namespace nokore.rails
nokore.rails = nokore.rails or {}

local function vox_manip_get_node_name(pos)
  local vm = minetest.get_voxel_manip()
  local emin, emax = vm:read_from_map(pos, pos)
  local area = VoxelArea:new{
    MinEdge = emin,
    MaxEdge = emax,
  }
  local data = vm:get_data()
  local vi = area:indexp(pos)
  return minetest.get_name_from_content_id(data[vi])
end

-- @spec #is_rail_at_pos(Vector3, rail_group?: Integer): Boolean
function nokore.rails:is_rail_at_pos(pos, rail_group)
  local node = minetest.get_node(pos)
  local name = node.name
  local nodedef

  if name == "ignore" then
    -- attempt to retrieve the rail name via the voxel manipulator
    name = vox_manip_get_node_name(pos)
  end

  nodedef = minetest.registered_nodes[name]

  if Groups.has_group(nodedef, "rail") then
    -- not a rail
    return false
  end

  if not rail_group then
    -- no specific rail group was asked for, so this is a rail of some sort
    return true
  end

  return Groups.has_group(nodedef, "connect_to_raillike") == rail_group
end

-- Builds a groups table, additional groups can be provided via the 'groups' argument.
--
-- @spec #build_rail_groups(groups: Table): Table
function nokore.rails:build_rail_groups(groups)
  return table_merge({
    dig_immediate = 2,
    attached_node = 1,
    rail = 1,
    connect_to_raillike = minetest.raillike_group("rail"),
  }, groups or {})
end

-- @spec #register_rail_node(name: String, def: Table): Table
function nokore.rails:register_rail_node(name, def)
  local new_def = table_merge({
    sounds = node_sounds:build("metal"),
    sunlight_propagates = true,
    is_ground_content = false,
    walkable = false,

    drawtype = "raillike",

    paramtype = "light",

    selection_box = {
      type = "fixed",
      fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
    },
  }, def)

  return minetest.register_node(name, new_def)
end
