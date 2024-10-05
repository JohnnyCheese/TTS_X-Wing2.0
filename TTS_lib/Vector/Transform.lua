-- Define a class for Transform
local Transform = {}
Transform.__index = Transform

-- Constructor
function Transform:new(targetPosition, targetForward)
    local self = setmetatable({}, Transform)
    self.targetPosition = targetPosition
    self.targetForward = targetForward:normalize()
    return self
end

-- Method to calculate the centroid of a group of objects
function Transform:calculateCentroid(objects)
    local sum = Vector(0, 0, 0)
    for _, obj in ipairs(objects) do
        sum:add(obj.getPosition())
    end
    return sum:scale(1.0 / #objects)
end

-- Method to calculate the rotation angle between two forward vectors
function Transform:calculateRotationAngle(currentForward, targetForward)
    local angle = targetForward:angle(currentForward)

    -- Determine the sign of the angle based on the cross product
    local crossProduct = targetForward:cross(currentForward)
    if crossProduct.y < 0 then
        angle = -angle
    end

    return angle
end

-- Method to rotate a point around the Y-axis by a given angle
function Transform:rotateAroundY(point, origin, angle)
    local pos = point - origin
    pos:rotateOver('y', angle)
    return pos + origin
end

-- Method to apply the transformation to a single object
function Transform:applyToObject(object, centroid, rotationAngle)
    local currentPos = object.getPosition()

    -- Rotate the object around the centroid
    local rotatedPos = self:rotateAroundY(currentPos, centroid, rotationAngle)

    -- Calculate translation
    local translation = self.targetPosition - centroid

    -- Apply translation
    local newPos = rotatedPos + translation
    object.setPositionSmooth(newPos)

    -- Apply rotation
    local currentRotation = object.getRotation()
    local newRot = {
        x = currentRotation.x,
        y = (currentRotation.y + rotationAngle) % 360,
        z = currentRotation.z,
    }
    object.setRotationSmooth(newRot)
end

-- Public method to apply the transformation to a single object or a table of objects
function Transform:translate(objects)
    local objectList = objects
    if type(objects) ~= "table" then
        objectList = { objects }
    end

    local centroid = self:calculateCentroid(objectList)
    local currentForward = objectList[1]:getTransformForward():normalize()
    local rotationAngle = self:calculateRotationAngle(currentForward, self.targetForward)

    for _, obj in ipairs(objectList) do
        self:applyToObject(obj, centroid, rotationAngle)
    end
end

return Transform
