-- ~~~~~~
-- Script by Eirik 'Flippster' Munthe
--
-- ~~~~~~
local RangeCheck = require("Device.RangeCheck")

function onDropped()
    Global.call("API_BombTokenDrop", { token = self })
end

local spawnedRuler = nil

function update()
    if self.getDescription() == "r" then
        if ToggleRuler() then
            printToAll("Spawning " .. self.getName() .. " guide", { 0, 1, 1 })
        end
        self.setDescription("")
    end
end

function ToggleRuler()
    local didSpawn
    spawnedRuler, _, didSpawn = RangeCheck.toggleBombRuler(self, spawnedRuler, 1)
    return didSpawn
end

function onLoad()
    if self.getName() == "AoE Bomb source" then
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
