local mod = assert(nokore_world_snow)

local function on_construct(pos)
  pos.y = pos.y - 1
  if minetest.get_node(pos).name == "nokore_world_standard:dirt_with_grass" then
    minetest.set_node(pos, {name = "nokore_world_snow:dirt_with_snow"})
  end
end

local snow_name = mod:make_name("snow")
local snow_slab_name = mod:make_name("snow_slab")
local snow_tall_slab_name = mod:make_name("snow_tall_slab")
local snow_block_name = mod:make_name("snow_block")

-- Snow Composites, i.e. if you add snow to snow, you get more snow
local SNOW_COMPOSITES = {
  -- A+B = C
  [snow_name] = {
    [snow_name] = snow_slab_name,
    [snow_slab_name] = snow_tall_slab_name,
    [snow_tall_slab_name] = snow_block_name,
  },
  [snow_slab_name] = {
    [snow_name] = snow_tall_slab_name,
    [snow_slab_name] = snow_block_name,
  },
  [snow_tall_slab_name] = {
    [snow_name] = snow_block_name,
  }
}

local function before_replace_node(pos, old_node, new_node, _placer, _item_stack, _pointed_thing)
  local targets = SNOW_COMPOSITES[old_node.name]
  if targets then
    local target = targets[new_node.name]

    if target then
      -- So if the new node is a snow, it means we are attempting to stack it
      -- Since snow by default is the 1/4 tile, we now turn this into a 1/2 tile
      minetest.add_node(pos, {
        name = target,
        param1 = new_node.param1,
        param2 = new_node.param2,
      })

      -- do not replace the node, since we've already done so here
      return false
    end
  end

  return true
end

mod:register_node("snow", {
  description = mod.S("Snow"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
    falling_node = 1,
    snowy = 1,
  },

  use_texture_alpha = "opaque",
  tiles = {
    "world_snow.png",
  },

  inventory_image = "world_snowball.png",
  wield_image = "world_snowball.png",

  paramtype = "light",
  buildable_to = true,
  floodable = true,
  drawtype = "nodebox",

  node_box = {
    type = "fixed",
    fixed = {
      {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
    },
  },
  collision_box = {
    type = "fixed",
    fixed = {
      {-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
    },
  },
  sounds = nokore.node_sounds:build("snow"),

  on_construct = on_construct,
  before_replace_node = before_replace_node,
})

mod:register_node("snow_slab", {
  description = mod.S("Snow Slab"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
    falling_node = 1,
    snowy = 1,
  },

  use_texture_alpha = "opaque",
  tiles = {
    "world_snow.png",
  },

  -- inventory_image = "world_snowball.png",
  -- wield_image = "world_snowball.png",

  paramtype = "light",
  buildable_to = true,
  floodable = true,
  drawtype = "nodebox",

  node_box = {
    type = "fixed",
    fixed = {
      {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
    },
  },
  collision_box = {
    type = "fixed",
    fixed = {
      {-0.5, -0.5, -0.5, 0.5, -3 / 16, 0.5},
    },
  },
  sounds = nokore.node_sounds:build("snow"),

  on_construct = on_construct,
  before_replace_node = before_replace_node,
})

--
-- 3/4 Block basically
--
mod:register_node("snow_tall_slab", {
  description = mod.S("Snow Tall Slab"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
    falling_node = 1,
    snowy = 1,
  },

  use_texture_alpha = "opaque",
  tiles = {
    "world_snow.png",
  },

  -- inventory_image = "world_snowball.png",
  -- wield_image = "world_snowball.png",

  paramtype = "light",
  buildable_to = true,
  floodable = true,
  drawtype = "nodebox",

  node_box = {
    type = "fixed",
    fixed = {
      {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
    },
  },
  collision_box = {
    type = "fixed",
    fixed = {
      {-0.5, -0.5, -0.5, 0.5, 6 / 16, 0.5},
    },
  },
  sounds = nokore.node_sounds:build("snow"),

  on_construct = on_construct,
  before_replace_node = before_replace_node,
})

mod:register_node("snow_block", {
  description = mod.S("Snow Block"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
    cools_lava = 1,
    snowy = 1,
  },

  use_texture_alpha = "opaque",
  tiles = {
    "world_snow.png",
  },
  sounds = nokore.node_sounds:build("snow"),

  on_construct = on_construct,
})
