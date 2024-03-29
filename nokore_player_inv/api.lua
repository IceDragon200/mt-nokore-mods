local table_key_of = assert(foundation.com.table_key_of)
local table_merge = assert(foundation.com.table_merge)
local fspec = assert(foundation.com.formspec.api)

--- @namespace nokore_player_inv
local mod = assert(nokore_player_inv)

-- Default minetest bar size
--- @const player_hotbar_size: Integer
mod.player_hotbar_size = mod.player_hotbar_size or 8

--- @const player_data: { [player_name: String]: Table }
mod.player_data = {}

--- @const tabs: { [tab_name: String]: Table }
mod.tabs = {}

--- @const ordered_tabs_index: { [tab_index: Integer]: (tab_name: String) }
mod.ordered_tabs_index = {}

--- @spec update(dt, trace?: Trace)
function mod.update(dt, trace)
  local span
  if trace then
    span = trace:span_start("nokore_player_inv.update/2")
  end

  local player
  for player_name, data in pairs(mod.player_data) do
    if data.refresh_on_next_tick then
      player = nokore.player_service:get_player_by_name(player_name)
      if player then
        mod.refresh_player_inventory_formspec(player)
      end
      data.refresh_on_next_tick = false
    end
  end

  if span then
    span:span_end()
  end
end

--- @spec on_player_data_initialize(PlayerRef, player_data: Table): void
function mod.on_player_data_initialize(player, player_data)
  --
end

--- @spec get_player_data(PlayerRef): Table
function mod.get_player_data(player)
  assert(player, "expected a player")
  local name = player:get_player_name()
  if not mod.player_data[name] then
    mod.player_data[name] = {
      -- this affects the player's inventory carry over data
      -- such as current tab and other attributes
      assigns = {},
      --
      current_tab_index = 1,
      -- contains tab specific data
      tabs = {},
      -- index::Integer => tab_name::String
      tabs_index = {},
      --
      refresh_on_next_tick = false,
    }

    mod.on_player_data_initialize(player, mod.player_data[name])
  end

  return mod.player_data[name]
end

--- @spec register_player_inventory_tab(tab_name: String, definition: Tab): void
function mod.register_player_inventory_tab(tab_name, definition)
  assert(type(tab_name) == "string", "expected a tab name")
  assert(type(definition) == "table", "expected a tab definition")
  mod.tabs[tab_name] = definition

  mod.ordered_tabs_index[#mod.ordered_tabs_index + 1] = tab_name
end

--- @spec update_player_inventory_tab(tab_name: String, new_definition: Tab): void
function mod.update_player_inventory_tab(tab_name, new_definition)
  assert(type(tab_name) == "string", "expected a tab name")
  assert(type(new_definition) == "table", "expected a tab definition")
  if not mod.tabs[tab_name] then
    error("expected tab to already exist tab=" .. tab_name)
  end

  mod.tabs[tab_name] = table_merge(mod.tabs[tab_name], new_definition)
end

--- @spec unregister_player_inventory_tab(tab_name: String): void
function mod.unregister_player_inventory_tab(tab_name)
  assert(tab_name, "expected a tab name")
  mod.tabs[tab_name] = nil

  local new_index = {}
  local j = 0
  for _index,old_tab_name in ipairs(mod.ordered_tabs_index) do
    if old_tab_name ~= tab_name then
      j = j + 1
      new_index[j] = old_tab_name
    end
  end
  mod.ordered_tabs_index = new_index
end

--- @spec refresh_player_tabs(PlayerRef): void
function mod.refresh_player_tabs(player)
  assert(player, "expected a player")
  local data = mod.get_player_data(player)

  data.tabs_index = {}

  local j = 0

  for _index,tab_name in ipairs(mod.ordered_tabs_index) do
    local tab = mod.tabs[tab_name]
    local is_enabled = true

    if tab.on_player_initialize then
      if not data.tabs[tab_name] then
        data.tabs[tab_name] = tab.on_player_initialize(player, data.assigns)
      end
    end

    if tab.check_player_enabled then
      is_enabled = tab.check_player_enabled(player, data.assigns, data.tabs[tab_name])
    end

    if is_enabled then
      j = j + 1
      data.tabs_index[j] = tab_name
    end
  end
end

--- @spec make_player_inventory_formspec(PlayerRef): String
function mod.make_player_inventory_formspec(player)
  --
  -- Stock Formspec as of 2020-07-16
  -- Below is a copy of the default minetest player inventory formspec:
  --   size[8,7.5]
  --   list[current_player;main;0,3.5;8,4;]
  --   list[current_player;craft;3,0;3,3;]
  --   listring[]
  --   list[current_player;craftpreview;7,1;1,1;]
  --
  local data = mod.get_player_data(player)

  local tab_captions = {}

  for index,tab_name in ipairs(data.tabs_index) do
    local tab = mod.tabs[tab_name]
    tab_captions[#tab_captions + 1] = minetest.formspec_escape(tab.description)
  end

  local header_config = fspec.formspec_version(6)
  local header = fspec.tabheader(0, 0, nil, nil, "player_nav", tab_captions, data.current_tab_index)
  local tab_name = data.tabs_index[data.current_tab_index]
  local tab = mod.tabs[tab_name]

  local tab_formspec = tab.render_formspec(player, data.assigns, data.tabs[tab_name])
  local formspec = header_config .. tab_formspec .. header

  return formspec
end

--- @spec player_inventory_size2(Player): Vector2
function mod.player_inventory_size2(player)
  assert(player, "expected a player")
  local inv = player:get_inventory()
  local rows = math.ceil(inv:get_size("main") / mod.player_hotbar_size)
  return { x = mod.player_hotbar_size, y = rows }
end

--- @spec player_inventory_lists_fragment(
---   PlayerRef,
---   x: Number,
---   y: Number
--- ): (formspec: String, dimensions: Vector2)
function mod.player_inventory_lists_fragment(player, x, y)
  local dims = mod.player_inventory_size2(player)
  return fspec.list("current_player", "main", x, y, dims.x, dims.y), dims
end

--- @spec refresh_player_inventory_formspec(PlayerRef): void
function mod.refresh_player_inventory_formspec(player)
  assert(player, "expected player")
  mod.refresh_player_tabs(player)
  local formspec = mod.make_player_inventory_formspec(player)
  player:set_inventory_formspec(formspec)
end

--- @spec activate_tab(PlayerRef, tab_name: String): void
function mod.activate_tab(player, tab_name)
  assert(player, "expected a player")
  assert(type(tab_name) == "string", "expected a tab name")
  local data = mod.get_player_data(player)
  data.current_tab_index = table_key_of(data.tabs_index, tab_name)

  local tab = mod.tabs[tab_name]

  if tab.on_player_activate then
    tab.on_player_activate(player, data.assigns)
  end

  mod.refresh_player_inventory_formspec(player)
end

--- @spec send_tab_event(PlayerRef, tab_name: String, event: Any): void
function mod.send_tab_event(player, tab_name, event)
  assert(player, "expected a player")
  assert(type(tab_name) == "string", "expected a tab name")

  local data = mod.get_player_data(player)

  local tab = mod.tabs[tab_name]

  local idx = data.current_tab_index
  local focused_tab_name = data.tabs_index[idx]

  if tab.on_event then
    local should_refresh = tab.on_event(player, data.assigns, event, data.tabs[tab_name])

    if should_refresh and tab_name == focused_tab_name then
      data.refresh_on_next_tick = true
    end
  end
end
