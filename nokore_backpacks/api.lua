local fspec = assert(foundation.com.formspec.api)

--- @namespace nokore_backpacks
local mod = assert(nokore_backpacks)

--- @overridable
--- @spec get_backpack_inventory_size(pos: Vector3): Integer
function mod.get_backpack_inventory_size(pos)
  return nokore_player_inv.player_hotbar_size * 4
end

--- @overridable
--- @spec render_formspec(pos: Vector3, player: PlayerRef): String
function mod.render_formspec(pos, player)
  local spos = pos.x..","..pos.y..","..pos.z

  local inv = player:get_inventory()
  local inv_size = inv:get_size("main")
  local bpk_size = mod.get_backpack_inventory_size(pos)
  local cio = fspec.calc_inventory_offset
  local cis = fspec.calc_inventory_size

  local padding = 0.5

  local cols = nokore_player_inv.player_hotbar_size
  local cw = cis(cols)
  local bpkh = cis(math.floor(bpk_size / cols))
  local invh = cis(math.floor(inv_size / cols))

  local w = cw + padding * 2
  local h = invh + bpkh + padding * 4

  local formspec =
    fspec.formspec_version(6)
    .. fspec.size(w, h)
    .. fspec.list(
      "nodemeta:"..spos,
      "main",
      padding,
      padding,
      cols,
      math.ceil(bpk_size / cols)
    )
    .. nokore_player_inv.player_inventory_lists_fragment(player, padding, bpkh + padding * 3)
    .. fspec.listring()

  return formspec
end
