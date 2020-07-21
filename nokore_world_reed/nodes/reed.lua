local mod = nokore_world_reed

mod:register_node("reed", {
  description = mod.S("Papyrus"),

  groups = {
    snappy = 3,
    flammable = 2,
  },

  drawtype = "plantlike",
  tiles = {"default_papyrus.png"},
  inventory_image = "default_papyrus.png",
  wield_image = "default_papyrus.png",

  selection_box = {
    type = "fixed",
    fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
  },

  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  sounds = nokore.node_sounds:build("reeds"),

  after_dig_node = function (pos, node, metadata, digger)
    --default.dig_up(pos, node, digger)
    -- TODO:
  end,
})
