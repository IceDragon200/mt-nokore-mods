local mod = assert(nokore_treasure)
local treasure = assert(nokore.treasure)

-- @private.spec action(Vector3, NodeRef): void
local function action(pos, _node)
  local meta = minetest.get_meta(pos)
  local chest_name = meta:get_string("nok_chest_name")

  treasure:spawn_treasure_chest(pos, chest_name)
end

minetest.register_lbm({
  label = "Replace Treasure Placeholders",

  nodenames = {mod:make_name("treasure_placeholder")},

  name = mod:make_name("replace_treasure_placeholders"),

  run_at_every_load = true,

  action = action,
})
