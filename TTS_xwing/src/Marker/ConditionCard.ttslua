dial = nil
ship = nil
function addTintObject(params)
    if params[1] == "ship" then
        ship = params[2]
    elseif params[1] == "dial" then
        dial = params[2]
    end
end

function onUpdate()
    local tint = self.getColorTint()
    if tint ~= color(1, 1, 1, 1) then
        self.setColorTint(color(1, 1, 1, 1))
        if dial ~= nil then
            dial.setColorTint(tint)
        end

        for _, attachment in pairs(self.getAttachments()) do
            id = self.removeAttachment(attachment.index)
            id.setColorTint(tint)
            self.addAttachment(id)
        end

        if ship ~= nil then
            for _, attachment in pairs(ship.getAttachments()) do
                id = ship.removeAttachment(attachment.index)
                id.setColorTint(tint)
                ship.addAttachment(id)
            end
        end
    end
end

loaded = false

function onLoad(save_state)
    loaded = true
end

function isLoadedAndStill()
    return loaded and self.resting
end
