local mod = nokore_world_clay

mod:register_node("terracota", {
  description = mod.S("Terracota"),

  groups = {
    cracky = nokore.dig_class("copper"),
    terracota = 1,
  },

  tiles = {
    "world_terracota.png"
  },

  is_ground_content = true,

  sounds = nokore.node_sounds:build("terracota"),
})

mod.terracota_colors = {
  {"black", "Black"},
  {"blue", "Blue"},
  {"brown", "Brown"},
  {"cyan", "Cyan"},
  {"gray", "Gray"},
  {"green", "Green"},
  {"light_blue", "Light-Blue"},
  {"lime", "Lime"},
  {"magenta", "Magenta"},
  {"orange", "Orange"},
  {"pink", "Pink"},
  {"purple", "Purple"},
  {"red", "Red"},
  {"silver", "Silver"},
  {"white", "White"},
  {"yellow", "Yellow"},
}

for _,entry in ipairs(mod.terracota_colors) do
  mod:register_node("terracota_stained_" .. entry[1], {
    description = mod.S("Stained Terracota - " .. entry[2]),

    groups = {
      cracky = nokore.dig_class("copper"),
      stained_terracota = 1,
      terracota = 1,
    },

    tiles = {
      "world_terracota_stained_"..entry[1]..".png"
    },

    is_ground_content = true,

    sounds = nokore.node_sounds:build("terracota"),
  })
end
