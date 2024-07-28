require("TTS_lib.Util.Table")
local MissionApproachVectors = require("TTS_xwing.src.Game.HotAC.Setup.MissionApproachVectors")

local SmokeTest = {}

SmokeTest.runSmokeTest = function()
    printToAll("Approach Vectors Test ...", { 0, 1, 0 })

    local approachVectors = {
        "L3", "L6", "T2.5", "T6.5", "R6", "R3"
    }

    local mission = MissionApproachVectors:new(approachVectors)

    -- Show all approach vectors
    -- mission:showAll()

    -- To remove all approach vectors
    -- mission:removeAll()

    -- To layout ships around the approach vectors
    -- mission:layoutShips(ships)

    printToAll("Approach Vectors Test Completed.", { 0, 1, 0 })
end

return SmokeTest
