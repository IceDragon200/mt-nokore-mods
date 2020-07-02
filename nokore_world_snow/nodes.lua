dofile(nokore_world_snow.modpath .. "/nodes/snow.lua")
dofile(nokore_world_snow.modpath .. "/nodes/ice.lua")
if nokore.is_module_loaded("nokore_world_standard") then
  dofile(nokore_world_snow.modpath .. "/nodes/dirt_with_snow.lua")
end
