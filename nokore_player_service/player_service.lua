local PlayerService = foundation.com.Class:extends("nokore_player_service.PlayerService")
local ic = PlayerService.instance_class

function ic:initialize()
  self.m_uptime = 0
  self.m_players = {}
end

function ic:on_player_join(player, last_login)
  self.m_players[player:get_player_name()] = player
end

function ic:on_player_leave(player, timed_out)
  self.m_players[player:get_player_name()] = nil
end

function ic:update(dt)
  self.m_uptime = self.m_uptime + dt

  -- update the players every step
  self.m_players = {}
  for _i, player in pairs(minetest.get_connected_players()) do
    self.m_players[player:get_player_name()] = player
  end

  return self
end

function ic:get_player_by_name(player_name)
  return self.m_players[player_name]
end

nokore_player_service.PlayerService = PlayerService
