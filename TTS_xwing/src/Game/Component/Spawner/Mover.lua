require("TTS_lib.Util.Table")
local Sequence = require("Test.Sequence")
local Squadron = require("Game.StarForge.Squadron")

local Mover = {}

function Mover.waitForAllObjectsAtRest(seq, newObjects)
    Wait.condition(function()
        seq:next()
    end, function()
        return newObjects:allObjectsAtRest()
    end)
end

function Mover.moveTo(playerArea)
    local squad = Squadron:new(playerArea)
    local seq = Sequence:new()

    seq:add(function(seq)
        playerArea:translate(squad:getObjects())
        Mover.waitForAllObjectsAtRest(seq, squad)
    end)

    seq:add(function(seq)
        squad:dropDials()
        Mover.waitForAllObjectsAtRest(seq, squad)
    end)

    seq:start()
end

-- Helper function to perform movement after a delay
function Mover.Move(seq, playerArea, delay)
    Wait.frames(function()
        Mover.moveTo(playerArea)
        seq:next()
    end, delay)
end


-- Method to check if all objects are at rest
function Mover.allObjectsAtRest()
    for _, obj in ipairs(self.objects) do
        if obj.isSmoothMoving() or not obj.resting then
            return false
        end
    end
    return true
end



return Mover
