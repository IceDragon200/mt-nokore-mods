# Nokore Block Data

Nokore Block Data provides a single service module (nokore.block_data_service), which provides a simple key value store on map blocks, this data can be persisted to disk.

## Typespec

```lua
Block = {
  id = String,
  pos = Vector3,
  basename = String,
  filename = String,
  --- Persisted key-value store
  kv = nokore.KVStore,
  --- Unpersisted temp table
  assigns = Table,
  persisted_at = Integer,
  next_persist_at = Integer,
  expires_at = Integer,
}
```

## Usage

```lua
-- nokore.block_data_service:get_block(block_id)
local block_id = minetest.hash_node_position(pos)
local block = nokore.block_data_service:get_block(block_id)
if block then
  -- do stuff with the block
else
  -- block is not loaded
end

-- nokore.block_data_service:reduce_blocks(acc, reducer)
nokore.block_data_service:reduce_blocks(0, function (block_id, block, acc)
  block.kv:put("key", "value")
  return acc + 1, false
end)
```
