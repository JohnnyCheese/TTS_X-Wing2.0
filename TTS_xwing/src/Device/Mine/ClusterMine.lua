function onDropped()
    Global.call('API_BombTokenDrop', { token = self })
end

local Dim = require("Dim")

checkingRange = nil
scale = 1 / self.getScale().x

local removeButtonUp = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = { 0, 0.1 * scale, 0 },
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
    position = { 0, -0.1 * scale, 0 },
    rotation = { 180, 0, 0 },
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
