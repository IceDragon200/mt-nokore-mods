--
-- Key-Value Store
--
-- Simple class for defining a key-value store
-- @namespace nokore
local path_dirname = assert(foundation.com.path_dirname)
local Buffer = assert(foundation.com.BinaryBuffer or foundation.com.StringBuffer,
                      "expected some kind of buffer")

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

local ascii_file_pack = foundation.com.ascii_file_pack
local ascii_file_unpack = foundation.com.ascii_file_unpack

if ascii_file_pack and ascii_file_unpack then
  local function file_write(stream, data)
    local success, err = stream:write(data)
    if success then
      return #data, nil
    else
      return 0, err
    end
  end

  function ic:apack_dump(stream)
    local bytes_written = 0
    local bw, err

    bw, err = file_write(stream, "NKKV")
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = file_write(stream, "ASCI")
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = file_write(stream, "ASCI") -- ASCII Pack doesn't really have a byte order,
                                         -- so it just repeats the ASCII tag
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = ascii_file_pack(stream, 1) -- version 1
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = ascii_file_pack(stream, self.data) -- data
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = file_write(stream, "NKEE")
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    return bytes_written
  end

  function ic:apack_load(stream)
    local bytes_read = 0
    local br

    local magic, br = stream:read(4)
    if magic == "NKKV" then
      local format, br = stream:read(4)
      bytes_read = bytes_read + br

      if format == "ASCI" then
        local byte_order, br = stream:read(4)
        bytes_read = bytes_read + br

        if byte_order == "ASCI" then
          -- little endian encoding
          local ver, br = ascii_file_unpack(stream)
          bytes_read = bytes_read + br

          if ver == 1 then
            local data, br = ascii_file_unpack(stream)
            bytes_read = bytes_read + br

            local tail, br = stream:read(4)
            bytes_read = bytes_read + br

            assert(tail == "NKEE", "expected NKKV stream to end with NKEE")

            self.data = data
            return self, bytes_read
          else
            error("Unsupported version (expected:1, got:".. ver .. ")")
          end
        else
          error("Unsupported byte order (expected:LITE, got:".. byte_order .. ")")
        end
      else
        error("Incorrect format (expected:MRSH, got:".. format .. ")")
      end
    else
      error("Cannot reload table, magic bytes do not match (expected:NKKV, got:" .. magic .. ")")
    end
  end

  function ic:apack_dump_file(filename)
    --print("apack_dump_file", filename)
    minetest.mkdir(path_dirname(filename))
    local buffer = Buffer:new('', 'w')
    self:apack_dump(buffer)
    buffer:close()
    minetest.safe_file_write(filename, buffer:blob())
  end

  function ic:apack_load_file(filename)
    --print("apack_load_file", filename)
    local f = io.open(filename, 'r')
    if f then
      self:apack_load(f)
      f:close()
      return true
    end
    return false
  end
else
  minetest.log("warning", "ascii pack functions are not available for key-value store")
end

local ByteBuf = foundation.com.ByteBuf
local MarshallValue = foundation.com.binary_types.MarshallValue

if ByteBuf and MarshallValue then
  local marshall = MarshallValue:new()

  function ic:marshall_dump(stream)
    local bytes_written = 0
    local bw, err

    -- Write the magic bytes
    bw, err = ByteBuf.write(stream, "NKKV") -- NoKoreKeyValue
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    -- Write the format code
    bw, err = ByteBuf.write(stream, "MRSH") -- MRSH - Marshall, ASCI - ASCII Pack
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    -- Write the endian code
    bw, err = ByteBuf.write(stream, "LITE") -- LITE - little endian, BIGE - big endian
                                         -- always little because ByteBuf is in little by default
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = ByteBuf.w_i32(stream, 1) -- Version 1
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = marshall:write(stream, self.data) -- marshall dump the data
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = ByteBuf.write(stream, "NKEE") -- NoKoreEndEnd
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    return bytes_written, err
  end

  function ic:marshall_load(stream)
    local bytes_read = 0
    local br

    local magic, br = ByteBuf.read(stream, 4)
    bytes_read = bytes_read + br

    if magic == "NKKV" then
      local format, br = ByteBuf.read(stream, 4)
      bytes_read = bytes_read + br

      if format == "MRSH" then
        local byte_order, br = ByteBuf.read(stream, 4)
        bytes_read = bytes_read + br

        if byte_order == "LITE" then
          -- little endian encoding
          local ver, br = ByteBuf.r_i32(stream)
          bytes_read = bytes_read + br

          if ver == 1 then
            local data, br = marshall:read(stream)
            bytes_read = bytes_read + br

            local tail, br = ByteBuf.read(stream, 4)
            bytes_read = bytes_read + br

            assert(tail == "NKEE", "expected NKKV stream to end with NKEE")

            self.data = data
            return self, bytes_read
          else
            error("Unsupported version (expected:1, got:".. ver .. ")")
          end
        else
          error("Unsupported byte order (expected:LITE, got:".. byte_order .. ")")
        end
      else
        error("Incorrect format (expected:MRSH, got:".. format .. ")")
      end
    else
      error("Cannot reload table, magic bytes do not match (expected:NKKV, got:" .. magic .. ")")
    end
  end

  function ic:marshall_dump_file(filename)
    --print("marshall_dump_file", filename)
    minetest.mkdir(path_dirname(filename))
    local buffer = Buffer:new('', 'w')
    self:marshall_dump(buffer)
    buffer:close()
    minetest.safe_file_write(filename, buffer:blob())
  end

  function ic:marshall_load_file(filename)
    --print("marshall_load_file", filename)
    local f = io.open(filename, 'r')
    if f then
      self:marshall_load(f)
      f:close()
      return true
    end
    return false
  end
else
  minetest.log("warning", "marshall functions are not available for key-value store")
end

nokore_game_data.KVStore = KVStore
