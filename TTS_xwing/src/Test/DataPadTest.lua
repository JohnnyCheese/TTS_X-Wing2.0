require("TTS_lib.Util.Table")
local Sequence = require("Test.Sequence")
local ButtonTest = require("Test.ButtonTest")
local PlayerArea = require("Player.PlayerArea")
local Squadron = require("Game.StarForge.Squadron")
local Mover = require("Game.Component.Spawner.Mover")

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

    seq:clickButton(dataPad, 'Spawn List', player_color, false)
    seq:clickButton(dataPad, 'XWA Points', player_color, false)
    seq:clickButton(dataPad, 'Builder', player_color, false)
    seq:clickButton(dataPad, 'Imperial', player_color, false)
    seq:clickButton(dataPad, 'Add Ship', player_color, false)
    seq:clickButton(dataPad, 'TIE/ln Fighter', player_color, false)
    seq:clickButton(dataPad, '"Howlrunner"%s*%(%d+%)', player_color, false)
    seq:clickButton(dataPad, 'Add Ship', player_color, false)
    seq:clickButton(dataPad, 'TIE Advanced x1', player_color, false)
    seq:clickButton(dataPad, 'Darth Vader%s*%(%d+%)', player_color, false)
    seq:clickButton(dataPad, 'Spawn List', player_color, false)
    seq:add(Mover.Move, playerArea, 120)
end

function DataPadTest.spawnRebelShips(seq, playerArea)
    local dataPad = getObjectFromGUID("a4dbbf")
    if dataPad == nil then
        printToAll("Didn't find DataPad", { 0, 1, 0 })
        return
    end
    local player_color = playerArea.player.color

    seq:clickButton(dataPad, 'Spawn List', player_color, false)
    seq:clickButton(dataPad, 'XWA Points', player_color, false)
    seq:clickButton(dataPad, 'Builder', player_color, false)
    seq:clickButton(dataPad, 'Rebel', player_color, false)
    seq:clickButton(dataPad, 'Add Ship', player_color, false)
    seq:clickButton(dataPad, 'Y%-Wing', player_color, false)
    seq:clickButton(dataPad, 'Gray Squadron Bomber%s*%(%d+%)', player_color, false)
    seq:clickButton(dataPad, 'Add Ship', player_color, false)
    seq:clickButton(dataPad, 'X%-Wing', player_color, false)
    seq:clickButton(dataPad, 'Luke Skywalker%sRed Five%s*%(%d+%)', player_color, false)
    seq:clickButton(dataPad, 'Spawn List', player_color, false)
    seq:add(Mover.Move, playerArea, 120)
end

return DataPadTest
