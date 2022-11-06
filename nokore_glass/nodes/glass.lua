local mod = nokore_glass

mod:register_node("glass", {
  description = mod.S("Glass"),

  groups = {
    snappy = nokore.dig_class("wood"),
    cracky = nokore.dig_class("wood"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
    glass = 1,
  },

  is_ground_content = false,

  drawtype = "glasslike",
  tiles = {
    "glass.png",
  },
  use_texture_alpha = "blend",

  paramtype = "light",
  sunlight_propagates = true,

  sounds = nokore.node_sounds:build("glass"),
})

local glass_pane_nodebox = {
  type = "connected",
  fixed = {
    {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16}
  },
  connect_front = {
    {-1/16, -1/2, -1/2, 1/16, 1/2, -1/16}
  },
  connect_back = {
    {-1/16, -1/2, 1/16, 1/16, 1/2, 1/2}
  },
  connect_left = {
    {-1/2, -1/2, -1/16, -1/16, 1/2, 1/16}
  },
  connect_right = {
    {1/16, -1/2, -1/16, 1/2, 1/2, 1/16}
  },
}

local pane_connects_to = {
  "group:pane",
  "group:stone",
  "group:glass",
  "group:plank",
  "group:log",
  "group:wall"
}

mod:register_node("glass_pane", {
  description = mod.S("Glass Pane"),

  groups = {
    snappy = nokore.dig_class("wood"),
    cracky = nokore.dig_class("wood"),
    oddly_breakable_by_hand = nokore.dig_class("hand"),
    pane = 1,
    glass = 1,
  },

  is_ground_content = false,

  inventory_image = "glass.png",

  drawtype = "nodebox",
  node_box = table.copy(glass_pane_nodebox),
  tiles = {
    "glass_pane_top.png",
    "glass_pane_top.png",
    "glass.png",
  },
  use_texture_alpha = "blend",
  connects_to = table.copy(pane_connects_to),

  paramtype = "light",
  sunlight_propagates = true,

  sounds = nokore.node_sounds:build("glass"),
})

local colors = {
  {"white", "White"}
}

if rawget(_G, "dye") then
  colors = dye.dyes
end

for _, row in ipairs(colors) do
  local color = row[1]
  local description = row[2]

  mod:register_node("stained_glass_" .. color, {
    description = mod.S(description .. " Glass"),

    groups = {
      snappy = nokore.dig_class("wood"),
      cracky = nokore.dig_class("wood"),
      oddly_breakable_by_hand = nokore.dig_class("hand"),
      --
      glass = 1,
    },

    is_ground_content = false,

    drawtype = "glasslike",
    tiles = {
      "glass_" .. color .. ".png",
    },
    use_texture_alpha = "blend",

    paramtype = "light",
    sunlight_propagates = true,

    sounds = nokore.node_sounds:build("glass"),
  })

  mod:register_node("stained_glass_pane_" .. color, {
    description = mod.S(description .. " Glass Pane"),

    groups = {
      snappy = nokore.dig_class("wood"),
      cracky = nokore.dig_class("wood"),
      oddly_breakable_by_hand = nokore.dig_class("hand"),
      --
      pane = 1,
      glass = 1,
    },

    inventory_image = "glass_" .. color .. ".png",

    is_ground_content = false,

    drawtype = "nodebox",
    node_box = table.copy(glass_pane_nodebox),
    tiles = {
      "glass_pane_top_" .. color .. ".png",
      "glass_pane_top_" .. color .. ".png",
      "glass_" .. color .. ".png",
    },
    use_texture_alpha = "blend",
    connects_to = table.copy(pane_connects_to),

    paramtype = "light",
    sunlight_propagates = true,

    sounds = nokore.node_sounds:build("glass"),
  })
end
