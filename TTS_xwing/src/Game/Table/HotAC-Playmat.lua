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
__XW_Mat = true
-- Parent layout name
__XW_MatLayout = 'HotAC'
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
    spawnSet(gridPos, gridRot)
  elseif rulersState == 2 then
    spawnSet(roidPos, roidRot)
  elseif rulersState == 3 then
    spawnSet(setupPos, setupRot)
  elseif rulersState == 4 then
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
  for ruler in pairs(rulers) do ruler.destruct() end
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
rulerData.collider =
'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range13.obj'
rulerData.diffuse = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/rulers/range.jpg'
rulerData.material = 1

roidRot = {
  { 0, 270, 180 },
  { 0, 270, 180 },
  { 0, 180, 180 },
  { 0, 180, 180 },
  { 0, 270, 180 },
  { 0, 270, 180 },
  { 0, 0,   180 },
  { 0, 0,   180 },
  { 0, 90,  180 },
  { 0, 90,  180 },
  { 0, 180, 180 },
  { 0, 180, 180 }
}

setupRot = {
  { 0, 270, 0 },
  { 0, 0,   0 },
  { 0, 270, 0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 90,  0 },
  { 0, 180, 0 },
  { 0, 90,  0 },
  { 0, 180, 0 },
  { 0, 180, 0 }
}

roidPos = {
  { 12.37, 0.99871951341629,  -10.8846182632446 }, -- pio
  { 12.37, 0.99871951341629,  0 },
  { 13.87, 0.998719453811646, -9.37833354949951 }, -- poz
  { 3,     0.998719453811646, -9.37833354949951 },
  { -6.34, 0.998719573020935, -10.8876889038086 },
  { -6.34, 0.998719573020935, 0 },
  { -7.85, 0.998719453811646, -9.37820747375488 },
  { -7.85, 0.99871951341629,  9.37365325927734 },
  { -6.34, 0.998719453811646, 10.8807905578613 },
  { 12.37, 0.998719394207001, 10.8395362091064 }, -- pio
  { 13.87, 0.998719453811646, 9.32834770202637 }, -- poz
  { 3,     0.998719453811646, 9.32834770202637 }
}

setupPos = {
  { -13.55, 1.00172388553619, -10.8451750564575 }, --pio
  { -7.85,  1.00172448158264, -12.4075313186646 },
  { 19.55,  1.00172400474548, -10.8700817108154 }, --pio
  { 3,      1.0017237663269,  -12.4035499572754 },
  { 13.84,  1.00172340869904, -12.4002779006958 },

  { -13.55, 1.00172388553619, 10.8451750564575 }, --pio
  { -7.85,  1.00172448158264, 12.4075313186646 },
  { 19.55,  1.00172400474548, 10.8700817108154 }, --pio
  { 3,      1.0017237663269,  12.4035499572754 },
  { 13.84,  1.00172340869904, 12.4002779006958 },
}

-- Ruler Size
local r_sz = {
  height = 10.83691788, thickness = 0.08344745636, width = 0.5535750389
}

-- Board Size
local b_sz = {
  height = 32.6000022888184, thickness = 0.0240046977996826, width = 32.6000022888184
}

local BR = { x = -b_sz.width / 2 + 3, y = 1.00, z = -b_sz.height / 2 }

local halfHeight = r_sz.height / 2
local halfWidth = r_sz.width / 2

gridPos = {
  -- Horizontal
  { BR.x + halfHeight,                  BR.y, BR.z - halfWidth },
  { BR.x + halfHeight,                  BR.y, BR.z + r_sz.height },
  { BR.x + halfHeight,                  BR.y, BR.z + 2 * r_sz.height },
  { BR.x + halfHeight,                  BR.y, BR.z + 3 * r_sz.height + halfWidth },

  { BR.x + 3 * halfHeight,              BR.y, BR.z - halfWidth },
  { BR.x + 3 * halfHeight,              BR.y, BR.z + r_sz.height },
  { BR.x + 3 * halfHeight,              BR.y, BR.z + 2 * r_sz.height },
  { BR.x + 3 * halfHeight,              BR.y, BR.z + 3 * r_sz.height + halfWidth },

  { BR.x + 5 * halfHeight,              BR.y, BR.z - halfWidth },
  { BR.x + 5 * halfHeight,              BR.y, BR.z + r_sz.height },
  { BR.x + 5 * halfHeight,              BR.y, BR.z + 2 * r_sz.height },
  { BR.x + 5 * halfHeight,              BR.y, BR.z + 3 * r_sz.height + halfWidth },

  -- Vertical
  { BR.x + 3 * r_sz.height + halfWidth, BR.y, BR.z + halfHeight },
  { BR.x + 3 * r_sz.height + halfWidth, BR.y, BR.z + 3 * halfHeight },
  { BR.x + 3 * r_sz.height + halfWidth, BR.y, BR.z + 5 * halfHeight },

  { BR.x + 2 * r_sz.height,             BR.y, BR.z + halfHeight },
  { BR.x + 2 * r_sz.height,             BR.y, BR.z + 3 * halfHeight },
  { BR.x + 2 * r_sz.height,             BR.y, BR.z + 5 * halfHeight },

  { BR.x + r_sz.height,                 BR.y, BR.z + halfHeight },
  { BR.x + r_sz.height,                 BR.y, BR.z + 3 * halfHeight },
  { BR.x + r_sz.height,                 BR.y, BR.z + 5 * halfHeight },

  { BR.x - halfWidth,                   BR.y, BR.z + halfHeight },
  { BR.x - halfWidth,                   BR.y, BR.z + 3 * halfHeight },
  { BR.x - halfWidth,                   BR.y, BR.z + 5 * halfHeight },
}

gridRot = {
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 0,   0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
  { 0, 270, 0 },
}
