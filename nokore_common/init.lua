--
-- Initialize the default make_tool_* functions
-- When using nokore in a modpack or game, it's best to define these functions in the nokore_prelude
--

if nokore.make_tool_cap_times and nokore.make_tool_capability and nokore.dig_class then
  -- nothing to do here
  return
end

if not nokore.make_tool_cap_times and not nokore.make_tool_capability and not nokore.dig_class then
  --
  -- YATM's default tool caps are an approximation of minetest_game's default against HSW's
  -- materials.
  -- Effectively HSW has 13 levels while "default" only has around 5, therefore YATM does an
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

  -- @spec make_tool_cap_times(tool_class: String, material_class: String): { [Integer] = Number }
  function nokore.make_tool_cap_times(tool_class, material_class)
    error("TODO")
  end

  function nokore.make_tool_capability(tool_class, material_class)
    error("TODO")
  end

  -- @spec dig_class(material_class: String): Integer
  function nokore.dig_class(material_class)
    local value = DIG_CLASS[material_class]
    if value then
      return value
    end
    error("dig_class not found got=" .. material_class)
  end
else
  error([[
    incomplete make_tool_* and dig_class implementations.

    make_tool_cap_times, make_tool_capability, and dig_class must all be defined:

        function nokore.make_tool_cap_times(tool_class, material_class)
          return tool_cap_times
        end

        function nokore.make_tool_capability(tool_class, material_class)
          return tool_capability
        end

        function nokore.dig_class(material_class)
          return level
        end

    Either define all the functions, or none at all
  ]])
end

