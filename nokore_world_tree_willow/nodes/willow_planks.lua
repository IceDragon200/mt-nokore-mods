local mod = nokore_world_tree_willow

mod:register_node("willow_planks", {
  description = mod.S("Willow Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    --
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_willow.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})

if foundation.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes(mod:make_name("willow_planks"), {
    -- base
    _ = {
      groups = {
        choppy = nokore.dig_class("wme"),
        plank = 1
      },
      tiles = "nokore_planks_willow.png",
      sounds = nokore.node_sounds:build("wood"),
    },
    column = {
      description = mod.S("Willow Planks Column"),
    },
    plate = {
      description = mod.S("Willow Planks Plate"),
    },
    slab = {
      description = mod.S("Willow Planks Slab"),
    },
    stair = {
      description = mod.S("Willow Planks Stair"),
    },
    stair_inner = {
      description = mod.S("Willow Planks Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Willow Planks Stair Outer"),
    },
  })
end
