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
  'https://steamusercontent-a.akamaihd.net/ugc/5123439130600131751/A0015A12B09E8F0B985B919A08254853FECA7EFE/',
  'https://i.imgur.com/6IkNucB.jpg',
  'https://steamusercontent-a.akamaihd.net/ugc/1483326815456337025/EB436BA5C3D1B0BAF4ED3325456E7211A669E3BF/',
  'https://steamusercontent-a.akamaihd.net/ugc/1483326815456320038/68F5C582DBCBDC1070ACD4CE12091BFA73AE93F4/',
  'https://steamusercontent-a.akamaihd.net/ugc/1760324221436739587/059F900D0ABE33682825A2F0F7D00737E8327B1A/',
  'https://steamusercontent-a.akamaihd.net/ugc/1760324221436914449/FDE3C20CE192980B8176964A41D3A03851D0CB5C/',
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
__XW_MatLayout = 'Standard'
-- This mat identifier
__XW_MatID = 'Purple-Orange'

local ImageManager = require("Game.Component.Playmat.ImageManager")
local mgr

function onLoad(saved)
    mgr = ImageManager.install(self, { images = imageSet })
    mgr:onLoad(saved)
    self.lock()
    self.interactable = false
    self.tooltip = false
end

function onSave()
    return mgr:onSave()
end

corrScale = { 0.625, 0.625, 0.625 }

function ToggleRulers()
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
    local params = {}     -- 50
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
  { 29.872200088501,  0.99871951341629,  -10.8846182632446 }, -- pio
  { 29.872200088501,  0.99871951341629,  0 },
  { 31.382360534668,  0.998719453811646, -9.37833354949951 }, -- poz
  { 20.5,             0.998719453811646, -9.37833354949951 },
  { 11.1684393310547, 0.998719573020935, -10.8876889038086 },
  { 11.1684393310547, 0.998719573020935, 0 },
  { 9.64546291351318, 0.998719453811646, -9.37820747375488 },
  { 9.64722316741943, 0.99871951341629,  9.37365325927734 },
  { 11.1658749008179, 0.998719453811646, 10.8807905578613 },
  { 29.8585949707031, 0.998719394207001, 10.8395362091064 },  -- pio
  { 31.3808876037598, 0.998719453811646, 9.32834770202637 },  -- poz
  { 20.5,             0.998719453811646, 9.32834770202637 }
}

setupPos = {
  { 3.97240991592407, 1.00172388553619, -10.8451750564575 },  --pio
  { 9.67806907653809, 1.00172448158264, -8.75 },
  { 37.0594985961914, 1.00172400474548, -10.8700817108154 },  --pio
  { 20.5256023406982, 1.0017237663269,  -8.75 },
  { 31.3721223449707, 1.00172340869904, -8.75 },

  { 3.97240991592407, 1.00172388553619, 10.8451750564575 },  --pio
  { 9.67806907653809, 1.00172448158264, 8.75 },
  { 37.0594985961914, 1.00172400474548, 10.8700817108154 },  --pio
  { 20.5256023406982, 1.0017237663269,  8.75 },
  { 31.3721223449707, 1.00172340869904, 8.75 },
}
