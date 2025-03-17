# NoKore Player Spawn

Player Spawn Position service.

## Usage

```lua
-- You can register/set a default spawn (by name, if you need multiple default spawns)
--- @spec set_default_spawn(spawn_name, position)
nokore.player_spawn:set_default_spawn("default", vector.new(0, 32, 0))

-- You can recall a default spawn position later
nokore.player_spawn:get_default_spawn("default") -- => vector or nil

-- You can register a player's spawn positions
--- @spec set_player_spawn(player_name, spawn_name, position)
nokore.player_spawn:set_player_spawn(player:get_player_name(), "default", vector.new(0, 32, 0))

-- You can recall a player's spawn position, which may return the default
--- @spec get_player_spawn(player_name, spawn_name): Vector3 | nil
nokore.player_spawn:get_player_spawn(player:get_player_name(), "default")

-- You can check if a spawn position was already registered
--- @spec has_player_spawn(player_name, spawn_name): Boolean
nokore.player_spawn:has_player_spawn(player:get_player_name(), "default") -- => Boolean
```
