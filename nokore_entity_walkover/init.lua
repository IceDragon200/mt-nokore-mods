--
-- NoKore - Entity - Walkover
--
local mod = foundation.new_module("nokore_entity_walkover", "0.1.0")

local player_service = assert(nokore.player_service)
local Vector3 = assert(foundation.com.Vector3)

--
-- Triggered every interval while a player is standing still on a node, see STANDING_THRESHOLD for how long
-- they must remain still
--
-- @type OnStandingOnCallback: function(
--   pos: Vector3,
--   node: NodeRef,
--   player: PlayerRef,
--   dtime: Float
-- ) => void

--
-- Triggered once for every new position
--
-- @type OnWalkoverCallback: function(
--   pos: Vector3,
--   node: NodeRef,
--   player: PlayerRef
-- ) => void

-- A player must be standing still for this long before they are considered "standing" on a node
-- otherwise the walkover is triggered once
local STANDING_THRESHOLD = 2

-- How far must a player move before they are considered to have actually "moved" from their initial
-- position?
local MINIMUM_DISTANCE = 0.0625

local STEP = 0.1

mod.elapsed = 0

mod.on_player_walkover_cbs = {}

mod.on_player_standing_on_cbs = {}

-- @spec.private update_players(
--   players: Table<String, PlayerRef>,
--   dtime: Float,
--   player_assigns: Table<String, Table>
-- ): void
local function update_players(players, dtime, player_assigns)
  mod.elapsed = mod.elapsed + dtime

  if mod.elapsed > STEP then
    local elapsed = mod.elapsed
    mod.elapsed = 0

    local assigns
    local pos
    local dist
    local walkover_pos
    local node
    local nodedef

    for player_name,player in pairs(players) do
      assigns = player_assigns[player_name]

      pos = player:get_pos()

      if assigns.last_pos then
        dist = Vector3.distance(assigns.last_pos, pos)
        -- the magic number is 1/16
        if dist > MINIMUM_DISTANCE then
          assigns.last_moved_since = 0
        else
          assigns.last_moved_since = (assigns.last_moved_since or 0) + elapsed
        end
      end

      walkover_pos = Vector3.copy(pos)
      walkover_pos.y = walkover_pos.y - MINIMUM_DISTANCE
      walkover_pos = Vector3.floor(walkover_pos, walkover_pos)

      if assigns.last_moved_since then
        if assigns.last_moved_since <= 0 then
          -- the player has just moved
          node = minetest.get_node_or_nil(walkover_pos)

          if node then
            nodedef = minetest.registered_nodes[node.name]

            if nodedef.on_player_walkover then
              nodedef.on_player_walkover(walkover_pos, node, player)
            end

            for _, cb in pairs(mod.on_player_walkover_cbs) do
              cb(walkover_pos, node, player)
            end
          end
        elseif assigns.last_moved_since >= STANDING_THRESHOLD then
          node = minetest.get_node_or_nil(walkover_pos)

          if node then
            nodedef = minetest.registered_nodes[node.name]

            if nodedef.on_player_standing_on then
              nodedef.on_player_standing_on(walkover_pos, node, player, assigns.last_moved_since)
            end

            for _, cb in pairs(mod.on_player_standing_on_cbs) do
              cb(walkover_pos, node, player, assigns.last_moved_since)
            end
          end
        end
      end

      assigns.last_pos = pos
    end
  end
end

-- @spec &on_player_walkover(name: String, callback: OnWalkoverCallback): void
function mod:on_player_walkover(name, callback)
  self.on_player_walkover_cbs[name] = callback
end

-- @spec &on_player_standing_on(name: String, callback: OnStandingOnCallback): void
function mod:on_player_standing_on(name, callback)
  self.on_player_standing_on_cbs[name] = callback
end

player_service:register_update("nokore_entity_walkover:update_players", update_players)
