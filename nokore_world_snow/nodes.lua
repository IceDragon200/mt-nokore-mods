nokore_world_snow:require("nodes/snow.lua")
nokore_world_snow:require("nodes/ice.lua")
nokore_world_snow:require("nodes/permafrost.lua")
if foundation.is_module_present("nokore_world_standard") then
  nokore_world_snow:require("nodes/dirt_with_snow.lua")
end
