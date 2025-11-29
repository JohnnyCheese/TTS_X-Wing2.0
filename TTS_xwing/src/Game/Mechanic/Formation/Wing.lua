require("TTS_lib.Util.Math")
local Sequence = require("TTS_lib.Sequence.Sequence")
local Dim = require("Dim")

local nextSlot = 1
local collidingWith = {}
local suppressCollision = false
local currentFormation

local function buildWingFormation()
    local function calcOffset()
        local sz_base = Dim.Convert_mm_igu(Dim.mm_smallBase)
        local sz_tmpl_default = Dim.Convert_mm_igu(20)
        local sz_tmpl = sz_tmpl_default
        local bounds = self.getBoundsNormalized and self.getBoundsNormalized()
        local scale = self.getScale and self.getScale()
        if bounds and bounds.size and scale then
            sz_tmpl = bounds.size.z * scale.z
        end
        sz_tmpl = math.min(sz_tmpl, sz_tmpl_default)
        return (sz_base + sz_tmpl) / 2
    end

    local stateId = self.getStateId()
    local buffer = Dim.Convert_mm_igu(1.1)
    local offset = calcOffset()
    local offsetX = offset
    local offsetZ = offset + buffer

    local wingFormations = {
        [1] = {
            Vector(0.0, 0.0, -offsetZ),
            Vector(-2.0 * offsetX, 0.0, -offsetZ),
            Vector(2.0 * offsetX, 0.0, -offsetZ),
            Vector(0.0, 0.0, offsetZ),
            Vector(-2.0 * offsetX, 0.0, offsetZ),
            Vector(2.0 * offsetX, 0.0, offsetZ)
        },
        [2] = {
            Vector(0.0, 0.0, -offsetZ),
            Vector(0.0, 0.0, offsetZ)
        },
        [3] = {
            Vector(offsetX, 0.0, -offsetZ),
            Vector(-offsetX, 0.0, -offsetZ),
            Vector(offsetX, 0.0, offsetZ),
            Vector(-offsetX, 0.0, offsetZ)
        }
    }

    return wingFormations[stateId] or wingFormations[3]
end

function GetWingFormation()
    if not currentFormation then
        currentFormation = buildWingFormation()
    end
    return currentFormation
end

function ClearWing()
    nextSlot = 1
    collidingWith = {}
    suppressCollision = false
end

local function elementWiseDiv(a, b)
    return Vector(a.x / b.x, a.y / b.y, a.z / b.z)
end

function OffsetFrom(root, amt)
    local scaleVec = root.getScale()
    amt = elementWiseDiv(amt, scaleVec)
    return root.positionToWorld(amt)
end

function IsShip(obj)
    return Global.call("API_IsShipType", { ship = obj })
end

function onCollisionEnter(collision_info)
    if suppressCollision then return end
    local ship = collision_info.collision_object
    if not IsShip(ship) then return end
    if collidingWith[ship.guid] ~= nil then
        return
    end
    PositionShip(ship)
end

function onCollisionExit(collision_info)
    local ship = collision_info.collision_object
    if not IsShip(ship) then return end
    if collidingWith[ship.guid] == nil then return end
    collidingWith[ship.guid].active = false
end

function onLoad(save_data)
    self.bounciness = 0
    self.addContextMenuItem("Clear Template", ClearWing)
    ClearWing()
end

function onDrop(player_color)
    ClearWing()
    local ship = Global.call("API_FindNearestShip", { object = self, max_distance = 30 })
    if ship ~= nil then
        PositionTemplate(ship)
    end
end

-- Function to position a ship in the first available position
function PositionShip(ship)
    local currentFormation = GetWingFormation()
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
    local newPos = OffsetFrom(self, slotPos)
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

-- Function to position the template behind the lead ship
function PositionTemplate(ship)
    suppressCollision = true
    nextSlot = 1
    collidingWith[ship.guid] = { ship = ship, lock = ship.getLock(), slot = nextSlot }
    ship.setLock(true)
    self.setLock(true)
    local currentFormation = GetWingFormation()
    nextSlot = (nextSlot % #currentFormation) + 1
    local rot = ship.getRotation()

    local newPos = OffsetFrom(ship, -1 * Vector(currentFormation[collidingWith[ship.guid].slot]))
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
