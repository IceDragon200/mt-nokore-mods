--
-- NoKore - Tool / Copper
--
-- Adds copper tools
local mod = foundation.new_module("nokore_tool_copper", "0.1.0")

mod:register_tool("pick", {
  description = mod.S("Copper Pickaxe"),
  inventory_image = "nokore_tool_copper_pickaxe.png",
  tool_capabilities = {
    full_punch_interval = 1.0,
    max_drop_level=1,
    groupcaps={
      cracky = {times={[1]=4.50, [2]=1.80, [3]=0.90}, uses=20, maxlevel=2},
    },
    damage_groups = {fleshy=4},
  },
  sound = {breaks = "default_tool_breaks"},
  groups = {pickaxe = 1}
})

mod:register_tool("shovel", {
  description = mod.S("Copper Shovel"),

  inventory_image = "nokore_tool_copper_shovel.png",

  wield_image = "default_tool_copper_shovel.png^[transformR90",

  tool_capabilities = {
    full_punch_interval = 1.4,
    max_drop_level=0,
    groupcaps={
      crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},
    },
    damage_groups = {fleshy=2},
  },

  sound = {breaks = "default_tool_breaks"},
  groups = {shovel = 1}
})

mod:register_tool("axe", {
  description = mod.S("Copper Axe"),

  inventory_image = "nokore_tool_copper_axe.png",

  tool_capabilities = {
    full_punch_interval = 1.2,
    max_drop_level=0,
    groupcaps={
      choppy={times={[1]=3.00, [2]=2.00, [3]=1.30}, uses=20, maxlevel=1},
    },
    damage_groups = {fleshy=3},
  },

  sound = {breaks = "default_tool_breaks"},
  groups = {axe = 1}
})

mod:register_tool("hoe", {
  description = mod.S("Copper Hoe"),

  inventory_image = "nokore_tool_copper_hoe.png",

  tool_capabilities = {
    full_punch_interval = 1.2,
    max_drop_level=0,
    groupcaps={
      choppy={times={[1]=3.00, [2]=2.00, [3]=1.30}, uses=20, maxlevel=1},
    },
    damage_groups = {fleshy=3},
  },

  sound = {breaks = "default_tool_breaks"},
  groups = {axe = 1}
})
