require("TTS_lib.Util.Math")
local Sequence = require("TTS_lib.Sequence.Sequence")
local Dim = require("Dim")

local nextSlot = 1
local collidingWith = {}
local suppressCollision = false

function getWingFormation()
    function calcOffset()
        local sz_base = Dim.Convert_mm_igu(Dim.mm_smallBase)
        local sz_tmpl = Dim.Convert_mm_igu(20)
        return (sz_base + sz_tmpl) / 2
    end

    local stateId = self.getStateId()
    local offset = calcOffset()
    -- Define the positions for each Wing Formation
    local wingFormations = {
        [1] = {                                  -- Configuration for 6 ships
            Vector(0.0, 0.0, -offset),           -- Wing Leader
            Vector(-2.0 * offset, 0.0, -offset), -- Right Flank
            Vector(2.0 * offset, 0.0, -offset),  -- Left Flank
            Vector(0.0, 0.0, offset),            -- Rear Support
            Vector(-2.0 * offset, 0.0, offset),  -- Right Support
            Vector(2.0 * offset, 0.0, offset)    -- Left  Support
        },
        [2] = {                                  -- Configuration for 2 ships
            Vector(0.0, 0.0, -offset),           -- Wing Leader
            Vector(0.0, 0.0, offset)             -- Rear Support
        },
        [3] = {                                  -- Configuration for 4 ships
            Vector(offset, 0.0, -offset),        -- Wing Leader
            Vector(-offset, 0.0, -offset),       -- Right Flank
            Vector(offset, 0.0, offset),         -- Rear Support
            Vector(-offset, 0.0, offset)         -- Right Support
        }
    }
    return wingFormations[stateId] or wingFormations[3] -- Default to 4 positions if the state is unknown
end

function clearWing()
    nextSlot = 1
    collidingWith = {}
    suppressCollision = false
end

function offsetFrom(root, amt)
    function elementWiseDiv(a, b)
        return Vector(a.x / b.x, a.y / b.y, a.z / b.z)
    end

    local scaleVec = root.getScale()
    amt = elementWiseDiv(amt, scaleVec)
    return root.positionToWorld(amt)
end

function isShip(obj)
    return Global.call("API_IsShipType", { ship = obj })
end

function onCollisionEnter(collision_info)
    if suppressCollision then return end
    local ship = collision_info.collision_object
    if not isShip(ship) then return end
    if collidingWith[ship.guid] ~= nil then
        return
    end
    positionShip(ship)
end

function onCollisionExit(collision_info)
    local ship = collision_info.collision_object
    if not isShip(ship) then return end
    if collidingWith[ship.guid] == nil then return end
    collidingWith[ship.guid].active = false
end

function onLoad()
    self.bounciness = 0
    self.addContextMenuItem("Clear Template", clearWing)
    clearWing()
end

function onDrop(player_color)
    clearWing()
    local ship = Global.call("API_FindNearestShip", { object = self, max_distance = 30 })
    if ship ~= nil then
        positionTemplate(ship)
    end
end

-- Function to position a ship in the first available position
function positionShip(ship)
    local currentFormation = getWingFormation()
    local slot = nextSlot
    nextSlot = (slot % #currentFormation) + 1
    if collidingWith[ship.guid] == nil then
        collidingWith[ship.guid] = { ship = ship, lock = ship.getLock(), slot = slot, active = true }
    else
        nextSlot = collidingWith[ship.guid].slot
        collidingWith[ship.guid].slot = slot
    end
    self.setLock(true)
    ship.setLock(true)

    local slotPos = currentFormation[collidingWith[ship.guid].slot]
    local newPos = offsetFrom(self, slotPos)
    local rotation = self.getRotation()

    local seq = Sequence.new(true)

    ship.setRotationSmooth(rotation, false, true)
    ship.setPositionSmooth(newPos, false, true)

    seq:waitCondition(function()
        self.setLock(false)
        ship.setLock(collidingWith[ship.guid].lock)
    end, function() return ship.resting and self.resting end)

    seq:start()
end

function positionTemplate(ship)
    suppressCollision = true
    nextSlot = 1
    collidingWith[ship.guid] = { ship = ship, lock = ship.getLock(), slot = nextSlot }
    ship.setLock(true)
    self.setLock(true)
    local currentFormation = getWingFormation()
    nextSlot = (nextSlot % #currentFormation) + 1
    local rot = ship.getRotation()

    local newPos = offsetFrom(ship, -1 * Vector(currentFormation[collidingWith[ship.guid].slot]))
    newPos.y = self.getPosition().y

    local seq = Sequence.new(true)

    self.setRotationSmooth(rot, false, true)
    self.setPositionSmooth(newPos, false, true)
    self.setLock(false)
    function release()
        ship.setLock(collidingWith[ship.guid].lock)
        suppressCollision = false
    end

    seq:waitCondition(release,
        function() return ship.resting and self.resting end,
        2, release)

    seq:start()
end
