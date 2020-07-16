local function table_merge(...)
  local result = {}
  for _,t in ipairs({...}) do
    for key,value in pairs(t) do
      result[key] = value
    end
  end
  return result
end

local SCALE = 8/16
local OFFSET = 1/16

--
-- Entity used to present the item on the stockpile
--
minetest.register_entity("nokore_stockpile:item", {
  initial_properties = {
    hp_max = 1,
    visual = "wielditem",
    visual_size = {x = SCALE, y = SCALE, z = SCALE},
    collisionbox = {0,0,0,0,0,0},
    use_texture_alpha = true,
    physical = false,
    collide_with_objects = false,
    pointable = false,
    static_save = false, -- delete the entity on block unload, the stockpile will refresh it on load
  },

  on_step = function (self, delta)
    --
  end,

  on_activate = function(self, static_data)
    local data = minetest.parse_json(static_data)

    self.stockpile_id = data.stockpile_id
    self.item_name = data.item_name

    if not self.stockpile_id or not self.item_name then
      self.object:remove()
    else
      self.object:set_properties({
        visual_size = {x = SCALE, y = SCALE, z = SCALE},
        wield_item = self.item_name,
        itemstring = self.item_name,
      })
    end
  end,

  get_staticdata = function (self)
    local data = {
      stockpile_id = self.stockpile_id,
      item_name = self.item_name,
    }
    return minetest.write_json(data)
  end,
})

function nokore_stockpile.remove_stockpile_item_entity(pos)
  local stockpile_id = minetest.hash_node_position(pos)
  for _, object in ipairs(minetest.get_objects_inside_radius(pos, 0.75)) do
    if not object:is_player() then
      local lua_entity = object:get_luaentity()
      if lua_entity then
        if lua_entity.stockpile_id == stockpile_id then
          object:remove()
        end
      end
    end
  end
end

function nokore_stockpile.refresh_stockpile_item(pos)
  nokore_stockpile.remove_stockpile_item_entity(pos)

  local stockpile_id = minetest.hash_node_position(pos)
  local node = minetest.get_node_or_nil(pos)
  if node then
    local nodedef = minetest.registered_nodes[node.name]
    if nodedef then
      if nodedef.groups and nodedef.groups.stockpile then
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        local stack = inv:get_stack("main", 1)
        if stack and not stack:is_empty() then
          local obj_pos = {
            x = pos.x,
            y = pos.y + OFFSET, -- adjust for stockpile height
            z = pos.z,
          }
          minetest.add_entity(obj_pos, "nokore_stockpile:item", minetest.write_json({
            item_name = stack:get_name(),
            stockpile_id = stockpile_id,
          }))
        end
      end
    end
  end
end

function nokore_stockpile.stockpile_on_construct(pos)
  local meta = minetest.get_meta(pos)
  local inv = meta:get_inventory()

  inv:set_size("main", 1)
end

function nokore_stockpile.stockpile_after_destruct(pos, _old_node)
  nokore_stockpile.remove_stockpile_item_entity(pos)
end

--
-- Stockpile right click action, this allows the player to put their held item unto
-- the stockpile
function nokore_stockpile.stockpile_on_rightclick(pos, _node, player, item_stack, _pointed_thing)
  local meta = minetest.get_meta(pos)
  local inv = meta:get_inventory()

  local leftover_stack = inv:add_item("main", item_stack)
  nokore_stockpile.refresh_stockpile_item(pos)
  return leftover_stack
end

function nokore_stockpile.stockpile_on_punch(pos, node, player, pointed_thing)
  local meta = minetest.get_meta(pos)
  local inv = meta:get_inventory()

  if inv:is_empty("main") then
    -- TODO: notify player that the stockpile is empty
    minetest.node_punch(pos, node, player, pointed_thing)
  else
    local stack = inv:get_stack("main", 1)
    local player_inv = player:get_inventory()

    local leftover_stack = player_inv:add_item("main", stack)
    inv:set_stack("main", 1, leftover_stack)
    nokore_stockpile.refresh_stockpile_item(pos)
  end
end

function nokore_stockpile.stockpile_can_dig(pos)
  local meta = minetest.get_meta(pos)
  local inv = meta:get_inventory()

  return inv:is_empty("main")
end

-- @spec nokore_stockpile.register_stockpile(name: String, def: Table) :: void
function nokore_stockpile.register_stockpile(name, def)
  minetest.register_node(name, table_merge({
    description = "Stockpile",

    groups = {
      stockpile = 1,
      oddly_breakable_by_hand = 1,
      cracky = 1,
    },

    on_construct = nokore_stockpile.stockpile_on_construct,
    after_destruct = nokore_stockpile.stockpile_after_destruct,

    on_rightclick = nokore_stockpile.stockpile_on_rightclick,
    on_punch = nokore_stockpile.stockpile_on_punch,

    can_dig = nokore_stockpile.stockpile_can_dig,
  }, def))
end

nokore.register_stockpile = nokore_stockpile.register_stockpile

minetest.register_lbm({
  label = "Refresh Stockpile Items",

  nodenames = {"group:stockpile"},

  name = "nokore_stockpile:refresh_stockpile_item",

  run_at_every_load = true,

  action = function (pos, _node)
    nokore_stockpile.refresh_stockpile_item(pos)
  end,
})
