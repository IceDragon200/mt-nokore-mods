local mod = foundation.new_module("nokore_proxy", "1.0.0")

-- maybe it will be set, maybe
local Trace = foundation.com.Trace
local List = assert(foundation.com.List)

--- @namespace nokore_proxy

--- @type GlobalstepCallback: Function(dt: Float, trace?: Trace) => void

--- @type RegisteredGlobalstep: {
---   name: String,
---   callback: GlobalstepCallback,
--- }

--- @const registered_globalsteps: foundation.com.List<RegisteredGlobalstep>
mod.registered_globalsteps = List:new()

--- @const last_trace: Trace | nil
mod.last_trace = nil

--- @spec register_globalstep(name: String, callback: GlobalstepCallback): void
function mod.register_globalstep(name, callback)
  assert(name, "expected a callback name")
  assert(type(callback) == "function", "expected a callback function")

  local existing = mod.registered_globalsteps:find(nil, function (obj)
    return obj.name == name
  end)

  if existing then
    error("globalstep function already registered name=" .. name)
  end

  mod.registered_globalsteps:push({ name = name, callback = callback })
end

--- @spec update(Float): void
function mod.update(dt)
  local trace
  if Trace then
    trace = Trace:new("nokore_proxy.update/1")
  end
  local span

  local data = mod.registered_globalsteps:data()
  local size = mod.registered_globalsteps:size()
  local entry

  if size > 0 then
    for i = 1,size do
      entry = data[i]
      if trace then
        span = trace:span_start(entry.name)
      end
      entry.callback(dt, span)
      if span then
        span:span_end()
      end
    end
  end

  if trace then
    trace:span_end()
  end

  mod.last_trace = trace
end

minetest.register_globalstep(mod.update)

mod:require("chat_commands.lua")
