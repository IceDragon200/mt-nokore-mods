-- @namespace nokore_player_stats

local ic

--
-- @private.class Stat
local Stat = foundation.com.Class:extends("nokore_player_stats.Stat")
ic = Stat.instance_class

-- @spec #initialize(Table): void
function ic:initialize(def)
  self.calc = assert(def.calc)
  self.cached = def.cached or false
  self.set = def.set

  -- Modifiers are optional to implement for a stat, if they are
  -- they are normally applied in the order, base, add and then mul:
  --   base - the 'base' value of the stat that every other modifier will apply to (can be replaced)
  --   add - any additional additions to be made to the base (modifiers should only add/sub)
  --   multiplier - any multipliers that should be applied to the value at the end of calculations
  self.m_modifiers = {}
end

-- @spec #apply_modifiers(Player, value: T): T
function ic:apply_modifiers(player, value)
  local result = self:apply_modifier(player, "base", value)
  result = self:apply_modifier(player, "add", result)
  return self:apply_modifier(player, "mul", result)
end

-- @spec #apply_modifier(Player, type: String, value: T): T
function ic:apply_modifier(player, modtype, value)
  assert(player, "expected a player")
  assert(type(modtype) == "string", "expected a modifier type")

  local modifiers = self.m_modifiers[modtype]

  if modifiers then
    for _name, callback in pairs(modifiers) do
      value = callback(player, value)
    end
  end

  return value
end

-- @spec #register_modifier(name: String, modtype: "base" | "add" | "mul", Function/2): self
function ic:register_modifier(name, modtype, callback)
  assert(type(name) == "string", "expected a name for the modifier callback")
  assert(modtype == "add" or
         modtype == "mul" or
         modtype == "base", "expected a modifier type to be either add, mul or base")
  assert(type(callback) == "function", "expected a function")

  self.m_modifiers[modtype] = self.m_modifiers[modtype] or {}
  self.m_modifiers[modtype][name] = callback
  return self
end

-- @class PlayerStatsService
local PlayerStatsService = foundation.com.Class:extends("nokore_player_stats.PlayerStatsService")
ic = PlayerStatsService.instance_class

-- The definition table that should be used for register_stat.
-- calc/1 is the main function that will be called when a stat needs be recalculated.
-- cached is a flag that will tell the stats service whether or not the specific
-- stat should ever be cached, if true it will calculate once and then cache it.
--
-- @type StatDefinition: {
--   calc: function(self, player: Player) => Any,
--   cached?: Boolean,
-- }

-- @spec #initialize(): void
function ic:initialize()
  self.registered_stats = {}

  self.m_player_stat_cache = {}
end

-- Registers a new stat that can be calculated by the service for a player
-- It is up the stat to provide a calculation function and how those
-- calculations will be performed are up to the implementation.
--
-- @spec #register_stat(name: String, def: StatDefinition): Stat
function ic:register_stat(name, def)
  assert(type(name) == "string", "expected a name of the stat")
  assert(type(def) == "table", "expected a stat definition table")

  self.registered_stats[name] = Stat:new(def)

  return self.registered_stats[name]
end

-- @spec #register_stat_modifier(name: String, "base" | "add" | "mul", Function/2): Stat
function ic:register_stat_modifier(name, callback_name, modtype, callback)
  assert(type(name) == "string", "expected a name of the stat to register modifier under")

  local stat = self.registered_stats[name]

  if stat then
    return stat:register_modifier(callback_name, modtype, callback)
  else
    error("stat `" .. name .. "` does not exist")
  end
end

-- Calculates and returns the value for the player stat, this will bypass
-- any cached values and will not cache the result.
--
-- @spec #calc_player_stat(player: Player, name: String): Any
function ic:calc_player_stat(player, name)
  local stat = self.registered_stats[name]
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
  local stat = self.registered_stats[name]
  if stat then
    if stat.cached then
      local player_name = player:get_player_name()
      local player_stat_cache = self.m_player_stat_cache[player_name]
      if not player_stat_cache then
        player_stat_cache = {}
        self.m_player_stat_cache[player_name] = player_stat_cache
      end
      local cached = player_stat_cache[name]

      if not should_recache and cached ~= nil then
        return cached
      end

      cached = self:calc_player_stat(player, name)

      player_stat_cache[name] = cached
      return cached
    else
      return self:calc_player_stat(player, name)
    end
  end

  return nil
end

-- @spec #set_player_stat(player: Player, name: String, value: Any): Boolean
function ic:set_player_stat(player, name, value)
  local stat = self.registered_stats[name]
  if stat then
    return stat:set(player, value)
  end
  return false
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
