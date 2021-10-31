-- @namespace nokore

-- @class PlayerService
local PlayerService = foundation.com.Class:extends("nokore_player_service.PlayerService")
local ic = PlayerService.instance_class

-- @spec #initialize(): void
function ic:initialize()
  self.m_uptime = 0
  self.m_players = {}
  self.m_player_assigns = {}

  self.m_on_player_join_cbs = {}
  self.m_on_player_leave_cbs = {}

  self.m_update_cbs = {}
end

-- @spec #terminate(): void
function ic:terminate()
end

-- @spec #trigger_on_player_join(Player, last_login: Any): void
function ic:trigger_on_player_join(player, last_login)
  for _key, callback in pairs(self.m_on_player_join_cbs) do
    callback(player, last_login)
  end
end

-- @spec #trigger_on_player_leave(Player, timed_out: Boolean): void
function ic:trigger_on_player_leave(player, timed_out)
  for _key, callback in pairs(self.m_on_player_leave_cbs) do
    callback(player, timed_out)
  end
end

-- Register a callback to the player service for a newly joined player
--
-- @spec #register_on_player_join(String, Function/2): self
function ic:register_on_player_join(name, callback)
  self.m_on_player_join_cbs[name] = callback

  return self
end

-- Register a callback t the player service for a player that has left
--
-- @spec #register_on_player_leave(String, Function/2): self
function ic:register_on_player_leave(name, callback)
  self.m_on_player_leave_cbs[name] = callback

  return self
end

-- Register a update callback, this function should take the player, delta_time and assigns
--
-- @spec register_update(String, Function/3): self
function ic:register_update(name, callback)
  self.m_update_cbs[name] = callback

  return self
end

-- Callback used for minetest.on_joinplayer/2
--
-- @spec #on_player_join(Player, last_login: Any): self
function ic:on_player_join(player, last_login)
  local name = player:get_player_name()

  self.m_players[name] = player
  self.m_player_assigns[name] = {}

  self:trigger_on_player_join(player, last_login)

  return self
end

-- Callback used for minetest.on_leaveplayer/2
--
-- @spec #on_player_leave(Player, timed_out: Boolean): self
function ic:on_player_leave(player, timed_out)
  local name = player:get_player_name()

  self.m_players[name] = nil
  self.m_player_assigns[name] = nil

  self:trigger_on_player_leave(player, timed_out)

  return self
end

-- Ticking update
--
-- @spec #update(Float): self
function ic:update(dt)
  self.m_uptime = self.m_uptime + dt

  -- update the players every step
  self.m_players = {}
  for _i, player in pairs(minetest.get_connected_players()) do
    self.m_players[player:get_player_name()] = player
  end

  for _callback_name, callback in pairs(self.m_update_cbs) do
    callback(self.m_players, dt, self.m_player_assigns)
  end

  return self
end

-- Retrieve a player by their name.
-- Returns the player, or nil if they are not in the service
--
-- @spec #get_player_by_name(String): Player | nil
function ic:get_player_by_name(player_name)
  return self.m_players[player_name]
end

nokore_player_service.PlayerService = PlayerService
