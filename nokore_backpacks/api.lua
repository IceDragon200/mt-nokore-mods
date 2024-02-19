local fspec = assert(foundation.com.formspec.api)

--- @namespace nokore_backpacks
local mod = assert(nokore_backpacks)

--- @spec render_backpack_formspec(pos: Vector3, player: PlayerRef): String
function mod.render_backpack_formspec(pos, player)
  local spos = pos.x..","..pos.y..","..pos.z

  local formspec =
    fspec.formspec_version(6) ..
    fspec.size(13, 13) ..
    fspec.list("nodemeta:"..spos, "main", 0.375, 0.5, 10, 4) ..
    nokore_player_inv.player_inventory_lists_fragment(player, 0.375, 6) ..
    fspec.listring()

  return formspec
end
