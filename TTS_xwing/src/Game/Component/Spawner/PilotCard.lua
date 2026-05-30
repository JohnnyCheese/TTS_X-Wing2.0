dial = nil
ship = nil
dial_guid = nil
ship_guid = nil
current_state = "healthy"
points_tracker_visible = true
points_tracker_landscape = false
cached_ship_name = nil
cached_ship_points = 0
cached_ship_half_points = 0
cached_owning_player = nil
loaded = false
ui_initialized = false
ui_face_down = false

local STATE_HEALTHY = "healthy"
local STATE_DAMAGED = "damaged"
local STATE_DESTROYED = "destroyed"
local GAME_CONSOLE_GUID = "c9a2a0"

local panel_colors = {
  total = {
    healthy = "#FFFFFFFF",
    damaged = "#FFB6C1FF",
    destroyed = "#FF0000FF",
  },
  half = {
    healthy = "#FFFFFFFF",
    damaged = "#FF0000FF",
    destroyed = "#FF0000FF",
  },
  remaining = {
    healthy = "#FFFFFFFF",
    damaged = "#FFFFFFFF",
    destroyed = "#FF0000FF",
  }
}

local points_tracker_xml = [=[
<Defaults>
    <Button class="PointsTile" colors="#FFFFFFFF|#FFFFFFFF|#FFFFFFFF|#FFFFFFFF" color="#FFFFFFFF" outline="#00000055" outlineSize="2 2" textColor="#00000000" fontStyle="Bold" />
    <Text class="PointsValue" color="#111111FF" fontStyle="Bold" alignment="MiddleCenter" raycastTarget="false" />
</Defaults>

<Panel id="PointsRoot" width="320" height="190" position="0 250 0" rotation="0 0 180" color="#00000000" allowDragging="false" raycastTarget="false">
    <Button id="TotalPanel" class="PointsTile" width="154" height="78" offsetXY="0 46" color="#FFFFFFFF" text="0" fontSize="66" textColor="#111111FF" alignment="MiddleCenter" onClick="CyclePointsState" />

    <Panel id="BottomRow" width="260" height="78" offsetXY="0 -38" color="#00000000" raycastTarget="false">
        <Button id="HalfPanel" class="PointsTile" width="108" height="78" offsetXY="-58 0" color="#FFFFFFFF" onClick="CyclePointsState">
            <Text id="HalfPoints" class="PointsValue" text="0" width="108" height="78" offsetXY="0 0" fontSize="64" color="#111111FF" alignment="MiddleCenter" raycastTarget="false" />
        </Button>

        <Button id="RemainingPanel" class="PointsTile" width="108" height="78" offsetXY="58 0" color="#FFFFFFFF" onClick="CyclePointsState">
            <Text id="RemainingPoints" class="PointsValue" text="0" width="108" height="78" offsetXY="0 0" fontSize="64" color="#111111FF" alignment="MiddleCenter" raycastTarget="false" />
        </Button>
    </Panel>
</Panel>
]=]

local function getPointsTrackerAspectScale()
  local aspect_scale = 1
  if points_tracker_landscape then
    aspect_scale = 2.1
  end
  if aspect_scale < 0.8 then
    aspect_scale = 0.8
  elseif aspect_scale > 2.0 then
    aspect_scale = 2.0
  end
  return aspect_scale
end

local function applyPointsTrackerScale()
  if not loaded or not ui_initialized then
    return
  end

  local aspect_scale = getPointsTrackerAspectScale()
  pcall(function()
    self.UI.setAttribute("PointsRoot", "scale", string.format("%.3f 1.000", 1 / aspect_scale))
  end)
end

local function updatePointsLayout()
  if not loaded or not ui_initialized then
    return
  end

  local face_down = self.is_face_down == true
  if ui_face_down == face_down then
    return
  end

  ui_face_down = face_down
  if face_down then
    self.UI.setAttribute("PointsRoot", "rotation", "0 180 180")
  else
    self.UI.setAttribute("PointsRoot", "rotation", "0 0 180")
  end
end

local function resolveLinkedObjects()
  if dial == nil and dial_guid ~= nil then
    dial = getObjectFromGUID(dial_guid)
  end
  if ship == nil and ship_guid ~= nil then
    ship = getObjectFromGUID(ship_guid)
  end
end

local function initializeShipTrackerData()
  if cached_ship_name ~= nil then
    return true
  end

  resolveLinkedObjects()
  if ship == nil then
    return false
  end

  local data = ship.getTable("Data") or {}
  local points = data.points or 0
  cached_ship_name = data.name or ship.getName() or self.getName()
  cached_ship_points = points
  cached_ship_half_points = data.half_points or math.floor(points / 2)
  cached_owning_player = ship.getVar("owningPlayer")
  return true
end

local function getShipPointData()
  if initializeShipTrackerData() then
    local remaining_points = math.max((cached_ship_points or 0) - (cached_ship_half_points or 0), 0)
    log({
      card = self.getName(),
      ship_guid = ship_guid,
      data_name = cached_ship_name,
      data_points = cached_ship_points,
      data_half_points = cached_ship_half_points,
      resolved_points = cached_ship_points,
      resolved_half_points = cached_ship_half_points,
      resolved_remaining_points = remaining_points,
      using_cached_data = true,
    }, "Pilot card points")
    return cached_ship_points or 0, cached_ship_half_points or 0, remaining_points
  end

  log("Pilot card points: no linked ship or cached data", self.getName())
  return nil
end

local function refreshPointsUI()
  if not loaded or not ui_initialized then
    return
  end

  applyPointsTrackerScale()
  updatePointsLayout()
  self.UI.setAttribute("PointsRoot", "active", points_tracker_visible and "true" or "false")
  if not points_tracker_visible then
    return
  end

  local points, half_points, remaining_points = getShipPointData()
  if points == nil then
    return
  end
  self.UI.setAttribute("TotalPanel", "text", tostring(points))
  self.UI.setAttribute("HalfPoints", "text", tostring(half_points))
  self.UI.setAttribute("RemainingPoints", "text", tostring(remaining_points))
  self.UI.setAttribute("TotalPanel", "color", panel_colors.total[current_state] or panel_colors.total[STATE_HEALTHY])
  self.UI.setAttribute("HalfPanel", "color", panel_colors.half[current_state] or panel_colors.half[STATE_HEALTHY])
  self.UI.setAttribute("RemainingPanel", "color",
    panel_colors.remaining[current_state] or panel_colors.remaining[STATE_HEALTHY])
end

local function refreshPointsUIWhenReady(attempts_left)
  if attempts_left == nil then
    attempts_left = 10
  end

  if not loaded or not ui_initialized then
    if attempts_left > 0 then
      Wait.frames(function()
        refreshPointsUIWhenReady(attempts_left - 1)
      end, 1)
    end
    return
  end

  refreshPointsUI()
end

local function schedulePointsUIRefreshes()
  local refresh_frames = { 1, 5, 15, 30 }
  for _, frame_count in ipairs(refresh_frames) do
    Wait.frames(function()
      refreshPointsUIWhenReady()
    end, frame_count)
  end
end

local getPlayerLabel
local getShipLabel

local function normalizePlayerColor(playerRef)
  if playerRef == nil then
    return nil
  end
  if type(playerRef) == "string" then
    return playerRef
  end

  local ok, color_value = pcall(function()
    return playerRef.color
  end)
  if ok then
    return color_value
  end

  return nil
end

local function getOwningPlayerColor()
  resolveLinkedObjects()
  if ship ~= nil then
    cached_owning_player = ship.getVar("owningPlayer")
  elseif cached_owning_player == nil then
    initializeShipTrackerData()
  end
  return cached_owning_player
end

local function canModifyPointsState(playerColor)
  local owning_player = getOwningPlayerColor()
  if playerColor == "Black" then
    return true
  end
  if owning_player == nil or owning_player == "" then
    return false
  end
  return playerColor == owning_player
end

local function notifyUnauthorizedPointsChange(playerColor)
  local owning_player = getOwningPlayerColor()
  local actor = getPlayerLabel(playerColor)
  local ship_name = getShipLabel()
  local message
  if owning_player == nil or owning_player == "" then
    message = actor .. " cannot change " .. ship_name .. " points because it has no owner."
  else
    message = actor .. " cannot change " .. ship_name .. " points. Controlled by " .. owning_player .. "."
  end
  if playerColor ~= nil and Player[playerColor] ~= nil then
    printToColor(message, playerColor, { 1, 0.2, 0.2 })
  else
    printToAll(message, { 1, 0.2, 0.2 })
  end
end

local function rebuildPointsContextMenu()
  if not loaded then
    return
  end

  self.clearContextMenu()

  if points_tracker_visible then
    if current_state ~= STATE_HEALTHY then
      self.addContextMenuItem("Set to Healthy", function(playerColor)
        MarkHealthy(playerColor)
      end, false)
    end
    if current_state ~= STATE_DAMAGED then
      self.addContextMenuItem("Set to Damaged", function(playerColor)
        MarkDamaged(playerColor)
      end, false)
    end
    if current_state ~= STATE_DESTROYED then
      self.addContextMenuItem("Set to Destroyed", function(playerColor)
        MarkDestroyed(playerColor)
      end, false)
    end
    self.addContextMenuItem("Disable Points", function()
      HidePointsTracker()
    end, false)
  else
    self.addContextMenuItem("Enable Points", function()
      ShowPointsTracker()
    end, false)
  end
end

getPlayerLabel = function(playerColor)
  playerColor = normalizePlayerColor(playerColor)
  if playerColor ~= nil and Player[playerColor] ~= nil then
    return Player[playerColor].steam_name or playerColor
  end
  return "A player"
end

getShipLabel = function()
  if initializeShipTrackerData() then
    return cached_ship_name
  end
  return self.getName()
end

local function getConcededPointsForState(state)
  local points, half_points = getShipPointData()
  if points == nil then
    return 0
  end

  if state == STATE_HEALTHY then
    return 0
  elseif state == STATE_DAMAGED then
    return half_points
  elseif state == STATE_DESTROYED then
    return points
  end

  return 0
end

local function announcePointsStateChange(from_state, new_state, playerColor)
  local state_labels = {
    healthy = "Healthy",
    damaged = "Damaged",
    destroyed = "Destroyed",
  }
  local actor = getPlayerLabel(playerColor)
  local ship_name = getShipLabel()
  local from_label = state_labels[from_state] or from_state
  local state_label = state_labels[new_state] or new_state
  local delta = getConcededPointsForState(new_state) - getConcededPointsForState(from_state)
  local delta_label = string.format("%+d", delta)
  printToAll(actor .. " changed " .. ship_name .. " points from " .. from_label .. " to " .. state_label ..
    " (" .. delta_label .. " points)", { 1, 1, 1 })
end

local function updateGameConsoleConcededPoints(from_state, new_state, playerColor)
  local delta = getConcededPointsForState(new_state) - getConcededPointsForState(from_state)
  if delta == 0 then
    return
  end

  local owning_player = getOwningPlayerColor() or playerColor
  if owning_player == nil then
    return
  end

  local game_console = getObjectFromGUID(GAME_CONSOLE_GUID)
  if game_console == nil then
    return
  end

  pcall(function()
    game_console.call("AddConcededShipPoints", {
      playerColor = owning_player,
      delta = delta,
      ship = getShipLabel(),
      from_state = from_state,
      to_state = new_state,
    })
  end)
end

local function setPointsState(new_state, playerColor)
  playerColor = normalizePlayerColor(playerColor)
  local owning_player = getOwningPlayerColor()
  if current_state == new_state then
    return
  end

  if playerColor ~= nil and not canModifyPointsState(playerColor) then
    notifyUnauthorizedPointsChange(playerColor)
    return
  end

  local previous_state = current_state
  current_state = new_state
  refreshPointsUI()
  rebuildPointsContextMenu()
  updateGameConsoleConcededPoints(previous_state, new_state, playerColor)
  announcePointsStateChange(previous_state, new_state, playerColor)
end

function HandlePointsNumberTyped(params)
  if not points_tracker_visible then
    return
  end

  local number = params
  local playerColor = nil
  if type(params) == "table" then
    number = params.number
    playerColor = normalizePlayerColor(params.playerColor)
  end

  if number == 1 then
    MarkHealthy(playerColor)
  elseif number == 2 then
    MarkDamaged(playerColor)
  elseif number == 3 then
    MarkDestroyed(playerColor)
  end
end

function MarkHealthy(playerColor)
  setPointsState(STATE_HEALTHY, playerColor)
end

function MarkDamaged(playerColor)
  setPointsState(STATE_DAMAGED, playerColor)
end

function MarkDestroyed(playerColor)
  setPointsState(STATE_DESTROYED, playerColor)
end

function CyclePointsState(player, value, id)
  if not points_tracker_visible then
    return
  end

  local playerColor = normalizePlayerColor(player)

  if current_state == STATE_HEALTHY then
    MarkDamaged(playerColor)
  elseif current_state == STATE_DAMAGED then
    MarkDestroyed(playerColor)
  else
    MarkHealthy(playerColor)
  end
end

function ShowPointsTracker()
  points_tracker_visible = true
  refreshPointsUI()
  rebuildPointsContextMenu()
end

function HidePointsTracker()
  points_tracker_visible = false
  refreshPointsUI()
  rebuildPointsContextMenu()
end

function addTintObject(params)
    if params[1] == "ship" then
      ship = params[2]
      ship_guid = ship and ship.getGUID() or nil
      initializeShipTrackerData()
      schedulePointsUIRefreshes()
    elseif params[1] == "dial" then
      dial = params[2]
      dial_guid = dial and dial.getGUID() or nil
    end
end

function configurePointsTracker(params)
  refreshPointsUIWhenReady()
end

function DisableAttachedColliders()
  for i, child in ipairs(self.getChildren()) do
    if i ~= 1 then
      if child.getComponent("MeshCollider") then
        child.getComponent("MeshCollider").set("enabled", false)
      end
    end
  end
end

function pilotCardUpdate()
    resolveLinkedObjects()
    updatePointsLayout()
    local tint = self.getColorTint()
    if tint ~= color(1,1,1,1) then
      self.setColorTint(color(1,1,1,1))
      if dial ~= nil then
        dial.setColorTint(tint)
      end

      for i, attachment in pairs(self.getAttachments()) do
        id = self.removeAttachment(attachment.index)
        id.setColorTint(tint)
        self.addAttachment(id)
      end

      if ship ~= nil then
        local data = ship.getTable("Data")
        data.ColorId = tint
        ship.setTable("Data", data)
        for i, attachment in pairs(ship.getAttachments()) do
          id = ship.removeAttachment(0) -- This process puts the front attachment in the back, and the index is rearranged
          if id.getName():find("Arc Indicator") then
            local indicator = ship.getTable('arc_indicators')[id.getDescription()] or {}
            if indicator.color_by_id then
              id.setColorTint(tint)
            end
          elseif id.getName() == "ColorId" then
            id.setColorTint(tint)
          end
          ship.addAttachment(id)
        end
      end
      Wait.frames(DisableAttachedColliders, 1)

    end
end

function onLoad(savestate)
  if savestate ~= nil and savestate ~= "" then
    local decoded = JSON.decode(savestate)
    if decoded then
      current_state = decoded.current_state or STATE_HEALTHY
      ship_guid = decoded.ship_guid
      dial_guid = decoded.dial_guid
      cached_ship_name = decoded.cached_ship_name
      cached_ship_points = decoded.cached_ship_points or 0
      cached_ship_half_points = decoded.cached_ship_half_points or math.floor((cached_ship_points or 0) / 2)
      cached_owning_player = decoded.cached_owning_player
      if decoded.points_tracker_visible ~= nil then
        points_tracker_visible = decoded.points_tracker_visible
      end
    end
  end

  local tracker_config = self.getTable("PointsTrackerConfig") or {}
  if tracker_config.visible ~= nil then
    points_tracker_visible = tracker_config.visible == true
  end
  local ok, layout_visible = pcall(function()
    return Global.call("ShouldShowShipPointsTrackerForCurrentLayout")
  end)
  if ok and layout_visible ~= nil then
    points_tracker_visible = layout_visible == true
  end
  points_tracker_landscape = tracker_config.landscape == true
  resolveLinkedObjects()
  initializeShipTrackerData()
  self.max_typed_number = 3
  loaded = true
  rebuildPointsContextMenu()
  Wait.frames(function()
    if self == nil then
      return
    end
    local ok = pcall(function()
      self.UI.setXml(points_tracker_xml)
    end)
    if ok then
      ui_initialized = true
      ui_face_down = not (self.is_face_down == true)
      Wait.frames(function()
        applyPointsTrackerScale()
      end, 1)
      schedulePointsUIRefreshes()
    end
  end, 1)
  Wait.time(pilotCardUpdate, 0.5, -1)
end

function onNumberTyped(playerColor, number)
  HandlePointsNumberTyped({ number = number, playerColor = playerColor })
end

function onSave()
  initializeShipTrackerData()
  return JSON.encode({
    current_state = current_state,
    ship_guid = ship_guid,
    dial_guid = dial_guid,
    points_tracker_visible = points_tracker_visible,
    cached_ship_name = cached_ship_name,
    cached_ship_points = cached_ship_points,
    cached_ship_half_points = cached_ship_half_points,
    cached_owning_player = cached_owning_player,
  })
end

function isLoadedAndStill()
  return loaded and self.resting
end
