local mod = nokore_world_coral
local creative = rawget(_G, "creative")

local function coral_on_place(itemstack, placer, pointed_thing)
  if pointed_thing.type ~= "node" or not placer then
    return itemstack
  end

  local player_name = placer:get_player_name()
  local pos_under = pointed_thing.under
  local pos_above = pointed_thing.above
  local node_under = minetest.get_node(pos_under)
  local def_under = minetest.registered_nodes[node_under.name]

  if def_under and def_under.on_rightclick and not placer:get_player_control().sneak then
    return def_under.on_rightclick(pos_under, node_under,
        placer, itemstack, pointed_thing) or itemstack
  end

  if node_under.name ~= "nokore_world_coral:coral_skeleton" or
    -- Check if node is in sea_water group, rather than hardcode this
      minetest.get_node(pos_above).name ~= "nokore_world_water:water_source" then
    return itemstack
  end

  if minetest.is_protected(pos_under, player_name) or
      minetest.is_protected(pos_above, player_name) then
    minetest.log("action", player_name
      .. " tried to place " .. itemstack:get_name()
      .. " at protected position "
      .. minetest.pos_to_string(pos_under))
    minetest.record_protection_violation(pos_under, player_name)
    return itemstack
  end

  node_under.name = itemstack:get_name()
  minetest.set_node(pos_under, node_under)
  if not (creative and creative.is_enabled_for(player_name)) then
    itemstack:take_item()
  end

  return itemstack
end

mod:register_node("coral_green", {
  description = mod.S("Green Coral"),

  groups = {
    snappy = nokore.dig_class("stone"),
  },

  drawtype = "plantlike_rooted",
  waving = 1,
  paramtype = "light",
  tiles = {"world_coral_skeleton.png"},
  special_tiles = {{name = "world_coral_green.png", tileable_vertical = true}},
  inventory_image = "world_coral_green.png",
  selection_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
    },
  },
  node_dig_prediction = "nokore_world_coral:coral_skeleton",
  node_placement_prediction = "",
  sounds = nokore.node_sounds:build("coral", {
    sounds = {
      dig = {name = "default_dig_snappy", gain = 0.2},
      dug = {name = "default_grass_footstep", gain = 0.25},
    }
  }),

  on_place = coral_on_place,

  after_destruct  = function(pos, oldnode)
    minetest.set_node(pos, { name = "nokore_world_coral:coral_skeleton" })
  end,
})

mod:register_node("coral_pink", {
  description = mod.S("Pink Coral"),

  groups = {
    snappy = nokore.dig_class("stone"),
  },

  drawtype = "plantlike_rooted",
  waving = 1,
  paramtype = "light",
  tiles = {"world_coral_skeleton.png"},
  special_tiles = {{name = "world_coral_pink.png", tileable_vertical = true}},
  inventory_image = "world_coral_pink.png",
  selection_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
    },
  },
  node_dig_prediction = "nokore_world_coral:coral_skeleton",
  node_placement_prediction = "",
  sounds = nokore.node_sounds:build("coral", {
    sounds = {
      dig = {name = "default_dig_snappy", gain = 0.2},
      dug = {name = "default_grass_footstep", gain = 0.25},
    }
  }),

  on_place = coral_on_place,

  after_destruct  = function(pos, oldnode)
    minetest.set_node(pos, {name = "nokore_world_coral:coral_skeleton"})
  end,
})

mod:register_node("coral_cyan", {
  description = mod.S("Cyan Coral"),

  groups = {
    snappy = nokore.dig_class("stone"),
  },

  drawtype = "plantlike_rooted",
  waving = 1,
  paramtype = "light",
  tiles = {"world_coral_skeleton.png"},
  special_tiles = {{name = "world_coral_cyan.png", tileable_vertical = true}},
  inventory_image = "world_coral_cyan.png",
  selection_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
    },
  },
  node_dig_prediction = "nokore_world_coral:coral_skeleton",
  node_placement_prediction = "",
  sounds = nokore.node_sounds:build("coral", {
    sounds = {
      dig = {name = "default_dig_snappy", gain = 0.2},
      dug = {name = "default_grass_footstep", gain = 0.25},
    }
  }),

  on_place = coral_on_place,

  after_destruct  = function(pos, oldnode)
    minetest.set_node(pos, {name = "nokore_world_coral:coral_skeleton"})
  end,
})

mod:register_node("coral_brown", {
  description = mod.S("Brown Coral"),
  groups = {
    cracky = nokore.dig_class("stone"),
  },
  tiles = {
    "world_coral_brown.png"
  },
  drop = "nokore_world_coral:coral_skeleton",
  sounds = nokore.node_sounds:build("coral"),
})

mod:register_node("coral_orange", {
  description = mod.S("Orange Coral"),
  groups = {
    cracky = nokore.dig_class("stone"),
  },
  tiles = {
    "world_coral_orange.png",
  },
  drop = "nokore_world_coral:coral_skeleton",
  sounds = nokore.node_sounds:build("coral"),
})

mod:register_node("coral_skeleton", {
  description = mod.S("Coral Skeleton"),
  groups = {
    cracky = nokore.dig_class("stone"),
  },
  tiles = {
    "world_coral_skeleton.png",
  },
  sounds = nokore.node_sounds:build("coral"),
})
