local mod = nokore_world_tree_jungle

mod:register_node("jungle_leaves", {
  description = mod.S("Jungle Leaves"),

  groups = {
    snappy = nokore.dig_class("wme"),
    --
    leafdecay = 3,
    flammable = 2,
    leaves = 1,
  },

  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/20 chance
        items = {"nokore_world_tree_jungle:jungle_sapling"},
        rarity = 20,
      },
      {
        -- player will get leaves only if they get no saplings,
        -- this is because max_items is 1
        items = {"nokore_world_tree_jungle:jungle_leaves"},
      }
    }
  },

  drawtype = "allfaces_optional",
  waving = 1,
  tiles = {
    "nokore_leaves_jungle.png",
  },
  special_tiles = {
    "nokore_leaves_jungle.png",
  },

  paramtype = "light",
  is_ground_content = false,

  sounds = nokore.node_sounds:build("leaves"),

  after_place_node = after_place_leaves,
})
