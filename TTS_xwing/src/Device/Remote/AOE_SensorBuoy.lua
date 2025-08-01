-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- Buoy ruler modeled by CrazyVulcan
-- ~~~~~~
--modded to work with a FO Buoy and not a bomb
-- Call buoy drop stick
function onDropped()
    Global.call('API_BombTokenDrop', { token = self })
end

local spawnedRuler = nil
function update()
    if self.getDescription() == 'r' then
        if ToggleRuler() then
            printToAll('Spawning ' .. self.getName() .. ' guide', { 0, 1, 1 })
        end
        self.setDescription('')
    end
end

function ToggleRuler()
    if spawnedRuler then
        spawnedRuler.destruct()
        spawnedRuler = nil
        return false
    end
    local params = {
        type = 'Custom_Model',
        position = self.positionToWorld({ 0, 0.2, 0 }),
        rotation = self.getRotation(),
        scale = self.getScale()
    }
    local custom = {
        mesh = 'http://cloud-3.steamusercontent.com/ugc/1591414635586906061/A71FFBC75ADA0980F4124BCB96516F72D694489C/',
        collider = 'http://pastebin.com/raw.php?i=UK3Urmw1'
    }
    local removeButton = {
        click_function = 'ToggleRuler',
        label = 'DEL',
        function_owner = self,
        position = { 0, 0.25, 0 },
        rotation = { 0, 270, 0 },
        width = 750,
        height = 750,
        font_size = 250,
        color = { 0.7, 0.7, 0.7 }
    }
    spawnedRuler = spawnObject(params)
    spawnedRuler.setCustomObject(custom)
    spawnedRuler.setColorTint(color(1, 1, 0, 0.2))
    spawnedRuler.createButton(removeButton)
    spawnedRuler.lock()
    return true
end

function onLoad()
    -- TODO: hey should this be AOE_SensorBuoy instead? looks like a copy&paste error
    if self.getName() == 'AoE Bomb source' then
        self.setPosition({ 0, -3, 18.28 })
        self.setRotation({ 0, 0, 0 })
        self.lock()
        self.tooltip = false
        self.interactable = false
        update = nil
    else
        self.addContextMenuItem("Toggle Range 1", ToggleRuler, false)
    end
end
