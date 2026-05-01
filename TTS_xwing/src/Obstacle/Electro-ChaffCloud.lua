local RangeCheck = require("Device.RangeCheck")

checkingRange = nil
selectedShip = nil

sizeFactor = {
    small = 0,
    medium = 0.37,
    large = 0.74,
}

scale = 1 / self.getScale().x

function onDropped()
    Global.call('API_BombTokenDrop', { token = self })
end

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
    checkingRange = RangeCheck.checkObjectRange(self, range, checkingRange, removeButtonUp, removeButtonDown, {
        thickness = 0.05 * scale
    })
end
