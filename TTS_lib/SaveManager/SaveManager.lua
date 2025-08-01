-- Require EventSub so we can hook into onLoad
local ES = require("TTS_Lib.EventSub.EventSub")

local SaveManager = {
    moduleList = {}
}

SaveManager.Register = function(key, saveFcn, restoreFcn)
    assert(type(key) == 'string', 'SaveManager.Register: No table key provided!')
    assert(type(saveFcn) == 'function', 'SaveManager.Register: No save function provided!')
    assert(type(restoreFcn) == 'function', 'SaveManager.Register: No restore function provided!')

    if SaveManager.moduleList[key] then
        error('SaveManager.Register: Key \'' .. key .. '\' already reserved!')
    end
    SaveManager.moduleList[key] = { save = saveFcn, restore = restoreFcn }
end

SaveManager.onLoad = function(saveData)
    local saveTable = SaveManager.Decode(saveData)
    if type(saveTable) ~= 'table' then
        print('Save data is invalid or empty')
        return
    end
    local responses = {}
    for key, module in pairs(SaveManager.moduleList) do
        if saveTable[key] and (not table.empty(saveTable[key])) then
            local response = module.restore(saveTable[key])
            if response and type(response) == 'string' then
                table.insert(responses, response)
            end
        end
    end
    if #responses > 0 then
        table.insert(responses, 1, 'Attempting to restore state...')
    end
    SaveManager.Notify(responses)
end
ES.Register('onLoad', SaveManager.onLoad)

SaveManager.onSave = function()
    local saveData = {}
    for key, module in pairs(SaveManager.moduleList) do
        local moduleSave = module.save()
        if moduleSave and type(moduleSave) == 'table' and (not table.empty(moduleSave)) then
            saveData[key] = moduleSave
        end
    end
    return SaveManager.Encode(saveData)  -- Encode the table of JSON strings
end

SaveManager.Encode = function(dataTable)
    return JSON.encode(dataTable)
end

SaveManager.Decode = function(encodedData)
    return JSON.decode(encodedData)
end

SaveManager.Notify = function(responses)
    if #responses > 0 then
        printToAll(table.concat(responses, '\n'), { 0.8, 0.1, 0.8 })
    end
end

return SaveManager
