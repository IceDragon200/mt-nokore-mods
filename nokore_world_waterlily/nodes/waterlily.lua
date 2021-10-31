local mod = nokore_world_waterlily

mod:register_node("waterlily", {
  description = mod.S("Waterlily"),

  groups = {
    snappy = 3,
    flower = 1,
    flammable = 1,
  },

  drawtype = "nodebox",

  use_texture_alpha = "clip",
  tiles = {
    "world_waterlily.png",
    "world_waterlily.png",
  },
  inventory_image = "world_waterlily.png",
  wield_image = "world_waterlily.png",

  node_box = {
    type = "fixed",
    fixed = {-0.5, -31 / 64, -0.5, 0.5, -15 / 32, 0.5}
  },
  selection_box = {
    type = "fixed",
    fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16}
  },

  paramtype = "light",
  paramtype2 = "facedir",
  liquids_pointable = true,
  walkable = false,
  buildable_to = true,
  floodable = true,

  node_placement_prediction = "",

  on_place = function (itemstack, placer, pointed_thing)
    local pos = pointed_thing.above
    local node = minetest.get_node(pointed_thing.under)
    local def = minetest.registered_nodes[node.name]

    if def and def.on_rightclick then
      return def.on_rightclick(pointed_thing.under,
                               node,
                               placer,
                               itemstack,
                               pointed_thing)
    end

    if def and
       def.liquidtype == "source" and
       minetest.get_item_group(node.name, "water") > 0 then
      local player_name = placer and placer:get_player_name() or ""

      if not minetest.is_protected(pos, player_name) then
        minetest.set_node(pos, {
          name = "nokore_world_waterlily:waterlily",
          param2 = math.random(0, 3)
        })

        if not (creative and
                creative.is_enabled_for and
                creative.is_enabled_for(player_name)) then
          itemstack:take_item()
        end
      else
        minetest.chat_send_player(player_name, "Node is protected")
        minetest.record_protection_violation(pos, player_name)
      end
    end

    return itemstack
  end,

  sounds = nokore.node_sounds:build("waterlily"),
})
