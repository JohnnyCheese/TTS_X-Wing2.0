local Dim = require("Dim")

local RangeCheck = {}

local RULER_MESH_BASE =
    "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/bomb_range_"
local MINI_COLLIDER =
    "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/minicollider.obj"
local BOMB_COLLIDER =
    "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/bomb_collider.obj"
local ANNOUNCEMENT_COLOR = { 1.0, 1.0, 0 }

local function isShipFigurine(obj)
    return obj ~= nil
        and (obj.type == "Figurine" or obj.tag == "Figurine")
        and obj.getVar("__XW_Ship") == true
end

local function getShipObjects(source)
    if source == "tags" then
        return getObjectsWithAnyTags({ "Ship" })
    end

    local ships = {}
    for _, obj in pairs(getAllObjects()) do
        if isShipFigurine(obj) then
            table.insert(ships, obj)
        end
    end
    return ships
end

local function addLine(lines, owner, pointA, pointB, thickness)
    table.insert(lines, {
        points = { owner.positionToLocal(pointA), owner.positionToLocal(pointB) },
        color = { 1, 1, 1 },
        thickness = thickness,
        rotation = vector(0, 0, 0)
    })
end

local function getClosestShipPoints(owner, ship)
    local ownPoint = owner.getNearestPointFromObject(ship)
    local closest = Global.call("API_GetClosestPointToShip", { ship = ship, point = ownPoint })
    return closest.A, closest.B, Dim.Convert_igu_mm(closest.length)
end

local function getNearestPlanarPoints(owner, obj)
    local ownPoint = owner.getNearestPointFromObject(obj)
    local otherPoint = obj.getNearestPointFromObject(owner)
    otherPoint.y = ownPoint.y

    local distance = Dim.Convert_igu_mm(math.sqrt(
        math.pow(ownPoint.x - otherPoint.x, 2) +
        math.pow(ownPoint.z - otherPoint.z, 2)
    ))

    return ownPoint, otherPoint, distance
end

local function announceShips(owner, range, shipNames)
    if #shipNames > 0 then
        printToAll("Ships within range " .. tostring(range) .. " of " .. owner.getName() .. ": " ..
            table.concat(shipNames, ", "), ANNOUNCEMENT_COLOR)
    else
        printToAll("No ships within range " .. tostring(range) .. " of " .. owner.getName(), ANNOUNCEMENT_COLOR)
    end
end

function RangeCheck.collectShipLines(owner, range, options)
    options = options or {}
    local lines = {}
    local shipNames = {}
    local thickness = options.thickness or 0.1
    local maxDistance = options.maxDistance or (100 * range)

    for _, ship in pairs(getShipObjects(options.shipSource)) do
        local pointA, pointB, distance
        if options.pointMode == "nearest_planar" then
            pointA, pointB, distance = getNearestPlanarPoints(owner, ship)
        else
            pointA, pointB, distance = getClosestShipPoints(owner, ship)
        end

        if distance < maxDistance then
            table.insert(shipNames, ship.getName())
            addLine(lines, owner, pointA, pointB, thickness)
        end
    end

    return lines, shipNames
end

function RangeCheck.collectObstacleLines(owner, range, options)
    options = options or {}
    local lines = {}
    local thickness = options.thickness or 0.05
    local maxDistance = options.maxDistance or (100 * range)

    for _, obj in pairs(getObjectsWithAnyTags({ "Obstacle" })) do
        if obj.getName() ~= "Board Edge" then
            local pointA = owner.getNearestPointFromObject(obj) + vector(0, 0.1, 0)
            local pointB = obj.getNearestPointFromObject(owner) + vector(0, 0.1, 0)
            local distance = Dim.Convert_igu_mm(math.sqrt(
                math.pow(pointA.x - pointB.x, 2) +
                math.pow(pointA.z - pointB.z, 2)
            ))

            if distance < maxDistance then
                printToAll(obj.getName() .. " is within range " .. tostring(range) .. " of " .. owner.getName(),
                    ANNOUNCEMENT_COLOR)
                addLine(lines, owner, pointA, pointB, thickness)
            end
        end
    end

    return lines
end

function RangeCheck.appendLines(target, source)
    for _, line in ipairs(source) do
        table.insert(target, line)
    end
end

local function createBombRemoveButton(owner, clickFunction)
    return {
        click_function = clickFunction,
        label = "DEL",
        function_owner = owner,
        position = { 0, 0.1, 0 },
        rotation = { 0, 270, 0 },
        width = 750,
        height = 750,
        font_size = 250,
        color = { 0.7, 0.7, 0.7 }
    }
end

function RangeCheck.spawnBombRuler(owner, range, options)
    options = options or {}
    local spawnedRuler = spawnObject({
        type = "Custom_Model",
        position = owner.positionToWorld({ 0, 0.4, 0 }),
        rotation = owner.getRotation(),
        scale = owner.getScale()
    })

    spawnedRuler.setCustomObject({
        mesh = RULER_MESH_BASE .. tostring(range) .. ".obj",
        collider = options.collider or MINI_COLLIDER
    })
    spawnedRuler.setColorTint(color(1, 1, 0, 0.2))

    local lines, shipNames = RangeCheck.collectShipLines(owner, range, {
        shipSource = options.shipSource,
        pointMode = options.pointMode,
        thickness = options.thickness or 0.1,
        maxDistance = options.maxDistance
    })
    announceShips(owner, range, shipNames)

    spawnedRuler.setVectorLines(lines)
    spawnedRuler.createButton(createBombRemoveButton(owner, options.removeFunction or "ToggleRuler"))
    spawnedRuler.lock()

    return spawnedRuler
end

function RangeCheck.toggleBombRuler(owner, spawnedRuler, range, currentRange, options)
    if spawnedRuler then
        spawnedRuler.destruct()
        if currentRange == nil or currentRange == range then
            return nil, nil, false
        end
    end

    return RangeCheck.spawnBombRuler(owner, range, options), range, true
end

function RangeCheck.checkObjectRange(owner, range, currentRange, removeButtonUp, removeButtonDown, options)
    options = options or {}

    if range and currentRange ~= range then
        local subject = options.includeObstacles and "ships and obstacles" or "ships"
        printToAll("Checking for " .. subject .. " within range " .. tostring(range) .. " of " .. owner.getName(),
            ANNOUNCEMENT_COLOR)

        local lines, shipNames = RangeCheck.collectShipLines(owner, range, {
            shipSource = "tags",
            thickness = options.thickness or 0.05
        })

        if options.includeObstacles then
            RangeCheck.appendLines(lines, RangeCheck.collectObstacleLines(owner, range, {
                thickness = options.thickness or 0.05
            }))
        end

        owner.clearButtons()
        owner.setVectorLines(lines)

        if #lines > 0 then
            announceShips(owner, range, shipNames)
            if owner.is_face_down then
                owner.createButton(removeButtonDown)
            else
                owner.createButton(removeButtonUp)
            end
            return range
        end

        announceShips(owner, range, shipNames)
        return nil
    end

    owner.clearButtons()
    owner.setVectorLines({})
    return nil
end

RangeCheck.BOMB_COLLIDER = BOMB_COLLIDER

return RangeCheck
