local mod = nokore_world_clay

-- boring clay block
mod:register_node("block", {
  description = mod.S("Clay"),

  groups = {
    crumbly = nokore.dig_class("wme"),
    clay = 1,
  },

  tiles = {
    "world_clay.png"
  },

  drop = "default:clay_lump 4",
  is_ground_content = true,
  sounds = nokore.node_sounds:build("clay"),
})
