# NoKore Player Stats

Adds a service for managing additional player stats that can be recalculated from various modifiers.

The usecase was to abstract the calculation of various player stats (such as "hp_max") away and have only one mod that would handle updating these stat changes.

This mod by itself does not overwrite or rebind "hp", "breath" or other built-in stats.

If you wish to have this mod handle them, then register them accordinly and setup callbacks for refreshing their values.

## API

The first step is to register a new stat:

```lua
nokore.player_stats:register_stat("my_new_stat", {
  --- Whether or not the stat is allowed to be cached by default
  --- If set to false, when a get_player_stat is called it will always recalculate using calc/2
  cached = true,

  --- Calculate and return the value of the stat, it's up to you what that stat does in the long
  --- run, this mod only provides a service for doing so.
  ---
  --- @spec calc(Stat, PlayerRef): Any
  calc = function (self, player)
    --- self is an instance of nokore.player_stats.Stat
    local base_value = 0
    --- Some stats can support additional modifiers, usually these are for values that represent
    --- some maximum value, such as "hp_max" or "breath_max", if and when registering "hp"
    --- modifiers should never be applied.
    return self:apply_modifiers(player, base_value)
  end,

  --- This is an optional callback to allow setting the value of the stat if applicable
  ---
  --- @spec set(Stat, PlayerRef, value: Any): Boolean
  set = function (self, player, value)
    ---
  end,
})
```

Additional modifiers can be registered for that stat at a later time:

```lua
--- nokore.player_stats:register_stat_modifier(stat_name, callback_name, modifier_type, callback)
nokore.player_stats:register_stat_modifier("my_new_stat", "my_mod:state_modifier_for_my_new_stat", "add", function (player, value)
  --- make change to the value before returning it
  return value
end)
```

There are three modifier types:

* "base" - base is typically used for modifiers that will _overwrite_ the value with its own
* "add" - add is used when changes being made to the value are basic additions or subtractions
* "mul" - mul should be used for multipliers and is the final modifier applied

For illustrative purposes, the modifiers are applied in the order seen below:

```lua
-- Value can be anything
local value

-- First base
value = base_modifiers(value)
-- Then add
value = add_modifiers(value)
-- Finally mul
value = mul_modifiers(value)

return value
```
