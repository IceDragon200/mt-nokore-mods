local table_key_of = assert(foundation.com.table_key_of)
local fspec = assert(foundation.com.formspec.api)

local mod = nokore_player_inv

-- Default minetest bar size
mod.player_hotbar_size = 8

-- player_name::String => table
mod.player_data = {}

-- tab_name::String => table
mod.tabs = {}

-- tab_index => tab_name::String
mod.ordered_tabs_index = {}

function mod.on_player_data_initialize(player, player_data)
  --
end

function mod.get_player_data(player)
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
    }

    mod.on_player_data_initialize(player, mod.player_data[name])
  end
  return mod.player_data[name]
end

function mod.register_player_inventory_tab(tab_name, definition)
  assert(tab_name, "expected a tab name")
  assert(definition, "expected a tab definition")
  mod.tabs[tab_name] = definition

  table.insert(mod.ordered_tabs_index, tab_name)
end

function mod.unregister_player_inventory_tab(tab_name)
  assert(tab_name, "expected a tab name")
  mod.tabs[tab_name] = nil

  local new_index = {}
  local j = 0
  for _index,old_tab_name in ipairs(mod.ordered_tabs_index) do
    if old_tab_name ~= tab_name then
      j = j + 1
      mod.ordered_tabs_index[j] = old_tab_name
    end
  end
  mod.ordered_tabs_index = new_index
end

function mod.refresh_player_tabs(player)
  local data = mod.get_player_data(player)

  data.tabs_index = {}

  for index,tab_name in ipairs(mod.ordered_tabs_index) do
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
      data.tabs_index[index] = tab_name
    end
  end
end

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
    table.insert(tab_captions, minetest.formspec_escape(tab.description))
  end

  local header_config = fspec.formspec_version(4)
  local header = fspec.tabheader(0, 0, nil, nil, "player_nav", tab_captions, data.current_tab_index)
  local tab_name = data.tabs_index[data.current_tab_index]
  local tab = mod.tabs[tab_name]

  local tab_formspec = tab.render_formspec(player, data.assigns, data.tabs[tab_name])
  local formspec = header_config .. tab_formspec .. header
  return formspec
end

-- @spec player_inventory_size2(Player): Vector2
function mod.player_inventory_size2(player)
  local inv = player:get_inventory()
  local rows = math.ceil(inv:get_size("main") / mod.player_hotbar_size)
  return { x = mod.player_hotbar_size, y = rows }
end

-- @spec player_inventory_lists_fragment(PlayerRef, Number, Number):
--         (formspec: String, dimensions: Vector2)
function mod.player_inventory_lists_fragment(player, x, y)
  local dims = mod.player_inventory_size2(player)
  return fspec.list("current_player", "main", x, y, dims.x, dims.y), dims
end

function mod.refresh_player_inventory_formspec(player)
  mod.refresh_player_tabs(player)
  player:set_inventory_formspec(mod.make_player_inventory_formspec(player))
end

function mod.activate_tab(player, tab_name)
  local data = mod.get_player_data(player)
  data.current_tab_index = table_key_of(data.tabs_index, tab_name)

  local tab = mod.tabs[tab_name]

  if tab.on_player_activate then
    tab.on_player_activate(player, data.assigns)
  end

  mod.refresh_player_inventory_formspec(player)
end
