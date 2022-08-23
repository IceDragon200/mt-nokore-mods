--
-- NoKore Player Data
--
-- Data service built upon player service.
-- This offers a facility for getting a kvstore on a per-player and domain/namespace basis to
-- store additional data on a player.
--
-- Mods that need their own domain/namespace must register it with this mod's service.
local mod = foundation.new_module("nokore_player_data", "1.1.0")

nokore = rawget(_G, "nokore") or {}

mod:require("player_data_service.lua")

nokore.player_data_service = nokore.PlayerDataService:new()

nokore.player_service:register_on_player_join(
  "nokore_player_data:player_joined",
  nokore.player_data_service:method("on_player_join")
)
nokore.player_service:register_on_player_leave(
  "nokore_player_data:player_left",
  nokore.player_data_service:method("on_player_leave")
)
nokore_proxy.register_globalstep(
  "nokore_player_data.update/1",
  nokore.player_data_service:method("update")
)
minetest.register_on_shutdown(nokore.player_data_service:method("terminate"))
