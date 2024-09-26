require("TTS_lib.Util.Table")
local Sequence = require("TTS_xwing.src.Test.Sequence")
local ButtonTest = require("TTS_xwing.src.Test.ButtonTest")
local PlayerArea = require("TTS_xwing.src.Player.PlayerArea")
local Squadron = require("TTS_xwing.src.Game.StarForge.Squadron")

local DataPadTest = {}

DataPadTest.runSmokeTest = function()
    printToAll("Starting Smoke Test...", { 0, 1, 0 })

    local bluePlayerArea = PlayerArea:new(Player["Blue"])
    local redPlayerArea = PlayerArea:new(Player["Red"])

    local seq = Sequence:new()

    DataPadTest.spawnImperialShips(seq, bluePlayerArea)
    DataPadTest.spawnRebelShips(seq, redPlayerArea)

    seq:start()

    printToAll("Smoke Test Completed.", { 0, 1, 0 })
end

function DataPadTest.spawnImperialShips(seq, playerArea)
    local dataPad = getObjectFromGUID("a4dbbf")
    if dataPad == nil then
        printToAll("Didn't find DataPad", { 0, 1, 0 })
        return
    end
    local player_color = playerArea.player.color

    seq:add(ButtonTest.Click, dataPad, 'Spawn List', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'XWA Points', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Builder', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Imperial', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Add Ship', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'TIE/ln Fighter', player_color, false)
    seq:add(ButtonTest.Click, dataPad, '"Howlrunner"%s*%(%d+%)', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Add Ship', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'TIE Advanced x1', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Darth Vader%s*%(%d+%)', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Spawn List', player_color, false)
    seq:add(waitAndMove, playerArea, 120)
end

function DataPadTest.spawnRebelShips(seq, playerArea)
    local dataPad = getObjectFromGUID("a4dbbf")
    if dataPad == nil then
        printToAll("Didn't find DataPad", { 0, 1, 0 })
        return
    end
    local player_color = playerArea.player.color

    seq:add(ButtonTest.Click, dataPad, 'Spawn List', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'XWA Points', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Builder', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Rebel', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Add Ship', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Y%-Wing', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Gray Squadron Bomber%s*%(%d+%)', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Add Ship', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'X%-Wing', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Luke Skywalker%sRed Five%s*%(%d+%)', player_color, false)
    seq:add(ButtonTest.Click, dataPad, 'Spawn List', player_color, false)
    seq:add(waitAndMove, playerArea, 120)
end

local function waitForAllObjectsAtRest(seq, newObjects)
    Wait.condition(function()
        seq:next()
    end, function()
        return newObjects:allObjectsAtRest()
    end)
end

local function moveTo(playerArea)
    local squad = Squadron:new(playerArea)
    local seq = Sequence:new()

    seq:add(function(seq)
        playerArea:translate(squad:getObjects())
        waitForAllObjectsAtRest(seq, squad)
    end)

    seq:add(function(seq)
        squad:dropDials()
        waitForAllObjectsAtRest(seq, squad)
    end)
    -- seq:add(ButtonTest.Click, dataPad, 'Spawn List', player_color, false)
    -- seq:add(ButtonTest.Click, host_obj, "Place Ship", playerArea.player.color, false)

    seq:start()
end

-- Helper function to perform movement after a delay
function waitAndMove(seq, playerArea, delay)
    Wait.frames(function()
        moveTo(playerArea)
        seq:next()
    end, delay)
end

return DataPadTest
