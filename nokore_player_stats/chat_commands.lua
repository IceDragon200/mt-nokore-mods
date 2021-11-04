local mod = nokore_player_stats
local player_stats = assert(nokore.player_stats)
local player_service = assert(nokore.player_service)

minetest.register_chatcommand("my_stats", {
  description = mod.S("Shows all stats for current player"),

  func = function (caller)
    local player = player_service:get_player_by_name(caller)

    if player then
      local result = ""
      local value
      for stat_name, _ in pairs(player_stats.registered_stats) do
        value = player_stats:get_player_stat(player, stat_name)

        result = result .. "\t" .. stat_name .. ": " .. tostring(value) .. "\n"
      end
      print("my_stats", caller, result)
      return true, "Stats:\n" .. result
    else
      return false, "player not available, try again later"
    end
  end,
})
