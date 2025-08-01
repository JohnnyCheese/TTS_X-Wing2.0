-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: https://github.com/tjakubo2/TTS_xwing
--
-- Script applicable to playmats
-- ~~~~~~

-- TO ADD NEW IMAGES TO THE SET
-- Just add their links to the table below in the same fashion

-- Table of all images to be cycled through with NextImage()
imageSet = {
    'https://i.imgur.com/aCxRouI.jpg',
    'https://i.imgur.com/X3luGQr.jpg',
    'https://i.imgur.com/hGzGwY3.jpg',
    'https://i.imgur.com/W5AuCVd.jpg',
}

-- Mat flag for layouts
__XW_Mat = true
-- Parent layout name
__XW_MatLayout = 'Epic'
-- This mat identifier
__XW_MatID = 'Main'

function onLoad()
    -- Restore current image index
    currImage = tonumber(self.script_state) or 1
    self.lock()
    self.interactable = false
    self.tooltip = false
end

-- Change image to the next from the list, wrap around to 1
-- Reloads self to actually reflect the change
function NextImage()
    deleteAll()
    -- Increment image index
    local nextImage = currImage + 1
    if nextImage > #imageSet then
        nextImage = 1
    end
    
    -- Reload self with the new image and save the index
    local custom = self.getCustomObject()
    custom.diffuse = imageSet[nextImage]
    self.setCustomObject(custom)
    local newSelf = self.reload()
    newSelf.script_state = nextImage
end

function PrevImage()
    deleteAll()
    -- Increment image index
    local nextImage = currImage - 1
    if nextImage == 0 then
        nextImage = #imageSet
    end
    
    -- Reload self with the new image and save the index
    local custom = self.getCustomObject()
    custom.diffuse = imageSet[nextImage]
    self.setCustomObject(custom)
    local newSelf = self.reload()
    newSelf.script_state = nextImage
end

-- Please update me


corrScale = { 0.625, 0.625, 0.625 }

function ToggleRulers()
    deleteAll()
    rulersState = rulersState + 1
    if rulersState == 1 then
        spawnSet(setupPos, setupRot)
    elseif rulersState == 2 then
        rulersState = 0
    end
end

function spawnSet(posTable, rotTable)
    -- please kill me
    local function sPos(tab)
        if self.getPosition()[1] < 0 then
            return { -1 * tab[1], tab[2], tab[3] }
        else
            return tab
        end
    end
    local initPos = self.getPosition()
    initPos.y = initPos.y - 3
    for k, pos in pairs(posTable) do
        local params = {} -- 50
        params.type = 'Custom_Model'
        params.position = initPos
        --params.position = sPos(posTable[k])
        --params.rotation = rotTable[k]
        obj = spawnObject(params)
        obj.setCustomObject(rulerData)
        obj.setScale(corrScale)
        obj.lock()
        obj.setPositionSmooth(sPos(posTable[k]), false, true)
        obj.setRotationSmooth(rotTable[k], false, true)
        obj.addTag('TempLayoutElement')
        rulers[obj] = true
    end
end

function deleteAll()
    for ruler in pairs(rulers) do
        ruler.destruct()
    end
    rulers = {}
end

function onObjectDestroyed(obj)
    if rulers[obj] then
        rulers[obj] = nil
    end
end

rulers = {}
rulersState = 0
rulerData = {}
rulerData.mesh = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range13.obj'
rulerData.collider = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range13.obj'
rulerData.diffuse = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range.jpg'
rulerData.material = 1

setupRot = {
    { 0, 270, 0 },
    { 0, 0, 0 },
    { 0, 270, 0 },
    { 0, 0, 0 },
    { 0, 0, 0 },
    { 0, 90, 0 },
    { 0, 180, 0 },
    { 0, 90, 0 },
    { 0, 180, 0 },
    { 0, 180, 0 }
}

setupPos = {
    { 3.97240991592407, 1.00172388553619, -10.8451750564575 }, --pio
    { 9.67806907653809, 1.00172448158264, -12.4075313186646 },
    { 37.0594985961914, 1.00172400474548, -10.8700817108154 }, --pio
    { 20.5256023406982, 1.0017237663269, -12.4035499572754 },
    { 31.3721223449707, 1.00172340869904, -12.4002779006958 },
    
    { 3.97240991592407, 1.00172388553619, 10.8451750564575 }, --pio
    { 9.67806907653809, 1.00172448158264, 12.4075313186646 },
    { 37.0594985961914, 1.00172400474548, 10.8700817108154 }, --pio
    { 20.5256023406982, 1.0017237663269, 12.4035499572754 },
    { 31.3721223449707, 1.00172340869904, 12.4002779006958 },
}
