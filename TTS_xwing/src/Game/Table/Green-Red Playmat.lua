-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: https://github.com/tjakubo2/TTS_xwing
--
-- Script applicable to playmats
-- ~~~~~~

-- TO ADD NEW IMAGES TO THE SET
-- Just add their links to the table below in the same fashion

-- Table of all images to be cycled through with NextImage()
imageSet = { 'http://i.imgur.com/6IkNucB.jpg',
    'http://cloud-3.steamusercontent.com/ugc/1483326815456337025/EB436BA5C3D1B0BAF4ED3325456E7211A669E3BF/',
    'http://cloud-3.steamusercontent.com/ugc/1483326815456320038/68F5C582DBCBDC1070ACD4CE12091BFA73AE93F4/',
    'https://i.imgur.com/siDMVxH.mp4',
    'https://i.imgur.com/HXUBMXE.mp4',
    'http://i.imgur.com/dczrasC.jpg',
    'http://i.imgur.com/dKYBJMX.png',
    'https://i.imgur.com/1veiNk9.jpg',
    'http://i.imgur.com/8tDK0x8.png',
    'http://i.imgur.com/sb2AJOz.png',
    'https://i.imgur.com/KPtozCm.png',
    'http://i.imgur.com/V7pWVak.png',
    'http://i.imgur.com/spWTWy7.png',
    'http://i.imgur.com/YdIAcvP.png',
    'http://i.imgur.com/5CcjDzM.jpg',
    'http://i.imgur.com/4WMSCSV.jpg',
    'http://i.imgur.com/0FWrq21.jpg',
    'http://i.imgur.com/x4LEk1A.jpg',
    'http://i.imgur.com/fy6kooO.png', }

-- Mat flag for layouts
__XW_Mat = true
-- Parent layout name
__XW_MatLayout = 'Standard'
-- This mat identifier
__XW_MatID = 'Red-Blue'

function onLoad()
    -- Restore current image index
    currImage = tonumber(self.script_state) or 1
    self.lock()
    self.interactable = false
    self.tooltip = false
    BagOP = getObjectFromGUID('ffb783')
    ruler1 = getObjectFromGUID('bf91d5')
    ruler5 = getObjectFromGUID('3d90c5')
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
    if scenario_objects[obj] then
        scenario_objects[obj] = nil
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
scenario_objects = {}

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
    { 30.13, 1.0, -11.12 }, -- pio
    { 30.13, 1.0, 0 },
    { 31.64, 1.0, -9.6 },   -- poz
    { 20.5,  1.0, -9.6 },
    { 10.9,  1.0, -11.12 },
    { 10.9,  1.0, 0 },
    { 9.38,  1.0, -9.6 },
    { 9.38,  1.0, 9.6 },
    { 10.9,  1.0, 11.12 },
    { 30.13, 1.0, 11.12 }, -- pio
    { 31.64, 1.0, 9.6 },   -- poz
    { 20.5,  1.0, 9.6 }
}

setupPos = {
    { 3.68,  1.00, -11.11 }, --pio
    { 9.51,  1.00, -12.63 },
    { 37.35, 1.00, -11.11 }, --pio
    { 20.53, 1.00, -12.63 },
    { 31.53, 1.00, -12.63 },

    { 3.68,  1.00, 11.11 }, --pio
    { 9.51,  1.00, 12.63 },
    { 37.35, 1.00, 11.11 }, --pio
    { 20.53, 1.00, 12.63 },
    { 31.53, 1.00, 12.63 },
}

AH_setupPos = {
    { 29.94, 1.05, -12.59 },
    { 11.79, 1.05, -12.59 },
    { 7.90,  1.05, -9.24 },
    { 7.82,  1.05, 8.64 },
    { 11.15, 1.05, 12.53 },
    { 29.29, 1.05, 12.53 },
    { 33.18, 1.05, 9.18 },
    { 33.27, 1.05, -8.69 },
    { 20.88, 1.05, -12.59 },
    { 7.84,  1.05, -0.39 },
    { 20.21, 1.05, 12.55 },
    { 33.20, 1.05, 0.25 }
}

AH_setupRot = {
    { 0.00, 180.00, 0.00 },
    { 0.00, 180.00, 0.00 },
    { 0.00, 270.00, 0.00 },
    { 0.00, 90.00,  0.00 },
    { 0.00, 0.00,   0.00 },
    { 0.00, 0.00,   0.00 },
    { 0.00, 90.00,  0.00 },
    { 0.00, 270.00, 0.00 },
    { 0.00, 0.00,   0.00 },
    { 0.00, 270.00, 0.00 },
    { 0.00, 0.00,   0.00 },
    { 0.00, 90.00,  0.00 }
}

roidSoCPos = {

    { 15.00, 1.05, -9.59 },
    { 30.04, 1.10, -5.47 },
    { 30.02, 1.05, 5.52 },
    { 10.87, 1.10, -3.80 },
    { 17.44, 1.05, 1.26 },
    { 23.44, 1.05, 6.36 },
    { 26.74, 1.05, 9.63 },
    { 25.94, 1.05, -9.57 }

}

roidSoCRot = {
    { 0.00, 0.00,   180.00 },
    { 0.00, 270.00, 180.00 },
    { 0.00, 270.00, 180.00 },
    { 0.00, 270,    180.00 },
    { 0.00, 180.00, 180.00 },
    { 0.00, 90.00,  180.00 },
    { 0.00, 180.00, 180.00 },
    { 0.00, 180.00, 180.00 },
}

function clearScenario()
    for object in pairs(scenario_objects) do
        object.destruct()
    end
    scenario_objects = {}
    deleteAll()
    rulersState = 0
end

function SelectSoC()
    clearScenario()
    local SoC_InvisableHand = spawnObject({
        type = "Custom_Model",
        position = { -17.52, 0.97, 6.96 },
        scale = { 1.35, 1.35, 1.18 },
        rotation = { 0.00, 180.00, 0.00 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })

    SoC_InvisableHand.setCustomObject({
        type = 0,
        mesh = 'http://cloud-3.steamusercontent.com/ugc/1758114025984799581/CAEAD252E027EAEDEBD055BA364416266FDFD9E1/',
        diffuse = 'http://cloud-3.steamusercontent.com/ugc/1758114025984800067/A117F05C4595183126DBE59EFF6BEBEDB12BBBAC/',
        collider =
        'http://cloud-3.steamusercontent.com/ugc/1758114025984799581/CAEAD252E027EAEDEBD055BA364416266FDFD9E1/',
        material = 3,
    })

    SoC_InvisableHand.lock()
    SoC_InvisableHand.interactable = false
    SoC_InvisableHand.addTag("TempLayoutElement")

    spawnSet(roidSoCPos, roidSoCRot)
    rulersState = 2
end

function SelectAH()
    clearScenario()
    local HS_Token = getObjectFromGUID('36ae82')
    HS_Token.Call("toggleAcesHighSetup")
    local redCounter = spawnObject({
        type = "Counter",
        position = { -34.30, 0.98, -17.83 },
        rotation = { 357.05, 0.00, 0.00 },
        scale = { 0.75, 0.75, 0.75 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    redCounter.setColorTint("Red")

    local yellowCounter = spawnObject({
        type = "Counter",
        position = { -24.42, 0.98, -17.83 },
        rotation = { 357.05, 0.00, 0.00 },
        scale = { 0.75, 0.75, 0.75 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    yellowCounter.setColorTint("Yellow")

    local orangeCounter = spawnObject({
        type = "Counter",
        position = { -15.66, 0.98, -17.76 },
        rotation = { 357.05, 0.00, 0.00 },
        scale = { 0.75, 0.75, 0.75 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    orangeCounter.setColorTint("Orange")

    local greenCounter = spawnObject({
        type = "Counter",
        position = { -6.65, 0.98, -17.85 },
        rotation = { 357.05, 0.00, 0.00 },
        scale = { 0.75, 0.75, 0.75 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    greenCounter.setColorTint("Green")

    local blueCounter = spawnObject({
        type = "Counter",
        position = { -34.60, 0.98, 17.92 },
        rotation = { 357.19, 180.00, 0.00 },
        scale = { 0.75, 0.75, 0.75 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    blueCounter.setColorTint("Blue")

    local purpleCounter = spawnObject({
        type = "Counter",
        position = { -24.72, 0.98, 17.92 },
        rotation = { 357.19, 180.00, 0.00 },
        scale = { 0.75, 0.75, 0.75 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    purpleCounter.setColorTint("Purple")

    local pinkCounter = spawnObject({
        type = "Counter",
        position = { -15.93, 0.98, 17.93 },
        rotation = { 357.19, 180.00, 0.00 },
        scale = { 0.75, 0.75, 0.75 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    pinkCounter.setColorTint("Pink")

    local brownCounter = spawnObject({
        type = "Counter",
        position = { -6.92, 0.98, 17.81 },
        rotation = { 357.19, 180.00, 0.00 },
        scale = { 0.75, 0.75, 0.75 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    brownCounter.setColorTint("Brown")

    spawnSet(AH_setupPos, AH_setupRot)
    rulersState = 3
end

function SelectBoY()
    clearScenario()
    local BoY_DeathStarTrench = spawnObject({
        type = "Custom_Model",
        position = { -21.06, 1.04, 4.42 },
        scale = { 0.98, 0.98, 0.98 },
        rotation = { 0.00, 90.00, 0.00 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    BoY_DeathStarTrench.setCustomObject({
        type = 0,
        mesh = 'http://cloud-3.steamusercontent.com/ugc/1863954854624696677/453911740C854F3296724274C630FA211E509E0C/',
        diffuse = 'http://cloud-3.steamusercontent.com/ugc/1863954854624743591/746B48A74003822AEAF94B7C0895E2AAD7D7AE2C/',
        collider =
        'http://cloud-3.steamusercontent.com/ugc/1863954854624696677/453911740C854F3296724274C630FA211E509E0C/',
        material = 3,
    })
    local BoY_YahooCard = spawnObject({
        type = "CardCustom",
        position = { -33.27, 1.03, -14.44 },
        scale = { 0.98, 0.98, 0.98 },
        rotation = { 0.00, 0.00, 0.00 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    BoY_YahooCard.setCustomObject({
        type = 0,
        face = "http://cloud-3.steamusercontent.com/ugc/1867333336886624923/DB28D017E08CB6DB3BD5350A0F11D0C26E302E68/",
        back = "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/scenarios/back.png",
        sideways = false
    })
    local BoY_AttackRunCard = spawnObject({
        type = "CardCustom",
        position = { -33.16, 1.03, -10.06 },
        scale = { 0.98, 0.98, 0.98 },
        rotation = { 0.00, 0.00, 0.00 },
        sound = false,
        callback_function = function(obj)
            scenario_objects[obj] = true
        end
    })
    BoY_AttackRunCard.setCustomObject({
        type = 0,
        face = "http://cloud-3.steamusercontent.com/ugc/1867333336886629434/813352C9B1E17D29442BAEDC09B5706261A335E1/",
        back = "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/scenarios/back.png",
        sideways = false
    })

    BoY_DeathStarTrench.lock()
    BoY_DeathStarTrench.interactable = false
    BoY_DeathStarTrench.addTag("TempLayoutElement")
    ruler1.takeObject({
        position          = { -37.31, 1.09, 14.72 },
        rotation          = { 0.00, 90.00, 0.00 },
        callback_function = function(obj)
            obj.addTag("TempLayoutElement")
            rulers[obj] = true
            obj.setLock(true)
        end
    })
    ruler1.takeObject({
        position          = { -18.73, 1.09, 14.72 },
        rotation          = { 0.00, 90.00, 0.00 },
        callback_function = function(obj)
            obj.addTag("TempLayoutElement")
            rulers[obj] = true
            obj.setLock(true)
        end
    })
    ruler5.takeObject({
        position          = { -28.30, 1.09, 12.62 },
        rotation          = { 0.00, 90.00, 180.00 },
        callback_function = function(obj)
            obj.addTag("TempLayoutElement")
            rulers[obj] = true
            obj.setLock(true)
        end
    })

    ruler1.takeObject({
        position          = { -22.30, 1.08, -14.72 },
        rotation          = { 0.00, 270.00, 0.00 },
        callback_function = function(obj)
            obj.addTag("TempLayoutElement")
            rulers[obj] = true
            obj.setLock(true)
        end
    })
    ruler1.takeObject({
        position          = { -3.68, 1.09, -14.67 },
        rotation          = { 0.00, 270.00, 0.00 },
        callback_function = function(obj)
            obj.addTag("TempLayoutElement")
            rulers[obj] = true
            obj.setLock(true)
        end
    })
    ruler5.takeObject({
        position          = { -12.74, 1.09, -12.62 },
        rotation          = { 0.00, 270.00, 180.00 },
        callback_function = function(obj)
            obj.addTag("TempLayoutElement")
            rulers[obj] = true
            obj.setLock(true)
        end
    })

    rulersState = 2
end

function SelectEngagment()
    clearScenario()
    self.call('ToggleRulers')
    BagOP.takeObject({
        position          = { -20.51, 1.1, 0.00 },
        rotation          = { 180.00, 0.0, 0.00 },
        flip              = true,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("CenterObjective")
            obj.setLock(true)
            scenario_objects[obj] = true
        end
    })
end

function SelectScramble()
    clearScenario()
    BagOP.takeObject({
        position          = { -20.51, 1.1, 0.00 },
        rotation          = { 180.00, 0.0, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("CenterObjective")
            obj.setLock(true)
            scenario_objects[obj] = true
        end
    })
    BagOP.takeObject({
        position          = { -18.37, 1.10, -2.22 },
        rotation          = { 180.00, 0.0, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("Objective")
            scenario_objects[obj] = true
        end
    })
    BagOP.takeObject({
        position          = { -18.91, 1.10, 1.95 },
        rotation          = { 180.00, 0.0, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("Objective")
            scenario_objects[obj] = true
        end
    })
end

function SelectAssault()
    clearScenario()
    BagOP.takeObject({
        position          = { -20.51, 1.1, 0.00 },
        rotation          = { 180.00, 0.0, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("CenterObjective")
            obj.setLock(true)
            scenario_objects[obj] = true
        end
    })
    BagOP.takeObject({
        position          = { -18.37, 1.10, -2.22 },
        rotation          = { 180.00, 0.0, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("Objective")
            scenario_objects[obj] = true
        end
    })
    BagOP.takeObject({
        position          = { -18.91, 1.10, 1.95 },
        rotation          = { 180.00, 0.0, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("Objective")
            scenario_objects[obj] = true
        end
    })
    BagOP.takeObject({
        position          = { -22.12, 1.10, 1.91 },
        rotation          = { 180.00, 0.0, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("Objective")
            scenario_objects[obj] = true
        end
    })
    BagOP.takeObject({
        position          = { -22.04, 1.10, -2.23 },
        rotation          = { 180.00, 0.0, 0.00 },
        flip              = true,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("Objective")
            scenario_objects[obj] = true
        end
    })
end

function SelectSalvage()
    clearScenario()
    BagOP.takeObject({
        position          = { -20.51, 1.1, 0.00 },
        rotation          = { 0.00, 180.00, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("CenterObjective")
            obj.setLock(true)
            scenario_objects[obj] = true
        end
    })
    BagOP.takeObject({
        position          = { -18.37, 1.10, -2.22 },
        rotation          = { 0.00, 180.00, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("Objective")
            scenario_objects[obj] = true
        end
    })
    BagOP.takeObject({
        position          = { -18.91, 1.10, 1.95 },
        rotation          = { 0.00, 180.00, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("Objective")
            scenario_objects[obj] = true
        end
    })
    BagOP.takeObject({
        position          = { -22.12, 1.10, 1.91 },
        rotation          = { 0.00, 180.00, 0.00 },
        flip              = false,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("Objective")
            scenario_objects[obj] = true
        end
    })
    BagOP.takeObject({
        position          = { -22.04, 1.10, -2.23 },
        rotation          = { 0.00, 180.00, 0.00 },
        flip              = true,
        smooth            = true,
        callback_function = function(obj)
            obj.addTag("Objective")
            scenario_objects[obj] = true
        end
    })
end
