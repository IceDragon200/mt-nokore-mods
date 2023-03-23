-- @namespace nokore_treasure
local WeightedList = assert(foundation.com.WeightedList)
local list_sample = assert(foundation.com.list_sample)

-- @class TreasureRegistry
local TreasureRegistry = foundation.com.Class:extends("TreasureRegistry")
local ic = TreasureRegistry.instance_class

-- @spec #initialize(): void
function ic:initialize()
  self.registered_treasure_chests = {}
  self.registered_treasure_lists = {}
end

-- Register a treasure under a specified list, the item_stack can be an ItemStack, itemstring or
-- table, it will be passed to ItemStack/1 before being pushed into the list.
--
-- @spec #register_treasure(
--   list_name: String,
--   item_stack: ItemStack | String | Table,
--   weight: Integer
-- ): void
function ic:register_treasure_list_item(list_name, item_stack, weight)
  assert(type(list_name) == "string", "expected a list name (String)")
  assert(item_stack, "expected an item stack (ItemStack | String | Table)")
  assert(type(weight) == "number", "expected a weight (Integer)")

  if not self.registered_treasure_lists[list_name] then
    self.registered_treasure_lists[list_name] = WeightedList:new()
  end
  item_stack = ItemStack(item_stack)
  self.registered_treasure_lists[list_name]:push(item_stack, weight)
end

-- Retrieve the treasure weighted list by name
--
-- @spec #get_treasure_list(list_name: String): WeightedList
function ic:get_treasure_list(list_name)
  return self.registered_treasure_lists[list_name]
end

-- Retrieves a list of random treasures given the list name and a count
--
-- @spec #sample_treasures(list_name: String, count: Integer): Table
function ic:sample_treasure_list(list_name, count)
  local wlist = self.registered_treasure_lists[list_name]
  if wlist then
    return wlist:random_list(count)
  end
  return {}
end

-- Registers a chest definition, chest definitions are responsible for replacing
-- spawning chests with their appropriate treasures.
--
-- Usage:
--
--     register_treasure_chest("my_mod:my_chest", {
--       node_names = {"my_mod:chest"},
--       list_names = {"my_mod:loot_list_1"},
--     })
--
-- @spec #register_treasure_chest(chest_name: String, def: Table): void
function ic:register_treasure_chest(chest_name, def)
  assert(type(chest_name) == "string", "expected a chest name (String)")
  assert(type(def) == "table", "expected a chest definition (Table)")

  if self.registered_treasure_chests[chest_name] then
    error("Duplicate chest registration chest_name=" .. chest_name)
  end

  if not def.inventory_name then
    def.inventory_name = "main"
  end

  def.name = chest_name

  self.registered_treasure_chests[chest_name] = def

  return def
end

function ic:get_treasure_chest(chest_name)
  return self.registered_treasure_chests[chest_name]
end

local function spawn_from_def(chest_def, pos, original_node, tr)
  local node = {
    name = list_sample(chest_def.node_names),
    param1 = 0,
    param2 = 0,
  }

  if chest_def.copy_param1 then
    node.param1 = original_node.param1
  end

  if chest_def.copy_param2 then
    node.param2 = original_node.param2
  end

  minetest.add_node(pos, node)

  local meta = minetest.get_meta(pos)

  local inv = meta:get_inventory()

  --inv:set_size("main", 10)

  local inv_name = chest_def.inventory_name
  local dest = inv:get_list(inv_name)

  for _, list_name in ipairs(chest_def.list_names) do
    local list = tr:sample_treasure_list(list_name)

    if list then
      foundation.com.InventoryList.add_items(dest, list)
    end
  end

  inv:set_list(inv_name, dest)

  return true
end

function ic:spawn_treasure_chest(pos, node, chest_name)
  -- First find the chest definition
  local chest_def = self:get_treasure_chest(chest_name)

  if not chest_def then
    return false, "chest not found"
  end

  if chest_def.spawn then
    -- spawn the chest, giving the callback the instance of the chest definition
    -- followed by the position to spawn it at and finally a reference to the treasure
    -- registry, the spawn callback is therefore expected to handle adding the node and
    -- updating the inventory appropriately.
    return chest_def.spawn(chest_def, pos, node, self)
  end

  return spawn_from_def(chest_def, pos, node, self)
end

nokore_treasure.TreasureRegistry = TreasureRegistry
