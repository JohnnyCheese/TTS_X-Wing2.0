require("TTS_lib.Util.Table")
local Sequence = require("TTS_lib.Sequence.Sequence")
local PlayerArea = require("Player.PlayerArea")

local DataPadTest = {}

DataPadTest.runSmokeTest = function()
    local bluePlayerArea = PlayerArea:new(Player["Blue"])
    local redPlayerArea = PlayerArea:new(Player["Red"])

    local seq = Sequence:new(true)

    seq:addTask(printToAll, "Starting Smoke Test...", { 0, 1, 0 })
    DataPadTest.spawnImperialShips(seq, bluePlayerArea)
    DataPadTest.spawnRebelShips(seq, redPlayerArea)
    seq:addTask(printToAll, "Smoke Test Completed.", { 0, 1, 0 })

    seq:start()
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
    seq:waitFrames(120)
    seq:physicsCast(dataPad.getTable('data_pad_spawn_area'), moveableFilter)
    seq:waitCondition(function()
        seq.ctx.imperialSquadron = seq.result
        playerArea:translate(seq.ctx.imperialSquadron:getObjects())
    end, function()
        return seq.result:allAtRest()
    end)
    seq:waitCondition(function()
            local dials = seq.ctx.imperialSquadron:filter(function(obj)
                return obj.getName() == "Unassigned Dial"
            end)
            DataPadTest.dropDials(dials, playerArea)
        end,
        function()
            return seq.ctx.imperialSquadron:allAtRest()
        end)
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
    seq:clickButton(dataPad, 'Spawn & Move.List', player_color, false)
    seq:waitFrames(200)
    seq:physicsCast(playerArea:castParams(), function(obj)
        return obj.getName() == "Unassigned Dial"
    end)
    seq:waitCondition(function()
            DataPadTest.dropDials(seq.result, playerArea)
        end,
        function()
            return seq.result:allAtRest()
        end)
end

function moveableFilter(obj)
    return obj.locked == false and obj.interactable == true
end

function DataPadTest.dropDials(dials, playerArea)
    dials:forEach(function(dial)
        local shipPos = dial.getPosition() + 3 * playerArea.forward + Vector(0, 5, 0)
        dial.setPositionSmooth(shipPos, true, false)
        Wait.condition(function()
            DataPadTest.assignNearestShip(dial, playerArea.player.color)
        end, function()
            return dials:allAtRest()
        end)
    end)
end

function DataPadTest.assignNearestShip(dial, playerColor)
    local nearest = Global.call("API_FindNearestShip", { object = dial, max_distance = 80 })
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

return DataPadTest
