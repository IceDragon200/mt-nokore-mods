local mod = nokore_world_tree_big_oak

mod:register_node("big_oak_planks", {
  description = mod.S("Big Oak Planks"),

  groups = {
    choppy = nokore.dig_class("wme"),
    --
    flammable = 2,
    plank = 1
  },

  tiles = {
    "nokore_planks_big_oak.png",
  },

  paramtype2 = "facedir",
  place_param2 = 0,

  is_ground_content = false,

  sounds = nokore.node_sounds:build("wood"),
})

if foundation.is_module_present("nokore_stairs") then
  nokore_stairs.build_and_register_nodes(mod:make_name("big_oak_planks"), {
    -- base
    _ = {
      groups = {
        choppy = nokore.dig_class("wme"),
        plank = 1
      },
      tiles = "nokore_planks_big_oak.png",
      sounds = nokore.node_sounds:build("wood"),
    },
    column = {
      description = mod.S("Big Oak Planks Column"),
    },
    plate = {
      description = mod.S("Big Oak Planks Plate"),
    },
    slab = {
      description = mod.S("Big Oak Planks Slab"),
    },
    stair = {
      description = mod.S("Big Oak Planks Stair"),
    },
    stair_inner = {
      description = mod.S("Big Oak Planks Stair Inner"),
    },
    stair_outer = {
      description = mod.S("Big Oak Planks Stair Outer"),
    },
  })
end
