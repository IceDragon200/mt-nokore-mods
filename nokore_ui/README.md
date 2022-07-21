# Nokore UI

Adds the FormspecBindings class and service, which adds a much needed wrapper around minetest's builtin show_formspec, this service adds an on_receive_fields hook and the ability to maintain player-specific state objects for the form.

In addition it provides ways to "refresh" the formspec.

## Usage

```lua
nokore.formspec_bindings:show_formspec(
  player:get_player_name(),
  "formspec_name_here",
  formspec,
  {
    -- any state you wish to pass to the on_receive_fields callback
    -- this state can be modified between refreshes
    state = {},

    -- @optional
    on_receive_fields = function (player, form_name, fields, state)
      local stop_bubbling = true

      -- optionally a new formspec can be returned to replace the current one
      -- effectively 'refreshing' it, if nil is returned nothing is refreshed
      local new_formspec = nil

      return stop_bubbling, new_formspec
    end,
  }
)
```
