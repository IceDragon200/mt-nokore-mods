-- @namespace nokore_treasure
local WeightedList = assert(foundation.com.WeightedList)

-- @class TreasureRegistry
local TreasureRegistry = foundation.com.Class:extends("TreasureRegistry")
local ic = TreasureRegistry.instance_class

-- @spec #initialize(): void
function ic:initialize()
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
function ic:register_treasure(list_name, item_stack, weight)
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
function ic:sample_treasures(list_name, count)
  local wlist = self.registered_treasure_lists[list_name]
  if wlist then
    return wlist:random_list(count)
  end
  return {}
end

nokore_treasure.TreasureRegistry = TreasureRegistry
