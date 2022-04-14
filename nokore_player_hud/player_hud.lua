-- @namespace nokore_player_hud
local table_deep_copy = assert(foundation.com.table_deep_copy)

-- @class PlayerHud
local PlayerHud = foundation.com.Class:extends("nokore_player_hud.PlayerHud")
local ic = PlayerHud.instance_class

-- @type OnInitPlayerHudElementCallback: function(
--   Player,
--   hud_element_name: String,
--   hud_def: Table
-- ) => Table

-- @type PlayerHudIds: { [player_name: String]: { [hud_item_name: String]: ID} }

-- @type RegisteredElements: { [name: String]: HudDef }

-- @type OnInitPlayerHudElementCallbacks: {
--   [hud_element_name: String]: {
--     [callback_name: OnInitPlayerHudElementCallback]
--   }
-- }

-- @spec #initialize(): void
function ic:initialize()
  -- @member DIRECTION_LEFT_RIGHT: Integer = 0
  self.DIRECTION_LEFT_RIGHT = 0
  -- @member DIRECTION_RIGHT_LEFT: Integer = 1
  self.DIRECTION_RIGHT_LEFT = 1
  -- @member DIRECTION_TOP_BOTTOM: Integer = 2
  self.DIRECTION_TOP_BOTTOM = 2
  -- @member DIRECTION_BOTTOM_TOP: Integer = 3
  self.DIRECTION_BOTTOM_TOP = 3

  -- @member m_player_hud_ids: PlayerHudIds
  self.m_player_hud_ids = {}

  -- @member m_registered_elements: RegisteredElements
  self.m_registered_elements = {}

  -- @member m_on_init_player_hud_element_cbs: OnInitPlayerHudElementCallbacks
  self.m_on_init_player_hud_element_cbs = {}
end

-- Registers a general hud element
--
-- @spec #register_hud_element(String, Table): void
function ic:register_hud_element(name, def)
  assert(not self.m_registered_elements[name], "element already registered")

  self.m_registered_elements[name] = def
end

-- Register a callback for when a player's hud element is to be initialized.
-- Note that the target hud_element must be specified as well, or "_" to monitor all hud elements.
--
-- @spec #register_on_init_player_hud_element(
--         callback_name: String,
--         hud_element_name: String,
--         callback: cb_on_init_player_hud_element
--       ): void
function ic:register_on_init_player_hud_element(
          callback_name,
          hud_element_name,
          callback
        )
  if not self.m_on_init_player_hud_element_cbs[hud_element_name] then
    self.m_on_init_player_hud_element_cbs[hud_element_name] = {}
  end
  self.m_on_init_player_hud_element_cbs[hud_element_name][hud_element_name] = callback

  return self
end

-- Executes the on_init_player_hud_element/3 callbacks, if any callback returns
-- nil for the hud def it will not add that element to the player's hud.
-- Callbacks are expected to either pass-through the hud definition as is
-- or modify it as needed and return a new table (or modify it in place and return it)
--
-- @spec #maybe_init_player_hud_element(PlayerRef, hud_element_name: String, hud_def: Table):
--         Table | nil
function ic:maybe_init_player_hud_element(player, name, hud_def)
  -- _ is the wildcard callback
  if self.m_on_init_player_hud_element_cbs._ then
    for _callback_name, callback in pairs(self.m_on_init_player_hud_element_cbs._) do
      hud_def = callback(player, name, hud_def)
      if not hud_def then
        break
      end
    end
  end

  if self.m_on_init_player_hud_element_cbs[name] then
    for _callback_name, callback in pairs(self.m_on_init_player_hud_element_cbs[name]) do
      hud_def = callback(player, name, hud_def)
      if not hud_def then
        break
      end
    end
  end

  return hud_def
end

-- Called when a player newly joins the server and their hud elements need to be
-- initialized.
-- Callbacks registered via #register_on_init_player_hud_element/3, will be
-- triggered with a copy of the hud definition, if any callback returns nil
-- the hud element will not be added.
--
-- @spec #init_player_hud_elements(PlayerRef): void
function ic:init_player_hud_elements(player)
  local hud_element_id
  local player_name

  player_name = player:get_player_name()
  if not self.m_player_hud_ids[player_name] then
    self.m_player_hud_ids[player_name] = {}
  end
  local player_hud_ids = self.m_player_hud_ids[player_name]
  local hud_def

  for name,def in pairs(self.m_registered_elements) do
    hud_def = table_deep_copy(def)
    hud_def = self:maybe_init_player_hud_element(player, name, hud_def)

    if hud_def then
      -- make a deep copy of the hud def, so players always get their own
      -- copy of it, safe to modify
      hud_element_id = player:hud_add(hud_def)

      player_hud_ids[name] = hud_element_id
    end
  end
end

-- Removes the hud elements for the specified user
--
-- @spec #remove_player_hud_elements(PlayerRef): void
function ic:remove_player_hud_elements(player)
  local player_name = player:get_player_name()

  if self.m_player_hud_ids[player_name] then
    self.m_player_hud_ids[player_name] = nil
  end
end

-- @spec #change_player_hud_element(
--         PlayerRef, hud_element_name: String, prop: String, value: Any
--       ): Boolean
function ic:change_player_hud_element(player, hud_element_name, prop, value)
  local hud_element_id = self.m_player_hud_ids[hud_element_name]

  if hud_element_id then
    player:hud_change(hud_element_id, prop, value)
    return true
  end
  return false
end

-- May or may not insert a new hud element for player by name.
-- If properties are given, they will be applied to the existing or newly created
-- hud element using PlayerRef#hud_change/3
--
-- @spec #upsert_player_hud_element(PlayerRef, hud_element_name: String, props?: Table): void
function ic:upsert_player_hud_element(player, hud_element_name, props)
  local hud_element_id = self.m_player_hud_ids[hud_element_name]

  if not hud_element_id then
    local hud_def = table_deep_copy(def)
    hud_element_id = player:hud_add(hud_def)
    self.m_player_hud_ids[hud_element_name] = hud_element_id
  end

  if props then
    for prop, value in pairs(props) do
      player:hud_change(hud_element_id, prop, value)
    end
  end
end

-- Removes a player hud element by name
-- Returns true if any element was removed, returns false otherwise.
--
-- @spec #remove_player_hud_element(PlayerRef, hud_element_name: String): Boolean
function ic:remove_player_hud_element(player, hud_element_name)
  local hud_element_id = self.m_player_hud_ids[hud_element_name]

  if hud_element_id then
    player:hud_remove(hud_element_id)
    self.m_player_hud_ids[hud_element_name] = nil
    return true
  end
  return false
end

nokore_player_hud.PlayerHud = PlayerHud
