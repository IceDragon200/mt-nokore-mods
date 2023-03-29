--
-- Key-Value Store
--
-- Simple class for defining a key-value store
-- @namespace nokore
local table_keys = assert(foundation.com.table_keys)
local table_values = assert(foundation.com.table_values)

-- @class KVStore
local KVStore = foundation.com.Class:extends("nokore.KVStore")
local ic = KVStore.instance_class

-- @type Key: String

-- @type Value: Integer | String | Table | Boolean

-- @spec #initialize(): void
function ic:initialize()
  self.data = {}
  self.dirty = false
end

-- @spec #clear(): self
function ic:clear()
  -- it is faster to replace the data than it would be to nullify each pair
  self.data = {}
  self.dirty = true
  return self
end

-- @spec #mark_dirty(): self
function ic:mark_dirty()
  self.dirty = true
  return self
end

-- @spec #get(key: String, default: Value): Value
function ic:get(key, default)
  local value = self.data[key]
  if value == nil then
    return default
  end
  return value
end

-- @spec #get_lazy(key: String, Function/0): Value
function ic:get_lazy(key, callback)
  local value = self.data[key]

  if value == nil then
    return callback()
  end

  return value
end

-- @spec #keys(): Key[]
function ic:keys()
  return table_keys(self.data)
end

-- @spec #values(): Value[]
function ic:values()
  return table_values(self.data)
end

-- @spec #has_key(key: String): Boolean
function ic:has_key(key)
  return self.data[key] ~= nil
end

-- @spec #put(String, Value): self
function ic:put(key, value)
  self.data[key] = value
  self.dirty = true
  return self
end

-- @spec #put_new(String, Value): self
function ic:put_new(key, value)
  if self.data[key] == nil then
    return self:put(key, value)
  end
  return self
end

-- @spec #put_new_lazy(String, Function/0): self
function ic:put_new_lazy(key, callback)
  if self.data[key] == nil then
    return self:put(key, callback())
  end
  return self
end

-- Update an key-value pair regardless of if it exists.
--
-- Usage:
--
--     upsert_lazy("my_key", function (old_value)
--       ... do something with old_value
--       return new_value
--     end)
--
-- @spec #upsert_lazy(String, Function/1): self
function ic:upsert_lazy(key, callback)
  self.data[key] = callback(self.data[key])
  self.dirty = true
  return self
end

-- Update an existing key-value pair.
--
-- Usage:
--
--     update_lazy("my_key", function (old_value)
--       ... do something with old_value
--       return new_value
--     end)
--
-- @spec #update_lazy(String, Function/1): self
function ic:update_lazy(key, callback)
  if self.data[key] ~= nil then
    self.data[key] = callback(self.data[key])
    self.dirty = true
  end
  return self
end

-- @spec #delete(String): self
function ic:delete(key)
  self.data[key] = nil
  self.dirty = true
  return self
end

nokore_game_data.KVStore = KVStore
