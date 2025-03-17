local path_join = assert(foundation.com.path_join)

local mod = assert(nokore_player_spawn)

local DATA_DOMAIN = "nokore_player_spawn"
nokore.player_data_service:register_domain(DATA_DOMAIN, {
  save_method = "marshall"
})

nokore = rawget(_G, "nokore") or {}
nokore.player_spawn = mod.PlayerSpawnService:new{
  data_domain = DATA_DOMAIN,
  kv_filename = path_join(path_join(core.get_worldpath(), "nokore"), "spawn")
}
