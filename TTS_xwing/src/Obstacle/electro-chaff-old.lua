local Dim = require("Dim")

checkingRange = nil
selectedShip = nil

sizeFactor = {
    small = 0,
    medium = 0.37,
    large = 0.74,
}

scale = 1 / self.getScale().x

local removeButtonUp = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = { -1.8, 0.1 * scale, 0 },
    rotation = { 0, 90, 0 },
    width = 400 * scale,
    height = 300 * scale,
    font_size = 100 * scale,
    color = { 0.7, 0.7, 0.7 }
}

local removeButtonDown = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = { -1.8, -0.1 * scale, 0 },
    rotation = { 180, 90, 0 },
    width = 400 * scale,
    height = 300 * scale,
    font_size = 100 * scale,
    color = { 0.7, 0.7, 0.7 }
}

function removeCheckRange()
    checkRange(nil)
end

function onLoad(save_state)
    self.addContextMenuItem("Check Range 1", function() checkRange(1) end, false)
end

function checkRange(range)
    if range and checkingRange ~= range then
        printToAll("Checking for ships within range " .. range .. " of " .. self.getName(), color(1.0, 1.0, 0))
        vector_lines = {}
        for _, obj in pairs(getObjectsWithAnyTags({ 'Ship' })) do
            my_pos = self.getNearestPointFromObject(obj)
            closest = Global.call("API_GetClosestPointToShip", { ship = obj, point = my_pos })
            distance = Dim.Convert_igu_mm(closest.length)
            if distance < 100 * range then
                printToAll(obj.getName() .. " is within range " .. range .. " of " .. self.getName(), color(1.0, 1.0, 0))
                table.insert(vector_lines, {
                    points = { self.positionToLocal(closest.A), self.positionToLocal(closest.B) },
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

-- Assign on drop near a small base ship
function onDropped(color)
    local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 80 })
    if nearest ~= nil then
        printToAll('Electro-Chaff Missiles preparing to launch')
        initialP = self.getPosition()
        selectedShip = nearest
        local size = selectedShip.getTable('Data').Size or "small"
        local pos = selectedShip.getPosition() - selectedShip.getTransformForward() * (2 + sizeFactor[size])
        local rot = selectedShip.getRotation() + vector(0, -90, 0)
        doMove(pos, rot)
        launch()
    end
end

function launch()
    self.lock()
    self.createButton({
        click_function = "dropBR",
        function_owner = self,
        label          = "^",
        position       = { -1.2, 0.3, 1 },
        rotation       = { 0, 135, 0 },
        width          = 300,
        height         = 300,
        font_size      = 250
    })
    self.createButton({
        click_function = "dropS",
        function_owner = self,
        label          = "^",
        position       = { -1, 0.3, 0 },
        rotation       = { 0, 90, 0 },
        width          = 300,
        height         = 300,
        font_size      = 250
    })
    self.createButton({
        click_function = "dropBL",
        function_owner = self,
        label          = "^",
        position       = { -1.2, 0.3, -1 },
        rotation       = { 0, 45, 0 },
        width          = 300,
        height         = 300,
        font_size      = 250
    })
    self.createButton({
        click_function = "cancel",
        function_owner = self,
        label          = "Cancel",
        position       = { -2.5, 0.3, 0 },
        rotation       = { 0, 90, 0 },
        width          = 800,
        height         = 300,
        font_size      = 250
    })
end

function cancel()
    self.unlock()
    self.clearButtons()
    doMove(initialP, self.getRotation())
end

function dropBL()
    --print("BL")
    self.clearButtons()
    local size = selectedShip.getTable('Data').Size or "small"
    pos = selectedShip.getPosition() + vector(0, -0.1, 0) - selectedShip.getTransformForward() *
        (6.19 + sizeFactor[size]) + selectedShip.getTransformRight() * 2.79
    doMove(pos, self.getRotation() + vector(0, -45, 0))
    takeFuse(pos)
    Global.call('API_MineDrop', { mine = self })
end

function dropS()
    --print("S")
    self.clearButtons()
    local size = selectedShip.getTable('Data').Size or "small"
    pos = selectedShip.getPosition() + vector(0, -0.1, 0) - selectedShip.getTransformForward() *
        (7.71 + sizeFactor[size])
    doMove(pos, self.getRotation())
    takeFuse(pos)
    Global.call('API_MineDrop', { mine = self })
end

function dropBR()
    --print("BR")
    self.clearButtons()
    local size = selectedShip.getTable('Data').Size or "small"
    pos = selectedShip.getPosition() + vector(0, -0.1, 0) - selectedShip.getTransformForward() *
        (6.19 + sizeFactor[size]) - selectedShip.getTransformRight() * 2.79
    doMove(pos, self.getRotation() + vector(0, 45, 0))
    takeFuse(pos)
    Global.call('API_MineDrop', { mine = self })
end

function takeFuse(pos)
    fuseBag = getObjectFromGUID('568727')
    fuseBag.takeObject({
        position = pos + vector(0, 1, 0),
        smooth   = true,
    })
end

function doMove(pos, rot)
    Global.call("API_ClearPosition", { pos = pos, reach = 0.8 })
    self.setPositionSmooth(pos, false, true)
    self.setRotationSmooth(rot, false, true)
end
