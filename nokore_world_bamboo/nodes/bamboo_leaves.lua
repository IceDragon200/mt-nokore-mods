local mod = nokore_world_bamboo

mod:register_node("bamboo_leaves", {
  description = mod.S("Bamboo Leaves"),

  groups = {
    snippy = nokore.dig_class("wme"),
    --
    leafdecay = 3,
    flammable = 2,
    leaves = 1,
  },

  drop = {
    max_items = 1,
    items = {
      {
        -- player will get leaves only if they get no saplings,
        -- this is because max_items is 1
        items = {"nokore_world_tree_bamboo:bamboo_leaves"},
      }
    }
  },

  drawtype = "allfaces_optional",
  waving = 1,

  use_texture_alpha = "blend",
  tiles = {
    "nokore_leaves_bamboo.png",
  },
  special_tiles = {
    "nokore_leaves_bamboo.png",
  },

  paramtype = "light",
  is_ground_content = false,

  sounds = nokore.node_sounds:build("bamboo_leaves"),

  after_place_node = after_place_leaves,
})
