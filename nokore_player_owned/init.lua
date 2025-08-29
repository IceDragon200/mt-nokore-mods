--
-- Provides a unified interface for handling ownership of nodes, items and entities.
--
local mod = foundation.new_module("nokore_player_owned", "1.0.0")

--- @namespace nokore_player_owned

--- @const OWNER_TYPE_KEY: String
mod.OWNER_TYPE_KEY = "owner_type"

--- @const OWNER_KEY: String
mod.OWNER_KEY = "owner"

--- @spec clear_meta_owner(meta: MetaRef): void
function mod.clear_meta_owner(meta)
  meta:set_string(mod.OWNER_TYPE_KEY, "")
  meta:set_string(mod.OWNER_KEY, "")
end

--- @spec set_meta_owner_by_name(meta: MetaRef, player_name: String): void
function mod.set_meta_owner_by_name(meta, player_name)
  meta:set_string(mod.OWNER_TYPE_KEY, "player")
  meta:set_string(mod.OWNER_KEY, player_name)
end

--- @spec set_meta_owner_by_name(meta: MetaRef, owner: PlayerRef): void
function mod.set_meta_owner(meta, owner)
  mod.set_meta_owner_by_name(meta, owner:get_player_name())
end

--- @spec get_meta_owner(meta: MetaRef): (owner_name: String, owner_type: String)
function mod.get_meta_owner(meta)
  return meta:get_string(mod.OWNER_KEY), meta:get_string("owner_type")
end
