--
-- Nokore Player Hud
--
local mod = foundation.new_module("nokore_player_hud", "0.2.0")

mod:require("player_hud.lua")

--- @namespace nokore
nokore = rawget(_G, "nokore") or {}
--- @const player_hud: nokore_player_hud.PlayerHud
nokore.player_hud = mod.PlayerHud:new()

nokore.player_service:register_on_player_leave("nokore_player_hud:player_left", function (player)
  nokore.player_hud:remove_player_hud_elements(player)
end)

nokore.player_service:register_on_player_join("nokore_player_hud:player_joined", function (player)
  --player:hud_set_hotbar_image("gui_hotbar_base.png")
  --player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
  nokore.player_hud:init_player_hud_elements(player)
end)
