local path_dirname = assert(foundation.com.path_dirname)

local write_json = minetest.write_json
local parse_json = minetest.parse_json

local KVStore = nokore_game_data.KVStore
local ic = KVStore.instance_class

if write_json then
  function ic:json_dump()
    local doc = {
      -- version
      v = 1,
      -- type
      t = "NKKV",
      -- format, pretty much unnecessary
      f = "JSON",
      -- compression or encoding
      c = "identity",
      -- data
      d = self.data
    }

    return write_json(doc)
  end

  function ic:json_dump_file(filename, trace)
    local span
    local success
    local err

    if trace then
      span = trace:span_start("mkdir")
    end
    success, err = minetest.mkdir(path_dirname(filename))
    if span then
      span:span_end()
    end

    if not success then
      return success, err
    end

    local blob
    if trace then
      span = trace:span_start("write_json")
    end
    blob = self:json_dump()
    if span then
      span:span_end()
    end

    if trace then
      span = trace:span_start("safe_file_write")
    end
    success, err = minetest.safe_file_write(filename, blob)
    if span then
      span:span_end()
    end

    return success, err
  end
else
  minetest.log("warning", "json_dump functions are not available for key-value store")
end

if parse_json then
  function ic:json_load(blob)
    assert(type(blob) == "string", "expected blob to be a string of some kind")

    print(blob)

    local doc = parse_json(blob)

    if doc.t ~= "NKKV" then
      error("Incorrect document type (expected:NKKV, got:" .. doc.t .. ")")
    end

    if doc.f ~= "JSON" then
      error("Incorrect format (expected:JSON, got:".. doc.f .. ")")
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

  function ic:json_load_file(filename)
    --print("marshall_load_file", filename)
    local f = io.open(filename, 'r')
    if f then
      local blob = f:read("*all")
      f:close()
      self:json_load(blob)
      return true
    end

    return false
  end
else
  minetest.log("warning", "json_load functions are not available for key-value store")
end
