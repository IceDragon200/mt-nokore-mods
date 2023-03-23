local mod = nokore_world_tree_sakura

mod:register_node("sakura_planks", {
  description = mod.S("Sakura Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    --
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_sakura.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})

if foundation.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes(mod:make_name("sakura_planks"), {
    -- base
    _ = {
      groups = {
        choppy = nokore.dig_class("wme"),
        plank = 1
      },
      tiles = "nokore_planks_sakura.png",
      sounds = nokore.node_sounds:build("wood"),
    },
    column = {
      description = mod.S("Sakura Planks Column"),
    },
    plate = {
      description = mod.S("Sakura Planks Plate"),
    },
    slab = {
      description = mod.S("Sakura Planks Slab"),
    },
    stair = {
      description = mod.S("Sakura Planks Stair"),
    },
    stair_inner = {
      description = mod.S("Sakura Planks Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Sakura Planks Stair Outer"),
    },
  })
end
