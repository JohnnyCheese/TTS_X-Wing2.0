-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: https://github.com/tjakubo2/TTS_xwing
--
-- Script applicable to any object that allows control
--  over playmat and setup rulers on side it is loaded on
-- ~~~~~~

function onLoad()
    selfSide = 1
    controlledMatName = 'Teal-Blue Playmat'
    if self.getPosition()[1] < 0 then
        selfSide = -1
        controlledMatName = 'Green-Red Playmat'
    end
    rulersOnLoad()
    playmatOnLoad()
end

-- Transform a position to the side this object is on
function sPos(pos)
    return {selfSide*pos[1], pos[2], pos[3]}
end

-- AUTO RULERS SCRIPT
local rulers = {}
local rulersState = 0 -- 0: none, 1: roid setup, 2: ship setup

local rulerData = {}
rulerData.mesh = 'http://pastebin.com/raw.php?i=MLLajD97'
rulerData.collider = 'http://pastebin.com/raw.php?i=MLLajD97'
rulerData.diffuse = 'http://i.imgur.com/46CSDvj.jpg'
rulerData.material = 1

local roidRot = {
    { 0, 270, 180},
    { 0, 180, 180},
    { 0, 270, 180},
    { 0, 0, 180},
    { 0, 0, 180},
    { 0, 90, 180},
    { 0, 90, 180},
    { 0, 180, 180}
}

local setupRot = {
    {0, 270, 0},
    {0, 0, 0},
    {0, 270, 0},
    {0, 0, 0},
    {0, 0, 0},
    {0, 90, 0},
    {0, 180, 0},
    {0, 90, 0},
    {0, 180, 0},
    {0, 180, 0}
}

local roidPos = {
    { 29.872200088501, 0.99871951341629, -10.8846182632446}, -- pio
    { 31.382360534668, 0.998719453811646, -9.37833354949951}, -- poz
    { 11.1684393310547, 0.998719573020935, -10.8876889038086},
    { 9.64546291351318, 0.998719453811646, -9.37820747375488},
    { 9.64722316741943, 0.99871951341629, 9.37365325927734},
    { 11.1658749008179, 0.998719453811646, 10.8807905578613},
    { 29.8585949707031, 0.998719394207001, 10.8395362091064}, -- pio
    { 31.3808876037598, 0.998719453811646, 9.32834770202637} -- poz
}

local setupPos = {
    { 3.97240991592407, 1.00172388553619, -10.8451750564575}, --pio
    { 9.67806907653809, 1.00172448158264, -12.4075313186646},
    { 37.0594985961914, 1.00172400474548, -10.8700817108154}, --pio
    { 20.5256023406982, 1.0017237663269, -12.4035499572754},
    { 31.3721223449707, 1.00172340869904, -12.4002779006958},

    { 3.97240991592407, 1.00172388553619, 10.8451750564575}, --pio
    { 9.67806907653809, 1.00172448158264, 12.4075313186646},
    { 37.0594985961914, 1.00172400474548, 10.8700817108154}, --pio
    { 20.5256023406982, 1.0017237663269, 12.4035499572754},
    { 31.3721223449707, 1.00172340869904, 12.4002779006958},
}

local corrScale = {0.625, 0.625, 0.625}

function rulersOnLoad()
    local button = {}
    button.click_function = 'toggleRulers'
    button.function_owner = self
    button.label = 'TOGGLE RULERS'
    button.position = {8, 0.1, 0}
    button.rotation = {0, 90, 0}
    button.width = 4000
    button.height = 1200 -- 40
    button.font_size = 500
    self.createButton(button)
end

function toggleRulers()
    deleteAll()
    rulersState = rulersState + 1
    if rulersState == 1 then
      spawnSet(roidPos, roidRot)
    elseif rulersState == 2 then
      spawnSet(setupPos, setupRot)
    elseif rulersState == 3 then
      rulersState = 0
    end
end

function spawnSet(posTable, rotTable)
    for k,pos in pairs(posTable) do
        local params = {} -- 50
        params.type = 'Custom_Model'
        params.position = sPos(posTable[k])
        params.rotation = rotTable[k]
        obj = spawnObject(params)
        obj.setCustomObject(rulerData)
        obj.setScale(corrScale)
        obj.lock()
        obj.setDescription('autoruler')
        table.insert(rulers, obj)
    end
end

function deleteAll()
    for k,ruler in pairs(rulers) do ruler.destruct() ruler = nil end
end

function onObjectDestroyed(obj)
    if obj.getDescription() == 'autoruler' then
      for k, v in pairs(rulers) do
        if v == obj then table.remove(rulers, k) end
      end
    end
end
-- END AUTO RULERS SCRIPT

-- PLAYMAT IMAGE CHANGE SCRIPT
matObject = nil

function playmatOnLoad()
    local button = {}
    button.click_function = 'callImageChange'
    button.function_owner = self
    button.label = 'NEXT PLAYMAT'
    button.position = {12, 0.1, 0}
    button.rotation = {0, 90, 0}
    button.width = 4000
    button.height = 1200 -- 40
    button.font_size = 500
    self.createButton(button)

    button.click_function = 'callTypeChange'
    button.function_owner = self
    button.label = 'CHANGE MAT TYPE'
    button.position = {15, 0.1, 0}
    button.rotation = {0, 90, 0}
    button.width = 4000
    button.height = 1200 -- 40
    button.font_size = 450
    self.createButton(button)
end

function callImageChange()
    updatePlaymatRef()
    matObject.call('NextImage')
end

function callTypeChange()
    updatePlaymatRef()
    matObject.call('ChangeType')
end

function updatePlaymatRef()
    for k,obj in pairs(getAllObjects()) do
        if obj.getName() == controlledMatName then matObject = obj end
    end
end

-- PLAYMAT IMAGE CHANGE SCRIPT