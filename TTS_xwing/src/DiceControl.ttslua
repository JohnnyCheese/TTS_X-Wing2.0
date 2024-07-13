-- ~~~~~~
-- Script by Eirik 'Flippster' Munthe
--
--
-- X-Wing dice control module,
-- Prevents dice tampering, and presents dice results.
-- Stores and presents dice statistics
-- ~~~~~~
local EventSub = require("TTS_Lib.EventSub.EventSub")

local DiceControlModule = {
    dice_statistics = {},
    rolled_dice = {},
    dice_roller_state = {},
    player_colors = {},
    enabled = true,
    error_color = color(1.0, 0.2, 0.1),
    info_color = color(0.7, 0.7, 0.4),
    highlight_color = "[FFFF55]",
    test_mode = false,
    first_player_scores = {
        Crit = 100,
        Eye = 10,
        Hit = 1,
        Blank = 0
    }
}


DiceControlModule.dice_types = {
    Red = {
        color = "[FF0000]",
        luck_values = {
            Crit  = {
                expected = 1 / 8,
                luck = 1.25
            },
            Hit   = {
                expected = 3 / 8,
                luck = 1
            },
            Eye   = {
                expected = 2 / 8,
                luck = 0.5
            },
            Blank = {
                expected = 2 / 8,
                luck = 0
            }
        },
        result_order = { "Crit", "Hit", "Eye" }
    },
    Green = {
        color = "[00FF00]",
        luck_values = {
            Evade = {
                expected = 3 / 8,
                luck = 1
            },
            Eye = {
                expected = 2 / 8,
                luck = 0.75
            },
            Blank = {
                expected = 3 / 8,
                luck = 0
            }
        },
        result_order = { "Evade", "Eye" }
    },
    RedTest = {
        color = "[FFFFFF]",
        luck_values = {
            Crit = {
                expected = 1 / 8,
                luck = 1.25
            },
            Hit1 = {
                expected = 1 / 8,
                luck = 1
            },
            Hit2 = {
                expected = 1 / 8,
                luck = 1
            },
            Hit3 = {
                expected = 1 / 8,
                luck = 1
            },
            Eye1 = {
                expected = 1 / 8,
                luck = 0.5
            },
            Eye2 = {
                expected = 1 / 8,
                luck = 0.5
            },
            Blank1 = {
                expected = 1 / 8,
                luck = 0
            },
            Blank2 = {
                expected = 1 / 8,
                luck = 0
            }
        },
        result_order = { "Crit", "Hit1", "Hit2", "Hit3", "Eye1", "Eye2", "Blank1", "Blank2" }
    },
    PlayerOrder = {
        color = "[FF00FF]",
        result_order = { "Crit", "Eye", "Hit" }
    },
    Scenario = {
        color = "[7777FF]",
        result_order = { "Scramble the transmissions", "Assault at the satelite array", "Chance engagement", "Salvage mission" }
    },
    Default = {
        color = "[777777]"
    }
}

DiceControlModule.GetDefaultDiceStats = function(diceColor)
    def = { Total = 0 }
    if DiceControlModule.dice_types[diceColor] and DiceControlModule.dice_types[diceColor].luck_values then
        for result, _ in pairs(DiceControlModule.dice_types[diceColor].luck_values) do
            def[result] = 0
        end
    end
    return def
end

DiceControlModule.onLoad = function()
    addContextMenuItem("Toggle dice control",
        function()
            if DiceControlModule.enabled then
                DiceControlModule.enabled = false
                printToAll("Dice control is now DISABLED", DiceControlModule.info_color)
            else
                DiceControlModule.enabled = true
                printToAll("Dice control is now ENABLED", DiceControlModule.info_color)
            end
        end, false, false)
    addContextMenuItem("Present dice statistics", DiceControlModule.presentStatistics, false)
    addContextMenuItem("Reset dice statistics", function() DiceControlModule.dice_statistics = {} end, false)
    DiceControlModule.dicecontainer = DiceControlModule.findByGMNotes("dicebag1") -- you probably want findByGMNotes(gmnoteToFind) here
end

EventSub.Register('onLoad', DiceControlModule.onLoad)


DiceControlModule.presentStatistics = function()
    for player, types in pairs(DiceControlModule.dice_statistics) do
        local total = 0
        printToAll("[" .. Color.fromString(DiceControlModule.player_colors[player]):toHex() .. "]" .. player .. "[-] have rolled:", DiceControlModule.info_color)
        local playerLuck = nil
        for type, results in pairs(types) do
            local typeTotal = results.Total
            total = total + typeTotal
            local luck = 0
            local typeColor = DiceControlModule.dice_types[type].color or "[#FFFFFF]"
            for result, number in pairs(results) do
                local percentage = tostring(math.floor(number / typeTotal * 1000) / 10)
                local luckValue = DiceControlModule.dice_types[type].luck_values
                local luckString = ""
                if luckValue ~= nil and luckValue[result] ~= nil then
                    luckString = " - Expected: " .. tostring(luckValue[result].expected * typeTotal)
                    luck = luck + ((number - (luckValue[result].expected * typeTotal)) * luckValue[result].luck)
                end
                printToAll(typeColor .. type .. "[-] " .. result .. ": " .. DiceControlModule.highlight_color .. tostring(number) .. "[-] (" .. percentage .. "%)" .. luckString, DiceControlModule.info_color)
            end
            if DiceControlModule.dice_types[type] ~= nil then
                printToAll(typeColor .. type .. "[-] dice luck score: " .. DiceControlModule.highlight_color .. tostring(luck) .. "[-]", DiceControlModule.info_color)
                playerLuck = (playerLuck or 0) + luck
            end
        end
        if playerLuck ~= nil then
            printToAll("Total luck score: " .. DiceControlModule.highlight_color .. tostring(playerLuck) .. "[-]", DiceControlModule.info_color)
        end
    end
end

DiceControlModule.onObjectRandomize = function(object, playerInstance)
    local player = playerInstance.steam_name
    DiceControlModule.player_colors[player] = playerInstance.color
    if DiceControlModule.enabled and (object.tag == "Dice") and not object.locked and (object.held_by_color == nil) then
        DiceControlModule.dice_roller_state[player] = DiceControlModule.dice_roller_state[player] or "idle"
        if DiceControlModule.dice_roller_state[player] == "idle" then
            if object.held_by_color ~= nil then
                DiceControlModule.dice_roller_state[player] = "error"
                Wait.frames(function() DiceControlModule.dice_roller_state[player] = "idle" end, 1)
                return
            end
            DiceControlModule.rolled_dice[player] = {}

            if not DiceControlModule.PrepareDice(object, player) then
                return
            end
            DiceControlModule.dice_roller_state[player] = "starting"
            Wait.time(
                function()
                    if #DiceControlModule.rolled_dice[player] ~= 0 then
                        DiceControlModule.dice_roller_state[player] = "waiting"
                    end
                end, 0.8, 0)
            Wait.condition(function() DiceControlModule.PresentDiceRollerResult(player) end,
                function() return DiceControlModule.UntilRolledDiceAreStill(player) end, 6,
                function() DiceControlModule.RollTimeout(player) end)
        elseif DiceControlModule.dice_roller_state[player] == "starting" then
            for _, dice in pairs(DiceControlModule.rolled_dice[player]) do
                if dice == object then
                    return
                end
            end
            DiceControlModule.PrepareDice(object, player)
        elseif DiceControlModule.dice_roller_state[player] == "waiting" then
            for _, dice in pairs(DiceControlModule.rolled_dice[player]) do
                if dice == object then
                    return
                end
            end
            printToAll("Please don't start new rolls while waiting for the result of another", DiceControlModule.error_color)
            destroyObject(object)
        end
    end
end

--EventSub.Register('onObjectRandomize', DiceControlModule.onObjectRandomize)

DiceControlModule.PrepareDice = function(die, player)
    if not die.isSmoothMoving() then
        die.roll()
        Wait.time(function() die.roll() end, 0.1)
        die.interactable = false
        players = getSelectingPlayers(die)
        for _, playerInstance in pairs(players) do
            die.removeFromPlayerSelection(playerInstance.color)
        end
        table.insert(DiceControlModule.rolled_dice[player], die)
        return true
    else
        printToAll("Please don't roll flipping dice", DiceControlModule.error_color)
        destroyObject(die)
        return false
    end
end

DiceControlModule.RollTimeout = function(player)
    printToAll("Roll timed out, please try again", DiceControlModule.error_color)
    for _, dice in pairs(DiceControlModule.rolled_dice[player]) do
        dice.interactable = true
    end
    DiceControlModule.dice_roller_state[player] = "idle"
end

DiceControlModule.PresentDiceRollerResult = function(player)
    local resultTable = {}
    for _, dice in pairs(DiceControlModule.rolled_dice[player]) do
        dice.interactable = true
    end

    for _, dice in pairs(DiceControlModule.rolled_dice[player]) do
        local diceColor = dice.getVar("dicecolor") or "Default"
        local result = dice.getRotationValue()
        resultTable[diceColor] = resultTable[diceColor] or {}
        resultTable[diceColor][result] = (resultTable[diceColor][result] or 0) + 1
        local playerStats = DiceControlModule.dice_statistics[player] or {}
        playerStats[diceColor] = playerStats[diceColor] or DiceControlModule.GetDefaultDiceStats(diceColor)
        playerStats[diceColor].Total = (playerStats[diceColor].Total or 0) + 1
        playerStats[diceColor][result] = (playerStats[diceColor][result] or 0) + 1
        DiceControlModule.dice_statistics[player] = playerStats
    end
    local any_result = false
    local resultText = "[" .. Color.fromString(DiceControlModule.player_colors[player]):toHex() .. "]" .. player .. "[-] rolled " .. DiceControlModule.highlight_color .. tostring(#DiceControlModule.rolled_dice[player]) .. "[-] dice and got "
    local resultTexts = {}
    for dice_color, results in pairs(resultTable) do
        if DiceControlModule.dice_types[dice_color].result_order ~= nil then
            for _, result in pairs(DiceControlModule.dice_types[dice_color].result_order) do
                if results[result] ~= nil then
                    local plural_s = ""
                    if results[result] > 1 then
                        plural_s = "s"
                    end
                    any_result = true
                    table.insert(resultTexts, DiceControlModule.highlight_color .. tostring(results[result]) .. "[-] " .. DiceControlModule.dice_types[dice_color].color .. result .. plural_s .. "[-] ")
                end
            end
        else
            for res, num in pairs(results) do
                resultText = resultText .. DiceControlModule.highlight_color .. tostring(num) .. "[-]x" .. DiceControlModule.dice_types[dice_color].color .. res .. "[-] "
            end
        end
    end
    if any_result == false then
        resultText = resultText .. DiceControlModule.highlight_color .. "Got nothing![-]"
    else
        for i = 1, #resultTexts, 1 do
            resultText = resultText .. resultTexts[i]
            if #resultTexts - i > 1 then
                resultText = resultText .. ", "
            elseif #resultTexts - i == 1 then
                resultText = resultText .. " and "
            end
        end
    end
    printToAll(resultText, DiceControlModule.info_color)
    DiceControlModule.CheckFirstPlayerRoll(player)
    DiceControlModule.dice_roller_state[player] = "idle"

    if DiceControlModule.test_mode then
        for _, dice in pairs(DiceControlModule.rolled_dice[player]) do
            dice.setRotation(vector(326.26, 179.99, 90.00))
        end
        Wait.time(
            function()
                for _, dice in pairs(DiceControlModule.rolled_dice[player]) do
                    if dice then
                        dice.randomize(player)
                    end
                end
            end, 0.8, 0)
    end
end

DiceControlModule.CheckFirstPlayerRoll = function(player)
    if #DiceControlModule.rolled_dice[player] == 3 then
        local score = 0
        for _, dice in pairs(DiceControlModule.rolled_dice[player]) do
            if dice.getVar("dicecolor") ~= "PlayerOrder" then
                print("Not PlayerOrder dice")
                return
            end
            score = score + DiceControlModule.first_player_scores[dice.getRotationValue()] or 0
        end
        getObjectFromGUID("c9a2a0").call("firstPlayerRoll",
            { player = player, color = DiceControlModule.player_colors[player], score = score })
    end
end

DiceControlModule.UntilRolledDiceAreStill = function(player)
    local result = true
    for k = #DiceControlModule.rolled_dice[player], 1, -1 do
        local dice = DiceControlModule.rolled_dice[player][k]
        if dice == nil then
            printToAll("A dice disappeared while rolling!", DiceControlModule.error_color)
            table.remove(DiceControlModule.rolled_dice[player], k)
        elseif dice.held_by_color ~= nil then
            printToAll("Please don't grab dice that are being rolled!", DiceControlModule.error_color)
            table.remove(DiceControlModule.rolled_dice[player], k)
            destroyObject(dice)
        elseif not dice.resting then
            result = false
        end
    end
    return result
end

-- [[ Following is addition for changing dice looks by Snake3y3s]]
DiceControlModule.platformToBag = {
    ["atkPlat01"] = "atkOG1",
    ["atkPlat02"] = "atkBLACK1",
    ["atkPlat03"] = "atkWHITE1",
    ["atkPlat04"] = "atkGOLD1",
    ["atkPlat05"] = "atkSPARKLY1",
    ["atkPlat06"] = "atkMARBLE1",
    ["defPlat01"] = "defOG1",
    ["defPlat02"] = "defBLACK1",
    ["defPlat03"] = "defWHITE1",
    ["defPlat04"] = "defSILVER1",
    ["defPlat05"] = "defSPARKLY1",
    ["defPlat06"] = "defMARBLE1",
}

DiceControlModule.upCast = function(obj, dist, offset, multi)
    local dist = dist or 1
    local offset = offset or 0
    local multi = multi or 1
    local oPos = obj.getPosition()
    local oBounds = obj.getBoundsNormalized()
    local oRot = obj.getRotation()
    local orig = { oPos[1], oPos[2] + offset, oPos[3] }
    local siz = { oBounds.size.x * multi, dist, oBounds.size.z * multi }
    local orient = { oRot[1], oRot[2], oRot[3] }
    local hits = Physics.cast({
        origin       = orig,
        direction    = { 0, 1, 0 },
        type         = 3,
        size         = siz,
        orientation  = orient,
        max_distance = 0,
        debug        = false,
    })
    local hitObjects = {}
    for _, v in pairs(hits) do
        if v.hit_object ~= obj then table.insert(hitObjects, v.hit_object) end
    end
    return hitObjects
end


DiceControlModule.getObjectInContainerByGMNote = function(container, gmnoteToFind) -- most of the script here to find out if, and if so which, item is in the container
    local takenObject = nil                                                        -- keep the scope local outside of the loop 
    for _, c in ipairs(container.getObjects()) do
        if c.gm_notes == gmnoteToFind then
            takenObject = container.takeObject({ -- correct call syntax, use .takeObject() on your container
                index = c.index,                 -- c.index to get the correct index always
                position = Vector(0, 0, 0),
                smooth = false,
                callback_function = function(newBag)     -- executes when newBag finished spawning
                    newBag.translate(Vector(0, 0.08, 0)) -- moves it 1 unit straight down
                end
            })                                           -- position correctly spelled and correct case
            takenObject.setLock(true)                    -- locks it
        end
    end
    return takenObject
end

DiceControlModule.findByGMNotes = function(gmnotes) -- finds an object in the game whose .getGMNotes9) matches the gmnotes parameter
    for _, obj in pairs(getAllObjects()) do
        if obj.getGMNotes() == gmnotes then return obj end
    end
end

DiceControlModule.onObjectStateChange = function(object, old_guid)    -- object is the _new_ state
    -- clear the bag on top
    for _, foundObject in ipairs(DiceControlModule.upCast(object)) do -- for each object in the platform scripting zone..
        if foundObject.tag == "Infinite" then                         -- if an infinite bag
            local gmnotes = foundObject.getGMNotes()
            if gmnotes and gmnotes ~= "" then
                DiceControlModule.dicecontainer.putObject(foundObject)
                local lastNumber = tonumber(string.sub(gmnotes, -1)) or
                    0                                                                      -- gives us the very last character in our gmnotes - in our example "Platform 1" would give "1"
                foundObject.setPosition(Vector(-24, 1, 10) + Vector(lastNumber * 4, 0, 0)) -- sets the bag starting at 0,2,10, and adding 4 to x, multiplied by the lastNumber - so they all line up.
            end
        end
    end
    -- figure out which is the new bag
    local gmnotes = object.getGMNotes()                                                                               -- get the gm notes of the new state
    local infiniteBagString = DiceControlModule.platformToBag
        [gmnotes]                                                                                                     -- get the infiniteBagString from platformToBag e.g. "Platform 1" will give us "InfiniteBag 1"
    if not infiniteBagString then return end                                                                          -- if the object's gm notes is not a key in platformToBag then we don't want to run any more code

    local newBag = DiceControlModule.getObjectInContainerByGMNote(DiceControlModule.dicecontainer, infiniteBagString) -- a simple function to find an object that matches the infiniteBagString (see below)

    if not newBag then
        log("Error: No associated bag found - has it been deleted?")
        return
    end                                                           --

    newBag.setPosition(object.getPosition() + Vector(0, 0.08, 0)) -- put the new bag 2 units above the platform
end

EventSub.Register('onObjectStateChange', DiceControlModule.onObjectStateChange)

return DiceControlModule
