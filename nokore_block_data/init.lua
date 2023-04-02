--
-- Nokore Block Data
--
-- A service mod that watches players on the map and determines which blocks are loaded
-- all while providing a metadata table via game data's KeyValueStore
--
local mod = foundation.new_module("nokore_block_data", "1.3.0")

mod:require("service.lua")

nokore = rawget(_G, "nokore") or {}
nokore.BlockDataService = assert(nokore_block_data.BlockDataService)
nokore.block_data_service = nokore.BlockDataService:new()

if foundation.is_module_present("nokore_player_service") then
  nokore.player_service:register_on_player_leave(
    "nokore_block_data:on_player_leave",
    nokore.block_data_service:method("on_player_leave")
  )
else
  minetest.register_on_leaveplayer(nokore.block_data_service:method("on_player_leave"))
end

nokore_proxy.register_globalstep(
  "nokore_block_data.update/1",
  nokore.block_data_service:method("update")
)
minetest.register_on_shutdown(nokore.block_data_service:method("terminate"))
