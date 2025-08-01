local Dim = require("Dim")
local Vect = require("TTS_lib.Vector.Vector")

Buzz = self
Attach = false
assignedShip = nil


scale = 1 / self.getScale().x
checkingRange = nil

local removeButtonUp = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = { 0, 0.1 * scale, 0 },
    rotation = { 0, 90, 0 },
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
    rotation = { 180, 90, 0 },
    width = 400 * scale,
    height = 300 * scale,
    font_size = 100 * scale,
    color = { 0.7, 0.7, 0.7 }
}

function removeCheckRange()
    checkRange(nil)
end

function onLoad(save_state)
    self.addContextMenuItem("Check Range 1", function() checkRange(1) end, false)
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
            mainSet()
            self.setVectorLines({})
        end
    else
        printToAll("No ship assigned to " .. self.getName(), color(1.0, 1.0, 0))
    end
end

-- Assign on drop near a small base ship
function onDropped(color)
    if assignedShip == nil then
        local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 80 })
        if nearest ~= nil and Attach == false then
            printToAll('Buzz Droids Preparing to Launch')
            initialP = self.getPosition()
            assignedShip = nearest
            local pos = assignedShip.getPosition()
            local rot = assignedShip.getRotation()
            local newPos = {}
            local newRot = {}
            newPos[1] = pos[1]
            newPos[2] = 1.5
            newPos[3] = pos[3]
            newRot[1] = rot[1]
            newRot[2] = rot[2] - 90
            newRot[3] = rot[3]
            Global.call("API_ClearPosition", { pos = newPos, reach = 0.5 })
            self.setPositionSmooth(newPos, false, true)
            self.setRotationSmooth(newRot, false, true)
            self.lock()
            Launch()
        elseif nearest ~= nil and Attach == true then
            assignedShip = nearest
            size = assignedShip.getTable('Data').Size
            AttachSetting(assignedShip)
        end
    end
    self.setColorTint(Color.fromString(color))
end

function onPickUp(color)
    self.setColorTint(Color.fromString(color))
end

function AttachSetting(assignedShip)
    local pos = assignedShip.getPosition()
    local rot = assignedShip.getRotation()
    local newPos = {}
    local newRot = {}
    newPos[1] = pos[1]
    newPos[2] = 1.5
    newPos[3] = pos[3]
    newRot[1] = rot[1]
    newRot[2] = rot[2] - 90
    newRot[3] = rot[3]
    Global.call("API_ClearPosition", { pos = newPos, reach = 0.5 })
    self.setPositionSmooth(newPos, false, true)
    self.setRotationSmooth(newRot, false, true)
    self.lock()
    self.createButton({
        click_function = "AttachFront",
        function_owner = self,
        label          = "^",
        position       = { 0.9, 0.1, 0 },
        rotation       = { 0, 90, 0 },
        width          = 200,
        height         = 200,
        font_size      = 150
    })
    self.createButton({
        click_function = "AttachBack",
        function_owner = self,
        label          = "^",
        position       = { -0.9, 0.1, 0 },
        rotation       = { 0, -90, 0 },
        width          = 200,
        height         = 200,
        font_size      = 150
    })
end

function AttachFront()
    if size == 'small' then
        pos = LocalPos(self, { -1.46, -0.5, 0 })
    elseif size == 'medium' then
        pos = LocalPos(self, { -1.84, -0.5, 0 })
    elseif size == 'large' then
        pos = LocalPos(self, { -2.2, -0.5, 0 })
    end
    self.clearButtons()
    local rot = self.getRotation()
    local newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 180
    newRot[3] = rot[3]
    buzzMove(pos, newRot)
    mainSet()
end

function AttachBack()
    if size == 'small' then
        pos = LocalPos(self, { 1.46, -0.5, 0 })
    elseif size == 'medium' then
        pos = LocalPos(self, { 1.84, -0.5, 0 })
    elseif size == 'large' then
        pos = LocalPos(self, { 2.2, -0.5, 0 })
    end
    self.clearButtons()
    local rot = self.getRotation()
    local newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2]
    newRot[3] = rot[3]
    buzzMove(pos, newRot)
    mainSet()
end

-- Init
-- x -13.7
-- z -5.36

-- Bank3
-- x -16.15
-- z 0.48

-- Dx = 2.45
-- Dz = 5.84


-- Straight
-- -6.14
-- -11.88
-- Dz = 5.74

function Launch()
    self.createButton({
        click_function = "BuzzLaunchBR",
        function_owner = self,
        label          = "^",
        position       = { 0.9, 0.1, 0.5 },
        rotation       = { 0, 135, 0 },
        width          = 200,
        height         = 200,
        font_size      = 150
    })
    self.createButton({
        click_function = "BuzzLaunchS",
        function_owner = self,
        label          = "^",
        position       = { 0.9, 0.1, 0 },
        rotation       = { 0, 90, 0 },
        width          = 200,
        height         = 200,
        font_size      = 150
    })
    self.createButton({
        click_function = "BuzzLaunchBL",
        function_owner = self,
        label          = "^",
        position       = { 0.9, 0.1, -0.5 },
        rotation       = { 0, 45, 0 },
        width          = 200,
        height         = 200,
        font_size      = 150
    })
    self.createButton({
        click_function = "BuzzCancel",
        function_owner = self,
        label          = "Cancel",
        position       = { 0, 0.1, 0.5 },
        rotation       = { 0, 90, 0 },
        width          = 400,
        height         = 200,
        font_size      = 150
    })
end

function BuzzCancel()
    self.unlock()
    self.clearButtons()
    Global.call("API_ClearPosition", { pos = initialP, reach = 0.5 })
    self.setPositionSmooth(initialP, false, true)
    assignedShip = nil
end

function BuzzLaunchBL()
    self.clearButtons()
    pos = LocalPos(self, { -5.84, -0.5, -2.45 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] - 45
    newRot[3] = rot[3]
    buzzMove(pos, newRot)
    mainSet()
end

function BuzzLaunchS()
    self.clearButtons()
    pos = LocalPos(self, { -5.74, -0.5, 0 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2]
    newRot[3] = rot[3]
    buzzMove(pos, newRot)
    mainSet()
end

function BuzzLaunchBR()
    self.clearButtons()
    pos = LocalPos(self, { -5.84, -0.5, 2.45 })
    local rot = self.getRotation()
    newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] + 45
    newRot[3] = rot[3]
    buzzMove(pos, newRot)
    mainSet()
end

function buzzMove(pos, rot)
    Global.call("API_ClearPosition", { pos = pos, reach = 0.5 })
    self.setPositionSmooth(pos, false, true)
    self.setRotationSmooth(rot, false, true)
end

function mainSet()
    self.clearButtons()
    self.createButton({
        click_function = "BuzzAttach",
        function_owner = self,
        label          = "Attach",
        position       = { 0, 0.1, 0 },
        rotation       = { 0, 90, 0 },
        width          = 600,
        height         = 200,
        font_size      = 180,
    })
end

function BuzzAttach()
    self.clearButtons()
    self.unlock()
    backupPos = self.getPosition()
    backupRot = self.getRotation()
    Attach = true
    assignedShip = nil
    self.createButton({
        click_function = "Restore",
        function_owner = self,
        label          = "Back",
        position       = { 0, 0.1, 0 },
        rotation       = { 0, 90, 0 },
        width          = 600,
        height         = 200,
        font_size      = 180,
    })
end

function Restore()
    Global.call("API_ClearPosition", { pos = backupPos, reach = 0.5 })
    self.setPositionSmooth(backupPos, false, true)
    self.setRotationSmooth(backupRot, false, true)
    self.clearButtons()
    mainSet()
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
