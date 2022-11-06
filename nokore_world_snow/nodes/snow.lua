local mod = nokore_world_snow

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

  on_construct = function(pos)
    pos.y = pos.y - 1
    if minetest.get_node(pos).name == "nokore_world_standard:dirt_with_grass" then
      minetest.set_node(pos, {name = "nokore_world_snow:dirt_with_snow"})
    end
  end,
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

  on_construct = function(pos)
    pos.y = pos.y - 1
    if minetest.get_node(pos).name == "nokore_world_standard:dirt_with_grass" then
      minetest.set_node(pos, {name = "nokore_world_snow:dirt_with_snow"})
    end
  end,
})
