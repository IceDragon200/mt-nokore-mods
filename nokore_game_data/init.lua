--
-- NoKore - Game Data
--
-- Handful of utility classes and modules for dealing with data persistence
local mod = foundation.new_module("nokore_game_data", "0.5.0")

mod:require("key_value_store.lua")
mod:require("key_value_store/persist_ascii_pack.lua")
-- minetest's json implementation casts empty tables as null and doesn't restore them
--mod:require("key_value_store/persist_json.lua")
mod:require("key_value_store/persist_marshall.lua")
mod:require("key_value_store/persist_serialize.lua")

nokore = rawget(_G, "nokore") or {}
nokore.KVStore = nokore_game_data.KVStore

mod:require("tests.lua")
