local mod = nokore_world_tree_acacia

mod:register_node("acacia_planks", {
  description = mod.S("Acacia Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_acacia.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})

if foundation.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes(mod:make_name("acacia_planks"), {
    -- base
    _ = {
      groups = {
        choppy = nokore.dig_class("wme"),
        plank = 1
      },
      tiles = "nokore_planks_acacia.png",
      sounds = nokore.node_sounds:build("wood"),
    },
    column = {
      description = mod.S("Acacia Planks Column"),
    },
    plate = {
      description = mod.S("Acacia Planks Plate"),
    },
    slab = {
      description = mod.S("Acacia Planks Slab"),
    },
    stair = {
      description = mod.S("Acacia Planks Stair"),
    },
    stair_inner = {
      description = mod.S("Acacia Planks Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Acacia Planks Stair Outer"),
    },
  })
end
