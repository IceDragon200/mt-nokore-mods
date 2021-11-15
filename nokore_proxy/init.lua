local mod = foundation.new_module("nokore_proxy", "1.0.0")

local Trace = assert(foundation.com.Trace)

-- @namespace nokore_proxy
mod.registered_globalsteps = {}

mod.last_trace = nil

-- @spec register_globalstep(name: String, callback: Function/1): void
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
  local trace = Trace:new("nokore_proxy.update/1")
  local span

  for name, callback in pairs(mod.registered_globalsteps) do
    span = trace:span_start(name)
    callback(dt, span)
    span:span_end()
  end

  trace:span_end()

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
