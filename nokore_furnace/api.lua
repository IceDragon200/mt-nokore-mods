--- @namespace nokore_furnace
local mod = nokore_furnace

local get_craft_result = assert(core.get_craft_result)

--- @spec is_item_stack_fuel(item_stack: ItemStack): Boolean
function mod.is_item_stack_fuel(item_stack)
  if item_stack then
    local fuel = get_craft_result({
      method = "fuel",
      width = 1,
      items = { item_stack },
    })

    return fuel and fuel.time > 0
  end
  return false
end
