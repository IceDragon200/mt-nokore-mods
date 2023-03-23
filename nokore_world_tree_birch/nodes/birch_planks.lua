local mod = nokore_world_tree_birch

mod:register_node("birch_planks", {
  description = mod.S("Birch Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    --
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_birch.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})

if foundation.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes(mod:make_name("birch_planks"), {
    -- base
    _ = {
      groups = {
        choppy = nokore.dig_class("wme"),
        plank = 1
      },
      tiles = "nokore_planks_birch.png",
      sounds = nokore.node_sounds:build("wood"),
    },
    column = {
      description = mod.S("Birch Planks Column"),
    },
    plate = {
      description = mod.S("Birch Planks Plate"),
    },
    slab = {
      description = mod.S("Birch Planks Slab"),
    },
    stair = {
      description = mod.S("Birch Planks Stair"),
    },
    stair_inner = {
      description = mod.S("Birch Planks Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Birch Planks Stair Outer"),
    },
  })
end
