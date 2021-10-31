--
-- NoKore - Player Inventory
--
-- This is the base module for all player inventory related code
-- It also establishes the core API that should be used by all
-- mods for messing with the player inventory (and creative inventory)
--
-- You may recognize this is similar to sfinv, and you'd be kind of right.
local table_key_of = assert(foundation.com.table_key_of)
local fspec = assert(foundation.com.formspec.api)

local mod = foundation.new_module("nokore_player_inv", "0.2.0")

-- Default minetest bar size
mod.player_hotbar_size = 8
-- Default minetest inventory rows
mod.player_inventory_rows = 4

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
  -- size[8,7.5]list[current_player;main;0,3.5;8,4;]list[current_player;craft;3,0;3,3;]listring[]list[current_player;craftpreview;7,1;1,1;]
  --
  local data = mod.get_player_data(player)

  local tab_captions = {}

  for index,tab_name in ipairs(data.tabs_index) do
    local tab = mod.tabs[tab_name]
    table.insert(tab_captions, minetest.formspec_escape(tab.description))
  end
  local tab_captions_str = table.concat(tab_captions, ",")

  local header_config = "formspec_version[2]"
  local header = "tabheader[0,0;player_nav;"..tab_captions_str..";"..data.current_tab_index.."]"
  local tab_name = data.tabs_index[data.current_tab_index]
  local tab = mod.tabs[tab_name]

  local tab_formspec = tab.render_formspec(player, data.assigns, data.tabs[tab_name])
  local formspec = header_config .. tab_formspec .. header
  return formspec
end

-- This is a helper function for creating a formspec snippet exposing the player inventory
function mod.player_inventory_formspec(pos, options)
  return "list[current_player;main;" .. pos.x .. "," .. pos.y .. ";" .. mod.player_hotbar_size .. ","..mod.player_inventory_rows..";]"
end

-- @spec player_inventory_size2(Player): Vector2
function mod.player_inventory_size2(_player)
  return { x = mod.player_hotbar_size, y = mod.player_inventory_rows }
end

-- @spec player_inventory_lists_fragment(PlayerRef, Number, Number): (formspec: String, dimensions: Vector2)
function mod.player_inventory_lists_fragment(player, x, y)
  local dims = mod.player_inventory_size2(player)
  return fspec.list("current_player", "main", x, y, mod.player_hotbar_size, mod.player_inventory_rows), dims
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

minetest.register_on_player_receive_fields(function (player, form_name, fields)
  if form_name ~= "" then
    -- the player's main inventory formspec is represented by an empty form_name
    -- since this isn't that, we'll abandon this callback and let the system
    -- know it can propogate to other callbacks
    return false
  end

  --
  local player_data = mod.get_player_data(player)

  if fields.player_nav then
    local idx = tonumber(fields.player_nav)
    local tab_name = player_data.tabs_index[idx]
    if tab_name then
      mod.activate_tab(player, tab_name)
    end
  else
    local idx = player_data.current_tab_index
    local tab_name = player_data.tabs_index[idx]
    if tab_name and mod.tabs[tab_name] then
      local tab = mod.tabs[tab_name]

      if tab.on_player_receive_fields then
        local break_bubble, should_refresh =
          tab.on_player_receive_fields(player,
                                       player_data.assigns,
                                       fields,
                                       player_data.tabs[tab_name])
        if should_refresh then
          mod.refresh_player_inventory_formspec(player)
        end
        return break_bubble
      end
    end
  end
end)

minetest.register_on_joinplayer(function (player)
  player:hud_set_hotbar_image("gui_hotbar_base.png")
  player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")

  player:get_inventory():set_size("main", mod.player_hotbar_size *
                                          mod.player_inventory_rows)
  player:hud_set_hotbar_itemcount(mod.player_hotbar_size)
  mod.refresh_player_inventory_formspec(player)
end)

nokore_player_inv.register_player_inventory_tab("default", {
  description = "Default",

  on_player_initialize = function (player, _assigns)
    return {}
  end,

  render_formspec = function (player, assigns, tab_state)
    local mod = nokore_player_inv
    local w = 0.25 + mod.player_hotbar_size * 1.25
    return "size["..w..",9]" ..
           mod.player_inventory_formspec({ x = 0.25, y = 6.5 }) ..
           "list[current_player;craft;3,0.25;3,3;]" ..
           "listring[]" ..
           "list[current_player;craftpreview;7,1.25;1,1;]" ..
           "listring[current_player;main]"
  end,
})
