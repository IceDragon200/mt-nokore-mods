local path_dirname = assert(foundation.com.path_dirname)
local Buffer = assert(foundation.com.BinaryBuffer or foundation.com.StringBuffer,
                      "expected some kind of buffer")

local KVStore = nokore_game_data.KVStore
local ic = KVStore.instance_class

local ByteBuf
if foundation.com.ByteBuf then
  ByteBuf = assert(foundation.com.ByteBuf.little)
end
local MarshallValue

if foundation.com.binary_types then
  MarshallValue = foundation.com.binary_types.MarshallValue
end

if ByteBuf and MarshallValue then
  local marshall = MarshallValue:new()

  function ic:marshall_dump(stream)
    local bytes_written = 0
    local bw, err

    -- Write the magic bytes
    bw, err = ByteBuf:write(stream, "NKKV") -- NoKoreKeyValue
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    -- Write the format code
    bw, err = ByteBuf:write(stream, "MRSH") -- MRSH - Marshall, ASCI - ASCII Pack
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    -- Write the endian code
    bw, err = ByteBuf:write(stream, "LITE") -- LITE - little endian, BIGE - big endian
                                         -- always little because ByteBuf is in little by default
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = ByteBuf:w_i32(stream, 1) -- Version 1
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = marshall:write(stream, self.data) -- marshall dump the data
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    bw, err = ByteBuf:write(stream, "NKEE") -- NoKoreEndEnd
    bytes_written = bytes_written + bw
    if err then
      return bytes_written, err
    end

    return bytes_written, err
  end

  function ic:marshall_load(stream)
    local bytes_read = 0
    local br

    local magic
    magic, br = ByteBuf:read(stream, 4)
    bytes_read = bytes_read + br

    if magic ~= "NKKV" then
      error("Cannot reload table, magic bytes do not match (expected:NKKV, got:" .. magic .. ")")
    end

    local format
    format, br = ByteBuf:read(stream, 4)
    bytes_read = bytes_read + br

    if format ~= "MRSH" then
      error("Incorrect format (expected:MRSH, got:".. format .. ")")
    end

    local byte_order
    byte_order, br = ByteBuf:read(stream, 4)
    bytes_read = bytes_read + br

    if byte_order ~= "LITE" then
      error("Unsupported byte order (expected:LITE, got:".. byte_order .. ")")
    end

    -- little endian encoding
    local ver
    ver, br = ByteBuf:r_i32(stream)
    bytes_read = bytes_read + br

    if ver ~= 1 then
      error("Unsupported version (expected:1, got:".. ver .. ")")
    end

    local data
    data, br = marshall:read(stream)
    bytes_read = bytes_read + br

    local tail
    tail, br = ByteBuf:read(stream, 4)
    bytes_read = bytes_read + br

    assert(tail == "NKEE", "expected NKKV stream to end with NKEE")

    self.data = data
    return self, bytes_read
  end

  function ic:marshall_dump_file(filename, trace)
    --print("marshall_dump_file", filename)
    local span
    if trace then
      span = trace:span_start("mkdir")
    end
    minetest.mkdir(path_dirname(filename))
    if span then
      span:span_end()
    end

    local buffer = Buffer:new('', 'w')
    if trace then
      span = trace:span_start("marshall_dump")
    end
    self:marshall_dump(buffer)
    if span then
      span:span_end()
    end
    buffer:close()

    if trace then
      span = trace:span_start("safe_file_write")
    end
    minetest.safe_file_write(filename, buffer:blob())
    if span then
      span:span_end()
    end
    return true
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
