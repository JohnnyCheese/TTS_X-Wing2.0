-- ~~~~~~
-- Script by Eirik 'Flippster' Munthe
--
-- ~~~~~~
local RangeCheck = require("Device.RangeCheck")

-- Call bomb drop stick
function onDropped()
    Global.call('API_BombTokenDrop', { token = self })
end

local spawnedRuler = nil
function update()
    if self.getDescription() == 'r' then
        if ToggleRuler2() then
            printToAll('Spawning ' .. self.getName() .. ' guide', { 0, 1, 1 })
        end
        self.setDescription('')
    end
end

function ToggleRuler1()
    return ToggleRuler(1)
end

function ToggleRuler2()
    return ToggleRuler(2)
end

function DeleteRuler()
    if spawnedRuler then
        spawnedRuler.destruct()
        spawnedRuler = nil
    end
end

function ToggleRuler(range)
    local didSpawn
    spawnedRuler, spawnedRulerRange, didSpawn = RangeCheck.toggleBombRuler(self, spawnedRuler, range, spawnedRulerRange, {
        removeFunction = "DeleteRuler"
    })
    return didSpawn
end

function onLoad()
    if self.getName() == 'AoE Bomb source' then
        self.setPosition({ 0, -3, 18.28 })
        self.setRotation({ 0, 0, 0 })
        self.lock()
        self.tooltip = false
        self.interactable = false
        update = nil
    else
        self.addContextMenuItem("Toggle Range 1", ToggleRuler1, false)
        self.addContextMenuItem("Toggle Range 2", ToggleRuler2, false)
    end
end
