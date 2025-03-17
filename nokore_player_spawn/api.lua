local path_join = assert(foundation.com.path_join)

local mod = assert(nokore_player_spawn)

local DATA_DOMAIN = "nokore_player_spawn"
nokore.player_data_service:register_domain(DATA_DOMAIN, {
  save_method = "marshall"
})

nokore = rawget(_G, "nokore") or {}
nokore.player_spawn = mod.PlayerSpawnService:new{
  data_domain = DATA_DOMAIN,
  kv_filename = path_join(path_join(core.get_worldpath(), "nokore"), "spawn"),
  player_data_service = assert(nokore.player_data_service),
}

nokore.player_service:register_on_player_respawn(
  "nokore_player_spawn:on_player_respawn",
  nokore.player_spawn:method("on_player_respawn")
)
