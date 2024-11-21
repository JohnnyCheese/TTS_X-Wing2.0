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
    -- populate with base game objects
}

-- Table to store transported objects' data
local transportCargo = {}

-- Respawns any ship with this script to turn it into a Transport Freighter "Bag"
function createTransportFreighterBag()
    -- Spawning a bag if one does not exist
    -- local transportFreighterBag = self.clone()
    local transportFreighterBag = self
    -- transportFreighterBag.setName(name)
    transportFreighterBag.setDescription("name " .. name)

    local info = transportFreighterBag.getCustomObject()
    info.type = 6
    info.cast_shadows = true
    transportFreighterBag.setCustomObject(info)
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

-- Pack up objects from the table, excluding those in the base mod (exclude list)
function packObjects()
    transportCargo = {} -- Reset transported data

    -- Loop through all objects on the table
    for _, obj in ipairs(getObjects()) do
        local guid = obj.getGUID()

        -- Check if object is in the exclude list
        if not isExcluded(guid) then
            local item = {
                guid = guid,
                name = obj.getName(),
                pos = obj.getPosition(),
                rot = obj.getRotation(),
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

    printToAll("Objects packed into " .. name, Color.Yellow)
end

-- Check if an object GUID is in the exclude list
function isExcluded(guid)
    for _, excludedGUID in ipairs(excludeList) do
        if guid == excludedGUID then
            return true
        end
    end
    return false
end

-- Deploy stored objects from the Transport Freighter back to the table
function deployObjects()
    for _, item in ipairs(transportCargo) do
        local obj = self.takeObject({
            position = item.pos,
            rotation = item.rot,
            smooth = true,
            callback_function = function(spawnedObj)
                spawnedObj.setLock(item.locked)
                spawnedObj.script_state = item.state -- Restore object state
                -- spawnedObj.reload()                  -- not sure if I need this one or not
            end,
        })
    end

    printToAll("Objects deployed from " .. name, Color.Yellow)
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

    log(self.type, "type is ")
    if self.type == "Bag" then
        self.addContextMenuItem("Packup Game", packObjects, false)
        self.addContextMenuItem("Deploy Game", deployObjects, false)
        self.addContextMenuItem("Baseline Game Mod", baselineExclusions, false)
    else
        self.addContextMenuItem("Spawn Freighter", createTransportFreighterBag, false)
    end
    createFreighterButtons(self)
end
