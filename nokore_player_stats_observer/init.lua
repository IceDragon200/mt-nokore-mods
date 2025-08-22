--[[

  NoKore Player Stats Observer

  Mostly inefficient, but one of the only unified ways to check if a player stat changes.

]]
--- @namespace nokore_player_stats_observer
local mod = foundation.new_module("nokore_player_stats_observer", "1.0.0")

local assertions = assert(foundation.com.assertions)

local player_stats = assert(nokore.player_stats)
local player_stat_cache = {}

--- Only stats specified in register_on_stat_changed are observed normally
--- @const registered_observer_stats: {
---   [stat_name: String]: Boolean
--- }
mod.registered_observer_stats = {}

--- These are all of the callbacks, by name that
--- @const registered_observers: {
---   [stat_name: String]: {
---     [callback_name: String]: Function/4
---   }
--- }
mod.registered_observers = {}

--- Register a on_stat_changed callback given the name of the callback, the stat to observe
--- and a callback function.
--- This will raise an error if a callback with `name` is already registered.
---
--- Usage:
---
---    nokore_player_stats_observer.register_on_stat_changed("my_stat_observer", "hp", function (player, stat_name, old_value, new_value)
---      --- do something when hp changes
---    end)
---
--- @spec register_on_stat_changed(name: String, stat_name: String, callback: Function/4): void
function mod.register_on_stat_changed(name, stat_name, callback)
  assertions.is_string(name)
  assertions.is_string(stat_name)
  assertions.is_function(callback)

  if mod.registered_observers[name] then
    error("callback already registered name="..name)
  end
  mod.registered_observer_stats[stat_name] = true
  if not mod.registered_observers[stat_name] then
    mod.registered_observers[stat_name] = {}
  end
  mod.registered_observers[stat_name][name] = callback
end

--- @spec trigger_on_stat_changed(player: PlayerRef, stat_name: String, old_value: Any, new_value: Any): void
function mod.trigger_on_stat_changed(player, stat_name, old_value, new_value)
  local observers = mod.registered_observers[stat_name]
  if observers then
    for _,callback in pairs(observers) do
      callback(player, stat_name, old_value, new_value)
    end
  end
end

--- @spec update_players(PlayerRef[], dtime: Float, player_assigns: Table, trace: Trace): void
function mod.update_players(players, dtime, player_assigns, trace)
  local player_name
  local cache
  local old_value
  local new_value
  for _, player in pairs(players) do
    player_name = player:get_player_name()

    if player_name then
      cache = player_stat_cache[player_name]

      for stat_name, _ in pairs(mod.registered_observer_stats) do
        old_value = cache[stat_name]
        new_value = player_stats:get_player_stat(player, stat_name)
        if old_value ~= new_value then
          cache[stat_name] = new_value
          mod.trigger_on_stat_changed(player, stat_name, old_value, new_value)
        end
      end
    end
  end
end

--- @spec on_player_join(PlayerRef): void
function mod.on_player_join(player)
  local player_name = player:get_player_name()
  if not player_stat_cache[player_name] then
    player_stat_cache[player_name] = {}
  end
end

--- @spec on_player_leave(PlayerRef): void
function mod.on_player_leave(player)
  local player_name = player:get_player_name()
  if player_stat_cache[player_name] then
    player_stat_cache[player_name] = nil
  end
end

nokore.player_service:register_on_player_join(mod:make_name("on_player_join/1"), mod.on_player_join)
nokore.player_service:register_on_player_leave(mod:make_name("on_player_leave/1"), mod.on_player_leave)
nokore.player_service:register_update(mod:make_name("update_players/4"), mod.update_players)
