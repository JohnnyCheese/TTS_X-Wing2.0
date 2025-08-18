-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: https://github.com/tjakubo2/TTS_xwing
--
-- Script applicable to playmats
-- ~~~~~~

-- TO ADD NEW IMAGES TO THE SET
-- Just add their links to the table below in the same fashion

-- Table of all images to be cycled through with NextImage()
imageSet        = {
    'https://i.imgur.com/aCxRouI.jpg',
    'https://i.imgur.com/X3luGQr.jpg',
    'https://i.imgur.com/hGzGwY3.jpg',
    'https://i.imgur.com/W5AuCVd.jpg',
    'https://steamusercontent-a.akamaihd.net/ugc/16526075817900791097/B15B809BEA393E68315A24444C5061CD87139050/',
}

-- Mat flag for layouts
__XW_Mat        = true
-- Parent layout name
__XW_MatLayout  = 'Epic'
-- This mat identifier
__XW_MatID      = 'Main'

-- Image switching
local currImage = 1
function onLoad()
    -- Restore current image index
    currImage = tonumber(self.script_state) or 1
    self.lock(); self.interactable = false; self.tooltip = false
end

local function changeImage(idx)
    local custom = self.getCustomObject(); custom.diffuse = imageSet[idx]
    self.setCustomObject(custom)
    local newSelf = self.reload(); newSelf.script_state = idx
end

function NextImage()
    deleteAllEpic(); currImage = (currImage % #imageSet) + 1; changeImage(currImage)
end

function PrevImage()
    deleteAllEpic(); currImage = ((currImage - 2) % #imageSet) + 1; changeImage(currImage)
end

local r_sz = { height = 10.83691788, thickness = 0.08344745636, width = 0.5535750389 }
local R = r_sz.height
local range_1 = R / 3
local corrScale_E = { 0.625, 0.625, 0.625 }
local rulers_E, rulersState_E = {}, 0
local rulerData_E = {
    mesh     = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range13.obj',
    collider = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range13.obj',
    diffuse  = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range.jpg',
    material = 1,
}

-- Geometry
local function geomEpic()
    local b = self.getBoundsNormalized()
    local C = Vector(b.center.x, 1.0, b.center.z)
    local halfx, halfz = b.size.x / 2, b.size.z / 2
    local TL = Vector(C.x - halfx, C.y, C.z + halfz)
    local TR = Vector(C.x + halfx, C.y, C.z + halfz)
    local BL = Vector(C.x - halfx, C.y, C.z - halfz)
    local BR = Vector(C.x + halfx, C.y, C.z - halfz)

    local halfHeight, halfWidth = R / 2, r_sz.width / 2
    local row = Vector(halfHeight, 0, 0)

    return {
        TL = TL,
        TR = TR,
        BL = BL,
        BR = BR,
        halfHeight = halfHeight,
        halfWidth = halfWidth,
        row = row,
    }
end

local function setupRotEpic()
    return {
        { 0, 0,   0 }, { 0, 0, 0 }, { 0, 0, 0 },
        { 0, 180, 0 }, { 0, 180, 0 }, { 0, 180, 0 },
        { 0, 0,   0 }, { 0, 0, 0 }, { 0, 0, 0 },
        { 0, 180, 0 }, { 0, 180, 0 }, { 0, 180, 0 },
        { 0, 90, 0 }, { 0, 90, 0 }, { 0, 270, 0 }, { 0, 270, 0 },
        { 0, 90, 0 }, { 0, 90, 0 }, { 0, 270, 0 }, { 0, 270, 0 },
    }
end

local function buildSetupPosEpic(g)
    local zTop = Vector(0, 0, -(range_1)) - Vector(0, 0, g.halfWidth)
    local zBot = Vector(0, 0, (range_1)) + Vector(0, 0, g.halfWidth)
    local function topLeft(n) return g.TL + zTop + (g.row * n) end
    local function topRight(n) return g.TR + zTop - (g.row * n) end
    local function botLeft(n) return g.BL + zBot + (g.row * n) end
    local function botRight(n) return g.BR + zBot - (g.row * n) end
    return {
        topLeft(1.0), topLeft(3.0), topLeft(5.0),
        topRight(5.0), topRight(3.0), topRight(1.0),
        botLeft(1.0), botLeft(3.0), botLeft(5.0),
        botRight(1.0), botRight(3.0), botRight(5.0),
        Vector(g.TL.x - g.halfWidth, g.TL.y, g.TL.z - g.halfHeight),
        Vector(g.TR.x + g.halfWidth, g.TR.y, g.TR.z - g.halfHeight),
        Vector(g.BL.x - g.halfWidth, g.BL.y, g.BL.z + g.halfHeight),
        Vector(g.BR.x + g.halfWidth, g.BR.y, g.BR.z + g.halfHeight),
        Vector(g.TL.x + range_1 + g.halfWidth, g.TL.y, g.TL.z - ((5 * r_sz.height / 6) + r_sz.width)),
        Vector(g.TR.x - range_1 - g.halfWidth, g.TR.y, g.TR.z - ((5 * r_sz.height / 6) + r_sz.width)),
        Vector(g.BL.x + range_1 + g.halfWidth, g.BL.y, g.BL.z + ((5 * r_sz.height / 6) + r_sz.width)),
        Vector(g.BR.x - range_1 - g.halfWidth, g.BR.y, g.BR.z + ((5 * r_sz.height / 6) + r_sz.width)),
    }
end

local function spawnSetEpic(posTable, rotTable)
    local initPos = self.getPosition()
    for i = 1, #posTable do
        local obj = spawnObject({ type = 'Custom_Model', position = initPos })
        obj.setCustomObject(rulerData_E); obj.setScale(corrScale_E); obj.lock()
        obj.setPositionSmooth(posTable[i], false, true)
        obj.setRotationSmooth(rotTable[i], false, true)
        obj.addTag('TempLayoutElement'); rulers_E[obj] = true
    end
end

function deleteAllEpic()
    for o in pairs(rulers_E) do
        if o and o.destruct then o:destruct() end
        rulers_E[o] = nil
    end
end

function ToggleRulers()
    deleteAllEpic(); rulersState_E = (rulersState_E + 1) % 3
    if rulersState_E == 1 then
        local g = geomEpic(); spawnSetEpic(buildSetupPosEpic(g), setupRotEpic())
    end
end
