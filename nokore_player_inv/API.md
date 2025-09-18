# API

## Inventory Tabs

```lua
nokore_player_inv.register_player_inventory_tab("tab_name", {
  --- @spec on_player_initialize(PlayerRef, Table): Any
  on_player_initialize = function (player, assigns)
    return {}
  end,

  --- @spec check_player_enabled(PlayerRef, Table, Any): Boolean
  check_player_enabled = function (player, assigns, tab_state)
    return true
  end,

  --- @spec on_player_activate(PlayerRef, Table): void
  on_player_activate = function (player, assigns)
    --- Triggered whenever the tab is activated or put in focus
  end,

  --- @spec render_formspec(PlayerRef, Table, Any): String
  render_formspec = function (player, assigns, tab_state)
    local formspec = ""
    return formspec
  end,

  --- @spec on_player_receive_fields(
  ---   PlayerRef,
  ---   Table,
  ---   Table,
  ---   Any
  --- ): (break_bubbling: Boolean, should_refresh: Boolean)
  on_player_receive_fields = function (player, assigns, fields, tab_state)
    return false, false
  end,

  --- @spec on_event(PlayerRef, Table, Any, Any): Boolean
  on_event = function (player, assigns, event, tab_state)
    --- Return a boolean, true will trigger the formspec to refresh, false will not.
    return false
  end,
})

nokore_player_inv.update_player_inventory_tab("tab_name", {
  --- ..., partial definition

  render_formspec = function (player, assigns, tab_state)
    -- redefine the rendering
    local formspec = ""
    return formspec
  end,
})
```

## Constants

* `INVENTORY_TICK_INTERVAL` - defaults to 0.05 (i.e. 1/20)

## Data Initialize Function

The `on_player_data_initialize` function is provided for mods to modify the internal player inventory data during its initialization, note that the data is NOT persisted at the time of writing, so it's safe to store functions and the like on it.

```lua
--- @spec on_player_data_initialize(PlayerRef, Table): void
function nokore_player_inv.on_player_data_initialize(player, player_data)
  --- do whatever you like with the player_data here
end
```

It is expected that a game will override the function, individual mods SHOULD avoid overwriting it, unless they intend to daisy chain it:

```lua
local prev = nokore_player_inv.on_player_data_initialize

function nokore_player_inv.on_player_data_initialize(player, player_data)
  prev(player, player_data)
  -- ... do whatever you like
end
```

## General Callbacks

If there is a need to run an on_inventory_tick callback on *every* item in a player's inventory, the mod also allows that, just note that item specific callbacks take priority, and the `item_stack`, received by this callback *may* be the replacement.

Callback order is *NOT* guaranteed, if your callback or implementation relies on the specific order of callbacks being ran, see if one of the existing ones have infrastructure to subscribe to their callback, yes I know it sounds tacky, but to keep the implementation simple here a basic table was used.

The only guarantees are that general callbacks will ALWAYS follow after an item callback.

```lua
nokore_player_inv.register_on_inventory_tick(
  "my_mod:my_callback_name",
  function (item_stack, object, dtime)
    --- Same rules as the item version of on_inventory_tick/3
    return item_stack
  end
)
```

## Item Callbacks

Items within a player's inventory are subject to `on_inventory_tick` processing.

Items may define this callback to perform any actions within the player's inventory.

```lua
core.register_item("my_mod:my_item", {
  --- ...
  --- @spec on_inventory_tick(ItemStack, ObjectRef, Number): ItemStack | nil
  on_inventory_tick = function (item_stack, object, dtime)
    --- do whatever you like with the item, either return a replacement item, or nil to not
    --- modify the inventory.
    --- Note. if a mod decides to implement this callback for non-player entities
    --- be sure to check the object carefully to avoid assuming it is a player off the bat.
    return item_stack
  end,
})
```
