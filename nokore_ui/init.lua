--
-- NoKore - UI
--
-- This mod wraps up the formspec system into nice to manage classes
local mod = foundation.new_module("nokore_ui", "0.1.0")

local FormspecBindings = {}
FormspecBindings.instance_class = {}

local function default_on_receive_fields(player, form_name, fields, state)
  return false, nil
end

function FormspecBindings:new(...)
  local instance = {}
  setmetatable(instance, { __index = self.instance_class })
  instance:initialize(...)
  return instance
end

local ic = FormspecBindings.instance_class
function ic:initialize(name)
  self.name = name

  self.player_to_forms = {}
end

--
-- state MUST be a table where all the stateful data lives
--
-- @type ShowFormspecOptions :: {
--   state = Table,
--   on_receive_fields = function (player: PlayerRef, form_name: String, fields: Table, state: Table) ::
--                         (stop_bubbling: Boolean, new_formspec: String | nil),
--   on_quit = function (player: PlayerRef, form_name: String, fields: Table, state: Table) :: void
-- }
--
-- Wrapper for :bind_player_form and minetest.show_formspec, this will
-- setup the form binding and show the formspec to the player.
--
-- @spec :show_formspec(player_name: String,
--                      form_name: String,
--                      formspec: String,
--                      options: ShowFormspecOptions) :: (form: Table)
function ic:show_formspec(player_name, form_name, formspec, options)
  assert(player_name, "expected a player name")
  assert(form_name, "expected a form name")
  assert(formspec, "expected a formspec")
  assert(type(options) == "table", "expected options to be a table")

  local form = self:bind_player_form(player_name, form_name, options)
  minetest.show_formspec(player_name, form_name, formspec)

  return form
end

--
-- Bind specified form for player
--
-- @spec :bind_player_form(player_name: String,
--                         form_name: String,
--                         options: ShowFormspecOptions) :: (form: Table)
function ic:bind_player_form(player_name, form_name, options)
  assert(type(options) == "table", "expected options to be a table")

  if options.on_quit then
    assert(type(options.on_quit) == "function", "expected on_quit to be a function")
  end

  if options.on_receive_fields then
    assert(type(options.on_receive_fields) == "function", "expected on_receive_fields to be a function")
  end

  local form = {
    state = options.state or {},
    on_receive_fields = assert(options.on_receive_fields or
                               default_on_receive_fields, "expected on_receive_fields"),
    on_quit = options.on_quit
  }

  if not self.player_to_forms[player_name] then
    self.player_to_forms[player_name] = {}
  end

  self.player_to_forms[player_name][form_name] = form

  return form
end

--
-- Bind specified form for player
--
-- @spec :unbind_player_form(player_name: String,
--                           form_name: String) :: self
function ic:unbind_player_form(player_name, form_name)
  --print("trying to unbind form from player")
  local forms = self.player_to_forms[player_name]
  if forms then
    -- the player has forms
    if forms[form_name] then
      forms[form_name] = nil
    end

    local is_empty = true
    for _k, _v in pairs(forms) do
      is_empty = false
      break
    end

    if is_empty then
      self.player_to_forms[player_name] = nil
    end
  end
  return self
end

--
-- Callback function for minetest's on_player_receive_fields
--
-- @spec :on_player_receive_fields(player: PlayerRef, form_name: String, fields: Table) :: Boolean
function ic:on_player_receive_fields(player, form_name, fields)
  local player_name = player:get_player_name()
  local forms = self.player_to_forms[player_name]
  if not forms then
    --print("there are no known forms bound for player")
    -- the player had no forms bound at the moment
    return false
  end

  local form = forms[form_name]
  if not form then
    --print("specified form is not bound for player")
    -- the specified form for the player was not bound
    return false
  end

  local stop_bubbling, new_formspec = form.on_receive_fields(player, form_name, fields, form.state)
  --print(dump(fields))
  if fields["quit"] then
    self:unbind_player_form(player_name, form_name)
    if form.on_quit then
      --print("invoking on_quit callback")
      form.on_quit(player, form_name, fields, form.state)
    end
    return stop_bubbling
  else
    if new_formspec then
      minetest.show_formspec(player_name, form_name, new_formspec)
    end
    return stop_bubbling
  end
end

--
-- Register this FormspecBindings to minetest's on_player_receive_fields
--
-- @spec :listen() :: self
function ic:listen()
  local instance = self
  minetest.register_on_player_receive_fields(function (...)
    instance:on_player_receive_fields(...)
  end)
  return self
end

nokore.FormspecBindings = FormspecBindings
nokore.formspec_bindings = FormspecBindings:new("default")

nokore.formspec_bindings:listen()
