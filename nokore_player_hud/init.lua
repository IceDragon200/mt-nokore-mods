--
-- Nokore Player Hud
--
local mod = foundation.new_module("nokore_player_hud", "0.1.0")

-- @type {player_name::String => {hud_item_name::String => ID}}
mod.hud_ids = {}

-- @type {name::String => HudDef}
mod.registered_elements = {}

function mod.register_hud_element(name, def)
  assert(not mod.registered_elements[name], "element already registered")

  mod.registered_elements[name] = def
end

-- @spec change_hud_element(PlayerRef, String, String, term) :: boolean
function mod.change_hud_element(player, hud_element_name, prop, value)
  local hud_element_id = mod.hud_ids[hud_element_name]
  if hud_element_id then
    player:hud_change(hud_element_id, prop, value)
    return true
  end
  return false
end

minetest.register_on_leaveplayer(function (player)
  mod.hud_ids[player:get_player_name()] = nil
end)

minetest.register_on_joinplayer(function (player)
  --player:hud_set_hotbar_image("gui_hotbar_base.png")
  --player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")

  minetest.hud_replace_builtin("health", {
    hud_elem_type = "statbar",
    position = {
      x = 0.5,
      y = 1,
    },
    text = "heart_full.png",
    text2 = "heart_empty.png",
    number = minetest.PLAYER_MAX_HP_DEFAULT,
    item = minetest.PLAYER_MAX_HP_DEFAULT,
    direction = 0,
    size = {x = 24, y = 24},
    offset = {
      x = (-10 * 24 - 24),
      -- -(hotbar_height + icon_height + bottom_padding + margin)
      y = -(48 + 24 + 16 + 8)
    },
  })

  minetest.hud_replace_builtin("breath", {
    hud_elem_type = "statbar",
    position = {
      x = 0.5,
      y = 1,
    },
    text = "breath_full.png",
    text2 = "breath_empty.png",
    number = minetest.PLAYER_MAX_BREATH_DEFAULT,
    item = minetest.PLAYER_MAX_BREATH_DEFAULT * 2,
    direction = 0,
    size = {x = 24, y = 24},
    offset = {
      x = 24,
      -- -(hotbar_height + icon_height + bottom_padding + margin)
      y = -(48 + 24 + 16 + 8)
    },
  })

  for name,def in pairs(mod.registered_elements) do
    local hud_element_id = player:hud_add(def)

    if not mod.hud_ids[player:get_player_name()] then
      mod.hud_ids[player:get_player_name()] = {}
    end
    mod.hud_ids[player:get_player_name()][name] = hud_element_id
  end
end)

mod.register_hud_element("armor", {
  hud_elem_type = "statbar",
  position = {
    x = 0.5,
    y = 1,
  },
  text = "armor_full.png",
  text2 = "armor_empty.png",
  number = 20,
  item = 20,
  direction = 0,
  size = {x = 24, y = 24},
  offset = {
    x = (-10 * 24 - 24),
    -- -(hotbar_height + icon_height + bottom_padding + margin + offset)
    y = -(48 + 24 + 16 + 8 + 32)
  },
})
