local Dim = require("Dim")

local igu = Dim.Convert_mm_igu
-- TODO: add reverse move, and reverse bank

-----------------------------
-- Strategy Design Pattern --
-----------------------------

-- Base MovementStrategy class
local ManeuverStrategy = {}
ManeuverStrategy.__index = ManeuverStrategy

function ManeuverStrategy:new()
    return setmetatable({}, self)
end

function ManeuverStrategy:execute(ship)
    -- To be overridden by subclasses
end

function ManeuverStrategy:getBaseSize(ship)
    local shipData = ship.getTable("Data")
    local size = shipData.Size or "small"
    if type(size) == "string" then
        return igu(Dim.mm_baseSize[size])
    elseif type(size) == "number" then
        return igu(size) -- Assuming the size is provided in mm
    else
        error("Invalid size type")
    end
end

--[[
    If the forward Vector of the object doesn't line up with the object
    visually, you can attach an angle value here to correct the forward vector
    by rotating it around the y-axis by the provided angle in degrees.
    This will correct an object's forward vector to move it properly.
    [+ is clockwise, - is counter-clockwise]
 ]]
function ManeuverStrategy:getForwardVector(ship)
    local shipData = ship.getTable("Data")
    local forwardAdjustment = shipData.forwardAdjustment or 0
    local forward = ship.getTransformForward():copy()
    forward = forward:rotateOver("y", forwardAdjustment)
    return forward:normalized()
end

-- StraightMove class inherits from MovementStrategy
local Straight = setmetatable({}, { __index = ManeuverStrategy })
Straight.__index = Straight

function Straight:new(speed, rotation)
    local instance = ManeuverStrategy:new()
    instance.speed = igu(Dim.XWingTemplates.straight[speed])
    instance.rotation = rotation or 0
    return setmetatable(instance, self)
end

function Straight:execute(ship)
    local forward = self:getForwardVector(ship)
    local baseSize = self:getBaseSize(ship)
    local posDelta = (self.speed + baseSize) * forward
    local newPos = ship.getPosition() + posDelta
    local newRot = ship.getRotation() + Vector(0, self.rotation, 0)
    ship.setPositionSmooth(newPos, false, true)
    ship.setRotationSmooth(newRot, false, false)
end

-- KoiogranTurn class inherits from StraightMove
local KoiogranTurn = setmetatable({}, { __index = Straight })
KoiogranTurn.__index = KoiogranTurn

function KoiogranTurn:new(speed)
    local instance = Straight:new(speed, 180)
    return setmetatable(instance, self)
end

function KoiogranTurn:execute(ship)
    Straight.execute(self, ship)
end

-- Moves along a curved template
local ArcMove = setmetatable({}, { __index = ManeuverStrategy })
ArcMove.__index = ArcMove

function ArcMove:new(radius, angle, bearing, extraRot)
    local instance = ManeuverStrategy:new()
    instance.radius = igu(radius)
    instance.angle = angle
    instance.bearing = bearing or "right" -- Default to right if no bearing is provided
    instance.extraRotation = extraRot or 0
    return setmetatable(instance, self)
end

function ArcMove:execute(ship)
    local sign = (self.bearing == "right" and 1) or -1 -- + is clockwise, - is counter-clockwise
    local turnAngle = sign * self.angle
    local rotAngle = sign * (self.angle + self.extraRotation)

    -- Get ship's forward vector and base size
    local forward = self:getForwardVector(ship)
    local baseSize = self:getBaseSize(ship)

    -- Step 1: Initial straight move by half the base size
    local initialPos = ship.getPosition() + (baseSize / 2) * forward

    -- Recalculate arcCenter based on the new position
    local turnDirection = sign * forward:copy():rotateOver("y", 90):normalized()
    local arcCenter = initialPos + turnDirection * self.radius

    -- Step 2: Arc move
    local newPos = arcCenter + (initialPos - arcCenter):rotateOver("y", turnAngle)

    -- Step 3: Final straight move by half the base size
    newPos = newPos + (baseSize / 2) * forward:rotateOver("y", turnAngle):normalized()

    -- Determine new rotation
    local newRot = ship.getRotation() + Vector(0, rotAngle, 0)

    -- Update ship position and rotation smoothly
    ship.setPositionSmooth(newPos, false, false)
    ship.setRotationSmooth(newRot, false, false)
end

-- TurnMove class inherits from ArcMove
local TurnMove = setmetatable({}, { __index = ArcMove })
TurnMove.__index = TurnMove

function TurnMove:new(speed, bearing)
    return setmetatable(ArcMove:new(Dim.XWingTemplates.turn[speed], 90, bearing), self)
end

-- BankMove class inherits from ArcMove
local BankMove = setmetatable({}, { __index = ArcMove })
BankMove.__index = BankMove

function BankMove:new(speed, bearing)
    return setmetatable(ArcMove:new(Dim.XWingTemplates.bank[speed], 45, bearing), self)
end

-- SegnorLoop class inherits from ArcMove
local SegnorLoop = setmetatable({}, { __index = ArcMove })
SegnorLoop.__index = SegnorLoop

function SegnorLoop:new(speed, bearing)
    local instance = ArcMove:new(Dim.XWingTemplates.bank[speed], 45, bearing, 180) -- Using 45 degrees as the bank angle
    return setmetatable(instance, self)
end

-- TallonRoll class inherits from ArcMove
local TallonRoll = setmetatable({}, { __index = ArcMove })
TallonRoll.__index = TallonRoll

function TallonRoll:new(speed, bearing)
    local instance = ArcMove:new(Dim.XWingTemplates.turn[speed], 90, bearing, 90)
    return setmetatable(instance, self)
end

-- Main Movement class
local Maneuver = {}
Maneuver.__index = Maneuver

-- Define the moveStrategies table once, outside of the constructor
Maneuver.maneuverTemplates = {
    -- Straight Maneuvers
    s1 = Straight:new(1),
    s2 = Straight:new(2),
    s3 = Straight:new(3),
    s4 = Straight:new(4),
    s5 = Straight:new(5),

    -- Koiogran Turn (Straight Move with a 180º Rotation Maneuver)
    k1 = KoiogranTurn:new(1),
    k2 = KoiogranTurn:new(2),
    k3 = KoiogranTurn:new(3),
    k4 = KoiogranTurn:new(4),
    k5 = KoiogranTurn:new(5),

    -- Turn (90º Turn Maneuver)
    tr1 = TurnMove:new(1, "right"),
    tr2 = TurnMove:new(2, "right"),
    tr3 = TurnMove:new(3, "right"),

    tl1 = TurnMove:new(1, "left"),
    tl2 = TurnMove:new(2, "left"),
    tl3 = TurnMove:new(3, "left"),

    -- Bank (45º Turn Maneuver)
    br1 = BankMove:new(1, "right"),
    br2 = BankMove:new(2, "right"),
    br3 = BankMove:new(3, "right"),

    bl1 = BankMove:new(1, "left"),
    bl2 = BankMove:new(2, "left"),
    bl3 = BankMove:new(3, "left"),

    -- Segnor Loop (45º Turn with a 180º Rotation Maneuver)
    br1s = SegnorLoop:new(1, "right"),
    br2s = SegnorLoop:new(2, "right"),
    br3s = SegnorLoop:new(3, "right"),

    bl1s = SegnorLoop:new(1, "left"),
    bl2s = SegnorLoop:new(2, "left"),
    bl3s = SegnorLoop:new(3, "left"),

    -- Tallon Roll (90º Turn with a 90º Rotation Maneuver)
    tr1t = TallonRoll:new(1, "right"),
    tr2t = TallonRoll:new(2, "right"),
    tr3t = TallonRoll:new(3, "right"),

    tl1t = TallonRoll:new(1, "left"),
    tl2t = TallonRoll:new(2, "left"),
    tl3t = TallonRoll:new(3, "left"),
}

function Maneuver:new()
    return setmetatable({}, self)
end

function Maneuver:execute(ship, maneuverType)
    local maneuver = self.maneuverTemplates[maneuverType]
    if ship and maneuver then
        maneuver:execute(ship)
    else
        print("Invalid: ship: " .. tostring(ship) .. " with move type: " .. maneuverType)
    end
end

return Maneuver
