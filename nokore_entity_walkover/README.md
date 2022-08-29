# Nokore Entity Walkover

Handles `walkover` and `standing_on` callbacks for nodes.

Users can register global callbacks as follows:

```lua
nokore_entity_walkover:on_player_walkover("my_callback_name", function (pos, node, player)
  -- ... do something
end)

nokore_entity_walkover:on_player_standing_on("my_callback_name", function (pos, node, player)
  -- ... do something
end)
```

But one can also just define `on_player_walkover` and `on_player_standing_on` callbacks directly on the node definition as well:

```lua
minetest.register_node("my_mod:my_node", {
  ...

  -- Triggered once when a player has freshly moved
  --
  -- @spec on_player_walkover(pos: Vector3, node: NodeRef, player: PlayerRef): void
  on_player_walkover = function (pos, node, player)
    -- ... do something
  end,

  -- Triggered every tick when a player has remained "standing" in a specific position
  -- dtime is how long the player has been standing in that position in seconds
  --
  -- @spec on_player_standing_on(pos: Vector3, node: NodeRef, player: PlayerRef, dtime: Float): void
  on_player_standing_on = function (pos, node, player, dtime)
    -- ... do something
  end,
})
```
