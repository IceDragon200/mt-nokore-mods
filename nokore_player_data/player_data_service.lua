--
--
--
-- @namespace nokore
local KVStore = assert(nokore.KVStore)
local path_join = assert(foundation.com.path_join)

-- @class PlayerDataService
local PlayerDataService = foundation.com.Class:extends("nokore.PlayerDataService")
local ic = PlayerDataService.instance_class

local function fs_safe_name(path)
  -- TODO: ensure that the specified value is safe to use in a filesystem
  return path
end

-- @spec #initialize(): void
function ic:initialize()
  self.m_registered_domains = {}

  -- @type m_player_domains: {
  --   [player_name: String]: {
  --     [domain: String]: nokore.KVStore
  --   }
  -- }
  self.m_player_domains = {}

  -- @type self.m_dirname: String
  self.m_dirname = path_join(path_join(minetest.get_worldpath(), "nokore"), "players")

  self.m_elapsed = 0

  self.m_elapsed_since_save = 0
end

-- @spec #terminate(): void
function ic:terminate()
  print("player_data_service", "terminating")
  self:save()
  print("player_data_service", "terminated")
end

-- @spec #update_players(Table, Float, Table): void
function ic:update_players(players, _dt, _assigns)
  for player_name, player in pairs(players) do
    if not self.m_player_domains[player_name] then
      -- initialize any players that haven't been added yet
      self:on_player_join(player)
    end
  end
end

-- @spec #update(Float): void
function ic:update(dt)
  self.m_elapsed = self.m_elapsed + dt
  self.m_elapsed_since_save = self.m_elapsed_since_save + dt

  -- has a minute elapsed since last global save?
  if self.m_elapsed_since_save > 60 then
    self.m_elapsed_since_save = 0
    self:save()
  end
end

-- @spec #register_domain(domain_name: String, def: Table): void
function ic:register_domain(domain_name, def)
  assert(type(domain_name) == "string", "expected a domain name")
  assert(type(def) == "table", "expected a domain definition table")

  assert(def.save_method, "require a save method for key-value store")

  if def.save_method ~= "apack" and
     def.save_method ~= "marshall" then
    error("expected domain save_method to be either apack or marshall")
  end

  self.m_registered_domains[domain_name] = def
end

-- @spec #on_player_join(Player): void
function ic:on_player_join(player)
  local player_name = player:get_player_name()
  local domains = {}
  local domain
  local filename

  for domain_name, domain_def in pairs(self.m_player_domains) do
    filename = path_join(path_join(self.m_dirname, fs_safe_name(player_name)), domain_name)

    domain = {
      filename = filename,
      -- persistent data
      kv = KVStore:new(),
      -- volatile data
      assigns = {},
    }

    if domain_def.save_method == "apack" then
      domain.kv:apack_load_file(domain.filename)
    elseif domain_def.save_method == "marshall" then
      domain.kv:marshall_load_file(domain.filename)
    --elseif domain_def.save_method == "json" then
    --  domain.kv:json_load_file(domain.filename)
    end

    domains[domain_name] = domain
  end

  self.m_player_domains[player_name] = domains
end

-- @spec #persist_domain(domain_name: String, domain: Table): void
function ic:persist_domain(domain_name, domain)
  local domain_def = self.m_registered_domains[domain_name]

  if domain_def.save_method == "apack" then
    domain.kv:apack_dump_file(domain.filename)
  elseif domain_def.save_method == "marshall" then
    domain.kv:marshall_dump_file(domain.filename)
  --elseif domain_def.save_method == "json" then
  --  domain.kv:json_dump_file(domain.filename)
  end
end

-- @spec #persist_player_domains(player_name: String): void
function ic:persist_player_domains(player_name)
  local domains = self.m_player_domains[player_name]

  if domains then
    for domain_name, domain in pairs(domains) do
      self:persist_domain(domain_name, domain)
    end
  end
end

-- @spec #on_player_leave(Player): void
function ic:on_player_leave(player)
  local domains = self.m_player_domains[player_name]
  local domain_def
  self.m_player_domains[player_name] = nil
  if domains then
    for domain_name, domain in pairs(domains) do
      self:persist_domain(domain_name, domain)
    end
  end
end

-- @spec #save(): void
function ic:save()
  print("player_data_service", "save")
  for player_name, domains in pairs(self.m_player_domains) do
    for domain_name, domain in pairs(domains) do
      self:persist_domain(domain_name, domain)
    end
  end
  print("player_data_service", "saved")
end

-- Retrieves a player's key-value store by domain.
-- Any changes to the kv-store will not be noticed by the service.
-- If immediate persistence is needed, call #persist_domain/2
--
-- @spec #get_player_domain_kv(player_name: String, domain_name: String)
function ic:get_player_domain_kv(player_name, domain_name)
  local domains = self.m_registered_domains[player_name]

  if domains then
    local domain = domains[domain_name]

    if domain then
      return domain.kv
    end
  end

  return nil
end

-- Retrieves the player's key-value store by domain, and then passes
-- it to the callback provided, users can then modify the kv store as needed.
-- If the callback returns true, then the kv store is persisted immediately
-- otherwise it will be persisted whenever the service runs its persistence
-- loop.
function ic:with_player_domain_kv(player_name, domain_name, callback)
  local domains = self.m_registered_domains[player_name]

  if domains then
    local domain = domains[domain_name]

    if domain then
      local save_after = false

      if callback(domain.kv) then
        save_after = true
      end

      if save_after then
        persist_domain(domain_name, domain)
      end
    end
  end
end

nokore.PlayerDataService = PlayerDataService
