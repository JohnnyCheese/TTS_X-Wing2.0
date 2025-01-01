local Transform = require("TTS_lib.Vector.Transform")

PlayerArea = {}
PlayerArea.__index = PlayerArea

function PlayerArea:new(player, layout)
    local self = setmetatable({}, PlayerArea)
    self.player = player
    self.layout = self:layoutKey(layout or self:getCurrentLayout())
    self:calculateHandZoneInfo()
    return self
end

function PlayerArea:layoutKey(layout)
    local layouts = {
        [1] = 'Standard',
        [2] = 'Epic',
        [3] = 'HotAC'
    }

    if type(layout) == "number" then
        layout = layouts[layout]
    end

    return layout
end

function PlayerArea:calculateHandZoneInfo()
    local handTransform = self.player.getHandTransform()
    self.position = handTransform.position + handTransform.forward * self:getScalar()
    self.forward = handTransform.forward
    self.transform = Transform:new(self.position, handTransform.forward)
end

function PlayerArea:getCurrentLayout()
    local layoutController_GUID = "b3992e"
    local layout = getObjectFromGUID(layoutController_GUID)
    if layout then
        local currentLayout = layout.call("getLayoutState")
        return self:layoutKey(currentLayout)
    else
        printToAll("Error: Layout object not found.", Color.Orange)
    end
end

function PlayerArea:getScalar()
    local multipliers = {
        Standard = 18,
        Epic = 19.1,
        HotAC = 14.5
    }

    return multipliers[self.layout] or 18
end

function PlayerArea:translate(objects)
    self.transform:translate(objects)
end

return PlayerArea
