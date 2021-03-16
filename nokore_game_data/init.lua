--
-- NoKore - Game Data
--
-- Handful of utility classes and modules for dealing with data persistence
local mod = foundation.new_module("nokore_game_data", "0.1.0")

mod:require("key_value_store.lua")

nokore = rawget(_G, "nokore") or {}
nokore.KVStore = nokore_game_data.KVStore

mod:require("tests.lua")
