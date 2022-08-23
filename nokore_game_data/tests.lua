local KVStore = nokore_game_data.KVStore

local Luna = assert(foundation.com.Luna)

local ascii_file_pack = foundation.com.ascii_file_pack
local ascii_file_unpack = foundation.com.ascii_file_unpack

local ByteBuf = foundation.com.ByteBuf and foundation.com.ByteBuf.little
local MarshallValue = foundation.com.binary_types and foundation.com.binary_types.MarshallValue

local StringBuffer = foundation.com.StringBuffer

local case = Luna:new("nokore_game_data.KVStore")

local METHODS = {
  {
    enabled = ascii_file_pack and ascii_file_unpack,
    uses_stream = true,
    load = "apack_load",
    dump = "apack_dump",
    load_file = "apack_load_file",
    dump_file = "apack_dump_file",
  },
  {
    enabled = MarshallValue,
    uses_stream = true,
    load = "marshall_load",
    dump = "marshall_dump",
    load_file = "marshall_load_file",
    dump_file = "marshall_dump_file",
  },
  {
    enabled = minetest.write_json and minetest.parse_json,
    uses_stream = false,
    load = "json_load",
    dump = "json_dump",
    load_file = "json_load_file",
    dump_file = "json_dump_file",
  },
  {
    enabled = minetest.serialize and minetest.deserialize,
    uses_stream = false,
    load = "deserialize_load",
    dump = "serialize_dump",
    load_file = "deserialize_load_file",
    dump_file = "serialize_dump_file",
  },
}

for _, def in ipairs(METHODS) do
  local desc = def.dump .. "|" .. def.load
  local file_desc = def.dump_file .. "|" .. def.load_file
  if def.enabled then
    case:describe(desc, function (t2)
      t2:test("can handle serializing an empty key value store", function (t3)
        local kv = KVStore:new()

        t3:refute(kv:get("key"))

        local blob
        local stream
        if def.uses_stream then
          stream = StringBuffer:new('', 'w')
          kv[def.dump](kv, stream)
          stream:close()
        else
          blob = kv[def.dump](kv)
        end

        -- create a new key value store
        local new_kv = KVStore:new()

        if def.uses_stream then
          stream:open('r')
          new_kv[def.load](kv, stream)
        else
          new_kv[def.load](kv, blob)
        end

        t3:refute(new_kv:get("key"))
      end)

      t2:test("can handle serializing a key-value store with various values", function (t3)
        local kv = KVStore:new()

        kv:put("boolean_true", true)
        kv:put("boolean_false", false)

        kv:put("n-1", -1)
        kv:put("n1", 1)
        kv:put("n256", 256)

        kv:put("string", "Hello, World")

        kv:put("empty_table", {})
        kv:put("table_array", {1, 2, 3})
        kv:put("table_map", { a = 1, b = 2, c = 3 })

        local blob
        local stream
        if def.uses_stream then
          stream = StringBuffer:new('', 'w')
          t3:assert(kv[def.dump](kv, stream))
          stream:close()
        else
          blob = t3:assert(kv[def.dump](kv))
        end

        -- create a new key value store
        local new_kv = KVStore:new()

        if def.uses_stream then
          stream:open('r')
          t3:assert(new_kv[def.load](new_kv, stream))
        else
          t3:assert(new_kv[def.load](new_kv, blob))
        end

        t3:assert_eq(new_kv:get("boolean_true"), true)
        t3:assert_eq(new_kv:get("boolean_false"), false)
        t3:assert_eq(new_kv:get("n-1"), -1)
        t3:assert_eq(new_kv:get("n1"), 1)
        t3:assert_eq(new_kv:get("n256"), 256)
        t3:assert_eq(new_kv:get("string"), "Hello, World")
        t3:assert_deep_eq(new_kv:get("empty_table"), {})
        t3:assert_deep_eq(new_kv:get("table_array"), {1, 2, 3})
        t3:assert_deep_eq(new_kv:get("table_map"), { a = 1, b = 2, c = 3})
      end)
    end)
  else
    minetest.log("warning", desc .. " unavailable")
  end

  if def.enabled then
    case:describe(file_desc, function (t2)
      local test_filename = minetest.get_worldpath() .. "/tmp/nokore_game_data_kv_test.blob"

      t2:test("can handle serializing an empty key value store", function (t3)
        local kv = KVStore:new()

        t3:refute(kv:get("key"))

        kv[def.dump_file](kv, test_filename)

        -- create a new key value store
        local new_kv = KVStore:new()

        new_kv[def.load_file](kv, test_filename)

        t3:refute(new_kv:get("key"))
      end)

      t2:test("can handle serializing a key-value store with various values", function (t3)
        local kv = KVStore:new()

        kv:put("boolean_true", true)
        kv:put("boolean_false", false)

        kv:put("n-1", -1)
        kv:put("n1", 1)
        kv:put("n256", 256)

        kv:put("string", "Hello, World")

        kv:put("empty_table", {})
        kv:put("table_array", {1, 2, 3})
        kv:put("table_map", { a = 1, b = 2, c = 3 })

        kv[def.dump_file](kv, test_filename)

        -- create a new key value store
        local new_kv = KVStore:new()

        new_kv[def.load_file](new_kv, test_filename)

        t3:assert_eq(new_kv:get("boolean_true"), true)
        t3:assert_eq(new_kv:get("boolean_false"), false)
        t3:assert_eq(new_kv:get("n-1"), -1)
        t3:assert_eq(new_kv:get("n1"), 1)
        t3:assert_eq(new_kv:get("n256"), 256)
        t3:assert_eq(new_kv:get("string"), "Hello, World")
        t3:assert_deep_eq(new_kv:get("empty_table"), {})
        t3:assert_deep_eq(new_kv:get("table_array"), {1, 2, 3})
        t3:assert_deep_eq(new_kv:get("table_map"), { a = 1, b = 2, c = 3})
      end)
    end)
  else
    minetest.log("warning", file_desc .. " unavailable")
  end
end

case:execute()
case:display_stats()
case:maybe_error()
