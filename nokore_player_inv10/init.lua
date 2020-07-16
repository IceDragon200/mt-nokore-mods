--
-- NoKore - Player Inventory (10)
--
-- Resizes the player inventory and sets a standard 10 element inventory
local mod = nokore.new_module("nokore_player_inv10", "0.1.0")

nokore.player_hotbar_size = 10

minetest.register_on_joinplayer(function (player)
  -- Player inventories are limited to 10, that is, they don't have an inventory, just a hotbar
  player:get_inventory():set_size("main", nokore.player_hotbar_size)
end)
