--
-- Nokore Player Hud
--
local mod = foundation.new_module("nokore_player_hud", "0.2.0")

mod:require("player_hud.lua")

-- @namespace nokore
nokore = rawget(_G, "nokore") or {}
-- @const player_hud: nokore_player_hud.PlayerHud
nokore.player_hud = mod.PlayerHud:new()

nokore.player_service:register_on_player_leave("nokore_player_hud:player_left", function (player)
  nokore.player_hud.hud_ids[player:get_player_name()] = nil
end)

nokore.player_service:register_on_player_join("nokore_player_hud:player_joined", function (player)
  --player:hud_set_hotbar_image("gui_hotbar_base.png")
  --player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")

  minetest.hud_replace_builtin("health", {
    hud_elem_type = "statbar",
    position = {
      x = 0.5,
      y = 1,
    },
    text = "heart_full.png",
    text2 = "heart_empty.png",
    number = minetest.PLAYER_MAX_HP_DEFAULT,
    item = minetest.PLAYER_MAX_HP_DEFAULT,
    direction = nokore.player_hud.DIRECTION_LEFT_RIGHT,
    size = {x = 24, y = 24},
    offset = {
      x = (-10 * 24 - 24),
      -- -(hotbar_height + icon_height + bottom_padding + margin)
      y = -(48 + 24 + 16 + 8)
    },
  })

  minetest.hud_replace_builtin("breath", {
    hud_elem_type = "statbar",
    position = {
      x = 0.5,
      y = 1,
    },
    text = "breath_full.png",
    text2 = "breath_empty.png",
    number = minetest.PLAYER_MAX_BREATH_DEFAULT,
    item = minetest.PLAYER_MAX_BREATH_DEFAULT * 2,
    direction = nokore.player_hud.DIRECTION_LEFT_RIGHT,
    size = {x = 24, y = 24},
    offset = {
      x = 24,
      -- -(hotbar_height + icon_height + bottom_padding + margin)
      y = -(48 + 24 + 16 + 8)
    },
  })

  nokore.player_hud:init_player_hud_elements(player)
end)

nokore.player_hud:register_hud_element("armor", {
  hud_elem_type = "statbar",
  position = {
    x = 0.5,
    y = 1,
  },
  text = "armor_full.png",
  text2 = "armor_empty.png",
  number = 20,
  item = 20,
  direction = nokore.player_hud.DIRECTION_LEFT_RIGHT,
  size = {x = 24, y = 24},
  offset = {
    x = (-10 * 24 - 24),
    -- -(hotbar_height + icon_height + bottom_padding + margin + offset)
    y = -(48 + 24 + 16 + 8 + 32)
  },
})
