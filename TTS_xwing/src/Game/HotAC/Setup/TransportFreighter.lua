--[[ Tranport Freighter
Aid to migrate HotAC-type games. Add this script to any ship model
e.g. "Rebel Transport" or "Bulk Freighter," and convert it to a "Transport Freighter"
(Memory Bag). It's intended to collect all player artifacts and transport
them to a new release of the Unified Mod.
    1. Create a baseline of all default in-game objects this should be done from an unmodified game (as released).
        * this creates an exclusion list of objects which will not be packed up.
    2. `Pack up` player's objects and store them in the Transport Freighter.
    3. Save the Transport Freighter as an external object
    4. Load the new version of the X-Wing Mod
    5. Spawn the saved Transport Freighter external object into the game
    6. Deploy the transported game objects
]]
require("TTS_lib.Util.Table")
local Sequence = require("TTS_lib.Sequence.Sequence")

local name = "Transport Freighter"
local desc = [[
[b]Pack Up Game[/b]:
Adds all objects on the table (except those in its exclusion list) to the freighter.

[b]Deploy Game[/b]:
Redeploys all stored objects from the freighter out to the current table.

[b]Baseline Game Mod[/b]:
Creates an exclusion list based on the current table's objects.  Excluded items will not be packed for transport.
(This should be done first from an unmodified game.)
]]

-- Table to store the exclude list of base game object GUIDs
local excludeList = {}

-- Table to store transported objects' data
local transportCargo = {}

-- Respawns any ship with this script to turn it into a Transport Freighter "Memory Bag"
function createTransportFreighterBag()
    self.setName(name)
    self.setDescription(desc)

    local info = self.getCustomObject()
    info.type = 6
    info.cast_shadows = true
    self.setCustomObject(info)
    self.removeTag("Ship")
    self.reload()
end

-- Adds action buttons for packing and unpacking
function createFreighterButtons(obj)
    local bounds = obj.getBounds()
    local position = Vector(-1.25, 0.05, bounds.size.z)

    obj.createButton({
        label = "Pack Up",
        click_function = "packObjects",
        function_owner = obj,
        position = position,
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
        position = position:scale(Vector(-1, 1, 1)),
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
    transportCargo = {} -- Reset storage

    local toPack = {}
    for _, obj in ipairs(getAllObjects()) do
        if not isExcluded(obj) then
            table.insert(toPack, obj)
        end
    end

    table.sort(toPack, function(a, b)
        return a.getPosition().y > b.getPosition().y
    end)

    -- 3) Build sequence
    local seq = Sequence:new()
    for _, obj in ipairs(toPack) do
        seq:addTask(packOneObject, obj)
        seq:waitFrames(1)
    end

    seq:addTask(function()
        printToAll("Packing complete. " .. #transportCargo .. " objects packed into " .. name, Color.Yellow)
    end)

    seq:start()
end

function packOneObject(obj)
    -- we already filtered excluded objects, but double‐check if you like
    if isExcluded(obj) then
        printToAll("Skipping “" .. obj.getName() .. "”", Color.Red)
        return
    end

    -- record its final data
    local pos = obj.getPosition()
    local rot = obj.getRotation()
    table.insert(transportCargo, {
        guid   = obj.getGUID(),
        name   = obj.getName(),
        pos    = { x = round(pos.x, 4), y = round(pos.y, 4), z = round(pos.z, 4) },
        rot    = { x = round(rot.x, 4), y = round(rot.y, 4), z = round(rot.z, 4) },
        state  = obj.script_state or "",
        locked = obj.getLock(),
    })

    -- move it into the bag
    obj.setPositionSmooth(self.getPosition())
    self.putObject(obj)
end

function isExcluded(obj)
    local guid = obj.getGUID()
    if guid == self.getGUID()
        or obj.hasTag("TempLayoutElement")
        or obj.tag == "Hand"
    then
        return true
    end

    for _, ex in ipairs(excludeList) do
        if guid == ex then return true end
    end
    return false
end

-- Deploy stored objects from the Transport Freighter back to the table
function deployObjects()
    printToAll('[b]Redeploying objects...[/b] wait for message: "All objects deployed."', Color.Yellow)

    table.sort(transportCargo, function(a, b)
        return a.pos.y < b.pos.y
    end)

    -- Deploy each object sequentially
    local function deployNext(index)
        if index > #transportCargo then
            printToAll("[b]All objects deployed.[/b]", Color.Yellow)
            return
        end

        local item = transportCargo[index]
        self.takeObject({
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
            return placedObj ~= nil and placedObj.resting and not placedObj.spawning and not placedObj.loading_custom
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
        excludeList = loadedCargo.excludeList or { self.getGUID() }
    end

    local objInfo = self.getCustomObject()
    if objInfo and objInfo.type == 6 then -- Type 6 corresponds to "Bag"
        self.addContextMenuItem("Packup Game", packObjects, false)
        self.addContextMenuItem("Deploy Game", deployObjects, false)
        self.addContextMenuItem("Baseline Game Mod", baselineExclusions, false)

        Wait.condition(
            function() createFreighterButtons(self) end,
            function() return self.resting and not self.spawning and not self.loading_custom end
        )
    else
        self.addContextMenuItem("Convert To Freighter", createTransportFreighterBag, false)
    end
end
