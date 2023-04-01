--- @namespace nokore_block_data
local RingBuffer = assert(foundation.com.RingBuffer)

local KVStore = assert(nokore.KVStore)

local Trace = foundation.com.Trace

local hash_node_position = assert(minetest.hash_node_position)
local get_connected_players = assert(minetest.get_connected_players)

--- @class BlockDataService
local BlockDataService = foundation.com.Class:extends("nokore_block_data.BlockDataService")
do
  local ic = BlockDataService.instance_class

  --- @spec #initialize(): void
  function ic:initialize()
    --- @member monotonic_time: Float
    self.monotonic_time = 0
    --- @member elapsed_since_last_update: Float
    self.elapsed_since_last_update = 0
    --- @member expires_duration: Float
    self.expires_duration = 120 -- every 2 minutes
    --- @member persist_interval: Float
    self.persist_interval = 60 -- every minute
    --- @member blocks: { [block_id: String]: Block }
    self.blocks = {}
    --- @member expired_blocks: { [block_id]: Boolean }
    self.expired_blocks = {}
    --- @member next_expire_block: RingBuffer
    self.next_expire_block = RingBuffer:new()
    --- @member next_persist_block: RingBuffer
    self.next_persist_block = RingBuffer:new()
    --- @member player_block_pos_cache: { [player_name: String]: Any }
    self.player_block_pos_cache = {}
    --- @member range: Integer
    self.range = 2
    --- @member nokore_dir: String
    self.nokore_dir = minetest.get_worldpath() .. "/nokore"
    --- @member block_data_dir: String
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
      minetest.log(
        "warning",
        "block data cannot be persisted, neither ascii pack nor marshall_dump is available"
      )
    end
  end

  --- @spec #terminate(): void
  function ic:terminate()
    local trace
    local span
    if Trace then
      trace = Trace:new('nokore_block_data/terminate')
    end

    for block_id, block in pairs(self.blocks) do
      if trace then
        span = trace:span_start('blocks/'..block_id)
      end
      self:persist_block(block, span)
      if span then
        span:span_end()
      end
    end
    if trace then
      trace:span_end()
      -- trace:inspect()
    end
    self.blocks = {}
  end

  --- @spec #get_block(block_id: Integer): Block | nil
  function ic:get_block(block_id)
    return self.blocks[block_id]
  end

  --- @spec #reduce_blocks(acc: Any, callback: Function/3): Any
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

  --- @spec #on_player_leave(player: PlayerRef, timed_out: Boolean): void
  function ic:on_player_leave(player, timed_out)
    self.player_block_pos_cache[player:get_player_name()] = nil
  end

  --- @spec #update(dtime: Number, trace: Trace): void
  function ic:update(dtime, trace)
    self.monotonic_time = self.monotonic_time + dtime
    self.elapsed_since_last_update = self.elapsed_since_last_update + dtime

    if self.elapsed_since_last_update < 1 then
      return
    end
    self.elapsed_since_last_update = 0

    local pos
    local block_pos = { x = 0, y = 0, z = 0 }
    local nx, ny, nz
    local players = get_connected_players()
    local player_name
    local refresh_blocks
    local cached
    local item
    local block

    if next(players) then
      for _, player in pairs(players) do
        player_name = player:get_player_name()
        pos = player:get_pos()

        -- neutral x, y, z
        nx = math.floor(pos.x / 16)
        ny = math.floor(pos.y / 16)
        nz = math.floor(pos.z / 16)

        cached = self.player_block_pos_cache[player_name]
        if cached then
          if cached.pos.x ~= nx or cached.pos.y ~= ny or cached.pos.z ~= nz then
            refresh_blocks = true
            cached.pos = {
              x = nx,
              y = ny,
              z = nz,
            }
          end
        else
          refresh_blocks = true
          cached = {
            pos = {
              x = nx,
              y = ny,
              z = nz,
            }
          }

          self.player_block_pos_cache[player_name] = cached
        end

        if not cached.expires_at or cached.expires_at < self.monotonic_time then
          -- the cache is stale, force refresh it
          cached.expires_at = nil
          refresh_blocks = true
        end

        if refresh_blocks then
          for y = -self.range,self.range do
            for z = -self.range,self.range do
              for x = -self.range,self.range do
                block_pos.x = nx + x
                block_pos.y = ny + y
                block_pos.z = nz + z
                block = self:upsert_or_refresh_block(block_pos)

                -- try setting the caches expiration based on the block's expiration
                -- this will force the player caches to refresh the blocks after some time
                if cached.expires_at then
                  if block.expires_at < cached.expires_at then
                    cached.expires_at = block.expires_at
                  end
                else
                  cached.expires_at = block.expires_at
                end
              end
            end
          end
        end
      end
    end

    while not self.next_expire_block:is_empty() do
      item = self.next_expire_block:peek()
      if item.expires_at < self.monotonic_time then
        self.next_expire_block:pop()
        block = self.blocks[item.id]

        if block then
          if block.expires_at < self.monotonic_time then
            self.expired_blocks[item.id] = true
          else
            self.next_expire_block:push({
              id = item.id,
              expires_at = block.expires_at,
            })
          end
        end
      else
        break
      end
    end

    while not self.next_persist_block:is_empty() do
      item = self.next_persist_block:peek()
      if item.next_persist_at < self.monotonic_time then
        self.next_persist_block:pop()
        block = self.blocks[item.id]
        if block then
          if block.next_persist_at < self.monotonic_time then
            self:persist_block(block)
          end
        end
      else
        break
      end
    end

    if next(self.expired_blocks) then
      local expired = false
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
  end

  --- @spec #upsert_or_refresh_block(block_pos: Vector3): Block
  function ic:upsert_or_refresh_block(block_pos)
    local id = hash_node_position(block_pos)

    local block = self.blocks[id]
    if not block then
      -- minetest.log("debug", "initializing block data block_id=" .. id)
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

      block = {
        id = id,
        pos = vector.new(block_pos), -- copy the position
        basename = basename,
        filename = filename,
        kv = kv,
        assigns = {},
        persisted_at = self.monotonic_time,
        next_persist_at = self.monotonic_time + self.persist_interval,
        expires_at = self.monotonic_time + self.expires_duration,
      }

      self.blocks[id] = block
      self.next_persist_block:push({
        id = id,
        next_persist_at = block.next_persist_at,
      })
    end

    block.expires_at = self.monotonic_time + self.expires_duration
    self.next_expire_block:push({
      id = id,
      expires_at = block.expires_at,
    })

    return block
  end

  --- @spec #persist_block(Block, Trace): void
  function ic:persist_block(block, trace)
    local kv = block.kv
    if kv.dirty then
      kv.dirty = false
      if self.persistance_type == 'MRSH' then
        kv:marshall_dump_file(block.filename, trace)
      elseif self.persistance_type == 'ASCI' then
        kv:apack_dump_file(block.filename, trace)
      end
    end
    block.persisted_at = self.monotonic_time
    block.next_persist_at = block.persisted_at + self.persist_interval
    self.next_persist_block:push({
      id = block.id,
      next_persist_at = block.next_persist_at,
    })
  end
end

nokore_block_data.BlockDataService = BlockDataService
