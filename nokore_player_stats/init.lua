--
-- NoKore Player Stats
--
-- Adds system for managing arbitrary player stats that may or may not be
-- stored or even attached to the player themselves.
-- This also supports caching those values to speed up subsequent queries.
--
local mod = foundation.new_module("nokore_player_stats", "0.1.0")

mod:require("api.lua")

nokore = rawget(_G, "nokore") or {}
nokore.player_stats = nokore_player_stats.PlayerStatsService:new()

nokore.player_service:register_on_player_join(
  "nokore_player_stats:player_joined",
  nokore.player_stats:method("on_player_join")
)
nokore.player_service:register_after_player_join(
  "nokore_player_stats:after_player_joined",
  nokore.player_stats:method("after_player_join")
)
nokore.player_service:register_on_player_leave(
  "nokore_player_stats:player_left",
  nokore.player_stats:method("on_player_leave")
)

mod:require("chat_commands.lua")
