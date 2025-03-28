--
-- NoKore - Creative
--
-- Creative
foundation.new_module("nokore_creative", "0.1.0")

local Groups = assert(foundation.com.Groups)
local fspec = assert(foundation.com.formspec.api)

local creative = {
  trash_inventory = nil,
  inventories = {},
}

--- @spec get_player_creative_inventory_name(player: PlayerRef): String
function creative.get_player_creative_inventory_name(player)
  return "nokore_creative_player_" .. player:get_player_name()
end

local function filter_player_creative_inventory(player, filter)
  local inv = creative.inventories[player:get_player_name()]

  local list = {}
  local i = 0
  local normalized_filter = filter:lower()
  local itemdef
  local item_stack
  for _,item_name in nokore_item_index.filter_items(filter) do
    itemdef = core.registered_items[item_name]
    if itemdef and not Groups.has_group(itemdef.groups, "not_in_creative_inventory") then
      item_stack = ItemStack(item_name)
      item_stack:set_count(item_stack:get_stack_max())
      i = i + 1
      list[i] = item_stack
    end
  end

  inv:set_size("main", i)
  inv:set_list("main", list)
end

local function create_player_creative_inventory(owning_player)
  creative.inventories[owning_player:get_player_name()] =
    core.create_detached_inventory(
      creative.get_player_creative_inventory_name(owning_player),
      {
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
      },
      owning_player:get_player_name()
    )

  filter_player_creative_inventory(owning_player, "")
end

local function remove_player_creative_inventory(player)
  core.remove_detached_inventory(creative.get_player_creative_inventory_name(player))
  creative.inventories[player:get_player_name()] = nil
end

local function on_mods_loaded()
  creative.trash_inventory = core.create_detached_inventory("nokore_creative_trash", {
    allow_put = function (inv, listname, index, stack, player)
      return stack:get_count()
    end,

    on_put = function (inv, listname, index, stack, player)
      inv:set_stack(listname, index, nil)
    end,
  })
  creative.trash_inventory:set_size("main", 1)
end

core.register_on_joinplayer(create_player_creative_inventory)
core.register_on_leaveplayer(remove_player_creative_inventory)
core.register_on_mods_loaded(on_mods_loaded)

local function change_page(tab_state, amt)
  if tab_state.page_count > 0 then
    local page = tab_state.page_index - 1
    tab_state.page_index = 1 + ((page + amt) % tab_state.page_count)
    return true
  end
  return false
end

local function render_formspec(player, assigns, tab_state)
  local w = 0.25 + nokore_player_inv.player_hotbar_size * 1.25

  if core.is_creative_enabled(player:get_player_name()) then
    local inv_row_count = 6
    local page_size = nokore_player_inv.player_hotbar_size * inv_row_count
    local inventory_name = creative.get_player_creative_inventory_name(player)
    local inventory_offset = (tab_state.page_index - 1) * page_size

    local inv = creative.inventories[player:get_player_name()]
    local total = inv:get_size("main")
    tab_state.page_count = math.floor(total / page_size)

    if (total % page_size) > 0 then
      tab_state.page_count = tab_state.page_count + 1
    end

    local dims = nokore_player_inv.player_inventory_size2(player)
    local y = 0.25 + inv_row_count * 1.25

    return ""
      .. fspec.size(w, 0.25 + (inv_row_count + 1 + dims.y) * 1.25)
      .. fspec.list(
        "detached:"..inventory_name,
        "main",
        0.25,
        0.25,
        dims.x,
        inv_row_count,
        inventory_offset
      )
      .. nokore_player_inv.player_inventory_lists_fragment(player, 0.25, y + 1.25)
      .. fspec.list_ring()
      .. fspec.list(
        "detached:nokore_creative_trash",
        "main",
        0.25,
        y,
        1,
        1
      )
      .. fspec.field_area(
        1.5,
        y,
        w - 5.5,
        1,
        "search_query",
        "",
        tab_state.search_query
      )
      .. fspec.field_close_on_enter("search_query", false)
      .. fspec.button(
        w - 3.75,
        y,
        1,
        1,
        "creative_prev_page",
        "<"
      )
      .. fspec.label(
        w - 2.5,
        y + 0.25,
        tab_state.page_index .. "/" .. tab_state.page_count
      )
      .. fspec.label(
        w - 2.5,
        y + 0.75,
        inventory_offset .. "/" .. total
      )
      .. fspec.button(
        w - 1.25,
        y,
        1,
        1,
        "creative_next_page",
        ">"
      )
  else
    return fspec.size(w, 9) ..
           "label[0,0;Creative Unavailable]"
  end
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

  check_player_enabled = function (player, _assigns, _tab_state)
    return core.is_creative_enabled(player:get_player_name())
  end,

  render_formspec = render_formspec,

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
