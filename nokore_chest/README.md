# Nokore Chest

Provides an API for defining chests in minetest.

## Usage

```lua
nokore_chest:register_chest("my_mod:my_chest", {

})
```

## Game / Modpack Override

It is safe to override the render_formspec function for your game or modpack.

```lua
function nokore_chest.render_formspec(pos, player)
  local formspec = ""

  --- make your formspec here

  return formspec
end
```

The default formspec is raw and unstyled, so it's best to overwrite it with proper styling.
