# 0.4.0

* Started tracking changes in CHANGELOG
* Support sending events to a tab via `nokore_player_inv.send_tab_event/3`

```lua
nokore_player_inv.send_tab_event(PlayerRef, String, Any)
nokore_player_inv.send_tab_event(player, "my_tab", {})
```
