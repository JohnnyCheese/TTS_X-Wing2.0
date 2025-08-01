-- ~~~~~~
-- Script by Eirik 'Flippster' Munthe
--
-- ~~~~~~

local Dim = require("Dim")

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
    if spawnedRuler then
        spawnedRuler.destruct()
        spawnedRuler = nil
        return false
    end
    local params = {
        type = 'Custom_Model',
        position = self.positionToWorld({ 0, 0.4, 0 }),
        rotation = self.getRotation(),
        scale = self.getScale()
    }
    local custom = {
        mesh =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/bomb_range_1.obj',
        collider =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/minicollider.obj'
    }
    local removeButton = {
        click_function = 'ToggleRuler',
        label = 'DEL',
        function_owner = self,
        position = { 0, 0.1, 0 },
        rotation = { 0, 270, 0 },
        width = 750,
        height = 750,
        font_size = 250,
        color = { 0.7, 0.7, 0.7 }
    }
    spawnedRuler = spawnObject(params)
    spawnedRuler.setCustomObject(custom)
    spawnedRuler.setColorTint(color(1, 1, 0, 0.2))
    vector_lines = {}
    for _, obj in pairs(getAllObjects()) do
        if obj ~= nil and obj.type == 'Figurine' and obj.getVar('__XW_Ship') == true then
            my_pos = self.getNearestPointFromObject(obj)


            closest = Global.call('API_GetClosestPointToShip', { ship = obj, point = my_pos })
            distance = Dim.Convert_igu_mm(closest.length)
            if distance < 100 then
                table.insert(vector_lines, {
                    points = { self.positionToLocal(closest.A), self.positionToLocal(closest.B) },
                    color = { 1, 1, 1 },
                    thickness = 0.1,
                    rotation = vector(0, 0, 0)
                })
            end
        end
    end
    spawnedRuler.setVectorLines(vector_lines)
    spawnedRuler.createButton(removeButton)
    spawnedRuler.lock()
    return true
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
