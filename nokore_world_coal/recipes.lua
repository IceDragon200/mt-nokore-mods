local mod = nokore_world_coal

minetest.register_craft{
  type = "fuel",
  recipe = mod:make_name("coal_lump"),
  burntime = 30,
}
