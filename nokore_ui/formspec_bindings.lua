-- @namespace nokore
nokore = rawget(_G, "nokore") or {}

-- @class FormspecBindings
local FormspecBindings = foundation.com.Class:extends("nokore.FormspecBindings")
local ic = FormspecBindings.instance_class

local function default_on_receive_fields(player, form_name, fields, state)
  return false, nil
end

-- @spec #initialize(name: String): void
function ic:initialize(name)
  self.name = name

  self.player_to_forms = {}

  self.player_formspec_timers = {}
end

--
-- state MUST be a table where all the stateful data lives
--
-- @type TimerActionCommand: { type: String, value: Any }
--
-- @type ShowFormspecOptions :: {
--   state = Table,
--   timers = {
--     [name: String] = {
--       every = Number,
--       action = function (
--         player_name: String,
--         form_name: String,
--         state: Table
--       ) => TimerActionCommand[]
--     },
--   },
--   on_receive_fields = function (
--     player: PlayerRef,
--     form_name: String,
--     fields: Table,
--     state: Table
--   ) => (stop_bubbling: Boolean, new_formspec: String | nil),
--   on_quit = function (player: PlayerRef, form_name: String, fields: Table, state: Table) => void
-- }
--

-- Wrapper for :bind_player_form and minetest.show_formspec, this will
-- setup the form binding and show the formspec to the player.
--
-- @spec #show_formspec(player_name: String,
--                      form_name: String,
--                      formspec: String,
--                      options: ShowFormspecOptions): (form: Table)
function ic:show_formspec(player_name, form_name, formspec, options)
  assert(type(player_name) == "string", "expected a player name")
  assert(type(form_name) == "string", "expected a form name")
  assert(type(formspec) == "string", "expected a formspec")
  assert(type(options) == "table", "expected options to be a table")

  local form = self:bind_player_form(player_name, form_name, options)
  minetest.show_formspec(player_name, form_name, formspec)

  return form
end

--
-- @spec #find_forms(expected_form_name: String, callback: Function/2): void
function ic:find_forms(expected_form_name, callback)
  for player_name, forms in pairs(self.player_to_forms) do
    for form_name, form in pairs(forms) do
      if form_name == expected_form_name then
        callback(player_name, form)
      end
    end
  end
end

--
-- @spec #refresh_formspecs(expected_form_name: String, callback: Function/2): void
function ic:refresh_formspecs(expected_form_name, callback)
  self:find_forms(expected_form_name, function (player_name, form)
    local new_formspec = callback(player_name, form.state)
    if new_formspec then
      minetest.show_formspec(player_name, expected_form_name, new_formspec)
    end
  end)
end

--
-- Bind specified form for player
--
-- @spec #bind_player_form(player_name: String,
--                         form_name: String,
--                         options: ShowFormspecOptions): (form: Table)
function ic:bind_player_form(player_name, form_name, options)
  assert(type(options) == "table", "expected options to be a table")

  if options.on_quit then
    assert(type(options.on_quit) == "function", "expected on_quit to be a function")
  end

  if options.on_receive_fields then
    assert(type(options.on_receive_fields) == "function", "expected on_receive_fields to be a function")
  end

  local form = {
    form_name = form_name,
    state = options.state or {},
    on_receive_fields = assert(options.on_receive_fields or
                               default_on_receive_fields, "expected on_receive_fields"),
    on_quit = options.on_quit
  }

  if not self.player_to_forms[player_name] then
    self.player_to_forms[player_name] = {}
  end

  self.player_to_forms[player_name][form_name] = form

  if options.timers then
    if not self.player_formspec_timers[player_name] then
      self.player_formspec_timers[player_name] = {}
    end

    if not self.player_formspec_timers[player_name][form_name] then
      self.player_formspec_timers[player_name][form_name] = {}
    end

    local form_timers = self.player_formspec_timers[player_name][form_name]

    for timer_name, timer_def in pairs(options.timers) do
      assert(type(timer_def.every) == "number", "expected `every` field")
      assert(type(timer_def.action) == "function", "expected `action` field")

      form_timers[timer_name] = {
        definition = timer_def,
        elapsed = 0,
      }
    end
  end

  return form
end

--
-- Unbind specified form for player
--
-- @spec #unbind_player_form(player_name: String,
--                           form_name: String): self
function ic:unbind_player_form(player_name, form_name)
  --print("trying to unbind form from player")
  local forms = self.player_to_forms[player_name]
  if forms then
    -- the player has forms
    if forms[form_name] then
      forms[form_name] = nil
    end

    if not next(forms) then
      self.player_to_forms[player_name] = nil
    end
  end

  local forms = self.player_formspec_timers[player_name]
  if forms then
    -- the player has forms
    if forms[form_name] then
      forms[form_name] = nil
    end

    if not next(forms) then
      self.player_formspec_timers[player_name] = nil
    end
  end

  return self
end

--
-- Callback function for minetest's on_player_receive_fields
--
-- @spec #on_player_receive_fields(player: PlayerRef, form_name: String, fields: Table): Boolean
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

local function trigger_timer_item(self, timer_item, player_name, form_name)
  local def = timer_item.definition
  local form = self.player_to_forms[player_name][form_name]
  local commands = def.action(player_name, form_name, form.state)

  timer_item.elapsed = math.max(timer_item.elapsed - def.every, 0)

  if commands then
    for _,command in ipairs(commands) do
      if command.type == "refresh_formspec" then
        minetest.show_formspec(player_name, form_name, command.value)
      else
        error("unexpected command.type=" .. command.type ..
              " player=" .. player_name ..
              " formspec.name=" .. form_name)
      end
    end
  end

  return true
end

-- @since "0.2.0"
-- @spec #update(dtime: Float): void
function ic:update(dtime)
  local def

  for player_name, forms in pairs(self.player_formspec_timers) do
    for form_name, timers in pairs(forms) do
      for timer_name, timer_item in pairs(timers) do
        timer_item.elapsed = timer_item.elapsed + dtime

        def = timer_item.definition
        if timer_item.elapsed > def.every then
          trigger_timer_item(self, timer_item, player_name, form_name)
        end
      end
    end
  end
end

-- @since "0.3.0"
-- @spec #trigger_form_timer(form_name: String, timer_name: String): void
function ic:trigger_form_timer(form_name, timer_name)
  local timers
  local timer_item

  for player_name, forms in pairs(self.player_formspec_timers) do
    timers = forms[form_name]
    if timers then
      timer_item = timers[timer_name]

      if timer_item then
        trigger_timer_item(self, timer_item, player_name, form_name)
      end
    end
  end
end

--
-- Trigger's a player form's timer, the timer will be reset as if it was triggered normally
--
-- @since "0.3.0"
-- @spec #trigger_player_form_timer(
--   player_name: String,
--   form_name: String,
--   timer_name: String
-- ): Boolean
function ic:trigger_player_form_timer(player_name, form_name, timer_name)
  local forms = self.player_formspec_timers[player_name]
  if forms then
    local timers = forms[form_name]
    if timers then
      local timer_item = timers[timer_name]

      if timer_item then
        return trigger_timer_item(self, timer_item, player_name, form_name)
      end
    end
  end

  return false
end

nokore.FormspecBindings = FormspecBindings
