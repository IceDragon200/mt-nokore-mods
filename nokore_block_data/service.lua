local BlockDataService = foundation.com.Class:extends("nokore_block_data.BlockDataService")
local ic = BlockDataService.instance_class

local KVStore = nokore.KVStore

local Trace = assert(foundation.com.Trace)

local hash_node_position = minetest.hash_node_position

function ic:initialize()
  self.monotonic_time = 0
  self.expires_duration = 120 -- every 2 minutes
  self.persist_interval = 60 -- every minute
  self.blocks = {} -- block_id => BlockDetails
  self.expired_blocks = {} -- block_id => true
  self.range = 2

  self.nokore_dir = minetest.get_worldpath() .. "/nokore"
  self.block_data_dir = self.nokore_dir .. "/block_data"

  minetest.mkdir(self.block_data_dir)

  if KVStore.instance_class.marshall_dump then
    self.persistance_type = 'MRSH'
    minetest.log("info", "block data will be persisted using marshall")
  elseif KVStore.instance_class.apack_dump then
    self.persistance_type = 'ASCI'
    minetest.log("info", "block data will be persisted using ascii_pack")
  else
    self.persistance_type = 'NONE'
    minetest.log("warning", "block data cannot be persisted, neither ascii pack nor marshall_dump is available")
  end
end

function ic:terminate()
  local trace = Trace:new('nokore_block_data/terminate')
  local span
  for block_id, block in pairs(self.blocks) do
    span = trace:span_start('blocks/'..block_id)
    self:persist_block(block, span)
    span:span_end()
  end
  trace:span_end()
  trace:inspect()
  self.blocks = {}
end

function ic:get_block(block_id)
  return self.blocks[block_id]
end

function ic:reduce_blocks(acc, callback)
  local should_break
  for block_id, block in pairs(self.blocks) do
    acc, should_break = callback(block_id, block, acc)
    if should_break then
      break
    end
  end
  return acc
end

function ic:update(delta, trace)
  self.monotonic_time = self.monotonic_time + delta

  local expires_at = self.monotonic_time + self.expires_duration

  local pos, block_id
  local block_pos = { x = 0, y = 0, z = 0 }
  local nx, ny, nz
  local players = minetest.get_connected_players()
  for _, player in pairs(players) do
    pos = player:get_pos()

    -- neutral x, y, z
    nx = math.floor(pos.x / 16)
    ny = math.floor(pos.y / 16)
    nz = math.floor(pos.z / 16)

    for y = -self.range,self.range do
      for z = -self.range,self.range do
        for x = -self.range,self.range do
          block_pos.x = nx + x
          block_pos.y = ny + y
          block_pos.z = nz + z
          self:upsert_or_refresh_block(block_pos)
        end
      end
    end
  end

  for block_id, block in pairs(self.blocks) do
    if block.next_persist_at < self.monotonic_time then
      self:persist_block(block)
    end

    if block.expires_at < self.monotonic_time then
      self.expired_blocks[block_id] = true
    end
  end

  local expired = false
  local block
  local span
  for block_id,_ in pairs(self.expired_blocks) do
    expired = true
    block = self.blocks[block_id]
    self.blocks[block_id] = nil
    if trace then
      span = trace:span_start("expired_block:" .. block_id)
    end
    self:persist_block(block, span)
    if span then
      span:span_end()
    end
  end

  if expired then
    self.expired_blocks = {}
  end
end

function ic:upsert_or_refresh_block(block_pos)
  local id = hash_node_position(block_pos)

  if self.blocks[id] then
    local block = self.blocks[id]
    block.expires_at = self.monotonic_time + self.expires_duration
    return block
  else
    minetest.log("info", "initializing block data block_id=" .. id)
    local basename = "("..block_pos.x..","..block_pos.y..","..block_pos.z..")"

    local kv = KVStore:new()

    local filename

    if self.persistance_type == 'MRSH' then
      filename = self.block_data_dir .. "/" .. basename .. ".mrsh"
      kv:marshall_load_file(filename)
    elseif self.persistance_type == 'ASCI' then
      filename = self.block_data_dir .. "/" .. basename .. ".asci"
      kv:apack_load_file(filename)
    end

    local block = {
      id = id,
      pos = vector.new(block_pos), -- copy the position
      basename = basename,
      filename = filename,
      kv = kv,
      persisted_at = self.monotonic_time,
      next_persist_at = self.monotonic_time + self.persist_interval,
      expires_at = self.monotonic_time + self.expires_duration,
    }

    self.blocks[id] = block
    return block
  end
end

function ic:persist_block(block, trace)
  if block.kv.dirty then
    block.kv.dirty = false
    if self.persistance_type == 'MRSH' then
      block.kv:marshall_dump_file(block.filename, trace)
    elseif self.persistance_type == 'ASCI' then
      block.kv:apack_dump_file(block.filename, trace)
    elseif self.persistance_type == 'NONE' then
      -- can't persist
    end
  end
  block.persisted_at = self.monotonic_time
  block.next_persist_at = block.persisted_at + self.persist_interval
end

nokore.BlockDataService = BlockDataService
