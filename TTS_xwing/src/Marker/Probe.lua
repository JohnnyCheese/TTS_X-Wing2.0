require("TTS_lib.Util.Table")

local Probe = {}
local subject = {}

function onLoad()
    self.setScale({ 0.5, 0.5, 0.5 })
    -- Add a context menu item to manually check the object
    self.addContextMenuItem("Toggle Interactive", toggleInteractive)
    self.addContextMenuItem("Show Bounds", showBounds)
    self.addContextMenuItem("Move to Obj Center", centerOfObject)
end

function onCollisionEnter(info)
    subject = info.collision_object
    if subject.type ~= "Surface" then
        printToAll("=====" .. vectorToString(self.getPosition()) .. "=====", Color.Orange)
        Probe.printObjectInfo(subject)
    else
        printToAll("Object Position: " .. vectorToString(self.getPosition()), { 0, 1, 0 })
    end
end

function showBounds()
    printToAll("Object Bounds: ", { 0, 1, 0 })
    printToAll(JSON.encode_pretty(subject.getBoundsNormalized()), Color.Yellow)
end

function toggleInteractive()
    subject.interactable = not subject.interactable
end

function centerOfObject()
    self.setPositionSmooth(subject.getPosition(), false, true)
end

local function color(text, colorValue)
    return "[" .. colorValue:toHex() .. "]" .. tostring(text) .. "[-]"
end

function Probe.printObjectInfo(object)
    if object == nil then
        printToAll("printObjectInfo(object) is nil.", Color.Red)
        return
    end
    printToAll("Object.type: " .. color(object.type, Color.Yellow), { 0, 1, 0 })
    printToAll("Object.tag: " .. color(object.tag, Color.Yellow), { 0, 1, 0 })
    printToAll("Object.name: " .. color(object.name, Color.Yellow), { 0, 1, 0 })
    printToAll("Object Name: " .. color(object.getName(), Color.Yellow), { 0, 1, 0 })
    printToAll("Object GUID: " .. color(object.getGUID(), Color.Orange), { 0, 1, 0 })
    printToAll("Object Forward: " .. vectorToString(object.getTransformForward()), { 0, 1, 0 })
    printToAll("Object Position: " .. vectorToString(object.getPosition()), { 0, 1, 0 })
    printToAll("Object Rotation: " .. vectorToString(object.getRotation()), { 0, 1, 0 })
    printToAll("Object.lock: " .. color(object.lock, Color.Yellow), { 0, 1, 0 })
    printToAll("Object.interactable: " .. color(object.interactable, Color.Yellow), { 0, 1, 0 })
    printToAll("Object Scale: " .. vectorToString(object.getScale()), { 0, 1, 0 })
    printToAll("Object Description: " .. color(object.getDescription(), Color.Yellow), { 0, 1, 0 })
    printToAll("Object GM Note: " .. color(object.getGMNotes(), Color.Yellow), { 0, 1, 0 })
    printToAll("Object.memo: " .. color(object.memo, Color.Yellow), { 0, 1, 0 })
    printToAll("Object.is_face_down: " .. color(object.is_face_down, Color.Yellow), { 0, 1, 0 })
    printToAll("Object Tags: ", { 0, 1, 0 })
    table.print(object.getTags(), "tags")
    -- printToAll("Object Lua Script: " .. object.getLuaScript(), { 0, 1, 0 })
    -- printToAll("Object JSON State: " .. object.getJSON(), { 0, 1, 0 })
end

function Probe.printBagItem(item)
    printToAll("Bag Item: ", { 0, 1, 0 })
    printToAll("item.description: " .. item.description, Color.Pink)
    printToAll("item.gm_notes: " .. item.gm_notes, Color.Pink)
    printToAll("item.guid: " .. item.guid, Color.Pink)
    printToAll("item.index: " .. item.index, Color.Pink)
    printToAll("item.lua_script: " .. item.lua_script, Color.Pink)
    printToAll("item.lua_script_state: " .. item.lua_script_state, Color.Pink)
    printToAll("item.memo: " .. item.memo, Color.Pink)
    printToAll("item.name: " .. item.name, Color.Pink)
    printToAll("item.nickname: " .. item.nickname, Color.Pink)
    printToAll("item.tags: " .. item.tags, Color.Pink)
end

function vectorToString(vector)
    return string.format("x: %.2f, y: %.2f, z: %.2f", vector.x, vector.y, vector.z)
end

return Probe
