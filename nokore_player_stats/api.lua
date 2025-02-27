--- @namespace nokore_player_stats

--- Modtypes:
---   * "base"
---   * "add"
---   * "mul"
--- @type ModType: String

---
--- @class Stat
local Stat = foundation.com.Class:extends("nokore.player_stats.Stat")
do
  local ic = Stat.instance_class

  --- @spec #initialize(Table): void
  function ic:initialize(def)
    --- @member calc: Function/2
    self.calc = assert(def.calc)

    --- @member cached: Boolean = false
    self.cached = def.cached or false

    --- @member set: Function/3
    self.set = def.set

    --- Modifiers are optional to implement for a stat, if they are
    --- they are normally applied in the order: "base", "add" and then "mul":
    ---   base - the 'base' value of the stat that every other modifier will apply to (can be replaced)
    ---   add - any additional additions to be made to the base (modifiers should only add/sub)
    ---   mul - any multipliers that should be applied to the value at the end of calculations
    --- @member m_modifiers: {
    ---   base: { [name: String]: Function/2 },
    ---   add: { [name: String]: Function/2 },
    ---   mul: { [name: String]: Function/2 },
    --- }
    self.m_modifiers = {
      base = {},
      add = {},
      mul = {},
    }
  end

  --- @spec #apply_modifiers(Player, value: T): T
  function ic:apply_modifiers(player, value)
    local result = self:apply_modifier(player, "base", value)
    result = self:apply_modifier(player, "add", result)
    return self:apply_modifier(player, "mul", result)
  end

  --- @spec #apply_modifier(Player, type: String, value: T): T
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

  ---
  --- @spec #register_modifier(name: String, ModType, Function/2): self
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
end

--- @class PlayerStatsService
local PlayerStatsService = foundation.com.Class:extends("nokore.player_stats.PlayerStatsService")
do
  local ic = PlayerStatsService.instance_class

  --- The definition table that should be used for register_stat.
  --- calc/1 is the main function that will be called when a stat needs be recalculated.
  --- cached is a flag that will tell the stats service whether or not the specific
  --- stat should ever be cached, if true it will calculate once and then cache it.
  ---
  --- @type StatDefinition: {
  ---   calc: function(self, player: Player) => Any,
  ---   set: function(self, player: Player, value: Any): Boolean,
  ---   cached?: Boolean,
  --- }

  --- @spec #initialize(): void
  function ic:initialize()
    --- @member registered_stats: { [name: String]: Stat }
    self.registered_stats = {}

    self.m_player_stat_cache = {}
  end

  --- Registers a new stat that can be calculated by the service for a player
  --- It is up the stat to provide a calculation function and how those
  --- calculations will be performed are up to the implementation.
  ---
  --- @spec #register_stat(name: String, def: StatDefinition): Stat
  function ic:register_stat(name, def)
    assert(type(name) == "string", "expected a name of the stat")
    assert(type(def) == "table", "expected a stat definition table")

    self.registered_stats[name] = Stat:new(def)

    return self.registered_stats[name]
  end

  --- Modifiers are a way to augment an existing stat such as supporting other sources for stat
  --- changes.
  --- Take for example registering a modifier that will apply stat changes based on the player's
  --- equipment.
  ---
  --- @spec #register_stat_modifier(name: String, callback_name: String, ModType, Function/2): Stat
  function ic:register_stat_modifier(name, callback_name, modtype, callback)
    assert(type(name) == "string", "expected a name of the stat to register modifier under")

    local stat = self.registered_stats[name]

    if stat then
      return stat:register_modifier(callback_name, modtype, callback)
    else
      error("stat `" .. name .. "` does not exist")
    end
  end

  --- Calculates and returns the value for the player stat, this will bypass
  --- any cached values and will not cache the result.
  ---
  --- @spec #calc_player_stat(player: Player, name: String): Any
  function ic:calc_player_stat(player, name)
    local stat = self.registered_stats[name]
    if stat then
      return stat:calc(player)
    end
    return nil
  end

  --- Either returns a cached calculated stat or calculates and caches the value before returning.
  --- The `should_recache` flag can be provided to force the stat to recalculate and then cache.
  --- In a sense it can be used to invalidate the cache.
  ---
  --- @spec #get_player_stat(player: Player, name: String, should_recache?: Boolean): Any
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

  --- Retries a table of all stats for specified player.
  ---
  --- @spec #get_player_stats(PlayerRef): Table
  function ic:get_player_stats(player)
    local result = {}
    for name, _stat in pairs(self.registered_stats) do
      result[name] = self:get_player_stat(player, name)
    end
    return result
  end

  --- Attempts to set the value of the player's stat.
  --- If the stat supports being set, then the set/3 function is called,
  --- depending on the stat, this function may return true or false.
  --- false will always be returned if the stat does not support being set.
  ---
  --- @spec #set_player_stat(player: Player, name: String, value: Any): Boolean
  function ic:set_player_stat(player, name, value)
    local stat = self.registered_stats[name]
    if stat and stat.set then
      return stat:set(player, value)
    end
    return false
  end

  --- Clears a specific stat by its name
  ---
  --- @spec #clear_player_stat(player_name: String, name: String): void
  function ic:clear_player_stat(player_name, name)
    local cache = self.m_player_stat_cache[player_name]
    if cache then
      cache[name] = nil
    end
  end

  --- Clears any cached stats for the specified player by name
  ---
  --- @spec #clear_player_stats(player_name: String): void
  function ic:clear_player_stats(player_name)
    if self.m_player_stat_cache[player_name] then
      self.m_player_stat_cache[player_name] = {}
    end
  end

  --- Player Service Callback, handles creating the player's stat cache (initial setup)
  ---
  --- @spec #on_player_join(player: PlayerRef): void
  function ic:on_player_join(player)
    self.m_player_stat_cache[player:get_player_name()] = {}
  end

  --- Player Service Callback, handles actually initializing the player's stats
  ---
  --- @spec #after_player_join(player: PlayerRef): void
  function ic:after_player_join(player)
    for stat_name, _ in pairs(self.registered_stats) do
      self:get_player_stat(player, stat_name, true)
    end
  end

  --- Player Service Callback, clears the player's stat cache
  ---
  --- @spec #on_player_leave(player: PlayerRef): void
  function ic:on_player_leave(player)
    self.m_player_stat_cache[player:get_player_name()] = nil
  end
end

nokore_player_stats.PlayerStatsService = PlayerStatsService
