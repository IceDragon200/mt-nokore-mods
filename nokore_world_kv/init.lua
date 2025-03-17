--[[

  NoKore World Key-Value Store

  Like a globally available (and persisted) key-value store.

  Use responsibly.

]]
local mod = foundation.new_module("nokore_world_kv", "0.1.0")

local path_join = assert(foundation.com.path_join)

local filename = path_join(path_join(core.get_worldpath(), "nokore"), "world_kv")
local elapsed = 0.0

nokore.world_kv = nokore.KVStore:new()
do
  nokore.world_kv:marshall_load_file(filename)
end

nokore_proxy.register_globalstep(
  "nokore_world_kv:update/2",
  function (delta, trace)
    elapsed = elapsed + delta
    if nokore.world_kv.dirty then
      nokore.world_kv:marshall_dump_file(filename, trace)
      nokore.world_kv.dirty = false
    end
  end
)
