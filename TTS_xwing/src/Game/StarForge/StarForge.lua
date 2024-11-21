-- This is the Star Forge!
-- It will make what ever you desire!

-- StarForge.ttslua

if not self.hasTag("Star Forge") then
    printToAll("Only the Star Forge itself should run this script.")
    return
end

require("TTS_lib.Util.Table")
local SFScript  = require("Game.StarForge.StarForgeScriptManager")
local SFDeduper = require("Game.StarForge.StarForgeDeduper")
local SFTester  = require("Test.DataPadTest")
local SFVector  = require("Test.HotAC.ApproachVectorTest")

--[[
## Star Forge

Utility Object to aid in Game Mod Script Updates. Locating and "sourcing" Objects.
- This should replace the Accessories Bag or at least provide a Facade in front of it
- Extract and lay out all scripted objects
    - Possibly be sensitive to HotAC vs Standard Layout vs Epic Layout
    - Reset each script back to itself to force an update.
    - Keep track of where each object came from to survive a save and reload.

### Steps:

1. **Extract All Objects**:
    - Trigger a context menu to "Take Everything Out," which will:
    1. Lay out all scripted objects.

    2. Keep track of which Bag each object came from, as they need to be returned to their original bag.
    3. If the object is a multi-state object:
        - Keep track of the initial state (baseState).
        - Clone the object for each state and stack them vertically.
        - This allows VSCode to update the alternative state's scripts.

2. **Save and Reload**:
    1. Save the game via TTS UI.
    2. Load the game via TTS UI.
    3. Send all scripts from VSCode.

3. **Put Everything Away**:
    - Trigger a context menu to "Put Everything Away," which will:
    - For each object that was taken out:
        1. Reset the bag it came from.
        2. Put the object back.
        3. If the object is the initial state of a multi-state object:
            - Traverse all initial state's copies and have them:
                - Change the baseState object to match their state.
                - Set the baseState's script for that state to the new one from the extra state object.
                - Destroy the extra state object.
            - Set the initial state object back to its baseState.
        4. Put the initial state object back in the bag it came from.

- Assess each Container as a possible source of objects.
    - Point out when there are duplicate sources for an object.
    - Front all containers/dispensers as a registry for objects
    - Not all Bags have names
    - Not all Objects in Bags have names
    - Multi-State Objects need
        - each of their names and
        - a way to recognize which one to morph to
    - names may include: Bag name, Object Contents name, or NickName

### Requirements
- Each object to be produced needs a unique name.
]]
local StarForge = {
    factories = {},
    lastLayout = 1
}

local layoutController_GUID = "b3992e"

function onSave()
    local saveData = {}
    saveData.lastLayout = getCurrentLayout()
    saveData.objects = SFScript.objects
    saveData.hidden = self.getVar("hidden")
    return JSON.encode(saveData)
end

function onLoad(saveData)
    if saveData ~= "" then
        local loadData = JSON.decode(saveData)
        if loadData and loadData.lastLayout ~= nil then
            StarForge.lastLayout = loadData.lastLayout
        else
            StarForge.lastLayout = getCurrentLayout()
        end
        if loadData and loadData.objects ~= nil then
            SFScript.objects = loadData.objects
        end
        self.setVar("hidden", loadData.hidden or false)
    end
    if self.getVar("hidden") then
        hide()
    else
        show()
    end
    showMainMenu()
end

function setToLayout(layoutNumber)
    local layout = getObjectFromGUID(layoutController_GUID)
    if layout then
        StarForge.lastLayout = layout.call("setLayoutState", layoutNumber)
    else
        printToAll("Error: Layout object not found.", Color.Orange)
    end
end

function getCurrentLayout()
    local layout = getObjectFromGUID(layoutController_GUID)
    if layout then
        return layout.call("getLayoutState", layoutNumber)
    else
        printToAll("Error: Layout object not found.", Color.Orange)
    end

    return -1
end

function show()
    local sPos = self.getPosition()
    self.setPosition({ sPos[1], 0.8, sPos[3] })
    self.setScale({ 2.10, 2.10, 2.10 })
    self.interactable = true
    self.tooltip = true
    self.lock()
    self.setVar("hidden", false)
    printToAll("Star Forge is active and online!", Color.Orange)
end

function hide()
    local sPos = self.getPosition()
    self.setPosition({ sPos[1], -3, sPos[3] })
    self.setScale({ 0.0001, 0.0001, 0.0001 })
    self.interactable = false
    self.tooltip = false
    self.lock()
    if not self.getVar("hidden") then
        printToAll("Star Forge is going offline!", Color.Orange)
    end
    self.setVar("hidden", true)
end

local function colorText(text, color)
    return "[" .. color:toHex() .. "]" .. text .. "[-]"
end

MultiStateExp = function()
    -- local bag = getObjectFromGUID("224816") -- Charge Token
    -- local bag = getObjectFromGUID("ae62df") -- Wing Tool
    -- local bag = getObjectFromGUID("07d45b") -- Shield
    local bag = getObjectFromGUID("8b1614") -- Gas Cloud
    if bag == nil then
        printToAll("Bag is nil")
        return
    end

    printToAll(colorText(bag.getName(), Color.Orange) .. " Bag type is " .. colorText(tostring(bag.type), Color.Blue))

    SFScript.takeObject(bag, "")
end

ListFactories = function()
    printToAll("StarForge: List Factories")
    if not StarForge.factories or next(StarForge.factories) == nil then
        printToAll("StarForge: no Factories registered")
        return
    end
    printToAll("StarForge Factories:")
    for object, factory in pairs(StarForge.factories) do
        printToAll("a function named: " .. factory.funcName)
        factory.func(object)
    end
    printToAll("End Factories:")
end

StarForge.RegisterFactory = function(factory, product)
    local previousFactory = StarForge.factories[product]
    if previousFactory ~= nil then
        printToAll("Replacing " .. previousFactory.getName() .. " with " .. factory.getName())
    end
    StarForge.factories[product] = factory
    return previousFactory
end

function NoOp(obj)
end

handlers = function()
    local typeHandlers = {
        Generic = NoOp,
        Figurine = NoOp,
        Dice = NoOp,
        Coin = NoOp,
        Board = NoOp,
        Chip = NoOp,
        Bag = NoOp,
        Infinite = NoOp
    }
    return typeHandlers
end


factory = function(dispenser, func, funcName)
    local factory = {}
    factory.dispenser = dispenser
    factory.func = printInfiniteBag
    factory.funcName = 'printInfiniteBag'
    return factory
end

extractProducts = function(dispenser)
    local names = {}
    local call_back = function(obj)
        print(tostring(obj))
        table.insert(names, "dispenser: " .. tostring(dispenser.getName()))
        table.insert(names, "name: " .. tostring(obj.getName()))
    end
    local position = { 0, 2, 0 }
    interrogateContainer(dispenser, position, call_back)
    return names
end

interrogateContainer = function(dispenser, position, callback)
    dispenser.takeObject({
        -- guid = itemGuid,
        smooth = true,
        position = position,
        callback_function = function(obj)
            -- Handle the object after it's taken from the bag
            -- if dispenser.type == "InfiniteBag" then
            callback(obj)
            -- else
            --     local clone = obj.clone({ position = position })     -- Clone it to the desired position
            --     factory.putObject(obj)                               -- Put the original back into the bag
            --     if callback then
            -- callback(clone)
            --     end
            -- end
        end
    })
end

function printInfiniteBag(obj)
    printToAll(tostring(obj) .. " is a Infinite Bag", Color.Green)
end

function printBag(obj)
    printToAll(tostring(obj) .. " is a Bag", Color.Yellow)
end

-- Method to get an object from a factory (Bag or InfiniteBag)
function StarForge.getObjectFromFactory(factoryName, objectName, position, callback)
    local factory = self.getFactory(factoryName)
    if not factory then
        print("Factory not found: " .. factoryName)
        return
    end

    local items = factory.getObjects() -- Retrieve a list of all items in the bag
    local itemGuid = nil               -- This will store the GUID of the requested object

    -- Search through the items to find the requested object
    for _, item in ipairs(items) do
        if item.name == objectName then
            itemGuid = item.guid
            break
        end
    end

    if itemGuid then
        factory.takeObject({
            guid = itemGuid,
            smooth = true,
            position = position,
            callback_function = function(obj)
                -- Handle the object after it's taken from the bag
                if factory.type == "InfiniteBag" then
                    obj.setPosition(position)
                else
                    local clone = obj.clone({ position = position }) -- Clone it to the desired position
                    factory.putObject(obj)                           -- Put the original back into the bag
                    if callback then
                        callback(clone)
                    end
                end
            end
        })
    else
        print("Object not found in factory: " .. objectName)
    end
end

function StarForge.createObject(name, options)
    options = options or {}
    local bag = StarForge.factories[name]
    if bag then
        local params = {
            position = options.position or (bag.getPosition() + Vector(0, 2, 0)),
            rotation = options.rotation,
            smooth = options.smooth or false,
            callback_function = options.callback_function
        }
        local obj = bag.takeObject(params)
        if options.clone then
            return obj.clone({ position = params.position })
        else
            return obj
        end
    else
        print("Error: No registered factory with name: " .. name)
        return nil
    end
end

-- Utility function to check if a table contains a value
function tableContains(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

function getInfiniteBagProductName(asset_bag)
    local name = asset_bag.getName()
    local product = asset_bag.takeObject()

    if asset_bag then
        for _, containedObject in ipairs(asset_bag.getObjects()) do
            asset = asset_bag.takeObject({
                index = containedObject.index,
                position = self.getPosition() + Vector(10, 2, 0),
                rotation = self.getRotation() + Vector(180, 0, 0),
            })
            assetClone = asset.clone()
            asset_bag.putObject(assetClone)
            break
        end
    end
end

function watchaGot(bag)
    if bag.type == "InfiniteBag" then
        return tookAnObject(bag)
    elseif bag.type == "Bag" then
        return whatsInTheBag(bag)
    end
    printToAll("Not a Bag")
    return {}
end

function whatsInTheBag(mixedBag)
    if bag == nil then
        printToAll("How did we get a nil bag!?")
        return
    end
    local names = {}
    printToAll("bag.type: " .. bag.type)
    printToAll("function is " .. tostring(bag.getObjects))
    local result = bag.getObjects
    printToAll("result is " .. tostring(result))
    result = result()
    if result == nil then
        return
    end
    for _, product in ipairs(result) do
        local name = product.getName()
        if name ~= nil then
            table.insert(names, name)
        end
    end
    return names
end

function emptyBag()
    local items = self.getObjects()
    local position = self.getPosition()

    position.x = position.x + 10
    position.z = position.z - 15
    local count = 0

    for i = #items, 1, -1 do
        local item = items[i]
        if item.lua_script ~= "" then
            count = count + 1
            local spreadPos = {
                x = position.x + math.floor(count / 3) * 3.5,
                y = position.y + 1,
                z = position.z + (count % 3) * 3
            }

            self.takeObject({
                position = spreadPos,
                index = i - 1, -- Adjust index to current position in the array
                smooth = false
            })
        end
    end
end

LaunchProbe = function()
    local probe = spawnObject({
        type = "Custom_Token",
        position = { -30, 3, -20 },
        scale = { 1, 1, 1 },
        sound = true,
        callback_function = function(spawned_object)
            spawned_object.setName("Probe")
        end
    })

    probe.setCustomObject({
        image = "https://static.wikia.nocookie.net/starwars/images/f/f2/Sith_probe_droid.png?raw=true"
    })
end

function HiddenBags(operation)
    local bagGuids = {
        'a3690e', -- Extra Assets 15 items
        '203cb8', -- ObstacleBag 31 items
        'f0e7b9', -- Dice Bag 10 items
        '53ad3d', -- Accessories 79 items
    }

    for _, guid in ipairs(bagGuids) do
        local bag = getObjectFromGUID(guid)
        if bag ~= nil then
            bag.call(operation)
        end
    end

    local guids = {
        '2ef5bb', -- Relay (Mod Load Counter)
        '900937', -- MoveLUT
        'f8f07c', -- Dial Set source
        '3d63d2', -- dice Preload Green
        'be075b', -- dice Preload Red
        '0db84a', -- Red-Blue playmat
        '224031', -- Purple-Orange playmat
    }

    for _, guid in ipairs(guids) do
        local obj = getObjectFromGUID(guid)
        local pos = obj.getPosition()
        if "submerge" == operation and pos.y > 0 then
            pos.y = -1 * pos.y
        elseif "surface" == operation and pos.y < 0 then
            pos.y = -1 * pos.y
        end
        obj.setPosition(pos)
    end

    local compositeBaseGUID = '8c3322'
    local obj = getObjectFromGUID(compositeBaseGUID)
    local pos = obj.getPosition()
    if "submerge" == operation then
        obj.setPosition(Vector(0, -3, 0))
    else
        obj.setPosition(Vector(0, 3, 0))
    end
end

-- Function to show a menu based on the menu name
function showMenu(menu)
    self.clearContextMenu()
    for _, item in ipairs(menus[menu]) do
        self.addContextMenuItem(item[1], item[2], false)
    end
end

function showMainMenu()
    setToLayout(StarForge.lastLayout)
    showMenu("main")
end

function showScriptingMenu()
    setToLayout(2) -- Epic Layout
    showMenu("scripting")
end

menus = {
    main = {
        { "Script Manager >", showScriptingMenu },
        { "Game Tester >",    function() showMenu("testing") end },
        { "Deduplicator >",   function() showMenu("deduper") end },
        { "Hidden Bags >",    function() showMenu("bags") end },
        { "Launch Probe",     LaunchProbe },
        { "List Factories",   ListFactories },
    },
    bags = {
        { "Surface Bags",   function() HiddenBags("surface") end },
        { "Submerge Bags",  function() HiddenBags("submerge") end },
        { "Back to Main >", showMainMenu },
    },
    scripting = {
        { "Multi-State Object",  MultiStateExp },
        { "Take Everything Out", SFScript.TakeEveryThingOut },
        { "Put Everything Away", SFScript.PutEverythingAway },
        { "Dump Products",       SFScript.dumpProducts },
        { "Back to Main >",      showMainMenu },
    },
    testing = {
        { "DataPad Spawn Test",   SFTester.runSmokeTest },
        { "Approach Vector Test", SFVector.runSmokeTest },
        { "Back to Main >",       showMainMenu },
    },
    deduper = {
        { "Scan For Duplicates", SFDeduper.ScanAllBags },
        { "Layout Duplicates",   SFDeduper.LayoutDuplicates },
        { "Back to Main >",      showMainMenu },
    },
}
