local mod = nokore_world_tree_spruce

mod:register_node("spruce_planks", {
  description = mod.S("Spruce Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    --
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_spruce.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})

if foundation.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes(mod:make_name("spruce_planks"), {
    -- base
    _ = {
      groups = {
        choppy = nokore.dig_class("wme"),
        plank = 1
      },
      tiles = "nokore_planks_spruce.png",
      sounds = nokore.node_sounds:build("wood"),
    },
    column = {
      description = mod.S("Spruce Planks Column"),
    },
    plate = {
      description = mod.S("Spruce Planks Plate"),
    },
    slab = {
      description = mod.S("Spruce Planks Slab"),
    },
    stair = {
      description = mod.S("Spruce Planks Stair"),
    },
    stair_inner = {
      description = mod.S("Spruce Planks Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Spruce Planks Stair Outer"),
    },
  })
end
