local mod = foundation.new_module("nokore_proxy", "1.0.0")

-- maybe it will be set, maybe
local Trace = foundation.com.Trace

-- @namespace nokore_proxy

-- @type GlobalstepCallback: Function(dt: Float, trace?: Trace) => void

-- @const registered_globalsteps: {
--   [name: String]: GlobalstepCallback
-- }
mod.registered_globalsteps = {}

-- @const last_trace: Trace | nil
mod.last_trace = nil

-- @spec register_globalstep(name: String, callback: GlobalstepCallback): void
function mod.register_globalstep(name, callback)
  assert(name, "expected a callback name")
  assert(type(callback) == "function", "expected a callback function")

  if mod.registered_globalsteps[name] then
    error("globalstep function already registered name=" .. name)
  end

  mod.registered_globalsteps[name] = callback
end

-- @spec update(Float): void
function mod.update(dt)
  local trace
  if Trace then
    trace = Trace:new("nokore_proxy.update/1")
  end
  local span

  for name, callback in pairs(mod.registered_globalsteps) do
    if trace then
      span = trace:span_start(name)
    end
    callback(dt, span)
    if span then
      span:span_end()
    end
  end

  if trace then
    trace:span_end()
  end

  mod.last_trace = trace
end

minetest.register_globalstep(mod.update)
minetest.register_chatcommand("print_proxy_trace", {
  description = mod.S("Prints the details of the last proxy update trace to console"),

  func = function (_caller_name)
    if mod.last_trace then
      mod.last_trace:inspect()
      return true, "OK check console"
    else
      return false, "ERR trace to print"
    end
  end,
})
