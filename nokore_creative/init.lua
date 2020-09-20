--
-- NoKore - Creative
--
-- Creative
local mod = foundation.new_module("nokore_creative", "0.1.0")

local creative = {
  registered_items = {},
  inventories = {}
}

local function create_player_creative_inventory(player)
  creative.inventories[player:get_player_name()] =
    minetest.create_detached_inventory("nokore_creative_" .. player:get_player_name(), {
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
end

local function remove_player_creative_inventory(player)
  minetest.remove_detached_inventory("nokore_creative_" .. player:get_player_name())
  creative.inventories[player:get_player_name()] = nil
end

minetest.register_on_joinplayer(create_player_creative_inventory)
minetest.register_on_leaveplayer(remove_player_creative_inventory)
minetest.register_on_mods_loaded(function ()
  local registered_item_names = {}
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
