local mod = nokore_door

local table_copy = assert(foundation.com.table_copy)
local table_merge = assert(foundation.com.table_merge)
local table_deep_merge = assert(foundation.com.table_deep_merge)
local Directions = assert(foundation.com.Directions)
local Vector3 = assert(foundation.com.Vector3)
local Groups = assert(foundation.com.Groups)
local Cuboid = assert(foundation.com.Cuboid)
local ng = assert(Cuboid.new_fast_node_box)

function nokore_door.is_opposite_segment(my_segment, sibling_segment)
  if my_segment == "top" then
    return sibling_segment == "bottom"
  end
  return sibling_segment == "top"
end

function nokore_door.door_on_place(item_stack, placer, pointed_thing)
  if pointed_thing.type ~= "node" then
    return item_stack
  end

  local pos

  local itemdef = item_stack:get_definition()
  -- local doorname = item_stack:get_name()
  local node = minetest.get_node(pointed_thing.under)
  local pdef = minetest.registered_nodes[node.name]
  if pdef and pdef.on_rightclick and
      not (placer and placer:is_player() and
      placer:get_player_control().sneak) then
    return pdef.on_rightclick(
      pointed_thing.under,
      node,
      placer,
      item_stack,
      pointed_thing
    )
  end

  if pdef and pdef.buildable_to then
    pos = pointed_thing.under
  else
    pos = pointed_thing.above
    node = minetest.get_node(pos)
    pdef = minetest.registered_nodes[node.name]
    if not pdef or not pdef.buildable_to then
      return item_stack
    end
  end

  local above = {x = pos.x, y = pos.y + 1, z = pos.z}
  local top_node = minetest.get_node_or_nil(above)
  local topdef = top_node and minetest.registered_nodes[top_node.name]

  if not topdef or not topdef.buildable_to then
    return item_stack
  end

  local pn = placer and placer:get_player_name() or ""
  if minetest.is_protected(pos, pn) or minetest.is_protected(above, pn) then
    return item_stack
  end

  local dir = placer and minetest.dir_to_facedir(placer:get_look_dir()) or 0

  -- check the left hand if a door is present
  local aside_check_dir = Directions.D_WEST
  local aside_dir = Directions.facedir_to_face(dir, aside_check_dir)
  local aside_vec = Directions.DIR6_TO_VEC3[aside_dir]
  local aside_pos = Vector3.add({}, pos, aside_vec)
  local aside_node = minetest.get_node_or_nil(aside_pos)
  local aside_nodedef = minetest.registered_nodes[aside_node.name]

  local mirror_state = 0
  if Groups.has_group(aside_nodedef, "door") then
    local aside_meta = minetest.get_meta(aside_pos)
    local aside_mirror_state = aside_meta:get_int("mirror_state")
    if aside_mirror_state > 0 then
      mirror_state = 0
    else
      mirror_state = 1
    end
  end

  if mirror_state > 0 then
    -- a door is present on the left hand, this door needs to be mirrored
    minetest.set_node(pos, {name = itemdef.door_item.bottom .. "_mirror", param2 = dir})
    minetest.set_node(above, {name = itemdef.door_item.top .. "_mirror", param2 = dir})
  else
    minetest.set_node(pos, {name = itemdef.door_item.bottom, param2 = dir})
    minetest.set_node(above, {name = itemdef.door_item.top, param2 = dir})
  end

  for _,vec in ipairs({pos, above}) do
    local meta = minetest.get_meta(vec)

    meta:set_int("mirror_state", mirror_state)
    if itemdef.protected then
      meta:set_string("owner", pn)
      meta:set_string("infotext", itemdef.description .. "\n" .. mod.S("Owned by @1", pn))
    end
  end

  if not minetest.is_creative_enabled(pn) then
    item_stack:take_item()
  end

  if itemdef.sounds and itemdef.sounds.place then
    minetest.sound_play(itemdef.sounds.place, {pos = pos}, true)
  end

  -- on_place_node(
  --   pos,
  --   minetest.get_node(pos),
  --   placer,
  --   node,
  --   item_stack,
  --   pointed_thing
  -- )

  return item_stack
end

local function get_sibling_node(my_pos, my_node)
  local dir = Directions.D_UP

  local nodedef = minetest.registered_nodes[my_node.name]

  if nodedef.door.segment == "top" then
    dir = Directions.D_DOWN
  end

  local sibling_segment_dir = Directions.facedir_to_face(my_node.param2, dir)
  local sibling_vec = Directions.DIR6_TO_VEC3[sibling_segment_dir]
  local sibling_pos = Vector3.add({}, my_pos, sibling_vec)
  local sibling_node = minetest.get_node_or_nil(sibling_pos)
  if not sibling_node then
    return nil, nil, nil
  end

  local sibling_nodedef = minetest.registered_nodes[sibling_node.name]
  if not sibling_nodedef or not sibling_nodedef.door then
    return nil, nil, nil
  end

  if not nokore_door.is_opposite_segment(nodedef.door.segment, sibling_nodedef.door.segment) then
    return nil, nil, nil
  end

  return sibling_pos, sibling_node, sibling_nodedef
end

local function trigger_door(pos, node, clicker, item_stack, pointed_thing, trigger_aside)
  local nodedef = minetest.registered_nodes[node.name]
  if not nodedef.door then
    return
  end

  local meta = minetest.get_meta(pos)

  local sibling_pos, sibling_node, sibling_nodedef = get_sibling_node(pos, node)
  if not sibling_pos then
    return
  end
  local sibling_meta = minetest.get_meta(sibling_pos)

  local new_param2

  local mirror_state = meta:get_int("mirror_state")
  local door_state = meta:get_int("door_state")
  if ((door_state + mirror_state) % 2) == 1 then
    new_param2 = Directions.rotate_facedir_face_anticlockwise(node.param2)
  else
    new_param2 = Directions.rotate_facedir_face_clockwise(node.param2)
  end

  local new_door_state = (door_state + 1) % 2
  meta:set_int("door_state", new_door_state)
  sibling_meta:set_int("door_state", new_door_state)

  local new_node = table_copy(node)
  new_node.name = nodedef.door.mirror_name
  new_node.param2 = new_param2

  local new_sibling_node = table_copy(sibling_node)
  new_sibling_node.name = sibling_nodedef.door.mirror_name
  new_sibling_node.param2 = new_node.param2

  minetest.swap_node(pos, new_node)
  minetest.swap_node(sibling_pos, new_sibling_node)

  if not trigger_aside then
    return
  end

  local aside_check_dir = Directions.D_EAST
  if mirror_state > 0 then
    aside_check_dir = Directions.D_WEST
  end
  if door_state > 0 then
    aside_check_dir = Directions.D_NORTH
  end
  local aside_dir = Directions.facedir_to_face(node.param2, aside_check_dir)
  local aside_vec = Directions.DIR6_TO_VEC3[aside_dir]
  local aside_pos = Vector3.add({}, pos, aside_vec)
  local aside_node = minetest.get_node_or_nil(aside_pos)

  if not aside_node then
    return
  end

  local aside_nodedef = minetest.registered_nodes[aside_node.name]
  if not aside_nodedef then
    return
  end

  if Groups.has_group(aside_nodedef, "door") then
    trigger_door(aside_pos, aside_node, clicker, item_stack, pointed_thing, false)
  end
end

function nokore_door.door_on_right_click(pos, node, clicker, item_stack, pointed_thing)
  trigger_door(pos, node, clicker, item_stack, pointed_thing, true)

  return item_stack
end

function nokore_door.door_after_destruct(my_pos, my_node)
  local sibling_pos = get_sibling_node(my_pos, my_node)

  if sibling_pos then
    minetest.remove_node(sibling_pos)
  end
end

function nokore_door.door_on_blast(my_pos, intensity)
  local my_node = minetest.get_node(my_pos)
  local sibling_pos = get_sibling_node(my_pos, my_node)

  minetest.remove_node(my_pos)
  if sibling_pos then
    minetest.remove_node(sibling_pos)
  end

  local nodedef = minetest.registered_nodes[my_node.name]

  return {nodedef.drop}
end

function nokore_door.door_after_dig_node(my_pos, my_node, old_meta, digger)
  local my_nodedef = minetest.registered_nodes[my_node.name]
  if my_nodedef then
    if my_nodedef.door and my_nodedef.door.segment == "top" then
      minetest.check_for_falling(my_pos)
    end
  end

  local sibling_pos, sibling_node, sibling_nodedef = get_sibling_node(my_pos, my_node)

  if sibling_pos and sibling_node then
    minetest.remove_node(sibling_pos)
    if sibling_nodedef.door.segment == "top" then
      minetest.check_for_falling(sibling_pos)
    end
  end
end

local function register_door_segment(name, base)
  local mirror_name = name .. "_mirror"
  local groups = table_merge(base.groups or {}, {
    door = 1,
    not_in_creative_inventory = 1,
  })

  -- do not overwrite groups
  local new_base = table_copy(base)
  new_base.groups = nil
  new_base.door = nil

  local door = base.door
  door.is_mirror = false
  door.mirror_name = mirror_name

  local def = table_merge({
    groups = groups,

    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        ng(0, 0, 0, 16, 16, 3)
      }
    },

    paramtype = "light",
    paramtype2 = "facedir",

    after_destruct = nokore_door.door_after_destruct,
    on_blast = nokore_door.door_on_blast,
    after_dig_node = nokore_door.door_after_dig_node,

    on_rightclick = nokore_door.door_on_right_click,

    door = door,
  }, new_base)

  minetest.register_node(name, def)

  local mirror_def = table_copy(def)
  mirror_def.tiles = {}

  for i, texture in pairs(def.tiles) do
    mirror_def.tiles[i] = texture .. "^[transformFX"
  end

  minetest.register_node(mirror_name, table_deep_merge(mirror_def, {
    door = {
      is_mirror = true,
      mirror_name = name,
    },
  }))
end

local function register_door_segment_top(basename, base)
  register_door_segment(basename .. "_s_top", table_deep_merge({
    groups = {
      door_top = 1,
    },
    door = {
      name = basename,
      segment = "top",
    },
  }, base))
end

local function register_door_segment_bottom(basename, base)
  register_door_segment(basename .. "_s_bottom", table_deep_merge({
    groups = {
      door_bottom = 1,
    },
    door = {
      name = basename,
      segment = "bottom",
    },
  }, base))
end

-- @spec #register_door(basename: String, base: { node: Table, item: Table }): Table
function nokore_door:register_door(basename, base)
  register_door_segment_top(
    basename,
    table_deep_merge(
      {
        drop = basename,
      },
      table_deep_merge(base.node or {}, base.top or {})
    )
  )
  register_door_segment_bottom(
    basename,
    table_deep_merge(
      {
        drop = basename,
      },
      table_deep_merge(base.node or {}, base.bottom or {})
    )
  )

  minetest.register_craftitem(basename, table_deep_merge({
    on_place = nokore_door.door_on_place,

    door_item = {
      top = basename .. "_s_top",
      bottom = basename .. "_s_bottom",
    },
  }, base.item))
end
