require("TTS_Lib.Util.Math")
require("TTS_Lib.Util.Table")
require("TTS_Lib.Util.String")

local Vect = require("TTS_Lib.Vector.Vector")
local ObjType = require("TTS_Lib.ObjType.ObjType")

ObjType.AddType('dialBag', function(obj) return (obj.tag == 'Infinite') end)

Layout = require("Layouts.LayoutElements")
Layout.layouts = {}

Layout.AddLayout = function(layoutTable)
    table.insert(Layout.layouts, layoutTable)
end

Layout.AddLayout(require("Layouts.Standard"))
Layout.AddLayout(require("Layouts.Epic"))
Layout.AddLayout(require("Layouts.HotAC"))

self.setPosition({ 0, 3, 0 })

state = {
    active = true,
    index = 1,
    dialZones = {},
    tempObjs = {}
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
function onObjectDestroyed(obj)
    if state.active and Layout.required[obj] then
        --broadcastToAll('An object that was part of layout system was destroyed, disabling layouts', {1, 0.4, 0})
        broadcastToAll('You\'re breaking the game, please don\'t', { 1, 0.4, 0 })
        state.active = false
    end
    if state.dialZones[obj.getGUID()] then
        state.dialZones[obj.getGUID()] = nil
        SaveState()
    end
end

Layout.RequireFromGUID = function(guid)
    local obj = (getObjectFromGUID(guid) or error('Layout.RequireFromGUID: object with \'' .. guid .. '\' GUID not found'))
    Layout.required[obj] = true
    return obj
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
    SaveState()
end

Layout.CreateControls = function(index)
    local lay = Layout.layouts[index]
    for _, button in pairs(lay.controls) do
        self.createButton(button)
    end
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
    local load = JSON.decode(saveState)
    state.active = load.active or state.active
    state.index = load.index
    Layout.FillElements()
    Layout.CreateControls(load.index)
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
