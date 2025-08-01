local Transform = require("TTS_lib.Vector.Transform")
local Dim = require("Dim")

ApproachVector = {}
ApproachVector.__index = ApproachVector

local image_url =
"https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/HotAC/Table/Approach%20Vector.png"
local model_url =
"https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/HotAC/Table/Approach%20Vector.obj"

-- Constructor for the ApproachVectorArea class
function ApproachVector:new(index, notation)
    local self = setmetatable({}, ApproachVector)
    self.index = index
    self.notation = notation
    self.position, self.forward = self:calculatePositionAndForward(notation)
    self.transform = Transform:new(self.position, self.forward)
    self:createApproachVectorUI(index)
    return self
end

-- Function to calculate the position and forward vector based on the notation
function ApproachVector:calculatePositionAndForward(notation)
    local boardEdges = self:getBoardEdges()

    local edge, range = notation:match("([LTRB])(%d%.?%d?)")
    range = Dim.Convert_mm_igu(tonumber(range) * 100) -- Assuming 1 Range Unit = 100 mm

    local position, forward

    if edge == "T" then
        position = Vector(boardEdges["L"].x + range, 1, boardEdges["T"].z)
        forward = Vector(0, 0, -1)
    elseif edge == "B" then
        position = Vector(boardEdges["L"].x + range, 1, boardEdges["B"].z)
        forward = Vector(0, 0, 1)
    elseif edge == "L" then
        position = Vector(boardEdges["L"].x, 1, boardEdges["B"].z + range)
        forward = Vector(1, 0, 0)
    elseif edge == "R" then
        position = Vector(boardEdges["R"].x, 1, boardEdges["B"].z + range)
        forward = Vector(-1, 0, 0)
    else
        printToAll("Invalid notation: " .. notation, Color.Red)
    end

    return position, forward
end

-- Function to get the board edges from the layout
function ApproachVector:getBoardEdges()
    local hotacMatGUID = "79e109"
    local hotacMat = getObjectFromGUID(hotacMatGUID)
    if hotacMat then
        local bounds = hotacMat.getBounds()
        local halfSize = bounds.size * 0.5

        local boardEdges = {
            T = { x = bounds.center.x, z = bounds.center.z + halfSize.z },
            B = { x = bounds.center.x, z = bounds.center.z - halfSize.z },
            L = { x = bounds.center.x - halfSize.x, z = bounds.center.z },
            R = { x = bounds.center.x + halfSize.x, z = bounds.center.z }
        }

        return boardEdges
    else
        printToAll("Error: HotAC mat not found.", Color.Orange)
    end
end

-- Function to create the approach vector UI
function ApproachVector:createApproachVectorUI(index)
    local uiData = {
        tag = "Panel",
        attributes = {
            id = "approachVectorPanel" .. index,
            rectAlignment = "MiddleCenter",
            width = 0,
            height = 0,
            visibility = "approachVectorPanel"
        },
        children = {
            {
                tag = "Text",
                attributes = {
                    id = "approachVectorNumber" .. index,
                    text = tostring(index),
                    color = "#FFFFFF",
                    fontSize = "300",
                    alignment = "MiddleCenter"
                }
            }
        }
    }
    UI.setXmlTable({ uiData })
end

function ApproachVector:addApproachVector()
    self:addApproachVectorObject()
end

function ApproachVector:addApproachVectorCard()
    local targetForward = self.forward
    local currentForward = Vector(0, 0, -1)
    local angle = targetForward:angle(currentForward)
    local direction = currentForward:cross(targetForward)
    angle = direction * angle

    local card = {
        type = "Card",
        position = self.position,
        rotation = angle,
        scale = { 1, 1, 1 },
        sound = false,
        snap_to_grid = true,
        callback_function = function(obj)
            self:attachUIToVector(obj)
            local name = "Approach Vector #" .. self.index .. " [" .. self.notation .. "]"
            obj.setName(name)
        end
    }

    local cardData = {
        type = 0,
        face = image_url,
        back = image_url
    }

    local approachVector = spawnObject(card)
    approachVector.setCustomObject(cardData)
end

function ApproachVector:addApproachVectorObject()
    local targetForward = self.forward
    local currentForward = Vector(0, 0, -1)
    local angle = targetForward:angle(currentForward)
    local direction = currentForward:cross(targetForward)
    angle = direction * angle
    local pos = self.position
    pos.y = 1.1

    local object = {
        type = "Custom_Model",
        position = pos,
        rotation = angle,
        scale = { 1, 1, 1 },
        sound = false,
        snap_to_grid = true,
        callback_function = function(obj)
            self:attachUIToVector(obj)
            local name = "Approach Vector #" .. self.index .. " [" .. self.notation .. "]"
            obj.setName(name)
            if obj.is_face_down then
                printToAll("flipping: " .. obj.getName())
                obj.flip()
            end
        end
    }


    local customUI = {
        type = 0,
        mesh = model_url,
        diffuse = image_url,
        material = 3,
    }

    local approachVector = spawnObject(object)
    approachVector.setCustomObject(customUI)
end

function ApproachVector:addApproachVectorDie()
    local targetForward = self.forward
    local currentForward = Vector(0, 0, -1)
    local angle = targetForward:angle(currentForward)
    local direction = currentForward:cross(targetForward)
    angle = direction * angle

    local die4 = {
        type = "Die_4",
        position = self.position,
        rotation = { 0, 100 / 3, 0 },
        scale = { 1, 1, 1 },
        sound = false,
        snap_to_grid = true,
        callback_function = function(obj)
            self:attachUIToVector(obj)
            local name = "Approach Vector #" .. self.index .. " [" .. self.notation .. "]"
            obj.setName(name)
            obj.setValue(1)
            obj.setRotation(-1 * angle)
        end
    }

    local approachVector = spawnObject(die4)
end

function ApproachVector:attachUIToVector(obj)
    obj.UI.setXmlTable({
        {
            tag = "Text",
            attributes = {
                text = "Vector " .. tostring(self.index),
                color = "#FFFFFF",
                fontSize = "300",
                alignment = "MiddleCenter",
                rectAlignment = "MiddleCenter",
                width = 0,
                height = 0
            }
        }
    })
end

-- Function to layout ships around the approach vector area
function ApproachVector:layoutShips(ships)
    self.transform:translate(ships)
end

return ApproachVector
