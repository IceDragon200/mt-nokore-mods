local mod = nokore_glass

mod:register_node("glass", {
  description = mod.S("Glass"),

  groups = {
    cracky = 3,
    oddly_breakable_by_hand = 3,
  },

  tiles = {
    "glass.png",
  },

  sounds = nokore.node_sounds:build("glass"),
})

mod:register_node("glass_pane", {
  description = mod.S("Glass Pane"),

  groups = {
    cracky = 3,
    oddly_breakable_by_hand = 3,
  },

  tiles = {
    "glass_pane_top.png",
    "glass_pane_top.png",
    "glass.png",
  },

  drawtype = "nodebox",
  node_box = {
    type = "connected",
    fixed = {
      {-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}
    },
    connect_front = {
      {-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}
    },
    connect_left = {
      {-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}
    },
    connect_back = {
      {-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}
    },
    connect_right = {
      {1/32, -1/2, -1/32, 1/2, 1/2, 1/32}
    },
  },

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
      cracky = 3,
      oddly_breakable_by_hand = 3,
    },

    tiles = {
      "glass_" .. color .. ".png",
    },

    sounds = nokore.node_sounds:build("glass"),
  })

  mod:register_node("stained_glass_pane_" .. color, {
    description = mod.S(description .. " Glass"),

    groups = {
      cracky = 3,
      oddly_breakable_by_hand = 3,
    },

    tiles = {
      "glass_pane_top_" .. color .. ".png",
      "glass_pane_top_" .. color .. ".png",
      "glass_" .. color .. ".png",
    },

    sounds = nokore.node_sounds:build("glass"),
  })
end
