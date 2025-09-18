--
-- Initialize the default make_tool_* functions
-- When using nokore in a modpack or game, it's best to define these functions in the nokore_prelude
--
local mod = foundation.new_module("nokore_common", "1.0.0")

--- @namespace nokore
nokore = rawget(_G, "nokore") or {}

if nokore.make_tool_cap_times and nokore.make_tool_capability and nokore.dig_class then
  -- nothing to do here
  core.log("info", "nokore utility functions are present, skipping patches")
  return
end

if not nokore.make_tool_cap_times then
  --- @spec make_tool_cap_times(tool_class: String, material_class: String): { [Integer] = Number }
  function nokore.make_tool_cap_times(tool_class, material_class)
    error("TODO")
  end
end

if not nokore.make_tool_capability then
  function nokore.make_tool_capability(tool_class, material_class)
    error("TODO")
  end
end

if not nokore.dig_class then
  --
  -- Nokore's default tool caps are an approximation of minetest_game's default against HSW's
  -- materials.
  -- Effectively HSW has 13 levels while "default" only has around 5, therefore Nokore does an
  -- approximation
  --

  local DIG_CLASS = {
    hand = 3,
    wme = 3,
    wood = 3,
    stone = 3,
    copper = 2,
    gold = 2,
    bronze = 2,
    iron = 2,
    invar = 2,
    abyssal_iron = 1,
    carbon_steel = 1,
    nano_steel = 1,
    nano_element = 1,
  }

  --- @spec dig_class(material_class: String): Integer
  function nokore.dig_class(material_class)
    local value = DIG_CLASS[material_class]
    if value then
      return value
    end
    error("dig_class not found got=" .. material_class)
  end
end

core.log("warning", "nokore's backfilling has been completed for some core functions, they may not be what you want however.")
