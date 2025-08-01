local Dim = require("Dim")

held = false
waiting = false
lineDrawing = true
waitDuration = 0.1
scale = 0.2

rulers = {}
rulersType = nil

boardLength = nil

Data = { Size = "objective" }

function claim(player)
    local color = Color.fromString(player)
    self.setColorTint(color)
    printToAll(player .. " claimed an objective", Color(1.0, 1.0, 0))
end

function unclaim(player)
    self.setColorTint(Color(1, 1, 1, 0.00))
    printToAll(player .. " removed claim of an objective", Color(1.0, 1.0, 0))
end

function onLoad(save_state)
    local state = JSON.decode(save_state)
    if state then
        lineDrawing = state.linedrawing or true
    end
    SetupContextMenu()
end

function onSave()
    return JSON.encode({ linedrawing = lineDrawing })
end

function SetupContextMenu()
    self.clearContextMenu()
    self.addContextMenuItem("Check Range 1", checkRange1, false)
    self.addContextMenuItem("Check Range 2", checkRange2, false)
    self.addContextMenuItem("Claim", claim, false)
    self.addContextMenuItem("Remove Claim", unclaim, false)
    if lineDrawing then
        self.addContextMenuItem("Disable lines",
            function()
                lineDrawing = false
                self.setVectorLines({})
                SetupContextMenu()
            end, false)
    else
        self.addContextMenuItem("Enable lines", function()
            lineDrawing = true
            SetupContextMenu()
        end, false)
    end
end

function checkRange1()
    checkArc("full", 1, true)
end

function checkRange2()
    checkArc("full", 2, true)
end

function checkArc(type, range, friendly)
    self.clearButtons()
    for _, ruler in pairs(rulers) do
        destroyObject(ruler)
    end
    rulers = {}
    if rulersType == type .. range then
        rulersType = nil
    else
        if type == "full" then
            printToAll("Checking for ships at range " .. tostring(range) .. " from " .. self.getName(), color(1.0, 1.0, 0.2, 0.9))
        end
        rulers = Global.call("CheckArc",
            { ship = self, arctype = type, range = range, include_friendly_ships = friendly })
    end
    if rulers and #rulers > 0 then
        rulersType = type .. range
        arcsOpen = true
        local rotation = vector(0, -90, 0)
        local up = vector(0, 1, 0)
        if self.is_face_down then
            up = -1 * up
            rotation = rotation + vector(0, 0, 180)
        end
        local raise = 0.03 * up
        self.createButton({
            click_function = "removeArcs",
            function_owner = self,
            label          = "Remove",
            position       = raise,
            rotation       = rotation,
            width          = 170,
            height         = 150,
            font_size      = 40
        })
    else
        rulersType = nil
        arcsOpen = false
    end
end

function removeArcs()
    self.clearButtons()
    for _, ruler in pairs(rulers) do
        destroyObject(ruler)
        rulers = {}
    end
    rulersType = nil
    arcsOpen = false
end

function onUpdate()
    if boardLength == nil then
        first_edge = nil
        for _, edge in pairs(getObjectsWithTag("PlayerBoardEdge")) do
            if first_edge == nil then
                first_edge = edge
            else
                first_pos = first_edge.getNearestPointFromObject(edge)
                second_pos = edge.getNearestPointFromObject(first_edge)

                boardLength = Dim.Convert_igu_mm(math.sqrt(math.pow(first_pos.x - second_pos.x, 2) +
                    math.pow(first_pos.z - second_pos.z, 2)))
            end
        end
    end
    if lineDrawing and not waiting and held then
        vector_lines = {}
        local side_offset = vector(0, 0.01, 0)
        if self.is_face_down then
            side_offset = side_offset * -1
        end
        for _, obj in pairs(getObjectsWithTag("Objective")) do
            if obj ~= self then
                local my_pos = self.getNearestPointFromObject(obj)
                local other_pos = obj.getNearestPointFromObject(self)
                other_pos.y = my_pos.y

                local distance = Dim.Convert_igu_mm(math.sqrt(math.pow(my_pos.x - other_pos.x, 2) +
                    math.pow(my_pos.z - other_pos.z, 2)))
                if (distance < 200) or (obj.hasTag("CenterObjective") and (distance > 300)) then
                    table.insert(vector_lines, {
                        points = { self.positionToLocal(my_pos) + side_offset, self.positionToLocal(other_pos) + side_offset },
                        color = { 1, 1, 1 },
                        thickness = 0.05 * scale,
                        rotation = vector(0, 0, 0)
                    })
                end
            end
        end

        for _, obj in pairs(getObjectsWithTag("PlayerBoardEdge")) do
            if obj ~= self then
                my_pos = self.getNearestPointFromObject(obj)
                other_pos = obj.getNearestPointFromObject(self)
                other_pos.y = my_pos.y

                local distance = Dim.Convert_igu_mm(math.sqrt(math.pow(my_pos.x - other_pos.x, 2) +
                    math.pow(my_pos.z - other_pos.z, 2)))
                if (distance < 100) or ((distance > 400) and (boardLength / 2.0 > distance)) then
                    table.insert(vector_lines, {
                        points = { self.positionToLocal(my_pos) + side_offset, self.positionToLocal(other_pos) + side_offset },
                        color = { 1, 1, 1 },
                        thickness = 0.05 * scale,
                        rotation = vector(0, 0, 0)
                    })
                end
            end
        end

        self.setVectorLines(vector_lines)
        waiting = true
        Wait.time(function() waiting = false end, waitDuration)
    end
end

function onPickUp(player_color)
    held = true
end

function onDrop(player_color)
    held = false
end
