# Nokore Player Data

Data storage for players.

## Usage

To get started register a domain (acts like a namespace) for your data.

```lua
nokore.player_data_service:register_domain("my_domain_name", {
  -- Choose a persistence method:
  -- * `apack` using foundation_ascii_pack
  -- * `marshall` using foundation_binary's MarshallValue
  -- * `json` using minetest's built-in json functions (disabled, due to empty table bug)
  -- * `serialize` using minetest's serialize|deserialize functions
  -- * `none` to not load or save data
  -- Note that save_method will not add an extension name
  save_method = "apack",

  -- optional filename override, otherwise the domain's name is used instead (without an extension)
  filename = "my_domain_name.apack",
})
```

Then you can access a player's specific domain storage using:

```lua
-- This returns a nokore.KVStore from nokore_game_data
local player_name = "singleplayer"
local domain_name = "my_domain_name"

local kv = nokore.player_data_service:get_player_domain_kv(player_name, domain_name)
kv:put("key", "value")
assert(kv:get("key") == "value")
kv:delete("key")
assert(kv:get("key") == nil)

-- Note that modifying the key-value store won't immediately persist changes, you must either
-- wait for the next persistence check, or manually persist it
nokore.player_data_service:persist_player_domains(player_name)

-- or persist a specific domain for a specific player
nokore.player_data_service:persist_player_domain(player_name, domain_name)

-- Generally it's best to leave the persistence to the service.
-- If there is a case where a domain needs to be modified and then persisted immediately after:
nokore.player_data_service:with_player_domain_kv(player_name, domain_name, function (kv)
  kv:put("key", "value")
  -- the boolean returned here tells the service whether or not to persist on the domain immediately
  return true
end)
```
