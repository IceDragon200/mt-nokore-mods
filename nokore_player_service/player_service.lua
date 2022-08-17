-- @namespace nokore
local get_connected_players = assert(minetest.get_connected_players)
local get_player_by_name = assert(minetest.get_player_by_name)

-- @class PlayerService
local PlayerService = foundation.com.Class:extends("nokore_player_service.PlayerService")
local ic = PlayerService.instance_class

-- @spec #initialize(): void
function ic:initialize()
  self.m_uptime = 0
  self.m_players = {}
  self.m_player_assigns = {}

  self.m_on_player_join_cbs = {}
  self.m_after_player_join_cbs = {}
  self.m_on_player_leave_cbs = {}

  self.m_update_cbs = {}
end

-- @spec #terminate(): void
function ic:terminate()
end

-- @spec #trigger_on_player_join(Player, last_login: Any): void
function ic:trigger_on_player_join(player, last_login)
  local player_name = player:get_player_name()
  for callback_name, callback in pairs(self.m_on_player_join_cbs) do
    print("player_service", "on_player_join", player_name, "callback", callback_name)
    callback(player, last_login)
  end
end

-- @spec #trigger_after_player_join(Player, last_login: Any): void
function ic:trigger_after_player_join(player, last_login)
  local player_name = player:get_player_name()
  for callback_name, callback in pairs(self.m_after_player_join_cbs) do
    print("player_service", "after_player_join", player_name, "callback", callback_name)
    callback(player, last_login)
  end
end

-- @spec #trigger_on_player_leave(Player, timed_out: Boolean): void
function ic:trigger_on_player_leave(player, timed_out)
  local player_name = player:get_player_name()
  for callback_name, callback in pairs(self.m_on_player_leave_cbs) do
    print("player_service", "on_player_leave", player_name, "callback", callback_name)
    callback(player, timed_out)
  end
end

-- Register a callback to the player service for a newly joined player
--
-- @spec #register_on_player_join(String, Function/2): self
function ic:register_on_player_join(name, callback)
  assert(type(name) == "string", "expected a registration name")
  assert(type(callback) == "function", "expected a callback")

  self.m_on_player_join_cbs[name] = callback

  return self
end

-- Register a callback to the player service for a joined player
-- These are triggered AFTER the on_player_join callbacks are finished
--
-- @spec #register_after_player_join(String, Function/2): self
function ic:register_after_player_join(name, callback)
  assert(type(name) == "string", "expected a registration name")
  assert(type(callback) == "function", "expected a callback")

  self.m_after_player_join_cbs[name] = callback

  return self
end

-- Register a callback t the player service for a player that has left
--
-- @spec #register_on_player_leave(String, Function/2): self
function ic:register_on_player_leave(name, callback)
  assert(type(name) == "string", "expected a registration name")
  assert(type(callback) == "function", "expected a callback")

  self.m_on_player_leave_cbs[name] = callback

  return self
end

-- Register a update callback, this function should take a list of players, delta_time and assigns
--
-- @spec #register_update(name: String, Function/3): self
function ic:register_update(name, callback)
  assert(type(name) == "string", "expected a registration name")
  assert(type(callback) == "function", "expected a callback")

  self.m_update_cbs[name] = callback

  return self
end

-- Callback used for minetest.on_joinplayer/2
--
-- @spec #on_player_join(Player, last_login: Any): self
function ic:on_player_join(player, last_login)
  local name = player:get_player_name()

  print("player_service", "on_player_join", name)

  self.m_players[name] = player
  self.m_player_assigns[name] = {}

  self:trigger_on_player_join(player, last_login)
  self:trigger_after_player_join(player, last_login)

  return self
end

-- Callback used for minetest.on_leaveplayer/2
--
-- @spec #on_player_leave(Player, timed_out: Boolean): self
function ic:on_player_leave(player, timed_out)
  local name = player:get_player_name()

  print("player_service", "on_player_leave", name)

  self.m_players[name] = nil
  self.m_player_assigns[name] = nil

  self:trigger_on_player_leave(player, timed_out)

  return self
end

function ic:update_players_list(dt, trace)
  -- update the players every step
  --self.m_players = {}
  local player_name
  for _i, player in pairs(get_connected_players()) do
    player_name = player:get_player_name()
    self.m_players[player_name] = player
    if not self.m_player_assigns[player_name] then
      self.m_player_assigns[player_name] = {}
    end
  end
end

-- Ticking update
--
-- @spec #update(Float, trace?: Trace): self
function ic:update(dt, trace)
  self.m_uptime = self.m_uptime + dt

  local span

  if trace then
    span = trace:span_start("update players")
  end

  self:update_players_list(dt, span)

  if span then
    span:span_end()
  end

  for callback_name, callback in pairs(self.m_update_cbs) do
    if trace then
      span = trace:span_start(callback_name)
    end
    callback(self.m_players, dt, self.m_player_assigns, span)
    if span then
      span:span_end()
    end
  end

  if trace then
    trace:span_end()
  end

  return self
end

-- Retrieve a player by their name.
-- Returns the player, or nil if they are not in the service
--
-- @spec #get_player_by_name(String): Player | nil
function ic:get_player_by_name(player_name)
  --return self.m_players[player_name]
  return get_player_by_name(player_name)
end

nokore_player_service.PlayerService = PlayerService
