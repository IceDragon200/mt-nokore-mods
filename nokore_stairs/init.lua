--
-- NoKore - Stairs
--
-- For lack of a better name, adds APIs for generating stairs, slabs, and plates
-- Unlike minetest_game's stairs this will not register, but instead returns the
-- node definition to the caller.

-- @namespace nokore_stairs
local mod = foundation.new_module("nokore_stairs", "0.2.0")
local table_merge = assert(foundation.com.table_merge)

local function maybe_backface_cull_tiles(def)
  local old_tiles
  if type(def.tiles) == "string" then
    old_tiles = {def.tiles}
  else
    old_tiles = table.copy(def.tiles)
  end

  local tiles = {}
  for index,tile in pairs(old_tiles) do
    local new_tile
    if type(tile) == "string" then
      new_tile = {
        name = tile,
        backface_culling = true
      }
    else
      new_tile = table.copy(tile)
      if new_tile.backface_culling == nil then
        new_tile.backface_culling = true
      end
    end
    tiles[index] = new_tile
  end

  return tiles
end

-- Taken from minetest_game's stairs mod
function mod.rotate_and_place(itemstack, placer, pointed_thing)
  local p0 = pointed_thing.under
  local p1 = pointed_thing.above
  local param2 = 0

  if placer then
    local placer_pos = placer:get_pos()
    if placer_pos then
      param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
    end

    local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
    local fpos = finepos.y % 1

    if p0.y - 1 == p1.y or (fpos > 0 and fpos < 0.5)
        or (fpos < -0.5 and fpos > -0.999999999) then
      param2 = param2 + 20
      if param2 == 21 then
        param2 = 23
      elseif param2 == 23 then
        param2 = 21
      end
    end
  end
  return minetest.item_place(itemstack, placer, pointed_thing, param2)
end

function mod.slab_on_place(itemstack, placer, pointed_thing)
  local under = minetest.get_node(pointed_thing.under)
  local wield_item = itemstack:get_name()
  local player_name = placer and placer:get_player_name() or ""
  local creative_enabled = false --(creative and creative.is_enabled_for
                                 --          and creative.is_enabled_for(player_name))

  if under then
    local nodedef = minetest.registered_nodes[under.name]
    if nodedef and nodedef.groups.slab and nodedef.groups.slab > 0 then
      -- place slab using under node orientation
      local dir =
        minetest.dir_to_facedir(
          vector.subtract(pointed_thing.above, pointed_thing.under),
          true
        )

      local p2 = under.param2

      -- Placing a slab on an upside down slab should make it right-side up.
      if p2 >= 20 and dir == 8 then
        p2 = p2 - 20
      -- same for the opposite case: slab below normal slab
      elseif p2 <= 3 and dir == 4 then
        p2 = p2 + 20
      end

      -- else attempt to place node with proper param2
      minetest.item_place_node(ItemStack(wield_item), placer, pointed_thing, p2)
      if not creative_enabled then
        itemstack:take_item()
      end
      return itemstack
    else
      return mod.rotate_and_place(itemstack, placer, pointed_thing)
    end
  else
    return mod.rotate_and_place(itemstack, placer, pointed_thing)
  end
end

function mod.stair_on_place(itemstack, placer, pointed_thing)
  if pointed_thing.type ~= "node" then
    return itemstack
  end

  return mod.rotate_and_place(itemstack, placer, pointed_thing)
end

-- @spec build_column(NodeDefinition): NodeDefinition
function mod.build_column(old_def)
  local def = table.copy(old_def)
  local groups = table.copy(def.groups or {})
  if groups.column == nil then
    groups.column = 1
  end
  def.groups = nil

  local tiles = maybe_backface_cull_tiles(def)
  def.tiles = nil

  return table_merge({
    groups = groups,

    tiles = tiles,

    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-0.5, -0.5, 0.0, 0.0, 0.5, 0.5},
      },
    },

    paramtype = "light",
    paramtype2 = "facedir",

    is_ground_content = false,

    on_place = mod.slab_on_place,
  }, def)
end

-- A plate is 1/16 thick node, which acts as a cover or barely noticable tile
--
-- @spec build_plate(NodeDefinition): NodeDefinition
function mod.build_plate(old_def)
  local def = table.copy(old_def)
  local groups = table.copy(def.groups or {})
  if groups.slab == nil then
    groups.slab = 1
  end
  def.groups = nil

  local tiles = maybe_backface_cull_tiles(def)
  def.tiles = nil

  return table_merge({
    groups = groups,

    tiles = tiles,

    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-0.5, -0.5, -0.5, 0.5, -7/16, 0.5},
      },
    },

    paramtype = "light",
    paramtype2 = "facedir",

    is_ground_content = false,

    on_place = mod.slab_on_place,
  }, def)
end

-- A slab is a 1/2 node, usually acting as a long step
--
-- @spec build_slab(NodeDefinition): NodeDefinition
function mod.build_slab(old_def)
  local def = table.copy(old_def)
  local groups = table.copy(def.groups or {})
  if groups.slab == nil then
    groups.slab = 1
  end
  def.groups = nil

  local tiles = maybe_backface_cull_tiles(def)
  def.tiles = nil

  return table_merge({
    groups = groups,

    tiles = tiles,

    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
      },
    },

    paramtype = "light",
    paramtype2 = "facedir",

    is_ground_content = false,

    on_place = mod.slab_on_place,
  }, def)
end

-- Basic stairs
--
-- @spec build_stair(NodeDefinition): NodeDefinition
function mod.build_stair(old_def)
  local def = table.copy(old_def)
  local groups = table.copy(def.groups or {})
  if groups.stair == nil then
    groups.stair = 1
  end
  def.groups = nil

  local tiles = maybe_backface_cull_tiles(def)
  def.tiles = nil

  return table_merge({
    groups = groups,

    tiles = tiles,

    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
        {-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
      },
    },

    paramtype = "light",
    paramtype2 = "facedir",

    is_ground_content = false,

    on_place = mod.stair_on_place,
  }, def)
end

-- Stairs inner section
--
-- @spec build_stair_inner(NodeDefinition): NodeDefinition
function mod.build_stair_inner(old_def)
  local def = table.copy(old_def)
  local groups = table.copy(def.groups or {})
  if groups.stair == nil then
    groups.stair_inner = 1
  end
  def.groups = nil

  local tiles = maybe_backface_cull_tiles(def)
  def.tiles = nil

  return table_merge({
    groups = groups,

    tiles = tiles,

    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
        {-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
        {-0.5, 0.0, -0.5, 0.0, 0.5, 0.0},
      },
    },

    paramtype = "light",
    paramtype2 = "facedir",

    is_ground_content = false,

    on_place = mod.stair_on_place,
  }, def)
end

-- Stairs outer
--
-- @spec build_stair_outer(NodeDefinition): NodeDefinition
function mod.build_stair_outer(old_def)
  local def = table.copy(old_def)
  local groups = table.copy(def.groups or {})
  if groups.stair == nil then
    groups.stair_outer = 1
  end
  def.groups = nil

  local tiles = maybe_backface_cull_tiles(def)
  def.tiles = nil

  return table_merge({
    groups = groups,

    tiles = tiles,

    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
        {-0.5, 0.0, 0.0, 0.0, 0.5, 0.5},
      },
    },

    paramtype = "light",
    paramtype2 = "facedir",

    is_ground_content = false,

    on_place = mod.stair_on_place,
  }, def)
end

-- @spec build_nodes({ [type: String]: NodeDefinition }): Table
function mod.build_nodes(data)
  local result = {}

  local default_def = data._ or {}

  if data.column ~= false then
    local column_def = table_merge(default_def, data.column or {})
    result.column = mod.build_column(column_def)
  end

  if data.plate ~= false then
    local plate_def = table_merge(default_def, data.plate or {})
    result.plate = mod.build_plate(plate_def)
  end

  if data.slab ~= false then
    local slab_def = table_merge(default_def, data.slab or {})
    result.slab = mod.build_slab(slab_def)
  end

  if data.stair ~= false then
    local stair_def = table_merge(default_def, data.stair or {})
    result.stair = mod.build_stair(stair_def)
  end

  if data.stair_outer ~= false then
    local stair_outer_def = table_merge(default_def, data.stair_outer or {})
    result.stair_outer = mod.build_stair_outer(stair_outer_def)
  end

  if data.stair_inner ~= false then
    local stair_inner_def = table_merge(default_def, data.stair_inner or {})
    result.stair_inner = mod.build_stair_inner(stair_inner_def)
  end

  return result
end

-- Helper function for registering nodes from the build_stairs function
-- it's actually quite generic and could be used for any table of nodes definitions.
function mod.register_nodes(basename, state)
  for key,def in pairs(state) do
    local name = basename .. "_" .. key
    minetest.register_node(name, def)
  end
  return state
end

function mod.build_and_register_nodes(basename, state)
  local result = mod.build_nodes(state)

  return mod.register_nodes(basename, result)
end
