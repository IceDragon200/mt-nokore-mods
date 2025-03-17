local path_join = assert(foundation.com.path_join)
local Vector3 = assert(foundation.com.Vector3)
local KVStore = assert(nokore.KVStore)

local mod = assert(nokore_player_spawn)

mod.PlayerSpawnService = foundation.com.Class:extends("nokore_player_spawn.PlayerSpawnService")
do
  local ic = mod.PlayerSpawnService.instance_class

  --- @spec #initialize(options: Table): void
  function ic:initialize(options)
    ic._super.initialize(self)
    self.m_data_domain = assert(options.data_domain)
    self.m_kv_filename = assert(options.kv_filename)
    self.m_kv = KVStore:new()

    self:_load_kv()
  end

  --- @spec #_load_kv(): void
  function ic:_load_kv()
    self.m_kv:marshall_load_file(m_kv_filename)
  end

  --- @spec #_save_kv(): void
  function ic:_save_kv()
    self.m_kv:marshall_dump_file(m_kv_filename)
  end

  --- @spec #set_default_spawn(name: String, pos: Vector3): void
  function ic:set_default_spawn(name, pos)
    assert(name, "expected a default for position")
    assert(pos, "expected a vector for position")

    local safe_pos = Vector3.copy(pos)
    self.m_kv:upsert_lazy("default_spawns", function (spawns)
      spawns = spawns or {}
      spawns[name] = safe_pos
      return spawns
    end)
    self:_save_kv()
  end

  --- @spec #get_default_spawn(name: String): Vector3
  function ic:get_default_spawn(name)
    local spawns = self.m_kv:get("default_spawns")
    local spawn_pos = spawns[name]
    if spawn_pos then
      return Vector3.copy(spawn_pos)
    else
      return nil
    end
  end

  --- @spec #get_player_domain_kv_by_name(player_name: String): nokore.KVStore
  function ic:get_player_domain_kv_by_name(player_name)
    return self.player_data_service:get_player_domain_kv(player_name, self.m_data_domain)
  end

  --- @spec #set_player_spawn(player_name: String, name: String, pos: Vector3): Boolean
  function ic:set_player_spawn(player_name, name, pos)
    assert(player_name, "expected a player name")
    assert(player_name, "expected a spawn name")
    assert(pos, "expected a position")

    local kv = self:get_player_domain_kv_by_name(player_name)
    if kv then
      kv:upsert_lazy("spawns", function (spawns)
        spawns = spawns or {}
        spawns[name] = Vector3.copy(pos)
        return spawns
      end)
      return true
    end
    return false
  end

  --- @spec #get_player_spawn(player_name: String, name: String): Vector3 | nil
  function ic:get_player_spawn(player_name, name)
    local kv = self:get_player_domain_kv_by_name(player_name)
    if kv then
      local spawns = kv:get("spawns")
      if spawns then
        local pos = spawns[name]
        if pos then
          return Vector3.copy(pos)
        end
      end
    end
    return self:get_default_spawn(name)
  end

  --- @spec #has_player_spawn(player_name: String, name: String): Boolean
  function ic:has_player_spawn(player_name, name)
    local kv = self:get_player_domain_kv_by_name(player_name)
    if kv then
      local spawns = kv:get("spawns")
      if spawns then
        return spawns[name] ~= nil
      end
    end
    return false
  end
end
