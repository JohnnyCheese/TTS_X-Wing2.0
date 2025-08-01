local Dim = require("Dim")
local Vect = require("TTS_lib.Vector.Vector")

Parts = self
Attach = false
assignedShip = nil
checkingRange = nil


scale = 1 / self.getScale().x

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
    rotation = { 180, 0, 0 },
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
        end
    else
        checkingRange = nil
        self.clearButtons()
        self.setVectorLines({})
    end
end

-- Assign on drop near a small base ship
function onDropped()
    if assignedShip == nil then
        local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 80 })
        if nearest ~= nil then
            assignedShip = nearest
            size = assignedShip.getTable('Data').Size
            AttachBack(assignedShip)
        end
    end
end

function AttachBack()
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
    self.setPosition(newPos)
    self.setRotation(newRot)
    self.lock()
    if size == 'small' then
        pos = LocalPos(self, { 1.52, -0.5, 0 })
    elseif size == 'medium' then
        pos = LocalPos(self, { 1.9, -0.5, 0 })
    elseif size == 'large' then
        pos = LocalPos(self, { 2.27, -0.5, 0 })
    end
    self.clearButtons()
    local rot = self.getRotation()
    local newRot = {}
    newRot[1] = rot[1]
    newRot[2] = rot[2] - 90
    newRot[3] = rot[3]
    self.setPosition(pos)
    self.setRotation(newRot)
    Global.call('API_MineDrop', { mine = self, ship = assignedShip })
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
