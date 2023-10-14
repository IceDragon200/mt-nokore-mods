local mod = assert(nokore_proxy)

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
