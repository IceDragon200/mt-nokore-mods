local KVStore = nokore_game_data.KVStore

local Luna = assert(foundation.com.Luna)

local ascii_file_pack = foundation.com.ascii_file_pack
local ascii_file_unpack = foundation.com.ascii_file_unpack

local ByteBuf = foundation.com.ByteBuf and foundation.com.ByteBuf.little
local MarshallValue = foundation.com.binary_types and foundation.com.binary_types.MarshallValue

local StringBuffer = foundation.com.StringBuffer

local case = Luna:new("nokore_game_data.KVStore")

if ascii_file_pack and ascii_file_unpack then
  case:describe("apack_load|apack_dump", function (t2)
    t2:test("can handle serializing an empty key value store", function (t3)
      local kv = KVStore:new()

      local stream = StringBuffer:new('', 'w')

      t3:refute(kv:get("key"))

      kv:apack_dump(stream)

      stream:close()
      stream:open('r')

      -- create a new key value store
      local kv = KVStore:new()

      kv:apack_load(stream)

      t3:refute(kv:get("key"))
    end)

    t2:test("can handle serializing a key-value store with various values", function (t3)
      local kv = KVStore:new()

      local stream = StringBuffer:new('', 'w')

      kv:put("boolean_true", true)
      kv:put("boolean_false", false)

      kv:put("n-1", -1)
      kv:put("n1", 1)
      kv:put("n256", 256)

      kv:put("string", "Hello, World")

      kv:put("empty_table", {})
      kv:put("table_array", {1, 2, 3})
      kv:put("table_map", { a = 1, b = 2, c = 3 })

      kv:apack_dump(stream)

      stream:close()
      stream:open('r')

      -- create a new key value store
      local kv = KVStore:new()

      kv:apack_load(stream)

      t3:assert_eq(kv:get("boolean_true"), true)
      t3:assert_eq(kv:get("boolean_false"), false)
      t3:assert_eq(kv:get("n-1"), -1)
      t3:assert_eq(kv:get("n1"), 1)
      t3:assert_eq(kv:get("n256"), 256)
      t3:assert_eq(kv:get("string"), "Hello, World")
      t3:assert_deep_eq(kv:get("empty_table"), {})
      t3:assert_deep_eq(kv:get("table_array"), {1, 2, 3})
      t3:assert_deep_eq(kv:get("table_map"), { a = 1, b = 2, c = 3})
    end)
  end)

  case:describe("marshall_load|marshall_dump", function (t2)
    t2:test("can handle serializing an empty key value store", function (t3)
      local kv = KVStore:new()

      local stream = StringBuffer:new('', 'w')

      t3:refute(kv:get("key"))

      kv:marshall_dump(stream)

      stream:close()
      stream:open('r')

      -- create a new key value store
      local kv = KVStore:new()

      kv:marshall_load(stream)

      t3:refute(kv:get("key"))
    end)

    t2:test("can handle serializing a key-value store with various values", function (t3)
      local kv = KVStore:new()

      local stream = StringBuffer:new('', 'w')

      kv:put("boolean_true", true)
      kv:put("boolean_false", false)

      kv:put("n-1", -1)
      kv:put("n1", 1)
      kv:put("n256", 256)

      kv:put("string", "Hello, World")

      kv:put("empty_table", {})
      kv:put("table_array", {1, 2, 3})
      kv:put("table_map", { a = 1, b = 2, c = 3 })

      kv:marshall_dump(stream)

      stream:close()
      stream:open('r')

      -- create a new key value store
      local kv = KVStore:new()

      kv:marshall_load(stream)

      t3:assert_eq(kv:get("boolean_true"), true)
      t3:assert_eq(kv:get("boolean_false"), false)
      t3:assert_eq(kv:get("n-1"), -1)
      t3:assert_eq(kv:get("n1"), 1)
      t3:assert_eq(kv:get("n256"), 256)
      t3:assert_eq(kv:get("string"), "Hello, World")
      t3:assert_deep_eq(kv:get("empty_table"), {})
      t3:assert_deep_eq(kv:get("table_array"), {1, 2, 3})
      t3:assert_deep_eq(kv:get("table_map"), { a = 1, b = 2, c = 3})
    end)
  end)
end

case:execute()
case:display_stats()
case:maybe_error()
