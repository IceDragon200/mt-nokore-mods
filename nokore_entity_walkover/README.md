# Nokore Entity Walkover

Handles `walkover`, `walk_in`, `standing_on` and `standing_in` callbacks for nodes.

Users can register global callbacks as follows:

```lua
--- For when a player is walking over a specific node (that is, the node is below their feet)
nokore_entity_walkover:on_player_walkover("my_callback_name", function (pos, node, player)
  -- ... do something
end)

--- For when a player is walking inside a specific node
nokore_entity_walk_in:on_player_walk_in("my_callback_name", function (pos, node, player)
  -- ... do something
end)

nokore_entity_walkover:on_player_standing_on("my_callback_name", function (pos, node, player)
  -- ... do something
end)

nokore_entity_walkover:on_player_standing_in("my_callback_name", function (pos, node, player)
  -- ... do something
end)
```

But one can also just define:
* `on_player_walkover`
* `on_player_walk_in`
* `on_player_standing_on`
* `on_player_standing_in`

As callbacks directly on the node definition as well

```lua
minetest.register_node("my_mod:my_node", {
  ...

  --- Triggered once when a player has freshly moved
  ---
  --- @spec on_player_walkover(pos: Vector3, node: NodeRef, player: PlayerRef): void
  on_player_walkover = function (pos, node, player)
    -- ... do something
  end,

  --- Triggered once when a player has freshly moved
  ---
  --- @spec on_player_walk_in(pos: Vector3, node: NodeRef, player: PlayerRef): void
  on_player_walk_in = function (pos, node, player)
    -- ... do something
  end,

  --- Triggered every tick when a player has remained "standing" in a specific position
  --- elapsed is how long the player has been standing in that position in seconds
  ---
  --- @spec on_player_standing_on(pos: Vector3, node: NodeRef, player: PlayerRef, elapsed: Float): void
  on_player_standing_on = function (pos, node, player, elapsed)
    -- ... do something
  end,

  --- Triggered every tick when a player has remained "standing" in a specific position
  --- elapsed is how long the player has been standing in that position in seconds
  ---
  --- @spec on_player_standing_in(pos: Vector3, node: NodeRef, player: PlayerRef, elapsed: Float): void
  on_player_standing_in = function (pos, node, player, elapsed)
    -- ... do something
  end,
})
```
