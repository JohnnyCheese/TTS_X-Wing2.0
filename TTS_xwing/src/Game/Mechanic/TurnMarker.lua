local turnCount = 0

function onDrop()
    turnCount     = turnCount + 1
    local message = "Beginning of Turn " .. turnCount .. "."
    if turnCount > 12 then
        message = message .. " Should you still be playing?"
    end
    printToAll(message, Color.Red)
end

function reset()
    turnCount = 0
end

function onLoad(save_state)
    self.addContextMenuItem("Reset Counter", reset)
    if save_state and save_state ~= "" then
        local loadedData = JSON.decode(save_state)
        if loadedData then
            turnCount = loadedData.turnCount
        end
    end
end

function onSave()
    saveData = {}
    saveData.turnCount = turnCount
    return JSON.encode(saveData)
end
