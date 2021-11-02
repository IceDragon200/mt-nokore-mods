-- @namespace nokore_player_stats

-- @class PlayerStatsService
local PlayerStatsService = foundation.com.Class:extends("nokore_player_stats.PlayerStatsService")
local ic = PlayerStatsService.instance_class

-- @spec #initialize(): void
function ic:initialize()
  self.m_stats = {}

  self.m_player_stat_cache = {}
end

-- Registers a new stat that can be calculated by the service for a player
-- It is up the stat to provide a calculation function and how those
-- calculations will be performed are up to the implementation.
--
-- @spec #register_stat(name: String, def: Table): void
function ic:register_stat(name, def)
  assert(type(name) == "string", "expected a name of the stat")
  assert(type(def) == "table", "expected a stat definition table")
  assert(type(def.calc) == "function", "expected a stat calc function")

  self.m_stats[name] = def
end

-- Calculates and returns the value for the player stat, this will bypass
-- any cached values and will not cache the result.
--
-- @spec #calc_player_stat(player: Player, name: String): Any
function ic:calc_player_stat(player, name)
  local stat = self.m_stats[name]
  if stat then
    return stat:calc(player)
  end
  return nil
end

-- Either returns a cached calculated stat or calculates and caches the value before returning.
-- the should_recache flag can be provided to force the stat to recalculate and cache.
-- In a sense it can be used to invalidate the cache.
--
-- @spec #get_player_stat(player: Player, name: String, should_recache?: Boolean): Any
function ic:get_player_stat(player, name, should_recache)
  local player_name = player:get_player_name()
  local player_stat_cache = self.m_player_stat_cache[player_name]
  if not player_stat_cache then
    player_stat_cache = {}
    self.m_player_stat_cache[player_name] = player_stat_cache
  end
  local cached = player_stat_cache[name]

  if not should_recache and cached then
    return cached
  end

  cached = self:calc_player_stat(player, name)

  player_stat_cache[name] = cached
  return cached
end

-- Clears any cached stats for the specified player by name
--
-- @spec #clear_player_stats(player_name: String): void
function ic:clear_player_stats(player_name)
  self.m_player_stat_cache[player_name] = {}
end

function ic:on_player_join(player)
  self.m_player_stat_cache[player:get_player_name()] = {}
end

function ic:on_player_leave(player)
  self.m_player_stat_cache[player:get_player_name()] = nil
end

nokore_player_stats.PlayerStatsService = PlayerStatsService
