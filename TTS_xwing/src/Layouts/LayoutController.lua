require("TTS_Lib.Util.Math")
require("TTS_Lib.Util.Table")
require("TTS_Lib.Util.String")

local Vect       = require("TTS_Lib.Vector.Vector")
local ObjType    = require("TTS_Lib.ObjType.ObjType")
local BagHandler = require("Game.Component.Spawner.BagHandler")

ObjType.AddType('dialBag', function(obj) return (obj.tag == 'Infinite') end)

Layout = require("Layouts.LayoutElements")
Layout.layouts = {}

Layout.AddLayout = function(layoutTable)
    table.insert(Layout.layouts, layoutTable)
end

Layout.AddLayout(require("Layouts.Standard"))
Layout.AddLayout(require("Layouts.Epic"))
Layout.AddLayout(require("Layouts.HotAC"))
Layout.AddLayout(require("Layouts.Epic-HotAC"))

self.setPosition({ 0, 3, 0 })

state = {
    active = true,
    index = 1,
    tempObjs = {},
    requiredObjectGuids = {}
}

Layout.AddTempObj = function(obj)
    state.tempObjs[obj.getGUID()] = true
end

Layout.ClearTempObjs = function()
    for guid in pairs(state.tempObjs) do
        local obj = getObjectFromGUID(guid)
        if obj then obj.destruct() end
    end
end

Layout.NearLocal = function(zone, pos)
    local posAdj = Vect.ScaleEach(Vect.Sub(pos, { 0, zone.getPosition()[2], zone.getScale()[3] / 2 }),
        Vect.Inverse(zone.getScale()))
    posAdj[1] = posAdj[1] + 0.5 * math.sgn(posAdj[1])
    return posAdj
end

Layout.NearGlobal = function(zone, pos)
    local posAdj = Vect.ScaleEach(Vect.Sub(pos, { 0, zone.getPosition()[2], zone.getScale()[3] / 2 }),
        Vect.Inverse(zone.getScale()))
    posAdj[1] = posAdj[1] + 0.5 * math.sgn(posAdj[1])
    return zone.positionToWorld(Vect.ScaleEach(posAdj, { -1, 1, 1 }))
end

Layout.extIndex = 1

Layout.required = {}
Layout.requiredGuids = {}
Layout.requiredRoles = {}
Layout.requiredRoleObjects = {}
Layout.requiredOriginalGuids = {}
Layout.pendingStateChanges = {}

local layoutDebug = false
local function debugLayout(message)
    if layoutDebug then
        printToAll("[LayoutDebug] " .. message, { 0.4, 0.8, 1 })
        log("[LayoutDebug] " .. message)
    end
end

local function describeObject(obj)
    if not obj then
        return "<nil>"
    end
    local name = obj.getName and obj.getName() or ""
    local gmNotes = obj.getGMNotes and obj.getGMNotes() or ""
    local guid = obj.getGUID and obj.getGUID() or "no-guid"
    local stateId = obj.getStateId and obj.getStateId() or "no-state"
    return tostring(name) .. " gmnotes=" .. tostring(gmNotes) .. " [" .. tostring(guid) .. "] state=" .. tostring(stateId)
end

local defaultRequiredRoles = {
    e51a16 = 'Attack Dice changer',
    d9a9fa = 'Defence Dice changer',
}

local staticDiceBagGuids = {
    ['8a49f4'] = true,
    ['edbe72'] = true,
    ['3d426e'] = true,
}

local function dicePlatformPrefix(role)
    if role == 'Attack Dice changer' then
        return 'atkPlat'
    elseif role == 'Defence Dice changer' then
        return 'defPlat'
    end
end

local function findReplacementForRequired(role, oldGuid, oldName, oldGMNotes)
    local platformPrefix = dicePlatformPrefix(role)

    for _, candidate in pairs(getAllObjects()) do
        if candidate and candidate.getGUID then
            local candidateGuid = candidate.getGUID()
            if candidateGuid and candidateGuid ~= oldGuid then
                local gmNotes = candidate.getGMNotes and candidate.getGMNotes() or ""
                if platformPrefix and gmNotes:match("^" .. platformPrefix .. "%d+") then
                    return candidate
                end
                if not platformPrefix and oldGMNotes ~= "" and gmNotes == oldGMNotes then
                    return candidate
                end
                if not platformPrefix and oldName ~= "" and candidate.getName and candidate.getName() == oldName then
                    return candidate
                end
            end
        end
    end
end

Layout.ReplaceRequiredObject = function(oldGuid, object, reason)
    local newGuid = object.getGUID()
    local role = Layout.requiredRoles[oldGuid]
    local oldObject = role and Layout.requiredRoleObjects[role] or nil
    local originalGuid = Layout.requiredOriginalGuids[oldGuid] or oldGuid

    if oldObject then
        Layout.required[oldObject] = nil
    end

    Layout.pendingStateChanges[oldGuid] = nil
    Layout.requiredGuids[oldGuid] = nil
    Layout.requiredRoles[oldGuid] = nil
    Layout.requiredOriginalGuids[oldGuid] = nil
    Layout.required[object] = true
    Layout.requiredGuids[newGuid] = true
    Layout.requiredOriginalGuids[newGuid] = originalGuid
    state.requiredObjectGuids[originalGuid] = newGuid
    SaveState()

    if role then
        Layout.requiredRoles[newGuid] = role
        Layout.requiredRoleObjects[role] = object
        if Layout.elements then
            Layout.elements[role] = object
        end
    end

    debugLayout("updated required object" ..
        (role and " for " .. role or "") .. ": " .. tostring(oldGuid) .. " -> " .. tostring(newGuid) ..
        " via " .. tostring(reason))
end

Layout.RegisterRequiredRoles = function()
    for role, obj in pairs(Layout.elements or {}) do
        if obj and Layout.required[obj] and obj.getGUID then
            local guid = obj.getGUID()
            Layout.requiredRoles[guid] = role
            Layout.requiredRoleObjects[role] = obj
            Layout.requiredOriginalGuids[guid] = Layout.requiredOriginalGuids[guid] or guid
            if dicePlatformPrefix(role) then
                debugLayout("registered required role " .. tostring(role) .. " for " .. describeObject(obj))
            end
        end
    end
end

function onObjectDestroyed(obj)
    if state.active and Layout.required[obj] then
        local guid = obj.getGUID()
        local role = Layout.requiredRoles[guid]
        local oldName = obj.getName and obj.getName() or ""
        local oldGMNotes = obj.getGMNotes and obj.getGMNotes() or ""
        debugLayout("required object destroyed event: " .. describeObject(obj) ..
            " role=" .. tostring(role) .. "; deferring guard check")
        Wait.frames(function()
            if Layout.pendingStateChanges[guid] then
                debugLayout("accepted as state change replacement for old guid " .. tostring(guid))
                Layout.pendingStateChanges[guid] = nil
                return
            end
            if state.active and Layout.requiredGuids[guid] then
                local replacement = findReplacementForRequired(role, guid, oldName, oldGMNotes)
                if replacement then
                    Layout.ReplaceRequiredObject(guid, replacement, "deferred replacement scan")
                    return
                end
                --broadcastToAll('An object that was part of layout system was destroyed, disabling layouts', {1, 0.4, 0})
                debugLayout("no replacement detected; disabling layout for destroyed guid " .. tostring(guid) ..
                    " role=" .. tostring(role) .. " gmnotes=" .. tostring(oldGMNotes))
                broadcastToAll('You\'re breaking the game, please don\'t', { 1, 0.4, 0 })
                state.active = false
            end
        end, 5)
    end
end

Layout.RequireFromGUID = function(guid)
    state.requiredObjectGuids = state.requiredObjectGuids or {}
    local currentGuid = state.requiredObjectGuids[guid] or guid
    if staticDiceBagGuids[guid] and currentGuid ~= guid then
        state.requiredObjectGuids[guid] = nil
        currentGuid = guid
        SaveState()
    end
    local obj = getObjectFromGUID(currentGuid)
    if not obj and currentGuid ~= guid then
        state.requiredObjectGuids[guid] = nil
        currentGuid = guid
        obj = getObjectFromGUID(currentGuid)
    end
    if not obj then
        obj = findReplacementForRequired(defaultRequiredRoles[guid], guid, "", "")
        if obj then
            currentGuid = obj.getGUID()
            state.requiredObjectGuids[guid] = currentGuid
            SaveState()
        end
    end
    obj = (obj or error('Layout.RequireFromGUID: object with \'' .. currentGuid .. '\' GUID not found'))
    Layout.required[obj] = true
    Layout.requiredGuids[currentGuid] = true
    Layout.requiredOriginalGuids[currentGuid] = guid
    return obj
end

function onObjectStateChange(object, old_guid)
    debugLayout("state change event: old=" .. tostring(old_guid) .. " new=" .. describeObject(object) ..
        " oldRequired=" .. tostring(Layout.requiredGuids[old_guid] == true))
    if state.active and Layout.requiredGuids[old_guid] then
        if staticDiceBagGuids[Layout.requiredOriginalGuids[old_guid] or old_guid] then
            debugLayout("ignoring state change replacement for static dice bag guid " .. tostring(old_guid))
            return
        end
        Layout.pendingStateChanges[old_guid] = true
        Layout.ReplaceRequiredObject(old_guid, object, "state change event")
    end
end

function onObjectStateChangeFromGlobal(params)
    if params then
        onObjectStateChange(params.object, params.old_guid)
    end
end

Layout.GetTableRef = function()
    local hits = Physics.cast({
        origin = { 0, 0, 0 },
        direction = { 0, -1, 0 },
        type = 3,
        size = { 1, 1, 1 },
        orientation = { 0, 0, 0 },
        debug = false
    })
    for _, hitData in pairs(hits) do
        if hitData.hit_object.type == 'Surface' then
            return hitData.hit_object
        end
    end
    error('Layout.GetTableRef: No surface found')
end


Layout.Hide = function(obj)
    obj.highlightOff()
    obj.lock()
    obj.tooltip = false
    obj.interactable = false
    obj.setPositionSmooth({ 0, -5, 0 }, false, true)
    local handlers = obj.getTable('__XW_LayoutHandlers') or {}
    if handlers.hide then
        obj.call(handlers.hide)
    end
    obj.setScale(Vect.Scale(obj.getScale(), 0.1))
end

Layout.Put = function(obj, data)
    obj.setLock(data.lock ~= false)
    local int = data.int
    if int == nil then int = true end
    obj.interactable = int
    obj.tooltip = int
    obj.setPositionSmooth(data.pos, false, true)
    obj.setRotationSmooth(data.rot, false, true)
    obj.setScale(data.scale)
    if data.set then
        data.set(obj)
    end
    local handlers = obj.getTable('__XW_LayoutHandlers') or {}
    if handlers.show then
        obj.call(handlers.show)
    end
end

Layout.GetMats = function()
    local mats = {}
    for _, obj in pairs(getAllObjects()) do
        if obj.getVar('__XW_Mat') then
            local lay, ID = obj.getVar('__XW_MatLayout'), obj.getVar('__XW_MatID')
            if not mats[lay] then
                mats[lay] = {}
            end
            mats[lay][ID] = obj
        end
    end
    return mats
end

function setLayoutState(index)
    local prev = state.index
    if state.index ~= index then
        Layout.Switch(index)
    end
    return prev
end

function getLayoutState(index)
    return state.index
end

function Layout.Switch(newIndex)
    self.clearButtons()
    if not state.active then
        broadcastToAll('Layout system disabled', { 1, 0.2, 0 })
        return
    end
    --table.print(Layout.layouts)
    local lay = Layout.layouts[newIndex]
    --print('Switch to ' .. lay.name)
    local tabRef = Layout.GetTableRef()
    local cust = tabRef.getCustomObject()
    cust.image = lay.tableImage
    tabRef.setCustomObject(cust)
    tabRef.reload()
    for name, el in pairs(Layout.elements) do
        if lay.elements[name] then
            el.highlightOn({ 0, 0, 1 }, 2)
            Layout.Put(el, lay.elements[name])
        else
            Layout.Hide(el)
        end
    end

    local matData = Layout.GetMats()
    for layout, mats in pairs(matData) do
        if layout ~= lay.name then
            for _, mat in pairs(mats) do
                Layout.Hide(mat)
            end
        else
            for id, mat in pairs(mats) do
                if lay.mats[id] then
                    Layout.Put(mat, lay.mats[id])
                else
                    Layout.Hide(mat)
                end
            end
        end
    end
    Layout.CreateControls(newIndex)
    function setHandsDelayed()
        for _ = 1, 10 do
            coroutine.yield()
        end
        for color, data in pairs(lay.hands) do
            Player[color].setHandTransform({
                position = data.pos,
                rotation = data.rot,
                scale    = data.scale,
            })
        end
        return 1
    end

    self.setTable("elements", Layout.elements)
    startLuaCoroutine(self, 'setHandsDelayed')
    state.index = newIndex
    Global.call("SetShipPointsTrackersForLayout", { index = newIndex, layout = lay.name })
    SaveState()
end

Layout.CreateControls = function(index)
    local lay = Layout.layouts[index]
    for _, button in pairs(lay.controls) do
        self.createButton(button)
    end
end

Layout.SpawnPlaymatTile = function(type, position, rotation)
    local state = ((type or ""):lower() == "epic") and 2 or 1
    local bagGuids = Global.getTable('bagGuids') or {}
    local myBagHandler = BagHandler:new(bagGuids['ExtraAssets'])
    local tile = myBagHandler:takeItemByGMNote("playmattile", { position = position, rotation = rotation })
    if tile.getStateId() == state then
        return tile
    end

    tile = tile.setState(state)

    Wait.condition(function()
        tile.setPosition(position, false, true)
        tile.setRotation(rotation, false, true)
    end, function()
        return not tile.spawning
    end)
end

function SpawnEpicPlaymatTile()
    Layout.SpawnPlaymatTile("epic", Vector(-3, 3, 0), Vector(0, 180, 0))
end

function SpawnStandardPlaymatTile()
    Layout.SpawnPlaymatTile("standard", Vector(-20, 3, 0), Vector(0, 180, 0))
end

function SpawnHotacPlaymatTile()
    Layout.SpawnPlaymatTile("standard", Vector(-3, 3, 0), Vector(0, 180, 0))
end

function onChat(message, player)
    --[[
    if message == 'std' then
        Layout.Switch(1)
    end
    if message == 'ep' then
        Layout.Switch(2)
    end
    --]]
end

function onLoad(saveState)
    local load = JSON.decode(saveState) or {}
    if load.active ~= nil then
        state.active = load.active
    end
    state.index = load.index or state.index
    state.tempObjs = load.tempObjs or state.tempObjs
    state.requiredObjectGuids = load.requiredObjectGuids or state.requiredObjectGuids or {}
    Layout.FillElements()
    Layout.RegisterRequiredRoles()
    Layout.CreateControls(state.index)
    local sPos = self.getPosition()
    self.setPosition({ sPos[1], 0, sPos[3] })
    self.interactable = false
    self.tooltip = false
    self.lock()

    for _, layoutElement in pairs(getObjectsWithTag('TempLayoutElement')) do
        destroyObject(layoutElement)
    end

    --addContextMenuItem("Standard setup", function() Layout.Switch(1) end, false)
    --addContextMenuItem("Epic setup", function() Layout.Switch(2) end, false)
    --addContextMenuItem("HotAC setup", function() Layout.Switch(3) end, false)
end

function onSave()
    return JSON.encode(state)
end

function SaveState()
    self.script_state = JSON.encode(state)
end

return Layout
