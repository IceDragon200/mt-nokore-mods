--
-- NoKore - Player Inventory (10)
--
-- Resizes the player inventory and sets a standard 10 element inventory
local mod = nokore.new_module("nokore_player_inv10", "0.1.0")

nokore.player_hotbar_size = 10

-- Stock Formspec as of 2020-07-16
-- Below is a copy of the default minetest player inventory formspec:
-- size[8,7.5]list[current_player;main;0,3.5;8,4;]list[current_player;craft;3,0;3,3;]listring[]list[current_player;craftpreview;7,1;1,1;]

nokore_player_inv10.player_inventory_formspec =
  "size["..nokore.player_hotbar_size..",9]" ..
  "list[current_player;main;0,3.5;"..nokore.player_hotbar_size..",1;]" ..
  "list[current_player;craft;3,0;3,3;]" ..
  "listring[]" ..
  "list[current_player;craftpreview;7,1;1,1;]"

minetest.register_on_joinplayer(function (player)
  -- Player inventories are limited to 10, that is, they don't have an inventory, just a hotbar
  player:get_inventory():set_size("main", nokore.player_hotbar_size)
  player:hud_set_hotbar_itemcount(nokore.player_hotbar_size)
  print(player:get_inventory_formspec())

  player:set_inventory_formspec(nokore_player_inv10.player_inventory_formspec)
end)
