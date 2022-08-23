local path_dirname = assert(foundation.com.path_dirname)

local serialize = minetest.serialize
local deserialize = minetest.deserialize

local KVStore = nokore_game_data.KVStore
local ic = KVStore.instance_class

if serialize then
  function ic:serialize_dump()
    -- same document format as json
    local doc = {
      -- version
      v = 1,
      -- type
      t = "NKKV",
      -- format, pretty much unnecessary
      f = "SERI",
      -- compression or encoding
      c = "identity",
      -- data
      d = self.data
    }

    return serialize(doc)
  end

  function ic:serialize_dump_file(filename, trace)
    local span
    if trace then
      span = trace:span_start("mkdir")
    end
    minetest.mkdir(path_dirname(filename))
    if span then
      span:span_end()
    end

    local blob
    if trace then
      span = trace:span_start("write_json")
    end
    blob = self:serialize_dump()
    if span then
      span:span_end()
    end

    if trace then
      span = trace:span_start("safe_file_write")
    end
    minetest.safe_file_write(filename, blob)
    if span then
      span:span_end()
    end
  end
else
  minetest.log("warning", "serialize_dump functions are not available for key-value store")
end

if deserialize then
  function ic:deserialize_load(blob)
    local doc = deserialize(blob)

    if doc.t ~= "NKKV" then
      error("Incorrect document type (expected:NKKV, got:" .. doc.t .. ")")
    end

    if doc.f ~= "SERI" then
      error("Incorrect format (expected:SERI, got:".. doc.f .. ")")
    end

    if doc.v ~= 1 then
      error("Unsupported version (expected:1, got:".. doc.v .. ")")
    end

    if doc.c ~= "identity" then
      error("Unsupported compression or encoding (expected:identity, got:".. doc.c .. ")")
    end

    self.data = doc.d

    return self, 1
  end

  function ic:deserialize_load_file(filename)
    --print("marshall_load_file", filename)
    local f = io.open(filename, 'r')
    if f then
      local blob = f:read("*all")
      f:close()
      return self:deserialize_load(blob)
    end

    return false
  end
else
  minetest.log("warning", "deserialize_load functions are not available for key-value store")
end
