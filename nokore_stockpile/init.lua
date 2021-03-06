--
-- NoKore - Stockpile
--
-- Stockpiles can contain a stack of 1 item type
-- This is intended to be used with nokore_player_inv10 which removes the players
-- standard inventory
local mod = foundation.new_module("nokore_stockpile", "0.1.0")

mod:require("api.lua")
mod:require("nodes/stockpile.lua")
