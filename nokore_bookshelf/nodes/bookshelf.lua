local mod = nokore_bookshelf

mod:register_node("bookshelf", {
  description = "Bookshelf",

  groups = {
    snappy = 2,
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
