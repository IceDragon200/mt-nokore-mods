--
-- Key-Value Store
--
-- Simple class for defining a key-value store
-- @namespace nokore

-- @class KVStore
local KVStore = foundation.com.Class:extends("nokore.KVStore")
local ic = KVStore.instance_class

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

-- @spec #has_key(key: String): Boolean
function ic:has_key(key)
  return self.data[key] ~= nil
end

-- @spec #put(String, Any): self
function ic:put(key, value)
  self.data[key] = value
  self.dirty = true
  return self
end

-- @spec #delete(String): self
function ic:delete(key)
  self.data[key] = nil
  self.dirty = true
  return self
end

nokore_game_data.KVStore = KVStore
