require("TTS_lib.Util.Table")

local Probe = {}
local subject = {}

function onLoad()
    self.setScale({ 0.5, 0.5, 0.5 })
    -- Add a context menu item to manually check the object
    self.addContextMenuItem("Toggle Interactive", toggleInteractive)
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

function toggleInteractive()
    subject.interactable = not subject.interactable
end

local function color(text, color)
    return "[" .. color:toHex() .. "]" .. tostring(text) .. "[-]"
end

function Probe.printObjectInfo(object)
    if object == nil then
        printToAll("pringObjectInfo(object) is nil.", Color.Red)
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

function vectorToString(vector)
    return string.format("x: %.2f, y: %.2f, z: %.2f", vector.x, vector.y, vector.z)
end

return Probe
