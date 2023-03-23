local mod = nokore_world_tree_fir

mod:register_node("fir_planks", {
  description = mod.S("Fir Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    --
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_fir.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})

if foundation.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes(mod:make_name("fir_planks"), {
    -- base
    _ = {
      groups = {
        choppy = nokore.dig_class("wme"),
        plank = 1
      },
      tiles = "nokore_planks_fir.png",
      sounds = nokore.node_sounds:build("wood"),
    },
    column = {
      description = mod.S("Fir Planks Column"),
    },
    plate = {
      description = mod.S("Fir Planks Plate"),
    },
    slab = {
      description = mod.S("Fir Planks Slab"),
    },
    stair = {
      description = mod.S("Fir Planks Stair"),
    },
    stair_inner = {
      description = mod.S("Fir Planks Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Fir Planks Stair Outer"),
    },
  })
end
