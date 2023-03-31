--
-- NoKore - Player Inventory
--
-- This is the base module for all player inventory related code
-- It also establishes the core API that should be used by all
-- mods for messing with the player inventory (and creative inventory)
--
-- You may recognize this is similar to sfinv, and you'd be kind of right.
local mod = foundation.new_module("nokore_player_inv", "0.3.0")

local fspec = assert(foundation.com.formspec.api)

mod:require("api.lua")

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

local function on_player_join(player)
  player:hud_set_hotbar_image("gui_hotbar_base.png")
  player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")

  player:hud_set_hotbar_itemcount(mod.player_hotbar_size)
end

local function register_after_player_join(player)
  mod.refresh_player_inventory_formspec(player)
end

if foundation.is_module_present("nokore_player_service") then
  nokore.player_service:register_on_player_join("nokore_player_inv:on_player_join", on_player_join)
  nokore.player_service:register_after_player_join("nokore_player_inv:after_player_join", register_after_player_join)
else
  minetest.register_on_joinplayer(on_player_join)
end

nokore_player_inv.register_player_inventory_tab("default", {
  description = "Default",

  on_player_initialize = function (player, _assigns)
    return {}
  end,

  render_formspec = function (player, assigns, tab_state)
    local npi_mod = nokore_player_inv
    local dims = npi_mod.player_inventory_size2(player)
    local w = 0.25 + dims.x * 1.25
    local h = 0.5 + (4 + dims.y) * 1.25
    local cio = fspec.calc_inventory_offset

    return fspec.size(w, h) ..
           npi_mod.player_inventory_lists_fragment(player, 0.25, 0.25 + cio(4)) ..
           fspec.list("current_player", "craft", 3, 0.25, 3, 3) ..
           fspec.list_ring() ..
           fspec.list("current_player", "craftpreview", 7, 1.25, 1, 1) ..
           fspec.list_ring("current_player", "main")
  end,
})
