local mod = nokore_bookshelf

mod:register_node("bookshelf", {
  description = "Bookshelf",

  groups = {
    snappy = nokore.dig_class("wme"),
  },

  tiles = {
    "nokore_bookshelf_top.png",
    "nokore_bookshelf_top.png",
    "nokore_bookshelf_top.png",
    "nokore_bookshelf_top.png",
    "nokore_bookshelf_top.png",
    "nokore_bookshelf.png",
  },

  paramtype2 = "facedir",
})
