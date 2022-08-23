local path_dirname = assert(foundation.com.path_dirname)
local Buffer = assert(foundation.com.BinaryBuffer or foundation.com.StringBuffer,
                      "expected some kind of buffer")
local FileBuffer = assert(foundation.com.FileBuffer, "expected FileBuffer")

local KVStore = nokore_game_data.KVStore
local ic = KVStore.instance_class

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
    if magic ~= "NKKV" then
      error("Cannot reload table, magic bytes do not match (expected:NKKV, got:" .. magic .. ")")
    end
    local format
    format, br = stream:read(4)
    bytes_read = bytes_read + br

    if format ~= "ASCI" then
      error("Incorrect format (expected:MRSH, got:".. format .. ")")
    end

    local byte_order
    byte_order, br = stream:read(4)
    bytes_read = bytes_read + br

    if byte_order ~= "ASCI" then
      error("Unsupported byte order (expected:LITE, got:".. byte_order .. ")")
    end

    -- little endian encoding
    local ver
    ver, br = ascii_file_unpack(stream)
    bytes_read = bytes_read + br

    if ver ~= 1 then
      error("Unsupported version (expected:1, got:".. ver .. ")")
    end

    local data
    data, br = ascii_file_unpack(stream)
    bytes_read = bytes_read + br

    local tail
    tail, br = stream:read(4)
    bytes_read = bytes_read + br

    if tail ~= "NKEE" then
      error("expected NKKV stream to end with NKEE")
    end

    self.data = data
    return self, bytes_read
  end

  function ic:apack_dump_file(filename, trace)
    --print("apack_dump_file", filename)
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
      span = trace:span_start("apack_dump")
    end
    self:apack_dump(buffer)
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
  end

  function ic:apack_load_file(filename)
    --print("apack_load_file", filename)
    local f = io.open(filename, 'r')
    if f then
      self:apack_load(FileBuffer:new(f))
      f:close()
      return true
    end
    return false
  end
else
  minetest.log("warning", "ascii pack functions are not available for key-value store")
end
