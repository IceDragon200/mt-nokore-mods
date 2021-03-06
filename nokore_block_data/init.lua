--
-- Nokore Block Data
--
-- A service mod that watches players on the map and determines which blocks are loaded
-- all while providing a metadata table via game data's KeyValueStore
--
local mod = foundation.new_module("nokore_block_data", "1.0.0")

mod:require("service.lua")

nokore = rawget(_G, "nokore") or {}
nokore.block_data_service = nokore.BlockDataService:new()

minetest.register_globalstep(nokore.block_data_service:method("update"))
minetest.register_on_shutdown(nokore.block_data_service:method("terminate"))
