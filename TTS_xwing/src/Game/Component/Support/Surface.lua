local setting = false

function onLoad(save_state)
    if save_state and save_state ~= "" then
        local loadedData = JSON.decode(save_state)
        if loadedData then
            setting = loadedData.setting
        end
    end
    if setting == true then
        surface()
    else
        submerge()
    end
    setupContextMenu()
end

function onSave()
    saveData = {}
    saveData.setting = setting
    return JSON.encode(saveData)
end

function submerge()
    local sPos = self.getPosition()
    sPos.y = -3
    self.setPosition(sPos)
    self.interactable = false
    self.tooltip = false
    self.setLock(true)
end

function surface()
    local sPos = self.getPosition()
    sPos.y = 3
    self.setPosition(sPos)
    self.interactable = true
    self.tooltip = true
    self.setLock(true)
end

function setupContextMenu()
    self.addContextMenuItem("Dump Scripted Items", emptyBag)
    self.addContextMenuItem("Submerge", submerge)
end

function emptyBag()
    local items = self.getObjects()
    local position = self.getPosition()

    position.x = position.x + 10
    position.z = position.z - 15
    local count = 0
    
    for i = #items, 1, -1 do
        local item = items[i]
        if item.lua_script ~= "" then
            count = count + 1
            local spreadPos = {
                x = position.x + math.floor(count / 3) * 3.5,
                y = position.y + 1,
                z = position.z + (count % 3) * 3
            }
            
            self.takeObject({
                position = spreadPos,
                index = i - 1,  -- Adjust index to current position in the array
                smooth = false
            })
        end
    end
end