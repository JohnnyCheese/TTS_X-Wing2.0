--[[ Tranport Freighter
  Aid to migrate HotAC-type games. Perhaps a Memory Bag type "Rebel Transport" (or "Bulk Freighter")
    to collect all player artifacts and transport them to a new release of the Unified Mod.
    1. Create a baseline of all default in-game objects - these don't have to be moved.
    1. Packup player's objects and store in Transport Memory Bag.
    1. Save transport as an external object
    1. Load new version of the X-Wing Mod
    1. Spawn the saved Transport external object
    1. Deploy transported game objects
]]
require("TTS_lib.Util.Table")

local name = "HotAC Transport Freighter"

-- Table to store the exclude list of base game object GUIDs
local excludeList = {
    self.getGUID()
    -- populate with base game objects
}

-- Table to store transported objects' data
local transportCargo = {}

-- Respawns any ship with this script to turn it into a Transport Freighter "Bag"
function createTransportFreighterBag()
    local transportFreighterBag = self
    transportFreighterBag.setName(name)
    transportFreighterBag.setDescription("name " .. name)

    local info = transportFreighterBag.getCustomObject()
    info.type = 6
    info.cast_shadows = true
    transportFreighterBag.setCustomObject(info)
    transportFreighterBag.removeTag("Ship")
    transportFreighterBag.reload()

    -- Add action buttons to the bag
    createFreighterButtons(transportFreighterBag)
end

-- Adds action buttons for packing and unpacking
function createFreighterButtons(obj)
    obj.createButton({
        label = "Pack Up",
        click_function = "packObjects",
        function_owner = obj,
        position = { -1.25, 0.3, 3.0 },
        rotation = { 0, 0, 0 },
        width = 1000,
        height = 400,
        font_size = 200,
        color = { 0, 0, 0 },
        font_color = { 1, 1, 1 },
    })

    obj.createButton({
        label = "Deploy",
        click_function = "deployObjects",
        function_owner = obj,
        position = { 1.25, 0.3, 3.0 },
        rotation = { 0, 0, 0 },
        width = 1000,
        height = 400,
        font_size = 200,
        color = { 0, 0, 0 },
        font_color = { 1, 1, 1 },
    })
end

function round(num, decimalPlaces)
    local mult = 10 ^ (decimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Pack up objects from the table, excluding those in the base mod (exclude list)
function packObjects()
    transportCargo = {} -- Reset transported data

    -- Loop through all objects on the table
    for _, obj in ipairs(getObjects()) do
        -- Check if object should be excluded
        if not isExcluded(obj) then
            local pos = obj.getPosition()
            local rot = obj.getRotation()

            local item = {
                guid = obj.getGUID(),
                name = obj.getName(),
                pos = { x = round(pos.x, 4), y = round(pos.y, 4), z = round(pos.z, 4) },
                rot = { x = round(rot.x, 4), y = round(rot.y, 4), z = round(rot.z, 4) },
                state = obj.script_state or "", -- Save object state if any
                locked = obj.getLock(),
            }

            -- Store object data in transportedCargo
            table.insert(transportCargo, item)
            obj.setPositionSmooth(self.getPosition())
            Wait.condition(
                function() self.putObject(obj) end,
                function() return obj.resting end
            )
        end
    end

    -- Sort cargo by y-position during packing
    table.sort(transportCargo, function(a, b)
        return a.pos.y < b.pos.y
    end)
    printToAll("Objects packed into " .. name, Color.Yellow)
end

-- Check if an object GUID is in the exclude list
function isExcluded(obj)
    if obj.hasTag("TempLayoutElement") then
        return true
    end

    local guid = obj.getGUID()

    for _, excludedGUID in ipairs(excludeList) do
        if guid == excludedGUID then
            return true
        end
    end

    return false
end

-- Deploy stored objects from the Transport Freighter back to the table
function deployObjects()
    -- Deploy each object sequentially
    local function deployNext(index)
        if index > #transportCargo then
            printToAll("All objects deployed.", Color.Yellow)
            return
        end

        local item = transportCargo[index]
        local obj = self.takeObject({
            guid = item.guid,
            position = item.pos,
            rotation = item.rot,
            smooth = false, -- Skip smooth placement to avoid physics issues
            callback_function = function(spawnedObj)
                if spawnedObj then
                    spawnedObj.setLock(true) -- Temporarily lock object to disable physics
                    spawnedObj.setPosition(item.pos)
                    spawnedObj.setRotation(item.rot)
                    spawnedObj.script_state = item.state -- Restore object state
                else
                    printToAll("Failed to deploy object with GUID: " .. item.guid, Color.Red)
                end
            end,
        })

        local placedObj
        -- Wait for the object to settle before deploying the next
        Wait.condition(function()
            placedObj.setLock(item.locked)

            deployNext(index + 1)
        end, function()
            placedObj = getObjectFromGUID(item.guid)
            return placedObj ~= nil and placedObj.resting
        end)
    end

    -- Start deploying from the first item
    deployNext(1)
end

function baselineExclusions()
    excludeList = {}
    for _, obj in ipairs(getObjects()) do
        table.insert(excludeList, obj.guid)
    end
end

-- Utility functions to save state persistently
function onSave()
    return JSON.encode({ transportedCargo = transportCargo, excludeList = excludeList })
end

-- Initializes the transport freighter on load or spawn
function onLoad(saved_data)
    local loadedCargo = JSON.decode(saved_data)
    if loadedCargo then
        transportCargo = loadedCargo.transportedCargo or {}
        excludeList = loadedCargo.excludeList or {}
    end

    local objInfo = self.getCustomObject()
    if objInfo and objInfo.type == 6 then -- Type 6 corresponds to "Bag"
        self.addContextMenuItem("Packup Game", packObjects, false)
        self.addContextMenuItem("Deploy Game", deployObjects, false)
        self.addContextMenuItem("Baseline Game Mod", baselineExclusions, false)
        createFreighterButtons(self)
    else
        self.addContextMenuItem("Convert To Freighter", createTransportFreighterBag, false)
    end
end