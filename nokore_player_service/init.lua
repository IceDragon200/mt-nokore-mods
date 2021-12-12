--
-- NoKore Player Service
--
-- Instead of every mod implementing their own connected player management
-- and loop, this module takes care of all of that for them and provides
-- a handy interface and data service.
--
local mod = foundation.new_module("nokore_player_service", "1.0.0")

mod:require("player_service.lua")

-- @namespace nokore
nokore = rawget(_G, "nokore") or {}

-- @alias PlayerService = nokore_player_service.PlayerService
nokore.PlayerService = mod.PlayerService
-- @const player_service: PlayerService
nokore.player_service = mod.PlayerService:new()

minetest.register_on_joinplayer(nokore.player_service:method("on_player_join"))
minetest.register_on_leaveplayer(nokore.player_service:method("on_player_leave"))
nokore_proxy.register_globalstep("nokore_player_service.update/2", nokore.player_service:method("update"))
minetest.register_on_shutdown(nokore.player_service:method("terminate"))
