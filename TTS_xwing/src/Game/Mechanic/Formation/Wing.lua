require("TTS_lib.Util.Math")
local Dim = require("Dim")

local nextSlot = 1
local prevShip = nil
local debounce = nil

function calcOffset()
    local sz_base = Dim.Convert_mm_igu(Dim.mm_smallBase)
    local sz_tmpl = Dim.Convert_mm_igu(20)
    return (sz_base + sz_tmpl) / 2
end

function getWingFormation()
    local stateId = self.getStateId()
    local offset = calcOffset()
    -- Define the positions for each Wing Formation
    local wingFormations = {
        [1] = {                                          -- Configuration for 6 ships
            { x = 0.0,           y = 0.0, z = -offset }, -- Lead
            { x = -2.0 * offset, y = 0.0, z = -offset }, -- Right Wing
            { x = 2.0 * offset,  y = 0.0, z = -offset }, -- Left Wing
            { x = 0.0,           y = 0.0, z = offset },  -- Slot
            { x = -2.0 * offset, y = 0.0, z = offset },  -- Right Outer Wing
            { x = 2.0 * offset,  y = 0.0, z = offset }   -- Left Outer Wing
        },
        [2] = {                                          -- Configuration for 2 ships
            { x = 0.0, y = 0.0, z = -offset },           -- lead
            { x = 0.0, y = 0.0, z = offset }             -- Slot
        },
        [3] = {                                          -- Configuration for 4 ships
            { x = offset,  y = 0.0, z = -offset },       -- Lead
            { x = -offset, y = 0.0, z = -offset },       -- Right Wing
            { x = offset,  y = 0.0, z = offset },        -- Slot
            { x = -offset, y = 0.0, z = offset }         -- Right Rear Wing
        }
    }
    return wingFormations[stateId] or wingFormations[3] -- Default to 4 positions if the state is unknown
end

-- Function to position a ship in the first available position
function positionShip(ship)
    if ship == prevShip then
        return
    end
    prevShip = ship

    local currentFormation = getWingFormation()

    local slot = nextSlot
    if slot > #currentFormation then
        slot = 1
    end

    local scale = self.getScale()
    local pos = currentFormation[slot]
    pos.x = pos.x / scale.x
    pos.y = pos.y / scale.y
    pos.z = pos.z / scale.z
    local newPos = self.positionToWorld(pos)

    local rotation = self.getRotation()

    ship.setRotationSmooth(rotation, false, true)
    ship.setPositionSmooth(newPos, false, true)
    nextSlot = (slot % #currentFormation) + 1
end

-- Function to check if an object is a ship
function isShip(obj)
    return obj.hasTag("Ship")
end

-- Event triggered when a ship collides with the tool
function onCollisionEnter(collision_info)
    local obj = collision_info.collision_object

    if debounce == obj then
        return
    end

    debounce = obj
    if isShip(obj) then
        obj.setLock(true)
        positionShip(obj)
        obj.setLock(false)
    end
end

function onCollisionExit(collision_info)
    local obj = collision_info.collision_object
    debounce = nil
end

function clearWing()
    nextSlot = 1
    prevShip = nil
    debounce = nil
end

function onLoad()
    self.addContextMenuItem("Clear Template", clearWing)
    clearWing()
end

function onDrop(player_color)
    clearWing()
end
