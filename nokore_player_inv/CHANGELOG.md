# 0.5.0

* Added new system for updating hotbar items, you may add a `on_inventory_tick/3` function to items to have them respond to changes, see [API](API.md) for more details.
* Added `register_on_inventory_tick/2` function for a general callback, see [API](API.md) for more details.

# 0.4.0

* Started tracking changes in CHANGELOG
* Support sending events to a tab via `nokore_player_inv.send_tab_event/3`

```lua
nokore_player_inv.send_tab_event(PlayerRef, String, Any)
nokore_player_inv.send_tab_event(player, "my_tab", {})
```
