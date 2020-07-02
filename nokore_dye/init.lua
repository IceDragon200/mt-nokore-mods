--
-- NoKore - Dye
--
local mod = nokore.new_module("nokore_dye", "0.1.0")

-- I have my reservations about using minetests game's dye colors...
-- I would honestly prefer a 16 color system
mod.colors = {
  { name = "white",      description = "White" },
  { name = "grey",       description = "Grey" },
  { name = "dark_grey",  description = "Dark Grey" },
  { name = "black",      description = "Black" },
  { name = "violet",     description = "Violet" },
  { name = "blue",       description = "Blue" },
  { name = "cyan",       description = "Cyan" },
  { name = "dark_green", description = "Dark Green" },
  { name = "green",      description = "Green" },
  { name = "yellow",     description = "Yellow" },
  { name = "brown",      description = "Brown" },
  { name = "orange",     description = "Orange" },
  { name = "red",        description = "Red" },
  { name = "magenta",    description = "Magenta" },
  { name = "pink",       description = "Pink" },
}

mod.mixtures = {
  -- RYB mixes
  { from = {"red", "blue"}, to = "violet" },
  { from = {"red", "yellow"}, to = "orange" },
  { from = {"blue", "yellow"}, to = "green" },
  -- RYB complementary mixes
  { from = {"yellow", "violet"}, to = "dark_grey" },
  { from = {"blue", "orange"}, to = "dark_grey" },
  -- CMY mixes - approximation
  { from = {"cyan", "yellow"}, to = "green" },
  { from = {"cyan", "magenta"}, to = "blue" },
  { from = {"yellow", "magenta"}, to = "red" },
  -- other mixes that result in a color we have
  { from = {"red", "green"}, to = "brown" },
  { from = {"magenta", "blue"}, to = "violet" },
  { from = {"green", "blue"}, to = "cyan" },
  { from = {"pink", "violet"}, to = "magenta" },
  -- mixes with black
  { from = {"white", "black"}, to = "grey" },
  { from = {"grey", "black"}, to = "dark_grey" },
  { from = {"green", "black"}, to = "dark_green" },
  { from = {"orange", "black"}, to = "brown" },
  -- mixes with white
  { from = {"white", "red"}, to = "pink" },
  { from = {"white", "dark_grey"}, to = "grey" },
  { from = {"white", "dark_green"}, to = "green" },
}

-- Just patch dye in for backwards compat
dye = rawget(_G, "dye") or {}

if not dye.dyes then
  dye.dyes = {}
  for _, color in ipairs(mod.colors) do
    table.insert(dye.dyes, {color.name, color.description})
  end
end

dofile(mod.modpath .. "/items/dye.lua")
dofile(mod.modpath .. "/items/recipes.lua")
