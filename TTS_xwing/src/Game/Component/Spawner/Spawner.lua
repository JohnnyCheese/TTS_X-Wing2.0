local Dim = require("Dim")
local ShipVerification = require("Ship.ShipVerification")
local Vect = require("TTS_Lib.Vector.Vector")

local Spawner = {}

local function RotMatrix(axis, angDeg)
    local ang = math.rad(angDeg)
    local cs = math.cos
    local sn = math.sin

    if axis == 'x' then
        return {
            { 1, 0,       0 },
            { 0, cs(ang), -1 * sn(ang) },
            { 0, sn(ang), cs(ang) }
        }
    elseif axis == 'y' then
        return {
            { cs(ang),      0, sn(ang) },
            { 0,            1, 0 },
            { -1 * sn(ang), 0, cs(ang) }
        }
    elseif axis == 'z' then
        return {
            { cs(ang), -1 * sn(ang), 0 },
            { sn(ang), cs(ang),      0 },
            { 0,       0,            1 }
        }
    end
end

local function RotateVector(rotMat, vect)
    local out = { 0, 0, 0 }
    for i = 1, 3, 1 do
        for j = 1, 3, 1 do
            out[i] = out[i] + rotMat[i][j] * vect[j]
        end
    end
    return out
end

local function LocalPos(object, position)
    local rot = object.getRotation()
    local lPos = { position[1], position[2], position[3] }
    -- Z-X-Y extrinsic
    local zRot = RotMatrix('z', rot.z)
    lPos = RotateVector(zRot, lPos)
    local xRot = RotMatrix('x', rot.x)
    lPos = RotateVector(xRot, lPos)
    local yRot = RotMatrix('y', rot.y)
    lPos = RotateVector(yRot, lPos)

    return Vect.Sum(lPos, object.getPosition())
end

-- TODO: this is used by DataPad with Ship Spawning
local pilotCardScript =
[[
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
  initializeShipTrackerData()
  return cached_owning_player
end

local function canModifyPointsState(playerColor)
  local owning_player = getOwningPlayerColor()
  if owning_player == nil or owning_player == "" or owning_player == "Black" then
    return true
  end
  return playerColor == owning_player
end

local function notifyUnauthorizedPointsChange(playerColor)
  local owning_player = getOwningPlayerColor() or "the controlling player"
  local actor = getPlayerLabel(playerColor)
  local ship_name = getShipLabel()
  local message = actor .. " cannot change " .. ship_name .. " points. Controlled by " .. owning_player .. "."
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

  log({
    card = self.getName(),
    playerColor = playerColor,
    number = number,
  }, "Pilot card HandlePointsNumberTyped")

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
  log({
    card = self.getName(),
    playerColor = playerColor,
    number = number,
  }, "Pilot card onNumberTyped")
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
]]


-- Decker module

local Decker = {}

do

    -- provide unique ID starting from 20 for present decks
    local nextID = nil
    do
        local _nextID = 20
        nextID = function()
            _nextID = _nextID + 1
            return tostring(_nextID)
        end
    end

    -- Asset signature (equality comparison)
    local function assetSignature(assetData)
        return table.concat({
            assetData.FaceURL,
            assetData.BackURL,
            assetData.NumWidth,
            assetData.NumHeight,
            assetData.BackIsHidden and 'hb' or '',
            assetData.UniqueBack and 'ub' or ''
        })
    end
    -- Asset ID storage to avoid new ones for identical assets
    local idLookup = {}
    local function assetID(assetData)
        local sig = assetSignature(assetData)
        local key = idLookup[sig]
        if not key then
            key = nextID()
            idLookup[sig] = key
        end
        return key
    end

    local assetMeta = {
        deck = function(self, cardNum, options)
            return Decker.AssetDeck(self, cardNum, options)
        end
    }
    assetMeta = { __index = assetMeta }

    -- Create a new CustomDeck asset
    function Decker.Asset(face, back, options)
        local asset = {}
        options = options or {}
        asset.data = {
            FaceURL = face or error('Decker.Asset: faceImg link required'),
            BackURL = back or error('Decker.Asset: backImg link required'),
            NumWidth = options.width or 1,
            NumHeight = options.height or 1,
            BackIsHidden = options.hiddenBack or false,
            UniqueBack = options.uniqueBack or false
        }
        -- Reuse ID if asset existing
        asset.id = assetID(asset.data)
        return setmetatable(asset, assetMeta)
    end

    function Decker.AssetFromData(assetData)
        return setmetatable({ data = assetData, id = assetID(assetData) }, assetMeta)
    end

    -- Create a base for JSON objects
    function Decker.BaseObject()
        return {
            Name = 'Base',
            Transform = {
                posX = 0,
                posY = 5,
                posZ = 0,
                rotX = 0,
                rotY = 0,
                rotZ = 0,
                scaleX = 1,
                scaleY = 1,
                scaleZ = 1
            },
            Nickname = '',
            Description = '',
            ColorDiffuse = { r = 1, g = 1, b = 1 },
            Locked = false,
            Grid = true,
            Snap = true,
            Autoraise = true,
            Sticky = true,
            Tooltip = true,
            GridProjection = false,
            Hands = false,
            XmlUI = '',
            LuaScript = '',
            LuaScriptState = '',
            GUID = 'deadbf'
        }
    end

    -- Apply some basic parameters on base JSON object
    function Decker.SetCommonOptions(obj, options)
        options = options or {}
        obj.Nickname = options.name or ''
        obj.Description = options.desc or ''
        obj.LuaScript = options.script or ''
        obj.XmlUI = options.xmlui or ''
        obj.LuaScriptState = options.scriptState or ''
        obj.Locked = options.locked or false
        obj.Tooltip = options.tooltip or true
        obj.GUID = options.guid or 'deadbf'
    end

    -- default spawnObjectJSON params since it doesn't like blank fields
    local function defaultParams(params, json)
        params = params or {}
        params.json = json
        params.position = params.position or { 0, 5, 0 }
        params.rotation = params.rotation or { 0, 0, 0 }
        params.scale = params.scale or { 1, 1, 1 }
        if params.sound == nil then
            params.sound = true
        end
        return params
    end

    -- For copy method
    local deepcopy = nil
    deepcopy = function(t)
        local copy = {}
        for k, v in pairs(t) do
            if type(v) == 'table' then
                copy[k] = deepcopy(v)
            else
                copy[k] = v
            end
        end
        return copy
    end
    -- meta for all Decker derived objects
    local commonMeta = {
        -- return object JSON string, used cached if present
        _cache = function(self)
            if not self.json then
                self.json = JSON.encode(self.data)
            end
            return self.json
        end,
        -- invalidate JSON string cache
        _recache = function(self)
            self.json = nil
            return self
        end,
        spawn = function(self, params)
            params = defaultParams(params, self:_cache())
            return spawnObjectJSON(params)
        end,
        copy = function(self)
            return setmetatable(deepcopy(self), getmetatable(self))
        end,
        setCommon = function(self, options)
            Decker.SetCommonOptions(self.data, options)
            return self
        end,
    }
    -- apply common part on a specific metatable
    local function customMeta(mt)
        for k, v in pairs(commonMeta) do
            mt[k] = v
        end
        mt.__index = mt
        return mt
    end

    -- DeckerCard metatable
    local cardMeta = {
        setAsset = function(self, asset)
            local cardIndex = self.data.CardID:sub(-2, -1)
            self.data.CardID = asset.id .. cardIndex
            self.data.CustomDeck = { [asset.id] = asset.data }
            return self:_recache()
        end,
        getAsset = function(self)
            local deckID = next(self.data.CustomDeck)
            return Decker.AssetFromData(self.data.CustomDeck[deckID])
        end,
        -- reset deck ID to a consistent value script-wise
        _recheckDeckID = function(self)
            local oldID = next(self.data.CustomDeck)
            local correctID = assetID(self.data.CustomDeck[oldID])
            if oldID ~= correctID then
                local cardIndex = self.data.CardID:sub(-2, -1)
                self.data.CardID = correctID .. cardIndex
                self.data.CustomDeck[correctID] = self.data.CustomDeck[oldID]
                self.data.CustomDeck[oldID] = nil
            end
            return self
        end
    }
    cardMeta = customMeta(cardMeta)
    -- Create a DeckerCard from an asset
    function Decker.Card(asset, row, col, options)
        options = options or {}
        local card = Decker.BaseObject()
        card.Name = 'Card'
        -- optional custom fields
        Decker.SetCommonOptions(card, options)
        if options.sideways ~= nil then
            card.SidewaysCard = options.sideways
        end
        -- CardID string is parent deck ID concat with its 0-based index (always two digits)
        local num = (row - 1) * asset.data.NumWidth + col - 1
        num = string.format('%02d', num)
        card.CardID = asset.id .. num
        -- just the parent asset reference needed
        card.CustomDeck = { [asset.id] = asset.data }

        local obj = setmetatable({ data = card }, cardMeta)
        obj:_cache()
        return obj
    end

    -- DeckerDeck meta
    local deckMeta = {
        count = function(self)
            return #self.data.DeckIDs
        end,
        -- Transform index into positive
        index = function(self, ind)
            if ind < 0 then
                return self:count() + ind + 1
            else
                return ind
            end
        end,
        swap = function(self, i1, i2)
            local ri1, ri2 = self:index(i1), self:index(i2)
            assert(ri1 > 0 and ri1 <= self:count(), 'DeckObj.rearrange: index ' .. i1 .. ' out of bounds')
            assert(ri2 > 0 and ri2 <= self:count(), 'DeckObj.rearrange: index ' .. i2 .. ' out of bounds')
            self.data.DeckIDs[ri1], self.data.DeckIDs[ri2] = self.data.DeckIDs[ri2], self.data.DeckIDs[ri1]
            local co = self.data.ContainedObjects
            co[ri1], co[ri2] = co[ri2], co[ri1]
            return self:_recache()
        end,
        -- rebuild self.data.CustomDeck based on contained cards
        _rescanDeckIDs = function(self, id)
            local cardIDs = {}
            for k, card in ipairs(self.data.ContainedObjects) do
                local cardID = next(card.CustomDeck)
                if not cardIDs[cardID] then
                    cardIDs[cardID] = card.CustomDeck[cardID]
                end
            end
            --[[
            for id,data in pairs(cardIDs) do
                self.data.CustomDeck[id] = data
            end
            for id,data in pairs(self.data.CustomDeck) do
                if not cardIDs[id] then
                    self.data.CustomDeck[id] = nil
                end
            end
            ]]
            --
            -- eeh, GC gotta earn its keep as well
            self.data.CustomDeck = cardIDs
        end,
        remove = function(self, ind, skipRescan)
            local rind = self:index(ind)
            assert(rind > 0 and rind <= self:count(), 'DeckObj.remove: index ' .. ind .. ' out of bounds')
            local card = self.data.ContainedObjects[rind]
            table.remove(self.data.DeckIDs, rind)
            table.remove(self.data.ContainedObjects, rind)
            if not skipRescan then
                self:_rescanDeckIDs(next(card.CustomDeck))
            end
            return self:_recache()
        end,
        removeMany = function(self, ...)
            local indices = { ... }
            table.sort(indices, function(e1, e2)
                return self:index(e1) > self:index(e2)
            end)
            for _, ind in ipairs(indices) do
                self:remove(ind, true)
            end
            self:_rescanDeckIDs()
            return self:_recache()
        end,
        insert = function(self, card, ind)
            local rind = self:index(ind)
            assert(rind > 0 and rind <= (self:count() + 1), 'DeckObj.insert: index ' .. ind .. ' out of bounds')
            table.insert(self.data.DeckIDs, rind, card.data.CardID)
            table.insert(self.data.ContainedObjects, rind, card.data)
            local id = next(card.data.CustomDeck)
            if not self.data.CustomDeck[id] then
                self.data.CustomDeck[id] = card.data.CustomDeck[id]
            end
            return self:_recache()
        end,
        reverse = function(self)
            local s, e = 1, self:count()
            while s < e do
                self:swap(s, e)
                s = s + 1
                e = e - 1
            end
            return self:_recache()
        end,
        cardAt = function(self, ind)
            local rind = self:index(ind)
            assert(rind > 0 and rind <= (self:count() + 1), 'DeckObj.insert: index ' .. ind .. ' out of bounds')
            local card = setmetatable({ data = deepcopy(self.data.ContainedObjects[rind]) }, cardMeta)
            card:_cache()
            return card
        end,
        switchAssets = function(self, replaceTable)
            -- destructure replace table into
            -- [ID_to_replace] -> [ID_to_replace_with]
            -- [new_asset_ID] -> [new_asset_data]
            local idReplace = {}
            local assets = {}
            for oldAsset, newAsset in pairs(replaceTable) do
                assets[newAsset.id] = newAsset.data
                idReplace[oldAsset.id] = newAsset.id
            end
            -- update deckIDs
            for k, cardID in ipairs(self.data.DeckIDs) do
                local deckID, cardInd = cardID:sub(1, -3), cardID:sub(-2, -1)
                if idReplace[deckID] then
                    self.data.DeckIDs[k] = idReplace[deckID] .. cardInd
                end
            end
            -- update CustomDeck data - nil replaced
            for replacedID in pairs(idReplace) do
                if self.data.CustomDeck[replacedID] then
                    self.data.CustomDeck[replacedID] = nil
                end
            end
            -- update CustomDeck data - add replacing
            for _, replacingID in pairs(idReplace) do
                self.data.CustomDeck[replacingID] = assets[replacingID]
            end
            -- update card data
            for k, cardData in ipairs(self.data.ContainedObjects) do
                local deckID = next(cardData.CustomDeck)
                if idReplace[deckID] then
                    cardData.CustomDeck[deckID] = nil
                    cardData.CustomDeck[idReplace[deckID]] = assets[idReplace[deckID]]
                end
            end
            return self:_recache()
        end,
        getAssets = function(self)
            local assets = {}
            for id, assetData in pairs(self.data.CustomDeck) do
                assets[#assets + 1] = Decker.AssetFromData(assetData)
            end
            return assets
        end
    }
    deckMeta = customMeta(deckMeta)
    -- Create DeckerDeck object from DeckerCards
    function Decker.Deck(cards, options)
        local deck = Decker.BaseObject()
        deck.Name = 'Deck'
        Decker.SetCommonOptions(deck, options)
        deck.DeckIDs = {}
        deck.CustomDeck = {}
        deck.ContainedObjects = {}
        for _, card in ipairs(cards) do
            deck.DeckIDs[#deck.DeckIDs + 1] = card.data.CardID
            local id = next(card.data.CustomDeck)
            if not deck.CustomDeck[id] then
                deck.CustomDeck[id] = card.data.CustomDeck[id]
            end
            deck.ContainedObjects[#deck.ContainedObjects + 1] = card.data
        end

        local obj = setmetatable({ data = deck }, deckMeta)
        obj:_cache()
        return obj
    end

    -- Create DeckerDeck from an asset using X cards on its sheet
    function Decker.AssetDeck(asset, cardNum, options)
        cardNum = cardNum or asset.data.NumWidth * asset.data.NumHeight
        local row, col, width = 1, 1, asset.data.NumWidth
        local cards = {}
        for k = 1, cardNum do
            cards[#cards + 1] = Decker.Card(asset, row, col)
            col = col + 1
            if col > width then
                row, col = row + 1, 1
            end
        end
        return Decker.Deck(cards, options)
    end
end

--spawner function, checks for Pilots and Upgrades lists and spawn the respective objects

local legacyFactionKeys = {
    [0] = "dummy",
    [1] = "rebelalliance",
    [2] = "galacticempire",
    [3] = "scumandvillainy",
    [4] = "resistance",
    [5] = "firstorder",
    [6] = "galacticrepublic",
    [7] = "separatistalliance",
    Dum = "dummy",
    Reb = "rebelalliance",
    Imp = "galacticempire",
    Scu = "scumandvillainy",
    Res = "resistance",
    For = "firstorder",
    Rep = "galacticrepublic",
    Cis = "separatistalliance",
}

local function normalizeLegacySpawnerList(listTable)
    if listTable == nil then
        return
    end

    listTable.Faction = legacyFactionKeys[listTable.Faction] or listTable.Faction
    for _, pilot in pairs(listTable.Pilots or {}) do
        if pilot.Data ~= nil then
            pilot.Data.Faction = legacyFactionKeys[pilot.Data.Faction] or pilot.Data.Faction
        end
    end
end

local function initializeSpawnerAccessoryContext(context, spawnCard, bagPosition)
    context.bag = getObjectFromGUID(bagGuids['Accessories']).clone({ position = bagPosition })
    context.tokens = {}
    context.accessories = context.bag.getObjects()

    for _, accessory in ipairs(context.accessories) do
        if accessory.name == 'Charge' or accessory.name == 'Force' or accessory.name == 'Shield' or
            accessory.name == 'Energy' then
            context.tokens[accessory.name] = context.bag.takeObject({
                rotation = spawnCard.getRotation(),
                guid = accessory.guid,
                smooth = false
            })
        end
    end

end

local function destroySpawnerAccessoryContext(context)
    if context == nil then
        return
    end
    if context.bag ~= nil then
        context.bag.destruct()
    end
    for _, token in pairs(context.tokens or {}) do
        token.destruct()
    end
end

local function cloneSpawnerToken(template, position, ownerVar, owner, tokenName)
    local token = template.clone()
    token.setPosition(position)
    token.setVar(ownerVar, owner)
    if tokenName ~= nil then
        token.setVar("charge_name", tokenName)
    end
    return token
end

local function spawnPilotResourceTokens(pilot, spawnCard, tokens, hasMobileUpgrade)
    -- Spawn pilot and standardized-loadout charge tokens.
    if pilot.Charge > 0 or pilot.standardized_loadout then
        local chargeValue = pilot.Charge
        while chargeValue > 0 do
            chargeValue = chargeValue - 1
            local position
            if pilot.standardized_loadout then
                position = LocalPos(spawnCard, { 0.5 + 0.9 * chargeValue, 1, 3.4 })
                if chargeValue > 2 then
                    position = LocalPos(spawnCard, { 0.5 + 0.9 * (chargeValue - 3), 1, 2.5 })
                end
            elseif chargeValue == 3 then
                position = LocalPos(spawnCard, { -0.9, 1, 0.6 })
            elseif chargeValue == 2 then
                position = LocalPos(spawnCard, { 0.9, 1, 1.6 })
            elseif chargeValue == 1 then
                position = LocalPos(spawnCard, { 0, 1, 1.6 })
            elseif chargeValue == 0 then
                position = LocalPos(spawnCard, { -0.9, 1, 1.6 })
            else
                position = vector(0, 0, 0)
            end
            cloneSpawnerToken(tokens.Charge, position, "charge_owner", pilot.name)
        end

        if pilot.standardized_loadout and pilot.standardized_upgrades then
            local totalHeight = 3.0
            local step = totalHeight / #pilot.standardized_upgrades
            for index, upgrade in pairs(pilot.standardized_upgrades) do
                if upgrade.charge > 0 then
                    for chargeIndex = 1, upgrade.charge, 1 do
                        local token = cloneSpawnerToken(
                            tokens.Charge,
                            LocalPos(spawnCard, { -2.7 - chargeIndex * 0.6, 1, 4 + step * (index - 1) + step / 2 }),
                            "charge_owner",
                            pilot.name,
                            upgrade.name
                        )
                        token.setScale(token.getScale() * 0.75)
                    end
                end
            end
        end
    end

    if pilot.Force > 0 then
        local forceValue = pilot.Force
        while forceValue > 0 do
            forceValue = forceValue - 1
            local position
            if pilot.standardized_loadout then
                position = LocalPos(spawnCard, { 3.2, 1, 4.5 + 0.9 * forceValue })
            elseif hasMobileUpgrade == 1 then
                position = LocalPos(spawnCard, { 1.7 + 0.9 * forceValue, 1, 3.4 })
                if forceValue > 2 then
                    position = LocalPos(spawnCard, { 1.7 + 0.9 * (forceValue - 3), 1, 2.5 })
                end
            else
                position = LocalPos(spawnCard, { 1.7, 1, 3.7 + 0.9 * forceValue })
            end
            cloneSpawnerToken(tokens.Force, position, "force_owner", pilot.name)
        end
    end

    if pilot.Energy > 0 then
        local energyValue = pilot.Energy
        while energyValue > 0 do
            energyValue = energyValue - 1
            local position
            if pilot.standardized_loadout then
                position = LocalPos(spawnCard, { 0.5 + 0.9 * energyValue, 1, 3.4 })
                if energyValue > 2 then
                    position = LocalPos(spawnCard, { 0.5 + 0.9 * (energyValue - 3), 1, 2.5 })
                end
            else
                position = LocalPos(spawnCard, { 1.7, 1, 3.7 + 0.9 * energyValue })
            end
            cloneSpawnerToken(tokens.Energy, position, "energy_owner", pilot.name)
        end
    end

    if pilot.Shield > 0 then
        local shieldValue = pilot.Shield
        while shieldValue > 0 do
            shieldValue = shieldValue - 1
            local position
            if pilot.standardized_loadout then
                position = LocalPos(spawnCard, { -2.2 + 0.9 * shieldValue, 1, 3.4 })
                if shieldValue > 5 then
                    position = LocalPos(spawnCard, { -2.2 + 0.9 * (shieldValue - 6), 1, 1.6 })
                elseif shieldValue > 2 then
                    position = LocalPos(spawnCard, { -2.2 + 0.9 * (shieldValue - 3), 1, 2.5 })
                end
            else
                position = LocalPos(spawnCard, { -1 + 0.9 * shieldValue, 1, 3.4 })
                if shieldValue > 5 then
                    position = LocalPos(spawnCard, { -1 + 0.9 * (shieldValue - 6), 1, 1.6 })
                elseif shieldValue > 2 then
                    position = LocalPos(spawnCard, { -1 + 0.9 * (shieldValue - 3), 1, 2.5 })
                end
            end
            cloneSpawnerToken(tokens.Shield, position, "shield_owner", pilot.name)
        end
    end
end

local function cloneSpawnerAccessories(accessoryContext, accessoryName, position, rotation)
    local clones = {}
    for _, accessory in pairs(accessoryContext.accessories) do
        if accessory.name == accessoryName then
            local source = accessoryContext.bag.takeObject({
                position = position,
                rotation = rotation,
                guid = accessory.guid,
                smooth = false
            })
            local clone = source.clone()
            clone.setPosition(position)
            accessoryContext.bag.putObject(source)
            table.insert(clones, clone)
        end
    end
    return clones
end

local function spawnPilotAccessories(pilot, spawnCard, accessoryContext, faction, rotation, arcPosition)
    for mount, turret in pairs(pilot.Data.arcs.turret or {}) do
        local indicatorName = 'Arc Indicator' .. tostring(faction)
        if turret.type[1] == 'doubleturret' then
            indicatorName = 'Dual Arc Indicator' .. tostring(faction)
        end
        local mountingPoint = pilot.Data.mountingPoints[mount]
        local offset = LocalPos(spawnCard, { mountingPoint[1], 0, mountingPoint[2] + 9 })
        for _, indicator in ipairs(cloneSpawnerAccessories(accessoryContext, indicatorName, offset, rotation)) do
            indicator.setPosition(arcPosition)
            indicator.setName(string.gsub(indicator.getName(), faction, ''))
        end
    end

    local markerPosition = LocalPos(spawnCard, { -1.5, 1, 8.7 })
    if pilot.Bomb == true then
        for _, bombDrop in ipairs(cloneSpawnerAccessories(accessoryContext, 'Bomb drop token (unassigned)',
            markerPosition, rotation)) do
            bombDrop.setDescription(pilot.bombD)
        end
    end
    if pilot.Docking == true then
        cloneSpawnerAccessories(accessoryContext, 'Shuttle Launcher (assigned to mothership)', markerPosition,
            rotation)
    end
    if pilot.wingleader == true then
        cloneSpawnerAccessories(accessoryContext, 'Epic Wing Token', markerPosition, rotation)
    end
end

local function spawnSpawnerRemotes(remotes, spawnCard, accessoryContext)
    for _, remote in pairs(remotes or {}) do
        local remoteName = type(remote) == 'table' and remote.name or remote
        local remoteCharge = type(remote) == 'table' and (remote.Charge or 0) or 0
        print("Spawning remote:" .. remoteName)
        for _, accessory in ipairs(accessoryContext.accessories) do
            if accessory.name == remoteName then
                local position = LocalPos(spawnCard, { 1, 1, 0 })
                print("Found remote, spawning pos: " .. tostring(position[1]) .. "," ..
                    tostring(position[2]) .. "," .. tostring(position[3]))
                local remoteObject = accessoryContext.bag.takeObject({
                    rotation = spawnCard.getRotation(),
                    guid = accessory.guid,
                    smooth = false
                })
                local remoteClone = remoteObject.clone()
                remoteClone.setPosition(position)
                accessoryContext.bag.putObject(remoteObject)

                local charge = remoteCharge
                while charge > 0 do
                    local chargePosition
                    if charge == 2 then
                        chargePosition = LocalPos(spawnCard, { 1.45, 1, -2.2 })
                    elseif charge == 1 then
                        chargePosition = LocalPos(spawnCard, { 0.55, 1, -2.2 })
                    end
                    charge = charge - 1
                    cloneSpawnerToken(accessoryContext.tokens.Charge, chargePosition, "charge_owner", remoteName,
                        remoteName)
                end

                spawnCard.setPosition(LocalPos(spawnCard, { -3, 0, 0 }))
                break
            end
        end
    end
end

local function spawnSpawnerObstacles(obstacles, spawnCard, bagPosition)
    if obstacles == nil then
        return
    end

    local obstacleBag = getObjectFromGUID(bagGuids['Obstacles']).clone({ position = bagPosition })
    local success, spawnError = pcall(function()
        local availableObstacles = obstacleBag.getObjects()
        for _, obstacleName in ipairs(obstacles) do
            local found = false
            for _, obstacle in ipairs(availableObstacles) do
                if obstacle.name == obstacleName then
                    print("Found obstacle: " .. obstacle.name .. " - " .. obstacleName)
                    local position = LocalPos(spawnCard, { 0, 1, 0 })
                    local obstacleToken = obstacleBag.takeObject({
                        rotation = spawnCard.getRotation(),
                        guid = obstacle.guid,
                        smooth = false
                    })
                    local obstacleClone = obstacleToken.clone()
                    obstacleClone.setPosition(position)
                    obstacleBag.putObject(obstacleToken)
                    found = true
                    break
                end
            end
            if not found then
                print("Couldnt find obstacle: " .. obstacleName)
            else
                spawnCard.setPosition(LocalPos(spawnCard, { -4, 0, 0 }))
            end
        end
    end)
    obstacleBag.destruct()

    if not success then
        error(spawnError)
    end
end

function Spawner.newSpawner(listTable)
    normalizeLegacySpawnerList(listTable)
    --listTable contains :

    --Pilots[x] = table

    --Upgrades[x] = {string1, string2...}
    --spawnCard = Object reference used to position the spawned material
    --Faction = String

    local Pilots = listTable.Pilots
    local Upgrades = listTable.Upgrades
    local spawnCard = listTable.spawnCard
    local Faction = listTable.Faction
    local Customization = listTable.Customization or {}
    local dialSkin = listTable.factionDial
    local spawnPrefix =
    "{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/"
    local factionnames = {
        rebelalliance = "rebel",
        galacticempire = "empire",
        scumandvillainy = "scum",
        resistance = "resistance",
        firstorder = "first-order",
        galacticrepublic = "republic",
        separatistalliance = "separatists"
    }

    local bagPosition = { 15, 15, 0 }
    local storePos = spawnCard.getPosition()
    local storeRot = spawnCard.getRotation()
    local accessoryContext = { tokens = {} }

    local spawnSuccess, spawnError = pcall(function()
        initializeSpawnerAccessoryContext(accessoryContext, spawnCard, bagPosition)
        local tempBagAcc = accessoryContext.bag
        local listaAcc = accessoryContext.accessories
        local tokens = accessoryContext.tokens

        local UPGRADE_STEP_X = 1.78
        local UPGRADE_STEP_Y = 0.2
        local UPGRADE_EXTENDED_WIDTH_TUCK = 0.6
        local UPGRADE_EXTENDED_WIDTH_STEP = UPGRADE_STEP_X + UPGRADE_EXTENDED_WIDTH_TUCK
        local CONFIG_CARD_ANCHOR_X = 1.42
        local CONFIG_CARD_SHIFT_X = -1.9

        local function isExtendedWidthUpgrade(upgrade)
            return upgrade.extended_width == true
        end

        local function extendedWidthOffset(upgrade, direction)
            if isExtendedWidthUpgrade(upgrade) then
                return UPGRADE_EXTENDED_WIDTH_TUCK * direction
            end
            return 0
        end

        local function upgradeCardLayout(cursor, upgrade)
            local widthOffset = extendedWidthOffset(upgrade, -1)
            local layout = {
                x = cursor.x + widthOffset,
                y = cursor.y,
                z = cursor.z,
            }
            if isExtendedWidthUpgrade(upgrade) then
                cursor.x = cursor.x - UPGRADE_EXTENDED_WIDTH_STEP
            else
                cursor.x = cursor.x - UPGRADE_STEP_X
            end
            cursor.y = cursor.y - UPGRADE_STEP_Y
            return layout
        end

        local function configCardLayout(upgrade)
            local layout = {
                x = CONFIG_CARD_ANCHOR_X + extendedWidthOffset(upgrade, 1),
                y = 0,
                z = 5.5,
            }
            return layout
        end

        local function localLayoutPos(layout, dx, dy, dz)
            return LocalPos(spawnCard, {
                layout.x + (dx or 0),
                layout.y + (dy or 0),
                layout.z + (dz or 0),
            })
        end

        local function spawnUpgradeCharges(upgrade, pilot, layout, isConfiguration)
            local charges = upgrade.Charge
            while charges > 0 do
                local position
                if isConfiguration then
                    if charges == 5 then
                        position = localLayoutPos(layout, 0.88, 0, -3.6)
                    elseif charges == 4 then
                        position = localLayoutPos(layout, 0.88, 0, -2.7)
                    elseif charges == 3 then
                        position = localLayoutPos(layout, -0.02, 0, -2.7)
                    elseif charges == 2 then
                        position = localLayoutPos(layout, 0.88, 0, -1.8)
                    elseif charges == 1 then
                        position = localLayoutPos(layout, -0.02, 0, -1.8)
                    end
                else
                    if charges == 5 then
                        position = localLayoutPos(layout, -0.28, 1 - layout.y, -3.6)
                    elseif charges == 4 then
                        position = localLayoutPos(layout, -0.28, 1 - layout.y, -2.7)
                    elseif charges == 3 then
                        position = localLayoutPos(layout, -1.18, 1 - layout.y, -2.7)
                    elseif charges == 2 then
                        position = localLayoutPos(layout, -0.28, 1 - layout.y, -1.8)
                    elseif charges == 1 then
                        position = localLayoutPos(layout, -1.18, 1 - layout.y, -1.8)
                    end
                end
                if position == nil then
                    break
                end
                charges = charges - 1
                cloneSpawnerToken(tokens.Charge, position, "charge_owner", pilot.name, upgrade.name)
            end
        end

        local function spawnAssignableAccessories(accessoryName, position)
            for _, accessory in ipairs(listaAcc) do
                if accessory.name == accessoryName then
                    local source = tempBagAcc.takeObject({
                        position = position,
                        rotation = spawnCard.getRotation(),
                        guid = accessory.guid,
                        smooth = false
                    })
                    local clone = source.clone()
                    clone.setPosition(position)
                    clone.addTag("Assignable")
                    tempBagAcc.putObject(source)
                end
            end
        end

        local function spawnPilotUpgrades(pilot, upgrades)
            local result = {
                configCardGUID = nil,
                hasMobileUpgrade = 0,
                count = 0,
                layoutCursor = { x = -1.42, y = 1, z = 5.5 }
            }

            for _, upgrade in pairs(upgrades) do
                if upgrade.Config == true then
                    local layout = configCardLayout(upgrade)
                    spawnCard.setPosition(LocalPos(spawnCard, { CONFIG_CARD_SHIFT_X, 0, 0 }))
                    local position = localLayoutPos(layout)
                    local rotation = spawnCard.getRotation()
                    local cardLink = upgrade.card
                    local cardBackLink = upgrade.cardB
                    if Customization[upgrade.name] ~= nil then
                        cardLink = Customization[upgrade.name].face or upgrade.card
                        cardBackLink = Customization[upgrade.name].back or upgrade.cardB
                    end
                    local deck = Decker.Asset(cardLink, cardBackLink)
                    local card = Decker.Card(deck, 1, 1)
                    local spawnedUpgrade = card:spawn({ position = position, rotation = rotation, scale = { 0.68, 0.68, 0.68 } })
                    spawnedUpgrade.setName(upgrade.name)
                    spawnedUpgrade.addTag("ConfigCard")
                    result.configCardGUID = spawnedUpgrade.getGUID()
                    result.hasMobileUpgrade = 1
                    spawnUpgradeCharges(upgrade, pilot, layout, true)
                end
            end

            for _, upgrade in pairs(upgrades) do
                if upgrade.Config ~= true then
                    local layout = upgradeCardLayout(result.layoutCursor, upgrade)
                    local position = localLayoutPos(layout)
                    local rotation = spawnCard.getRotation()
                    local cardLink = upgrade.card
                    local cardBackLink = upgrade.cardB
                    if Customization[upgrade.name] ~= nil then
                        cardLink = Customization[upgrade.name].face or upgrade.card
                        cardBackLink = Customization[upgrade.name].back or upgrade.cardB
                    end
                    local deck = Decker.Asset(cardLink, cardBackLink)
                    local card = Decker.Card(deck, 1, 1)
                    local spawnedUpgrade = card:spawn({
                        position = position,
                        rotation = rotation,
                        scale = { 0.68, 0.68, 0.68 }
                    })
                    spawnedUpgrade.setName(upgrade.name)
                    if upgrade.Condition ~= nil then
                        spawnAssignableAccessories(upgrade.Condition, localLayoutPos(layout, -0.58, 0, 2.5))
                    end
                    spawnUpgradeCharges(upgrade, pilot, layout, false)
                    result.count = result.count + 1
                end
            end

            return result
        end

        local shipIndex = 1 --Sets index of ship being spawned

        while Pilots[shipIndex] ~= nil do
            if Pilots[shipIndex].standardized_loadout then
                spawnCard.setPosition(LocalPos(spawnCard, { -1.1, 0, 0 }))
            end

            local upgradeResult = spawnPilotUpgrades(Pilots[shipIndex], Upgrades[shipIndex])
            local configCardGUID = upgradeResult.configCardGUID
            local hasMob = upgradeResult.hasMobileUpgrade
            local upNum = upgradeResult.count
            local upgradeLayoutCursor = upgradeResult.layoutCursor

            if Pilots[shipIndex].id ~= '' then
                --Pilot and Ship Spawn
                local pilotName = Pilots[shipIndex].name
                local pilotCustomization = Customization[pilotName] or {}
                local card = pilotCustomization.face or Pilots[shipIndex].card
                local cardB = pilotCustomization.back or Pilots[shipIndex].cardB
                local tint = color(0, 0, 0, 0)
                local modeltint = color(1, 1, 1, 1)
                tint = pilotCustomization.tint or tint
                modeltint = pilotCustomization.modeltint or modeltint

                local pos = LocalPos(spawnCard, { 0, 1.2, 5.5 })
                local rot = spawnCard.getRotation()
                local newPil = nil
                if card ~= '' then
                    if cardB ~= nil then
                        local deck = Decker.Asset(card, cardB)
                        card = Decker.Card(deck, 1, 1)
                        newPil = card:spawn({ position = pos, rotation = rot })
                        newPil.setName(pilotName)
                        newPil.setDescription(Pilots[shipIndex].list)
                        newPil.setLuaScript(pilotCardScript)
                        newPil.setTable("PointsTrackerConfig", {
                            landscape = Pilots[shipIndex].standardized_loadout == true,
                            visible = ShouldShowShipPointsTrackerForCurrentLayout()
                        })
                        newPil.setLock(true)

                        -- Spawn Pilot Identifier
                        local card = newPil
                        local idpos = pos
                        local idrot = rot

                        local pilotIdSpawnFunc = function()
                            local pilotId = spawnObject({
                                type = "Custom_Model",
                                position = idpos,
                                rotation = idrot,
                                scale = Dim.mm_ship_scale,
                                sound = false,
                                snap_to_grid = false,
                            })
                            pilotId.setCustomObject({
                                mesh =
                                '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/cardid.obj',
                                convex = true,
                                material = 1,
                                type = 0
                            })
                            pilotId.setColorTint(tint)
                            card.addAttachment(pilotId)
                            card.setLock(false)
                        end
                        Wait.condition(pilotIdSpawnFunc, function()
                            return card ~= nil and (not card.spawning)
                        end)
                    end
                end
                if pilotName ~= '' then
                    for _, acc in pairs(listaAcc) do
                        local card = newPil
                        if acc.name == 'Unassigned Dial' then
                            local dialpos = LocalPos(spawnCard, { 0, 1, 13.2 })
                            local dialrot = rot
                            local dial = tempBagAcc.takeObject(
                                {
                                    position = dialpos,
                                    rotation = dialrot,
                                    guid = acc.guid
                                })
                            local newDial = dial.clone()
                            newDial.setPosition(pos)
                            tempBagAcc.putObject(dial)
                            local conditionFunc = function()
                                return card ~= nil and (not card.spawning) and (not newDial.spawning)
                            end
                            local executeFunc = function()
                                newDial.setCustomObject({ ['diffuse'] = dialSkin })
                                newDial = newDial.reload()
                                newDial.setColorTint(tint)
                                newDial.setPosition(dialpos)
                                newDial.setRotation(dialrot)
                                if card ~= nil then
                                    card.call('addTintObject', { 'dial', newDial })
                                end
                            end
                            Wait.condition(executeFunc, conditionFunc)
                        end
                    end
                end
                if Pilots[shipIndex].Condition ~= nil then
                    spawnAssignableAccessories(Pilots[shipIndex].Condition, LocalPos(spawnCard, { -2 - 1.78 * upNum, 1, 8 }))
                end

                local texture = nil
                Pilots[shipIndex].Data.ColorId = tint
                if Pilots[shipIndex].Data.Config then
                    Pilots[shipIndex].Data.Config.CardGUID = configCardGUID
                end

                if pilotCustomization.texture ~= nil then
                    texture = pilotCustomization.texture
                else
                    local textureKey = Pilots[shipIndex].Data.texture
                    local textureUrl = nil
                    if textureKey ~= nil and Pilots[shipIndex].Data.textures ~= nil then
                        textureUrl = Pilots[shipIndex].Data.textures[textureKey]
                    end
                    if textureUrl ~= nil then
                        texture = '{verifycache}' .. textureUrl
                    elseif textureKey ~= nil then
                        print("Missing ship texture '" .. tostring(textureKey) .. "' for " .. tostring(pilotName) ..
                            " (" .. tostring(Pilots[shipIndex].Data.shipId) .. ")")
                    end
                end
                local shipoffset = vector(0, 2.2, 0)
                local size = Pilots[shipIndex].Size
                local arcs = Pilots[shipIndex].Data.arcs
                local fixedarc = "none"
                if arcs.fixed then
                    fixedarc = arcs.fixed.type[1] or "none"
                end
                if size == "huge" then
                    pos = LocalPos(spawnCard, { 0, 0, 13.2 })
                else
                    pos = LocalPos(spawnCard, { 0, 0, 10.2 })
                end
                rot = spawnCard.getRotation()
                local base_prototype = getObjectFromGUID(CompositeBase_GUID)
                local factionName = factionnames[Faction]
                if factionName == nil then
                    print("Missing faction base texture for faction " .. tostring(Faction) .. " on " .. tostring(pilotName))
                    factionName = factionnames[1]
                end
                local baseDiffuse = spawnPrefix .. "bases/" .. size .. "/" .. fixedarc .. "/" .. factionName .. ".png"
                local newShip = base_prototype.clone()
                newShip.setPositionSmooth(pos, false, true)
                newShip.setRotationSmooth(rot, false, true)
                newShip.setScale(Dim.mm_ship_scale)

                newShip.setCustomObject({
                    mesh = spawnPrefix .. "bases/" .. size .. "/base.obj?1",
                    collider = ShipVerification.colliders[size],
                    diffuse = baseDiffuse,
                    convex = true,
                    material = 1,
                    type = 1
                })
                newShip.setTable("Data", Pilots[shipIndex].Data)
                newShip.setLock(true)
                if Pilots[shipIndex].Data.ProximityHider then
                    newShip.addTag("ProximityHider")
                end

                local base_name_str = pilotName
                if Pilots[shipIndex].Data.limited and Pilots[shipIndex].Data.limited > 0 then
                    base_name_str = string.rep("•", Pilots[shipIndex].Data.limited) .. " " .. pilotName
                end
                newShip.setTable("UiData", {
                    name = base_name_str,
                    icon = Pilots[shipIndex].Ship,
                    init = "init" .. Pilots[shipIndex].Data.initiative
                })

                local pegtype = Pilots[shipIndex].peg or size
                local pegCustomObject = {
                    mesh = spawnPrefix .. "bases/pegs/" .. pegtype .. ".obj",
                    diffuse = baseDiffuse,
                    collider =
                    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/minisculebox.obj',
                    convex = true,
                    material = 1,
                    type = 1
                }
                local shippos = pos
                local shiprot = rot
                local ship = newShip
                local shipCustomObject = nil
                if Pilots[shipIndex].Data.mesh then
                    shipCustomObject = {
                        mesh = '{verifycache}' .. Pilots[shipIndex].Data.mesh,
                        diffuse = texture,
                        collider =
                        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/minisculebox.obj',
                        convex = true,
                        material = 1,
                        type = 1
                    }
                end

                local pegAndShipSpawnFunction = function()
                    local pegModel = spawnObject({
                        type         = "Custom_Model",
                        position     = shippos,
                        rotation     = shiprot,
                        scale        = Dim.mm_ship_scale,
                        sound        = false,
                        snap_to_grid = false,
                    })
                    pegModel.setName("Peg")
                    pegModel.setCustomObject(pegCustomObject)
                    ship.addAttachment(pegModel)
                    if shipCustomObject then
                        local shipModel = spawnObject({
                            type         = "Custom_Model",
                            position     = vector(shippos[1], shippos[2], shippos[3]) + shipoffset,
                            rotation     = shiprot,
                            scale        = Dim.mm_ship_scale,
                            sound        = false,
                            snap_to_grid = false,
                        })
                        shipModel.setName("Ship")
                        shipModel.setCustomObject(shipCustomObject)
                        shipModel.setColorTint(modeltint)
                        ship.addAttachment(shipModel)
                    end
                end
                Wait.condition(pegAndShipSpawnFunction,
                    function() return (not ship.spawning) and (not ship.isSmoothMoving()) end)
                if newShip ~= nil then
                    local ship = newShip
                    local card = newPil
                    local idpos = pos
                    local idrot = rot
                    local customObj = {
                        convex = true,
                        material = 1,
                        type = 1,
                        collider =
                        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/minisculebox.obj',
                    }
                    if Pilots[shipIndex].Size == "small" then
                        customObj.mesh =
                        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base_ID_Marker.obj'
                    elseif Pilots[shipIndex].Size == "medium" then
                        customObj.mesh =
                        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base%20ID%20MED.obj'
                    elseif Pilots[shipIndex].Size == "large" then
                        customObj.mesh =
                        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base%20ID%20LAR.obj'
                    elseif Pilots[shipIndex].Size == "huge" then
                        customObj.mesh =
                        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base_ID_HUGE.obj'
                    end
                    local shipIdSpawnFunc = function()
                        local shipId = spawnObject({
                            type = "Custom_Model",
                            position = idpos,
                            rotation = idrot,
                            scale = Dim.mm_ship_scale * 0.99,
                            sound = false,
                            snap_to_grid = false,
                        })
                        shipId.setCustomObject(customObj)
                        shipId.setColorTint(tint)
                        shipId.setName("ColorId")
                        ship.addAttachment(shipId)
                        ship.setLock(false)
                        ship.addTag("Ship")
                        ship.drag_selectable = true
                        ship.interactable = true

                        if card ~= nil then
                            card.call('addTintObject', { 'ship', ship })
                        end
                        ship.call('initContextMenu')
                    end
                    if Pilots[shipIndex].Data.ProximityHider then
                        ship.addTag("ProximityHider")
                    end
                    Wait.condition(shipIdSpawnFunc,
                        function()
                            return (not ship.spawning) and (not ship.isSmoothMoving()) and (card == nil or not card.spawning)
                        end)

                    if Pilots[shipIndex].Data.Config and Pilots[shipIndex].Data.Config.States then
                        for k, config in pairs(Pilots[shipIndex].Data.Config.States) do
                            if config.Model then
                                local customObject = ship.getCustomObject()
                                customObject.mesh = config.Model
                                customObject.diffuse = texture
                                local configSpawnFunction = function()
                                    local configModel = spawnObject({
                                        type = "Custom_Model",
                                        position = vector(idpos[1], idpos[2], idpos[3]) + shipoffset,
                                        rotation = idrot,
                                        scale = Dim.mm_ship_scale,
                                        sound = false,
                                        snap_to_grid = false,
                                    })
                                    configModel.setName("Config")
                                    configModel.setDescription(tostring(k))
                                    configModel.setCustomObject(customObject)
                                    configModel.setColorTint(modeltint)
                                    if k ~= 1 then
                                        configModel.setScale(vector(0.0001, 0.0001, 0.0001))
                                    end
                                    ship.addAttachment(configModel)
                                    Wait.frames(function()
                                        ship.call("DisableAttachedColliders")
                                    end, 2)
                                    Wait.frames(function()
                                        ship.call("DisableAttachedColliders")
                                    end, 10)
                                    Wait.frames(function()
                                        ship.call("DisableAttachedColliders")
                                    end, 30)
                                end
                                Wait.condition(configSpawnFunction,
                                    function()
                                        return (not ship.spawning) and (not ship.isSmoothMoving())
                                    end)
                            end -- if Config.Model
                        end     -- for Data.Config
                        if Pilots[shipIndex].Data.Config and Pilots[shipIndex].Data.Config.Token then
                            pos = LocalPos(spawnCard, { -1.5, 1, 8.7 })
                            local configToken = spawnObject({
                                type = "Custom_Model",
                                scale = { 0.38, 0.38, 0.38 },
                                rotation = { 0, 270, 0 },
                                position = pos,
                            })
                            configToken.setCustomObject({
                                mesh =
                                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tokens/flip/flipToken.obj",
                                diffuse = Pilots[shipIndex].Data.Config.Token,
                                type = 5,
                                material = 1,
                                specular_intensity = 0
                            })
                            configToken.setLuaScript(
                                [[
            __XW_Token = true
            __XW_TokenIdle = true
            __XW_TokenType = 'config'

            self.addTag('Flippable')

            function onFlip()
            local ship = Global.call("getShipTokenIsAssignedTo",{token=self})
            if ship and ship.getVar("SetConfiguration") then
                ship.call("SetConfiguration", {ConfigId=self.is_face_down and 1 or 2})
            end
            end
            ]])
                        end -- token
                    end     -- config


                    --[[customization_parts = {
                    canopy = {
                    model = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/firesprayV3-canopy.obj',
                    material = 2,
                    tintable = true
                    }
                }]]
                    --[[
                local Dim = require("Dim")
                for k, customization_part in pairs(Pilots[shipIndex].Data.customization_parts or {}) do
                    if customization_part.model then
                    local customObject = ship.getCustomObject()
                    customObject.mesh = customization_part.model
                    if customization_part.texture then
                        customObject.diffuse = customization_part.texture
                    else
                        customObject.diffuse = texture
                    end
                    if customization_part.material then
                        customObject.material = customization_part.material
                    end
                    customObject.specular_sharpness = customization_part.specular_sharpness or 3
                    customObject.specular_intensity = customization_part.specular_intensity or 0.1
                    local customSpawnFunction = function()
                        local partModel = spawnObject({
                            type              = "Custom_Model",
                            position          = vector(idpos[1],idpos[2],idpos[3]) + shipoffset,
                            rotation          = idrot,
                            scale             = Dim.mm_ship_scale*1.01,
                            sound             = false,
                            snap_to_grid      = false,
                        })
                        partModel.setName("Part")
                        partModel.setDescription(tostring(k))
                        partModel.setCustomObject(customObject)
                        if customization_part.tint then
                        partModel.setColorTint(customization_part.tint)
                        end
                        ship.addAttachment(partModel)
                        Wait.frames(function() ship.call("DisableAttachedColliders") end, 2)
                        Wait.frames(function() ship.call("DisableAttachedColliders") end, 10)
                        Wait.frames(function() ship.call("DisableAttachedColliders") end, 30)
                    end
                    Wait.condition(customSpawnFunction , function() return (not ship.spawning) and (not ship.isSmoothMoving() ) end)
                    end -- if customization_part.models
                end -- for Data.customization_parts

                ]]
                end

                spawnPilotAccessories(Pilots[shipIndex], spawnCard, accessoryContext, Faction, rot, pos)
                spawnPilotResourceTokens(Pilots[shipIndex], spawnCard, tokens, hasMob)
            end

            if Pilots[shipIndex].standardized_loadout then
                local charges = 0
                for _, upgrade in pairs(Pilots[shipIndex].standardized_upgrades) do
                    charges = math.max(charges, upgrade.charge)
                end
                spawnCard.setPosition(LocalPos(spawnCard, { -(5.5 + charges * 0.7), 0, 0 }))
            else
                spawnCard.setPosition(LocalPos(spawnCard, { upgradeLayoutCursor.x - 2.58, 0, 0 }))
            end
            shipIndex = shipIndex + 1
        end

        spawnCard.setPosition(LocalPos(spawnCard, { 0, 0, 5.5 }))

        spawnSpawnerRemotes(listTable.Remotes, spawnCard, accessoryContext)

        spawnSpawnerObstacles(listTable.Obstacles, spawnCard, bagPosition)
    end)

    -- Temporary source objects and the spawn anchor must be released on success or failure.
    destroySpawnerAccessoryContext(accessoryContext)
    spawnCard.setPosition(storePos)
    spawnCard.setRotation(storeRot)

    if not spawnSuccess then
        error(spawnError)
    end
end


return Spawner
