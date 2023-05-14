# NoKore Common

## API

```lua
nokore.dig_class(material_class)

nokore.dig_class("hand")
nokore.dig_class("wme")
-- ...
nokore.dig_class("nano_element")

--- Usage
minetest.register_node("my_mod:my_node", {
  groups = {
    cracky = nokore.dig_class("wme")
  }
})
```
