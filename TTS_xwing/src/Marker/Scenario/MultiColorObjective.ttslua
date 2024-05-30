local Dim = require("TTS_xwing.src.Dim")

held = false
waiting = false
lineDrawing = true
waitDuration = 0.1

boardLength = nil

function claim(player)
    local color = Color.fromString(player)
    color[4] = 0.6
    self.setColorTint(color)
    printToAll(player .. " claimed an objective", Color(1.0, 1.0, 0))
end

function unclaim(player)
    self.setColorTint(Color(1, 1, 1, 0.05))
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
    self.addContextMenuItem("Check Range 1", function() checkRange(1) end, false)
    self.addContextMenuItem("Check Range 2", function() checkRange(2) end, false)
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

scale = 1 / self.getScale().x
checkingRange = nil

local removeButtonUp = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = { 0, 0.1 * scale, 0.0 },
    rotation = { 0, 0, 0 },
    width = 400 * scale,
    height = 300 * scale,
    font_size = 100 * scale,
    color = { 0.7, 0.7, 0.7 }
}

local removeButtonDown = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = { 0, -0.1 * scale, 0.0 },
    rotation = { 180, 180, 0 },
    width = 400 * scale,
    height = 300 * scale,
    font_size = 100 * scale,
    color = { 0.7, 0.7, 0.7 }
}


function removeCheckRange()
    checkRange(nil)
end

function checkRange(range)
    for _, p in ipairs(Player.getPlayers() or {}) do
        self.removeFromPlayerSelection(p.color)
    end

    if range and checkingRange ~= range then
        printToAll("Checking for ships within range " .. range .. " of " .. self.getName(), color(1.0, 1.0, 0))
        vector_lines = {}
        local side_offset = vector(0, 0.01, 0)
        if self.is_face_down then
            side_offset = side_offset * -1
        end
        for _, obj in pairs(getObjectsWithAnyTags({ 'Ship' })) do
            my_pos = self.getNearestPointFromObject(obj)
            closest = Global.call("API_GetClosestPointToShip", { ship = obj, point = my_pos })
            distance = Dim.Convert_igu_mm(closest.length)
            if distance < 100 * range then
                printToAll(obj.getName() .. " is within range " .. range .. " of " .. self.getName(), color(1.0, 1.0, 0))
                table.insert(vector_lines, {
                    points = { self.positionToLocal(closest.A) + side_offset, self.positionToLocal(closest.B) + side_offset },
                    color = { 1, 1, 1 },
                    thickness = 0.05 * scale,
                    rotation = vector(0, 0, 0)
                })
            end
        end
        self.clearButtons()
        self.setVectorLines(vector_lines)
        if #vector_lines > 0 then
            checkingRange = range
            if self.is_face_down then
                self.createButton(removeButtonDown)
            else
                self.createButton(removeButtonUp)
            end
        else
            checkingRange = nil
            printToAll("No ships is within range " .. range .. " of " .. self.getName(), color(1.0, 1.0, 0))
        end
    else
        checkingRange = nil
        self.clearButtons()
        self.setVectorLines({})
    end
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
