-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: https://github.com/tjakubo2/TTS_xwing
--
-- Script applicable to playmats
-- ~~~~~~

-- TO ADD NEW IMAGES TO THE SET
-- Just add their links to the table below in the same fashion

-- Table of all images to be cycled through with NextImage()
imageSet                  = {
  'https://i.imgur.com/6IkNucB.jpg',
  'https://steamusercontent-a.akamaihd.net/ugc/1483326815456337025/EB436BA5C3D1B0BAF4ED3325456E7211A669E3BF/',
  'https://steamusercontent-a.akamaihd.net/ugc/1483326815456320038/68F5C582DBCBDC1070ACD4CE12091BFA73AE93F4/',
  'https://i.imgur.com/siDMVxH.mp4',
  'https://i.imgur.com/HXUBMXE.mp4',
  'https://i.imgur.com/dczrasC.jpg',
  'https://i.imgur.com/dKYBJMX.png',
  'https://i.imgur.com/1veiNk9.jpg',
  'https://i.imgur.com/8tDK0x8.png',
  'https://i.imgur.com/sb2AJOz.png',
  'https://i.imgur.com/KPtozCm.png',
  'https://i.imgur.com/V7pWVak.png',
  'https://i.imgur.com/spWTWy7.png',
  'https://i.imgur.com/YdIAcvP.png',
  'https://i.imgur.com/5CcjDzM.jpg',
  'https://i.imgur.com/4WMSCSV.jpg',
  'https://i.imgur.com/0FWrq21.jpg',
  'https://i.imgur.com/x4LEk1A.jpg',
  'https://i.imgur.com/fy6kooO.png',
}

-- Mat flag for layouts
__XW_Mat                  = true
-- Parent layout name
__XW_MatLayout            = 'HotAC'
-- This mat identifier
__XW_MatID                = 'Main'

local r_sz                = { height = 10.83691788, thickness = 0.08344745636, width = 0.5535750389 }
local corrScale           = { 0.625, 0.625, 0.625 }
local rulers, rulersState = {}, 0
local rulerData           = {
  mesh     = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range13.obj',
  collider = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range13.obj',
  diffuse  = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range.jpg',
  material = 1,
}

-- image switching
local currImage           = 1
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
  deleteAll(); currImage = (currImage % #imageSet) + 1; changeImage(currImage)
end

function PrevImage()
  deleteAll(); currImage = ((currImage - 2) % #imageSet) + 1; changeImage(currImage)
end

local function geom()
  local b = self.getBoundsNormalized()
  local C = Vector(b.center.x, 1.0, b.center.z)
  local halfx, halfz = b.size.x / 2, b.size.z / 2
  local TL = Vector(C.x - halfx, C.y, C.z + halfz)
  local TR = Vector(C.x + halfx, C.y, C.z + halfz)
  local BL = Vector(C.x - halfx, C.y, C.z - halfz)
  local BR = Vector(C.x + halfx, C.y, C.z - halfz)

  local R = r_sz.height
  local halfHeight, halfWidth = R / 2, r_sz.width / 2
  local xa, za = Vector(R, 0, 0), Vector(0, 0, R)
  local xhw, zhw = Vector(halfWidth, 0, 0), Vector(0, 0, halfWidth)

  local O = BL:copy()
  return {
    TL = TL,
    TR = TR,
    BL = BL,
    BR = BR,
    halfHeight = halfHeight,
    halfWidth = halfWidth,
    xa = xa,
    za = za,
    xhw = xhw,
    zhw = zhw,
    O = O
  }
end

local function gridRot()
  local r = {}
  for i = 1, 12 do r[i] = { 0, 0, 0 } end
  for i = 13, 24 do r[i] = { 0, 270, 0 } end
  return r
end

local function setupRot()
  return {
    { 0, 0, 0 }, { 0, 0, 0 }, { 0, 180, 0 },
    { 0, 0, 0 }, { 0, 0, 0 }, { 0, 180, 0 },
    { 0, 90, 0 }, { 0, 90, 0 }, { 0, 270, 0 }, { 0, 270, 0 },
  }
end

local function roidRot()
  return {
    { 0, 270, 180 }, { 0, 270, 180 }, { 0, 90, 180 },
    { 0, 270, 180 }, { 0, 270, 180 }, { 0, 90, 180 },
    { 0, 0, 180 }, { 0, 0, 180 }, { 0, 180, 180 },
    { 0, 0, 180 }, { 0, 0, 180 }, { 0, 180, 180 },
  }
end

local function buildGridPos(g)
  local O, xa, za, xhw, zhw = g.O, g.xa, g.za, g.xhw, g.zhw
  return {
    -- horizontals
    O + (xa * 0.5) - zhw,
    O + (xa * 1.5) - zhw,
    O + (xa * 2.5) - zhw,

    O + (xa * 0.5) + (za * 1),
    O + (xa * 1.5) + (za * 1),
    O + (xa * 2.5) + (za * 1),

    O + (xa * 0.5) + (za * 2),
    O + (xa * 1.5) + (za * 2),
    O + (xa * 2.5) + (za * 2),

    O + (xa * 0.5) + (za * 3) + zhw,
    O + (xa * 1.5) + (za * 3) + zhw,
    O + (xa * 2.5) + (za * 3) + zhw,

    -- verticals
    O + (za * 0.5) - xhw,
    O + (za * 1.5) - xhw,
    O + (za * 2.5) - xhw,

    O + (xa * 1) + (za * 0.5),
    O + (xa * 1) + (za * 1.5),
    O + (xa * 1) + (za * 2.5),

    O + (xa * 2) + (za * 0.5),
    O + (xa * 2) + (za * 1.5),
    O + (xa * 2) + (za * 2.5),

    O + (xa * 3) + (za * 0.5) + xhw,
    O + (xa * 3) + (za * 1.5) + xhw,
    O + (xa * 3) + (za * 2.5) + xhw,
  }
end

local function buildSetupPos(g)
  local function top(xr)
    return g.TL + (g.za * (-1 / 3)) - g.zhw + (g.xa * xr)
  end
  local function bottom(xr)
    return g.BL + (g.za * (1 / 3)) + g.zhw + (g.xa * xr)
  end
  return {
    top(0.5), top(1.5), top(2.5),
    bottom(0.5), bottom(1.5), bottom(2.5),
    Vector(g.TL.x - g.halfWidth, g.TL.y, g.TL.z - g.halfHeight),
    Vector(g.TR.x + g.halfWidth, g.TR.y, g.TR.z - g.halfHeight),
    Vector(g.BL.x - g.halfWidth, g.BL.y, g.BL.z + g.halfHeight),
    Vector(g.BR.x + g.halfWidth, g.BR.y, g.BR.z + g.halfHeight),
  }
end

local function buildRoidPos(g)
  local xa, za, xhw, zhw = g.xa, g.za, g.xhw, g.zhw
  return {
    g.BL + (xa * (2 / 3)) + (za * 0.5) - xhw,
    g.BL + (xa * (2 / 3)) + (za * 1.5) - xhw,
    g.TL + (xa * (2 / 3)) - (za * 0.5) - xhw,

    g.BR - (xa * (2 / 3)) + (za * 0.5) + xhw,
    g.BR - (xa * (2 / 3)) + (za * 1.5) + xhw,
    g.TR - (xa * (2 / 3)) - (za * 0.5) + xhw,

    g.BL + (xa * 0.5) + (za * (2 / 3)) - zhw,
    g.BL + (xa * 1.5) + (za * (2 / 3)) - zhw,
    g.BR - (xa * 0.5) + (za * (2 / 3)) - zhw,

    g.TL + (xa * 0.5) - (za * (2 / 3)) + zhw,
    g.TL + (xa * 1.5) - (za * (2 / 3)) + zhw,
    g.TR - (xa * 0.5) - (za * (2 / 3)) + zhw,
  }
end

local function spawnSet(posTable, rotTable)
  local initPos = self.getPosition(); initPos.y = initPos.y - 3
  for i = 1, #posTable do
    local obj = spawnObject({ type = 'Custom_Model', position = initPos })
    obj.setCustomObject(rulerData); obj.setScale(corrScale); obj.lock()
    obj.setPositionSmooth(posTable[i], false, true)
    obj.setRotationSmooth(rotTable[i], false, true)
    obj.addTag('TempLayoutElement'); rulers[obj] = true
  end
end

function deleteAll()
  for o in pairs(rulers) do
    if o and o.destruct then o:destruct() end
    rulers[o] = nil
  end
end

function onObjectDestroyed(o) if rulers[o] then rulers[o] = nil end end

function ToggleRulers()
  deleteAll(); rulersState = (rulersState + 1) % 4
  local g = geom()
  if rulersState == 1 then
    spawnSet(buildGridPos(g), gridRot())
  elseif rulersState == 2 then
    spawnSet(buildRoidPos(g), roidRot())
  elseif rulersState == 3 then
    spawnSet(buildSetupPos(g), setupRot())
  end
end
