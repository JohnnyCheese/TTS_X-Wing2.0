local Dim = require("Dim")
local Vect = require("TTS_lib.Vector.Vector")
dork = self

assignedShip = nil
drop_offset = 0.0
spawnedRuler = nil
initialP = nil

token_offset = 18.1

size_adjust = {
    small = 20 - token_offset,
    medium = 30 - token_offset,
    large = 40 - token_offset,
}

scale = 1 / self.getScale().x
checkingRange = nil

function update()
    if self.getDescription() == 'r' then
        checkRange(3)
        self.setDescription('')
    end
end

local removeButtonUp = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = { 0, 0.1 * scale, 0.0 },
    rotation = { 0, 0, 0 },
    width = 400 * scale,
    height = 300 * scale,
    font_size = 100 * scale,
    color = { 0.7, 0.7, 0.7 }
}

local removeButtonDown = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = { 0, -0.1 * scale, 0.0 },
    rotation = { 180, 180, 0 },
    width = 400 * scale,
    height = 300 * scale,
    font_size = 100 * scale,
    color = { 0.7, 0.7, 0.7 }
}

function removeCheckRange()
    checkRange(nil)
end

function checkRange(range)
    if range and checkingRange ~= range then
        printToAll("Checking for ships within range " .. range .. " of " .. self.getName(), color(1.0, 1.0, 0))
        vector_lines = {}
        for _, obj in pairs(getObjectsWithAnyTags({ 'Ship' })) do
            my_pos = self.getNearestPointFromObject(obj)
            closest = Global.call("API_GetClosestPointToShip", { ship = obj, point = my_pos })
            distance = Dim.Convert_igu_mm(closest.length)
            if distance < 100 * range then
                printToAll(obj.getName() .. " is within range " .. range .. " of " .. self.getName(), color(1.0, 1.0, 0))
                table.insert(vector_lines, {
                    points = { self.positionToLocal(closest.A), self.positionToLocal(closest.B) },
                    color = { 1, 1, 1 },
                    thickness = 0.05 * scale,
                    rotation = vector(0, 0, 0)
                })
            end
        end
        self.clearButtons()
        self.setVectorLines(vector_lines)
        if #vector_lines > 0 then
            checkingRange = range
            if self.is_face_down then
                self.createButton(removeButtonDown)
            else
                self.createButton(removeButtonUp)
            end
        else
            checkingRange = nil
            printToAll("No ships is within range " .. range .. " of " .. self.getName(), color(1.0, 1.0, 0))
            mainSet()
        end
    else
        checkingRange = nil
        self.clearButtons()
        self.setVectorLines({})
        mainSet()
    end
end

function onPickUp(color)
    self.setColorTint(Color.fromString(color))
end

function onSave()
    if assignedShip ~= nil then
        local state = { assignedShipGUID = assignedShip.getGUID() }
        return JSON.encode(state)
    end
end

function onLoad(save_state)
    self.addContextMenuItem("Check Range 1", function()
        checkRange(1)
    end, false)
    self.addContextMenuItem("Check Range 3", function()
        checkRange(3)
    end, false)
end

-- Assign on drop near a small base ship
function onDropped(color)
    if assignedShip == nil then
        local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 80 })
        if nearest ~= nil then
            printToAll('DRK-1 Probe preparing to drop/lauch')
            initialP = self.getPosition()
            size = nearest.getTable('Data').Size or "small"
            drop_offset = Dim.Convert_mm_igu(size_adjust[size]);
            assignedShip = nearest
            local pos = assignedShip.getPosition()
            local rot = assignedShip.getRotation()
            local newPos = {}
            newPos[1] = pos[1]
            newPos[2] = 1.22
            newPos[3] = pos[3]
            dorkMove(newPos, rot)
            launchDrop()
        end
    end
    self.setColorTint(Color.fromString(color))
end

function launchDrop()
    self.lock()
    self.createButton({
        click_function = "prepareDrop",
        function_owner = self,
        label = "^",
        rotation = { 0, 180, 0 },
        position = { 0, 0.1, 0.7 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "prepareLaunch",
        function_owner = self,
        label = "^",
        position = { 0, 0.1, -0.7 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "cancelDrop",
        function_owner = self,
        label = "Cancel",
        position = { 1, 0.1, 0 },
        width = 500,
        height = 180,
        font_size = 150
    })
end

function prepareDrop()
    self.clearButtons()
    local rot = self.getRotation()
    local newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 180
    newRot[3] = rot[3]
    self.setRotation(newRot)
    prepareLaunch()
end

function prepareLaunch()
    self.lock()
    local pos = self.getPosition() - self.getTransformForward():normalize() * drop_offset
    dorkMove(pos, self.getRotation())
    self.clearButtons()
    dorkDrop()
end

function dorkDrop()
    self.createButton({
        click_function = "dorkDropTR",
        function_owner = self,
        label = "^",
        position = { 0.8, 0.1, -0.7 },
        rotation = { 0, 90, 0 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "dorkDropBR",
        function_owner = self,
        label = "^",
        position = { 0.4, 0.1, -0.7 },
        rotation = { 0, 45, 0 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "dorkDropS",
        function_owner = self,
        label = "^",
        position = { 0, 0.1, -0.7 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "dorkDropBL",
        function_owner = self,
        label = "^",
        position = { -0.4, 0.1, -0.7 },
        rotation = { 0, -45, 0 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "dorkDropTL",
        function_owner = self,
        label = "^",
        position = { -0.8, 0.1, -0.7 },
        rotation = { 0, -90, 0 },
        width = 200,
        height = 200,
        font_size = 150
    })
end

function cancelDrop()
    self.unlock()
    self.clearButtons()
    dorkMove(initialP + vector(0, 0.5, 0), self.getRotation())
    assignedShip = nil
end

--[[
Neutral
x=27.36
z=-6.92

bank
x=24.94
z=-1.23

Dx=2.42
Dz=5.76

Turn
x=31.27
z=2.99

Dx=3.96
Dz=3.93

]]


function dorkDropTL()
    --print("TL")
    self.clearButtons()
    dork = self
    local pos = LocalPos(dork, { 3.93, -0.12, -3.94 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 90
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    mainSet()
end

function dorkDropBL()
    --print("BL")
    self.clearButtons()
    dork = self
    pos = LocalPos(dork, { 2.39, -0.12, -5.78 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 135
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    mainSet()
end

function dorkDropS()
    --print("S")
    self.clearButtons()
    dork = self
    pos = LocalPos(dork, { 0, -0.12, -5.68 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 180
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    mainSet()
end

function dorkDropBR()
    --print("BR")
    self.clearButtons()
    dork = self
    pos = LocalPos(dork, { -2.39, -0.12, -5.78 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 225
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    mainSet()
end

function dorkDropTR()
    --print("TR")
    self.clearButtons()
    dork = self
    pos = LocalPos(dork, { -3.93, -0.12, -3.94 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 270
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    mainSet()
end

function mainSet()
    self.clearButtons()
    self.createButton({
        click_function = "dir1",
        function_owner = self,
        label = "^",
        position = { 0, 0.1, -0.7 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "dir2",
        function_owner = self,
        label = "^",
        position = { 0.7, 0.1, -0.24 },
        rotation = { 0, 72, 0 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "dir3",
        function_owner = self,
        label = "^",
        position = { 0.5, 0.1, 0.5 },
        rotation = { 0, 144, 0 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "dir4",
        function_owner = self,
        label = "^",
        position = { -0.5, 0.1, 0.5 },
        rotation = { 0, 216, 0 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "dir5",
        function_owner = self,
        label = "^",
        position = { -0.7, 0.1, -0.24 },
        rotation = { 0, 288, 0 },
        width = 200,
        height = 200,
        font_size = 150
    })
end

function dir1()
    moveSet()
end

function dir2()
    local rot = self.getRotation()
    local newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 72
    newRot[3] = rot[3]
    self.setRotation(newRot)
    moveSet()
end

function dir3()
    local rot = self.getRotation()
    local newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 144
    newRot[3] = rot[3]
    self.setRotation(newRot)
    moveSet()
end

function dir4()
    local rot = self.getRotation()
    local newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 216
    newRot[3] = rot[3]
    self.setRotation(newRot)
    moveSet()
end

function dir5()
    local rot = self.getRotation()
    local newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 288
    newRot[3] = rot[3]
    self.setRotation(newRot)
    moveSet()
end

function moveSet()
    self.clearButtons()
    self.createButton({
        click_function = "dorkMoveS",
        function_owner = self,
        label = "^",
        position = { 0, 0.1, -0.7 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "dorkMoveL",
        function_owner = self,
        label = "<",
        position = { -0.4, 0.1, -0.7 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "dorkMoveR",
        function_owner = self,
        label = ">",
        position = { 0.4, 0.1, -0.7 },
        width = 200,
        height = 200,
        font_size = 150
    })
    self.createButton({
        click_function = "mainSet",
        function_owner = self,
        label = "B",
        position = { 0, 0.1, 0 },
        width = 200,
        height = 200,
        font_size = 150
    })
end

function dorkMoveS()
    dork = self
    pos = LocalPos(dork, { 0, 0, -4.22 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 180
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    mainSet()
end

function dorkMoveL()
    dork = self
    pos = LocalPos(dork, { 1.84, 0, -4.44 })
    local rot = self.getRotation()
    local newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 135
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    mainSet()
end

function dorkMoveR()
    dork = self
    pos = LocalPos(dork, { -1.84, 0, -4.44 })
    local rot = self.getRotation()
    local newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 225
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    mainSet()
end

function dorkMove(pos, rot)
    Global.call("API_ClearPosition", { pos = pos, reach = 0.5 })
    self.setPositionSmooth(pos, false, true)
    self.setRotationSmooth(rot, false, true)
end

function RotMatrix(axis, angDeg)
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

-- Apply given rotation matrix on given vector
-- (multiply matrix and column vector)
function RotateVector(rotMat, vect)
    local out = { 0, 0, 0 }
    for i = 1, 3, 1 do
        for j = 1, 3, 1 do
            out[i] = out[i] + rotMat[i][j] * vect[j]
        end
    end
    return out
end

function LocalPos(object, position)
    local rot = object.getRotation()
    local lPos = { position[1], position[2], position[3] }
    -- Z-X-Y extrinsic
    local zRot = RotMatrix('z', rot['z'])
    lPos = RotateVector(zRot, lPos)
    local xRot = RotMatrix('x', rot['x'])
    lPos = RotateVector(xRot, lPos)
    local yRot = RotMatrix('y', rot['y'])
    lPos = RotateVector(yRot, lPos)

    return Vect.Sum(lPos, object.getPosition())
end
