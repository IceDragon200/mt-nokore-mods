--
-- NoKore - Creative
--
-- Creative
local mod = foundation.new_module("nokore_creative", "0.1.0")

local creative = {
  registered_items = {},
  inventories = {}
}

function creative.get_player_creative_inventory_name(player)
  return "nokore_creative_" .. player:get_player_name()
end

local function create_player_creative_inventory(player)
  creative.inventories[player:get_player_name()] =
    minetest.create_detached_inventory(creative.get_player_creative_inventory_name(player), {
      allow_move = function (inv, from_list, from_index, to_list, to_index, count, player)
        return 0
      end,

      allow_put = function (inv, listname, index, stack, player)
        return 0
      end,

      allow_take = function (inv, listname, index, stack, player)
        return -1
      end,

      on_move = function (inv, from_list, from_index, to_list, to_index, count, player)
        --
      end,

      on_put = function (inv, listname, index, stack, player)
        --
      end,

      on_take = function (inv, listname, index, stack, player)
        --
      end,
    }, player:get_player_name())

  local inv = creative.inventories[player:get_player_name()]
  inv:set_size("main", #creative.registered_items)

  local list = {}
  for index,item_name in ipairs(creative.registered_items) do
    list[index] = ItemStack(item_name)
  end

  inv:set_list("main", list)
end

local function remove_player_creative_inventory(player)
  minetest.remove_detached_inventory(creative.get_player_creative_inventory_name(player))
  creative.inventories[player:get_player_name()] = nil
end

minetest.register_on_joinplayer(create_player_creative_inventory)
minetest.register_on_leaveplayer(remove_player_creative_inventory)
minetest.register_on_mods_loaded(function ()
  local registered_item_names = creative.registered_items
  local i = 0
  for key,def in pairs(minetest.registered_items) do
    local should_include = true
    if def.groups and
       def.groups.not_in_creative_inventory and
       def.groups.not_in_creative_inventory > 0 then
      should_include = false
    end
    if should_include then
      i = i + 1
      registered_item_names[i] = key
    end
  end
  table.sort(registered_item_names)
end)

local function change_page(tab_state, amt)
  if tab_state.page_count > 0 then
    local page = tab_state.page_index - 1
    tab_state.page_index = 1 + ((page + amt) % tab_state.page_count)
    return true
  end
  return false
end

nokore_player_inv.register_player_inventory_tab("creative", {
  description = "Creative",

  on_player_initialize = function (player, _assigns)
    return {
      page_index = 1,
      page_count = 1,
    }
  end,

  render_formspec = function (player, assigns, tab_state)
    local mod = nokore_player_inv

    local page_size = mod.player_hotbar_size * 4
    local inventory_name = creative.get_player_creative_inventory_name(player)
    local inventory_offset = 1 + (tab_state.page_index - 1) * page_size

    local total = creative.inventories[player:get_player_name()]:get_size("main")
    tab_state.page_count = math.floor(total / page_size)

    if (total % page_size) > 0 then
      tab_state.page_count = tab_state.page_count + 1
    end

    return "size["..mod.player_hotbar_size..",9]" ..
           "list[detached:"..inventory_name..";main;0,0;"..mod.player_hotbar_size..",4;"..inventory_offset.."]" ..
           "list[current_player;main;0,5.5;"..mod.player_hotbar_size..","..mod.player_inventory_rows..";]" ..
           "listring[]" ..
           "button["..(mod.player_hotbar_size-4)..",4.5;1,1;creative_prev_page;<]" ..
           "label["..(mod.player_hotbar_size-3)..",4.5;"..minetest.formspec_escape(tab_state.page_index.."/"..tab_state.page_count).."]" ..
           "button["..(mod.player_hotbar_size-1)..",4.5;1,1;creative_next_page;>]"
  end,

  on_player_receive_fields = function (player, assigns, fields, tab_state)
    local should_refresh = false
    if fields.creative_prev_page then
      should_refresh = change_page(tab_state, -1)
    elseif fields.creative_next_page then
      should_refresh = change_page(tab_state, 1)
    end

    return false, should_refresh
  end,
})
