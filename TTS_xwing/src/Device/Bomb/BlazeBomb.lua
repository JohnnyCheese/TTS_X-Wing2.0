-- ~~~~~~
-- Script by Eirik 'Flippster' Munthe
--
-- ~~~~~~

local Dim = require("Dim")
local RangeCheck = require("Device.RangeCheck")

-- Call bomb drop stick
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
    local didSpawn
    spawnedRuler, _, didSpawn = RangeCheck.toggleBombRuler(self, spawnedRuler, 1)
    return didSpawn
end

SpawnBlaze = function()
    local position = self.getPosition() - Dim.Convert_mm_igu(53) * self.getTransformRight()
    cloneItemFromBag("Blaze", function(blaze)
        blaze.setPositionSmooth(position, false, true)
        blaze.setRotationSmooth(self.getRotation(), false, true)
        blaze.lock()
        Global.call("API_MineDrop", { mine = blaze })
    end)
    fuseBag = getObjectFromGUID('568727')
    fuseBag.takeObject({
        position = self.getPosition() - Dim.Convert_mm_igu(53) * self.getTransformRight() + vector(0, 1, 0),
        smooth   = true,
    })
end

function cloneItemFromBag(name, client_callback_function)
    local obstacleBag = getObjectFromGUID('203cb8')
    if obstacleBag == nil then
        printToAll("Obstacles Bag has gone missing!", { 1, 0, 0 })
        return
    end

    local itemGuid = nil
    for _, item in ipairs(obstacleBag.getObjects()) do
        if item.name == name then
            itemGuid = item.guid
            break
        end
    end

    if itemGuid then
        obstacleBag.takeObject({
            guid = itemGuid,
            position = obstacleBag.getPosition() + Vector(3, 1, 0),
            callback_function = function(obj)
                local clone = obj.clone()
                obstacleBag.putObject(obj)
                client_callback_function(clone)
            end
        })
    else
        print("Obstacle not found in Obstacles Bag.")
    end
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
        self.addContextMenuItem("Toggle Range 1", ToggleRuler, false)
        self.addContextMenuItem("Place Blaze", SpawnBlaze, false)
    end
end
