require("TTS_lib.Util.Table")
local Probe = require("Marker.Probe")
local Dim = require("Dim")
local PlayerArea = require("Player.PlayerArea")
local ButtonTest = require("Test.ButtonTest")

local Squadron = {}
Squadron.__index = Squadron

function Squadron:new(playerArea)
    local self = setmetatable({}, Squadron)
    self.objects = self:performCast()
    self.playerArea = playerArea
    return self
end

function Squadron:performCast()
    local dataPadSpawnArea = {
        origin = Vector(-64.00, 0.0, -30.00), -- Start below the objects
        direction = Vector(0, 0, 1),          -- Move in the positive z-direction
        type = 3,
        size = Vector(13, 10, 5),             -- Extend in the x, y, and z dimensions
        orientation = Vector(0, 0, 0),
        max_distance = 30,
        debug = true,
    }

    local castResult = Physics.cast(dataPadSpawnArea)
    local spawnedObjects = {}
    for _, hit_result in ipairs(castResult) do
        local obj = hit_result.hit_object
        if obj.locked == false and obj.interactable == true then
            table.insert(spawnedObjects, obj)
        end
    end
    return spawnedObjects
end

function Squadron:getObjects()
    return self.objects
end

function Squadron:getDials()
    local dials = {}
    for _, obj in ipairs(self.objects) do
        if obj.getName() == "Unassigned Dial" then
            table.insert(dials, obj)
        end
    end
    table.print(dials, "dials: ")
    return dials
end

function Squadron:getShips()
    local ships = {}
    for _, obj in ipairs(self.objects) do
        if obj.type == 'Figurine' then
            table.insert(ships, obj)
        end
    end
    table.print(ships, "ship: ")
    return ships
end

-- Method to check if all objects are at rest
function Squadron:allObjectsAtRest()
    for _, obj in ipairs(self.objects) do
        if obj.isSmoothMoving() or not obj.resting then
            return false
        end
    end
    return true
end

-- Function to assign the dial to the nearest ship
function Squadron:assignNearestShip(dial)
    printToAll("assignNearestShip ", Color.Orange)

    local playerColor = self.playerArea.player.color
    local dialPos = dial.getPosition()
    local minDist = Dim.Convert_mm_igu(80)
    local ships = self:getShips()
    local nearest = nil
    printToAll("#ships " .. #ships, Color.Orange)
    printToAll("minDist " .. tostring(minDist), Color.Orange)

    for _, ship in pairs(self:getShips()) do
        -- Probe.printObjectInfo(ship)
        if ship.type == 'Figurine' and ship.name ~= '' then
            local shipPos = ship.getPosition()
            local dist = dialPos:distance(shipPos)
            if dist < minDist then
                nearest = ship
                minDist = dist
            end
        end
    end

    if nearest ~= nil then
        if playerColor == "White" then
            printToAll("Please, pick a color before assigning dials")
        else
            nearest.setVar('owningPlayer', playerColor)
            dial.setVar('playerColor', playerColor)
            dial.setRotation(nearest.getRotation())
            dial.call("assignShip", { ship = nearest })
            dial.call("placeShip", { playerColor })
            Global.call("API_AssignDial", { dial = dial, ship = nearest, player = playerColor })
        end
    end
end

function Squadron:dropDials()
    local toShip = 3 * self.playerArea.forward
    toShip.y = 5
    for _, dial in ipairs(self:getDials()) do
        local shipPos = dial.getPosition() + toShip
        Wait.condition(function()
            dial.setPositionSmooth(shipPos, true, false)
            Wait.condition(function()
                self:assignNearestShip(dial)
            end, function()
                return self:allObjectsAtRest()
            end)
        end, function()
            return self:allObjectsAtRest()
        end)
    end
end

return Squadron
