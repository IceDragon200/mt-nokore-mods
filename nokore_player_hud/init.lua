--
-- Nokore Player Hud
--
local mod = foundation.new_module("nokore_player_hud", "0.2.0")

local table_deep_copy = assert(foundation.com.table_deep_copy)

-- @namespace nokore_player_hud

-- @callback cb_on_init_player_hud_element(Player, hud_element_name: String, hud_def: Table): Table

nokore.player_hud = {
  DIRECTION_LEFT_RIGHT = 0,
  DIRECTION_RIGHT_LEFT = 1,
  DIRECTION_TOP_BOTTOM = 2,
  DIRECTION_BOTTOM_TOP = 3,

  -- @type { [player_name: String]: { [hud_item_name: String]: ID} }
  m_player_hud_ids = {},

  -- @type { [name: String]: HudDef }
  m_registered_elements = {},

  -- @type { [hud_element_name: String]: { [callback_name: Function/3] } }
  m_on_init_player_hud_element_cbs = {},
}

-- Registers a general hud element
function nokore.player_hud:register_hud_element(name, def)
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
--       )
function nokore.player_hud:register_on_init_player_hud_element(
          callback_name,
          hud_element_name,
          callback
        )
  if not self.m_on_init_player_hud_element_cbs[hud_element_name] then
    self.m_on_init_player_hud_element_cbs[hud_element_name] = {}
  end
  self.m_on_init_player_hud_element_cbs[hud_element_name][name] = callback

  return self
end

-- Executes the on_init_player_hud_element/3 callbacks, if any callback returns
-- nil for the hud def it will not add that element to the player's hud.
-- Callbacks are expected to either pass-through the hud definition as is
-- or modify it as needed and return a new table (or modify it in place and return it)
--
-- @spec #maybe_init_player_hud_element(PlayerRef, hud_element_name: String, hud_def: Table):
--         Table | nil
function nokore.player_hud:maybe_init_player_hud_element(player, name, hud_def)
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
function nokore.player_hud:init_player_hud_elements(player)
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
    hud_def = nokore.player_hud:maybe_init_player_hud_element(player, name, hud_def)

    if hud_def then
      -- make a deep copy of the hud def, so players always get their own
      -- copy of it, safe to modify
      hud_element_id = player:hud_add(hud_def)

      player_hud_ids[name] = hud_element_id
    end
  end
end

-- @spec #change_player_hud_element(
--         PlayerRef, hud_element_name: String, prop: String, value: Any
--       ): Boolean
function nokore.player_hud:change_player_hud_element(player, hud_element_name, prop, value)
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
function nokore.player_hud:upsert_player_hud_element(player, hud_element_name, props)
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
-- @spec #remove_player_hud_eleemnt(PlayerRef, hud_element_name: String): Boolean
function nokore.player_hud:remove_player_hud_eleemnt(player, hud_element_name)
  local hud_element_id = self.m_player_hud_ids[hud_element_name]

  if hud_element_id then
    player:hud_remove(hud_element_id)
    self.m_player_hud_ids[hud_element_name] = nil
    return true
  end
  return false
end

nokore.player_service:register_on_player_leave(function (player)
  nokore.player_hud.hud_ids[player:get_player_name()] = nil
end)

nokore.player_service:register_on_player_join(function (player)
  --player:hud_set_hotbar_image("gui_hotbar_base.png")
  --player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")

  minetest.hud_replace_builtin("health", {
    hud_elem_type = "statbar",
    position = {
      x = 0.5,
      y = 1,
    },
    text = "heart_full.png",
    text2 = "heart_empty.png",
    number = minetest.PLAYER_MAX_HP_DEFAULT,
    item = minetest.PLAYER_MAX_HP_DEFAULT,
    direction = nokore.player_hud.DIRECTION_LEFT_RIGHT,
    size = {x = 24, y = 24},
    offset = {
      x = (-10 * 24 - 24),
      -- -(hotbar_height + icon_height + bottom_padding + margin)
      y = -(48 + 24 + 16 + 8)
    },
  })

  minetest.hud_replace_builtin("breath", {
    hud_elem_type = "statbar",
    position = {
      x = 0.5,
      y = 1,
    },
    text = "breath_full.png",
    text2 = "breath_empty.png",
    number = minetest.PLAYER_MAX_BREATH_DEFAULT,
    item = minetest.PLAYER_MAX_BREATH_DEFAULT * 2,
    direction = nokore.player_hud.DIRECTION_LEFT_RIGHT,
    size = {x = 24, y = 24},
    offset = {
      x = 24,
      -- -(hotbar_height + icon_height + bottom_padding + margin)
      y = -(48 + 24 + 16 + 8)
    },
  })

  nokore.player_hud:init_player_hud_elements(player)
end)

nokore.player_hud:register_hud_element("armor", {
  hud_elem_type = "statbar",
  position = {
    x = 0.5,
    y = 1,
  },
  text = "armor_full.png",
  text2 = "armor_empty.png",
  number = 20,
  item = 20,
  direction = nokore.player_hud.DIRECTION_LEFT_RIGHT,
  size = {x = 24, y = 24},
  offset = {
    x = (-10 * 24 - 24),
    -- -(hotbar_height + icon_height + bottom_padding + margin + offset)
    y = -(48 + 24 + 16 + 8 + 32)
  },
})
