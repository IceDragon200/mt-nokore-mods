local mod = nokore_world_tree_jungle

mod:register_node("jungle_planks", {
  description = mod.S("Jungle Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    --
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_jungle.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})

if foundation.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes(mod:make_name("jungle_planks"), {
    -- base
    _ = {
      groups = {
        choppy = nokore.dig_class("wme"),
        plank = 1
      },
      tiles = "nokore_planks_jungle.png",
      sounds = nokore.node_sounds:build("wood"),
    },
    column = {
      description = mod.S("Jungle Planks Column"),
    },
    plate = {
      description = mod.S("Jungle Planks Plate"),
    },
    slab = {
      description = mod.S("Jungle Planks Slab"),
    },
    stair = {
      description = mod.S("Jungle Planks Stair"),
    },
    stair_inner = {
      description = mod.S("Jungle Planks Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Jungle Planks Stair Outer"),
    },
  })
end
