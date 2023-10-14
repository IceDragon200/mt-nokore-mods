--
-- NoKore - UI
--

--- This mod wraps up the formspec system into nice to managed classes
--- @namespace nokore
local mod = foundation.new_module("nokore_ui", "0.3.0")

mod:require("formspec_bindings.lua")

--- @const formspec_bindings: FormspecBindings
nokore.formspec_bindings = nokore.FormspecBindings:new("default")

minetest.register_on_player_receive_fields(
  nokore.formspec_bindings:method("on_player_receive_fields")
)

nokore_proxy.register_globalstep(
  "nokore_ui:formspec_timers",
  nokore.formspec_bindings:method("update")
)
