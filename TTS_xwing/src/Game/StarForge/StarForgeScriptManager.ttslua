-- This is the Star Forge Script Manager!
-- It will update the behavior of Products.

-- StarForge.ttslua

require("TTS_lib.Util.Table")

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
### Requirements
- Each object to be produced needs a unique name.
]]
local StarForgeScriptManager = {
    objects = {},

    -- Add an object to the manager
    addObject = function(self, bag, object)
        local entry = {
            guid = object.getGUID(),
            name = object.getName(),
            bagGUID = bag.getGUID(),
            stateId = object.getStateId(),
            states = {}, -- Table to hold states if it's a multi-state object
        }

        self.objects[object.getGUID()] = entry
    end,
    -- Add a state to an existing multi-state object
    addState = function(self, multiObject, stateClone)
        if multiObject == stateClone then
            return
        end

        table.insert(self.objects[multiObject.getGUID()].states, {
            stateId = stateClone.getStateId(),
            guid = stateClone.getGUID(),
            name = stateClone.getName()
        })
    end,
    reset = function(self)
        self.objects = {}
    end
}

local SFLayout = require("TTS_xwing.src.Game.StarForge.StarForgeLayout")

local layoutInfiniteBag = function(infiniteBag)
    StarForgeScriptManager.takeObject(infiniteBag, "")
end

local layoutMixedBag = function(mixedBag)
    local items = mixedBag.getObjects()

    for i = #items, 0, -1 do
        local item = items[i]
        if item and item.lua_script ~= "" then
            StarForgeScriptManager.takeObject(mixedBag, item.guid)
        end
    end
end

--[[
## Extract All Products
Scan all game objects
- if it's an Infinite Bag, find out of what and register the object in the bag.
- if it's an Mixed Bag, find out of what and register the objects in the bag.
- if the Objects are Multi-state, consider registering each state with a "<key>.#".
]]
StarForgeScriptManager.TakeEveryThingOut = function()
    StarForgeScriptManager:reset()
    printToAll("Extract All Products")
    local everything = getObjects()
    for _, object in ipairs(everything) do
        if object.type == "Infinite" then
            layoutInfiniteBag(object)
        elseif object.type == "Bag" then
            layoutMixedBag(object)
        end
    end
    printToAll("Extract All Products Done")
end

StarForgeScriptManager.takeObject = function(Bag, guid)
    local guid = guid or ""
    local product = Bag.takeObject({
        position = SFLayout:nextPosition(),
        smooth = false,
        guid = guid,
        -- callback_function = function(obj) printToAll("We have Call Back!", Color.Orange) end
    })

    StarForgeScriptManager:addObject(Bag, product)

    if product.getStateId() ~= -1 then
        stackMultiStateObjects(product)
    end
end

stackMultiStateObjects = function(multiObject)
    local pos = multiObject.getPosition()
    local allStates = multiObject.getStates()
    local lastObject = multiObject
    for _, state in ipairs(allStates) do
        Wait.condition(function()
            pos.y = pos.y + 1
            local dup = multiObject.clone({ position = pos })
            dup.setPosition(pos)
            dup.setLock(true)
            Wait.condition(function()
                dup = dup.setState(state.id)
                dup.setLock(true)
                lastObject = dup
                StarForgeScriptManager:addState(multiObject, lastObject)
            end, function()
                return not dup.spawning
            end)
        end, function()
            return not lastObject.spawning
        end)
    end
end

StarForgeScriptManager.dumpProducts = function()
    printToAll("Dump Products", Color.Orange)
    table.print_r(StarForgeScriptManager.objects)
    printToAll("Dump Products Done", Color.Orange)
end

function putObjectBackInBag(bag, product)
    if bag then
        if bag.type == "Infinite" then
            bag.reset()
        end
        if product and not product.isDestroyed() then
            if product.type == "Deck" and product.is_face_down == false then
                product.setRotation(product.getRotation() + Vector(0, 0, 180))
            end
            bag.putObject(product)
        end
    end
end

function copyStateScript(index, entry, multiObject, callback)
    if index == 0 then
        multiObject = multiObject.setState(entry.stateId)
        Wait.condition(function()
            callback(multiObject)
        end, function()
            return multiObject ~= nil and not multiObject.spawning
        end)
        return
    end
    local stateEntry = entry.states[index]
    multiObject = multiObject.setState(stateEntry.stateId)
    local stateCopy = getObjectFromGUID(stateEntry.guid)
    Wait.condition(function()
        local script = stateCopy.getLuaScript() or ""
        multiObject.setLuaScript(script)
        destroyObject(stateCopy)
        table.remove(entry.states, index)
        return copyStateScript(index - 1, entry, multiObject, callback)
    end, function()
        local isMultiObjectReady = multiObject ~= nil and not multiObject.spawning
        local isStateReady = stateCopy ~= nil and not stateCopy.spawning
        return isMultiObjectReady and isStateReady
    end)
end

StarForgeScriptManager.PutEverythingAway = function()
    printToAll("Put Everything Away", Color.Orange)
    local products = StarForgeScriptManager.objects -- #654
    for guid, entry in pairs(products) do
        local bag = getObjectFromGUID(entry.bagGUID)
        local product = getObjectFromGUID(entry.guid)
        if product ~= nil and product.getStateId() ~= -1 then
            copyStateScript(#entry.states, entry, product, function(obj)
                putObjectBackInBag(bag, obj)
            end)
        else
            Wait.condition(function()
                putObjectBackInBag(bag, product)
            end, function()
                local isBagReady = bag ~= nil and not bag.spawning
                local isProductReady = product ~= nil and not product.spawning
                return isBagReady and isProductReady
            end)
        end
    end
    printToAll("Everything Put Away", Color.Orange)
end

return StarForgeScriptManager
