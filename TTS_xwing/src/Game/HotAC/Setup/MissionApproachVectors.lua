local ApproachVector = require("Game.HotAC.Setup.ApproachVector")

MissionApproachVectors = {}
MissionApproachVectors.__index = MissionApproachVectors

-- Constructor for the ApproachVectorContainer class
function MissionApproachVectors:new(vectors)
    local self = setmetatable({}, MissionApproachVectors)
    self.vectors = {}
    if vectors ~= nil then
        for index = 1, #vectors, 1 do
            self:addVector(index, vectors[index])
        end
    end
    return self
end

-- Function to add an approach vector
function MissionApproachVectors:addVector(index, notation)
    local vector = ApproachVector:new(index, notation)
    table.insert(self.vectors, vector)
    vector:addApproachVector()
end

-- Function to show all approach vectors
function MissionApproachVectors:showAll()
    for _, vector in ipairs(self.vectors) do
        vector:addApproachVector()
    end
end

-- Function to remove all approach vectors
function MissionApproachVectors:removeAll()
    for _, vector in ipairs(self.vectors) do
        local obj = getObjectFromGUID(vector.objectGUID)
        if obj then
            obj.destruct()
        end
    end
    self.vectors = {}
end

-- Function to layout ships around all approach vectors
function MissionApproachVectors:layoutShips(index, ships)
    self.vectors[index]:layoutShips(ships)
end

return MissionApproachVectors
