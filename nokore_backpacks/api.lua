local fspec = assert(foundation.com.formspec.api)
local get_meta = assert(tetra.get_meta)

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
  local bpk_meta = get_meta(pos)
  local bpk_size = bpk_meta:get_inventory():set_size("main")

  local cio = fspec.calc_inventory_offset
  local cis = fspec.calc_inventory_size

  local padding = 0.5

  local cols = nokore_player_inv.player_hotbar_size
  local cw = cis(cols)
  local bpkh = cis(math.ceil(bpk_size / cols))
  local invh = cis(math.ceil(inv_size / cols))

  local fw = cw + padding * 2
  local fh = invh + bpkh + padding * 4

  local formspec =
    fspec.formspec_version(6)
    .. fspec.size(fw, fh)
    .. fspec.list(
      "nodemeta:"..spos,
      "main",
      padding,
      padding,
      cols,
      math.ceil(bpk_size / cols)
    )
    .. nokore_player_inv.player_inventory_lists_fragment(player, padding, bpkh + padding * 3)
    .. fspec.list_ring()

  return formspec
end
