nokore_chest.open_chests = {}

function nokore_chest.chest_on_construct(pos)
  local meta = minetest.get_meta(pos)
  local inv = meta:get_inventory()

  inv:set_size("main", 10 * 4)
end

function nokore_chest.chest_after_destruct(pos)
  --
end

function nokore_chest.chest_can_dig(pos)
  local meta = minetest.get_meta(pos)
  local inv = meta:get_inventory()

  return inv:is_empty("main")
end

function nokore_chest.get_formspec(pos, player)
  local spos = pos.x .. "," .. pos.y .. "," .. pos.z

  local formspec =
    "size["..nokore_player_inv.player_hotbar_size..",9]" ..
    "list[nodemeta:" .. spos .. ";main;0,0.3;10,4;]" ..
    nokore_player_inv.player_inventory_formspec({ x = 0, y = 5.5 }) ..
    "listring[]"

  return formspec
end

function nokore_chest.on_formspec_quit(player, form_name, fields, state)
  local player_name = player:get_player_name()
  local chest_id = state.chest_id

  if nokore_chest.open_chests[chest_id] then
    nokore_chest.open_chests[chest_id][player_name] = nil

    local is_empty = true
    for _, _ in pairs(nokore_chest.open_chests[chest_id]) do
      is_empty = false
      break
    end

    if is_empty then
      nokore_chest.open_chests[chest_id] = nil

      local node = minetest.get_node_or_nil(state.pos)
      if node then
        local nodedef = minetest.registered_nodes[node.name]
        minetest.swap_node(state.pos, { name = nodedef.node_states.closed, param2 = node.param2 })

        minetest.log("action", player:get_player_name() .. " closed chest at=" .. chest_id)
      end
    else
      -- there are still
      print("someone is still looking in the chest")
    end
  end
end

function nokore_chest.maybe_open_chest(pos, player)
  local chest_id = minetest.pos_to_string(pos)
  if not nokore_chest.open_chests[chest_id] then
    nokore_chest.open_chests[chest_id] = {}

    local node = minetest.get_node_or_nil(pos)
    if node then
      local nodedef = minetest.registered_nodes[node.name]
      minetest.swap_node(pos, { name = nodedef.node_states.opened, param2 = node.param2 })

      minetest.log("action", player:get_player_name() .. " opened chest at=" .. chest_id)
    end
  end
  nokore_chest.open_chests[chest_id][player:get_player_name()] = true
end

function nokore_chest.chest_on_rightclick(pos, _node, player, item_stack, _pointed_thing)
  --
  local chest_id = minetest.pos_to_string(pos)
  local options = {
                    state = {
                      pos = pos,
                      chest_id = chest_id,
                    },
                    on_quit = nokore_chest.on_formspec_quit,
                  }
  nokore.formspec_bindings:show_formspec(player:get_player_name(),
                                          "nokore_chest:chest",
                                          nokore_chest.get_formspec(pos, player),
                                          options)

  nokore_chest.maybe_open_chest(pos, player)
end

function nokore_chest:register_chest(name, base)
  local def = table.copy(base)

  def.paramtype = "light"
  def.paramtype2 = "facedir"
  def.is_ground_content = false

  def.description = def.description or self.S("Chest")

  def.on_construct = def.on_construct or nokore_chest.chest_on_construct
  def.after_destruct = def.after_destruct or nokore_chest.chest_after_destruct
  def.can_dig = def.can_dig or nokore_chest.chest_can_dig
  def.on_rightclick = def.on_rightclick or nokore_chest.chest_on_rightclick

  def.node_states = {
    closed = name .. "_closed",
    opened = name .. "_opened",
  }

  local closed_def = table.copy(def)
  local opened_def = table.copy(def)

  opened_def.visual = "mesh"
  opened_def.drawtype = "mesh"
  opened_def.mesh = "nokore_chest_open.obj"

  for i = 1, #opened_def.tiles do
    if type(opened_def.tiles[i]) == "string" then
      opened_def.tiles[i] = {
        name = opened_def.tiles[i],
        backface_culling = true
      }
    elseif opened_def.tiles[i].backface_culling == nil then
      opened_def.tiles[i].backface_culling = true
    end
  end

  opened_def.drop = def.node_states.closed

  opened_def.groups.not_in_creative_inventory = 1

  opened_def.selection_box = {
    type = "fixed",
    fixed = { -1/2, -1/2, -1/2, 1/2, 3/16, 1/2 },
  }

  opened_def.can_dig = function()
    return false
  end

  opened_def.on_blast = function()
    --
  end

  closed_def.tiles[6] = def.tiles[5] -- swap textures around for "normal"
  closed_def.tiles[5] = def.tiles[3] -- drawtype to make them match the mesh
  closed_def.tiles[3] = def.tiles[3].."^[transformFX"

  minetest.register_node(def.node_states.closed, closed_def)
  minetest.register_node(def.node_states.opened, opened_def)
end
