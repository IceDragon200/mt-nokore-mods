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

    --
    -- A table containing named timers that should run while the formspec is
    -- active, they can be used to refresh the formspec if needed
    -- using the "refresh_formspec" command when returning from the timer
    --
    -- @optional
    timers = {
      -- timer_name can be replaced with anything
      timer_name = {
        -- how often should the timer execute its action? (in seconds)
        every = 1,

        -- notice that this function passes the player_name instead of the player ref
        -- you must pull the PlayerRef yourself if needed
        action = function (player_name, form_name, state)
          -- if no commands should be executed from this action return nil or an empty table
          return nil
        end,
      },

      timer_with_comands = {
        every = 1,

        action = function (player_name, form_name, state)
          local new_formspec = ... -- render new formspec

          return {
            {
              type = "refresh_formspec",
              value = new_formspec,
            }
          }
        end,
      },
    },

    --
    -- Callback whenever fields are received for the specified formspec
    --
    -- @optional
    on_receive_fields = function (player, form_name, fields, state)
      local stop_bubbling = true

      -- optionally a new formspec can be returned to replace the current one
      -- effectively 'refreshing' it, if nil is returned nothing is refreshed
      local new_formspec = nil

      return stop_bubbling, new_formspec
    end,

    --
    -- Callback whenever the player closes the formspec
    --
    -- @optional
    on_quit = function (player, form_name, fields, state)

    end,
  }
)
```
