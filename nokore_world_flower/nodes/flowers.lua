local mod = nokore_world_flower

mod:register_node("allium", {
  description = mod.S("Allium"),

  groups = {
    flower = 1,
    attached_node = 1,
  },

  dye_color = "purple", -- I think

  inventory_image = "world_flower_allium.png",

  drawtype = "plantlike",
  tiles = {
    "world_flower_allium.png",
  },

  sunlight_propagates = true,
  paramtype = "light",

  walkable = false,
  buildable_to = true,
})

mod:register_node("blue_orchid", {
  description = mod.S("Blue Orchid"),

  groups = {
    flower = 1,
    attached_node = 1,
  },

  dye_color = "blue",

  inventory_image = "world_flower_blue_orchid.png",

  drawtype = "plantlike",
  tiles = {
    "world_flower_blue_orchid.png",
  }
})

mod:register_node("dandelion", {
  description = mod.S("Dandelion"),

  groups = {
    flower = 1,
    attached_node = 1,
  },

  dye_color = "yellow",

  inventory_image = "world_flower_dandelion.png",

  drawtype = "plantlike",
  tiles = {
    "world_flower_dandelion.png",
  }
})

mod:register_node("houstonia", {
  description = mod.S("Houstonia"),

  groups = {
    flower = 1,
    attached_node = 1,
  },

  dye_color = "light_blue", -- I think?

  inventory_image = "world_flower_houstonia.png",

  drawtype = "plantlike",
  tiles = {
    "world_flower_houstonia.png",
  }
})

mod:register_node("oxeye_daisy", {
  description = mod.S("Oxeye Daisy"),

  groups = {
    flower = 1,
    attached_node = 1,
  },

  dye_color = "white",

  inventory_image = "world_flower_oxeye_daisy.png",

  drawtype = "plantlike",
  tiles = {
    "world_flower_oxeye_daisy.png",
  }
})

mod:register_node("rose", {
  description = mod.S("Rose"),

  groups = {
    flower = 1,
    attached_node = 1,
  },

  dye_color = "red",

  inventory_image = "world_flower_rose.png",

  drawtype = "plantlike",
  tiles = {
    "world_flower_rose.png",
  }
})

mod:register_node("tulip_orange", {
  description = mod.S("Orange Tulip"),

  groups = {
    flower = 1,
    attached_node = 1,
  },

  dye_color = "orange",

  inventory_image = "world_flower_tulip_orange.png",

  drawtype = "plantlike",
  tiles = {
    "world_flower_tulip_orange.png",
  }
})

mod:register_node("tulip_pink", {
  description = mod.S("Pink Tulip"),

  groups = {
    flower = 1,
    attached_node = 1,
  },

  dye_color = "pink",

  inventory_image = "world_flower_tulip_pink.png",

  drawtype = "plantlike",
  tiles = {
    "world_flower_tulip_pink.png",
  }
})

mod:register_node("tulip_red", {
  description = mod.S("Red Tulip"),

  groups = {
    flower = 1,
    attached_node = 1,
  },

  dye_color = "red",

  inventory_image = "world_flower_tulip_red.png",

  drawtype = "plantlike",
  tiles = {
    "world_flower_tulip_red.png",
  }
})

mod:register_node("tulip_white", {
  description = mod.S("White Tulip"),

  groups = {
    flower = 1,
    attached_node = 1,
  },

  dye_color = "white",

  inventory_image = "world_flower_tulip_white.png",

  drawtype = "plantlike",
  tiles = {
    "world_flower_tulip_white.png",
  }
})
