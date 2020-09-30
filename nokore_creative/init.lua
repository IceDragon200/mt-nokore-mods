--
-- NoKore - Creative
--
-- Creative
local mod = foundation.new_module("nokore_creative", "0.1.0")

local creative = {
  trash_inventory = nil,
  normalized_terms = {},
  registered_items = {},
  inventories = {},
}

function creative.get_player_creative_inventory_name(player)
  return "nokore_creative_player_" .. player:get_player_name()
end

local function filter_player_creative_inventory(player, filter)
  local inv = creative.inventories[player:get_player_name()]

  local list = {}
  local normalized_filter = filter:lower()
  local i = 0
  for index,item_name in ipairs(creative.registered_items) do
    local item = minetest.registered_items[item_name]
    local term = creative.normalized_terms[item_name]
    if filter == "" or
       (term.name:find(normalized_filter, 1, true) or
        term.description:find(normalized_filter, 1, true)) then
      local stack = ItemStack(item_name)
      stack:set_count(stack:get_stack_max())
      i = i + 1
      list[i] = stack
    end
  end

  inv:set_size("main", #list)
  inv:set_list("main", list)
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

  filter_player_creative_inventory(player, "")
end

local function remove_player_creative_inventory(player)
  minetest.remove_detached_inventory(creative.get_player_creative_inventory_name(player))
  creative.inventories[player:get_player_name()] = nil
end

minetest.register_on_joinplayer(create_player_creative_inventory)
minetest.register_on_leaveplayer(remove_player_creative_inventory)
minetest.register_on_mods_loaded(function ()
  creative.trash_inventory = minetest.create_detached_inventory("nokore_creative_trash", {
    allow_put = function (inv, listname, index, stack, player)
      return stack:get_count()
    end,

    on_put = function (inv, listname, index, stack, player)
      inv:set_stack(listname, index, nil)
    end,
  })
  creative.trash_inventory:set_size("main", 1)

  creative.normalized_terms = {}
  local registered_item_names = creative.registered_items
  local i = 0
  for name,def in pairs(minetest.registered_items) do
    local should_include = true
    if def.groups and
       def.groups.not_in_creative_inventory and
       def.groups.not_in_creative_inventory > 0 then
      should_include = false
    end
    if should_include then
      i = i + 1
      registered_item_names[i] = name
      creative.normalized_terms[name] = {
        name = name:lower(),
        description = (def.description or ""):lower(),
      }
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
      search_query = "",
      page_index = 1,
      page_count = 1,
    }
  end,

  render_formspec = function (player, assigns, tab_state)
    local mod = nokore_player_inv

    local page_size = mod.player_hotbar_size * 4
    local inventory_name = creative.get_player_creative_inventory_name(player)
    local inventory_offset = 1 + (tab_state.page_index - 1) * page_size

    local inv = creative.inventories[player:get_player_name()]
    local total = inv:get_size("main")
    tab_state.page_count = math.floor(total / page_size)

    if (total % page_size) > 0 then
      tab_state.page_count = tab_state.page_count + 1
    end

    local w = 0.25 + mod.player_hotbar_size * 1.25
    local y = 0.25 + 4 * 1.25

    return "size["..w..",9]" ..
           "list[detached:"..inventory_name..";main;0.25,0.25;"..mod.player_hotbar_size..",4;"..inventory_offset.."]" ..
           mod.player_inventory_formspec({ x = 0.25, y = 6.5 }) ..
           "listring[]" ..
           "list[detached:nokore_creative_trash;main;0.25,"..y..";1,1;]" ..
           "field[1.5,"..y..";"..(w-5.5)..",1;search_query;;"..minetest.formspec_escape(tab_state.search_query).."]" ..
           "field_close_on_enter[search_query;false]" ..
           "button["..(w-3.75)..","..y..";1,1;creative_prev_page;<]" ..
           "label["..(w-2.5)..","..(y+0.5)..";"..minetest.formspec_escape(tab_state.page_index.."/"..tab_state.page_count).."]" ..
           "button["..(w-1.25)..","..y..";1,1;creative_next_page;>]"
  end,

  on_player_receive_fields = function (player, assigns, fields, tab_state)
    local should_refresh = false
    if fields.search_query then
      if tab_state.search_query ~= fields.search_query then
        tab_state.page_index = 1
        tab_state.search_query = fields.search_query
        filter_player_creative_inventory(player, tab_state.search_query)
        should_refresh = true
      end
    end
    if fields.creative_prev_page then
      if change_page(tab_state, -1) then
        should_refresh = true
      end
    elseif fields.creative_next_page then
      if change_page(tab_state, 1) then
        should_refresh = true
      end
    end

    return false, should_refresh
  end,
})
