local Dim = require("TTS_xwing.src.Dim")
local Vect = require("TTS_lib.Vector.Vector")

dork = self

assignedShip = nil
drop_offset = 0.2

sizeOffset = {
    small = Dim.Convert_mm_igu(10.35),
    medium = Dim.Convert_mm_igu(0.35),
    large = Dim.Convert_mm_igu(-9.65),
    huge = Dim.Convert_mm_igu(-81.0)
}

function update()
    if self.getDescription() == 'r' then
        if ToggleRuler3() then
            printToAll('Spawning ' .. self.getName() .. ' guide', { 0, 1, 1 })
        end
        self.setDescription('')
    end
end

function onPickUp(color)
    self.setColorTint(Color.fromString(color))
end

function onLoad(save_state)
    self.addContextMenuItem("Check Range 1", function() checkRange(1) end, false)
    self.addContextMenuItem("Check Range 3", function() checkRange(3) end, false)
end

scale = 1 / self.getScale().x
checkingRange = nil

local removeButtonUp = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = { 0, 0.1 * scale, 0 },
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
    position = { 0, -0.1 * scale, 0 },
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
    if assignedShip then
        if range and checkingRange ~= range then
            printToAll("Checking for ships within range " .. range .. " of " .. self.getName(), color(1.0, 1.0, 0))
            vector_lines = {}
            for _, obj in pairs(getObjectsWithAnyTags({ 'Ship' })) do
                my_pos = self.getNearestPointFromObject(obj)
                closest = Global.call("API_GetClosestPointToShip", { ship = obj, point = my_pos })
                distance = Dim.Convert_igu_mm(closest.length)
                if distance < 100 * range then
                    printToAll(obj.getName() .. " is within range " .. range .. " of " .. self.getName(),
                        color(1.0, 1.0, 0))
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
                moveSet()
                printToAll("No ships is within range " .. range .. " of " .. self.getName(), color(1.0, 1.0, 0))
            end
        else
            checkingRange = nil
            self.clearButtons()
            moveSet()
            self.setVectorLines({})
        end
    end
end

-- Assign on drop near a small base ship
function onDropped(color)
    if assignedShip == nil then
        local spos = self.getPosition()
        local nearest = nil
        local minDist = Dim.Convert_mm_igu(120)
        for _, ship in pairs(getAllObjects()) do
            if ship.tag == 'Figurine' and ship.name ~= '' then
                local pos = ship.getPosition()
                local dist = math.sqrt(math.pow((spos[1] - pos[1]), 2) + math.pow((spos[3] - pos[3]), 2))
                if dist < minDist then
                    nearest = ship
                    minDist = dist
                end
            end
        end
        if nearest ~= nil then
            printToAll('DRK-1 Probe preparing to drop/lauch')
            initialP = self.getPosition()
            assignedShip = nearest
            local size = assignedShip.getTable('Data').Size

            local pos = LocalPos(assignedShip, vector(0, Dim.Convert_mm_igu(1), sizeOffset[size]))
            local rot = assignedShip.getRotation()
            dorkMove(pos, rot)
            prepareLaunch()
        end
    end
    self.setColorTint(Color.fromString(color))
end

function prepareLaunch()
    self.lock()
    self.clearButtons()
    moveSet()
end

function moveSet()
    self.createButton({
        click_function = "moveR",
        function_owner = self,
        label          = "^",
        position       = { 0.2, 0.05, -0.3 },
        rotation       = { 0, 45, 0 },
        width          = 70,
        height         = 70,
        font_size      = 80
    })
    self.createButton({
        click_function = "moveS",
        function_owner = self,
        label          = "^",
        position       = { 0, 0.05, -0.3 },
        width          = 70,
        height         = 70,
        font_size      = 80
    })
    self.createButton({
        click_function = "moveL",
        function_owner = self,
        label          = "^",
        position       = { -0.2, 0.05, -0.3 },
        rotation       = { 0, -45, 0 },
        width          = 70,
        height         = 70,
        font_size      = 80
    })
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


function moveL()
    --print("BL")
    self.clearButtons()
    dork = self
    pos = LocalPos(dork, { 2.68, 0, -6.49 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] - 45
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    moveSet()
end

function moveS()
    --print("S")
    self.clearButtons()
    dork = self
    pos = LocalPos(dork, { 0, 0, -8 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2]
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    moveSet()
end

function moveR()
    --print("BR")
    self.clearButtons()
    dork = self
    pos = LocalPos(dork, { -2.68, 0, -6.49 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 45
    newRot[3] = rot[3]
    dorkMove(pos, newRot)
    moveSet()
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
-- TODO: move this to "TTS_lib.Vector.Vector"
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
