local mod = nokore_world_clay

mod:register_node("terracota", {
  description = mod.S("Terracota"),

  groups = {
    cracky = nokore.dig_class("copper"),
  },

  tiles = {
    "world_terracota.png"
  },

  is_ground_content = false,

  sounds = nokore.node_sounds:build("terracota"),
})

--mod:register_node("hardened_stained", {
--  description = mod.S("Hardened Stained Clay"),
--
--  groups = {cracky = 2},
--
--  tiles = {
--    "world_hardened_clay.png"
--  },
--
--  is_ground_content = false,
--
--  sounds = nokore.node_sounds:build("hardened_clay"),
--})
