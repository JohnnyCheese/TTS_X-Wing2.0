-- ~~~~~~
-- Script by CrazyVulcan
-- Based on work by dzikakulka
-- Issues, history at: TBD
--
-- Epic Wing gizmo token v0.1 test canadate.
-- ~~~~~~

local Dim = require("Dim")

-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = false
__XW_TokenType = 'helper:epicWing'

local Vect = require("TTS_lib.Vector.Vector")
local s1 = 0.73

wingPositions = {
    leader = {
        posName = "leader",
        posOffset = vector(0, 0, 0),
    },
    leftFlank = {
        posName = "left flank",
        posOffset = vector(s1 * 3, 0, 0)
    },
    rightFlank = {
        posName = "right flank",
        posOffset = vector(-s1 * 3, 0, 0)
    },
    leftSupport = {
        posName = "left support",
        posOffset = vector(s1 * 3, 0, s1 * 3)
    },
    rearSupport = {
        posName = "rear support",
        posOffset = vector(0, 0, s1 * 3)
    },
    rightSupport = {
        posName = "right support",
        posOffset = vector(-s1 * 3, 0, s1 * 3)
    },
}

wingConfigurations = {
    [3] = {
        [1] = "leftFlank",
        [2] = "rightFlank"
    },
    [4] = {
        [1] = "leftFlank",
        [2] = "rightFlank",
        [3] = "rearSupport"
    },
    [5] = {
        [1] = "leftFlank",
        [2] = "rightFlank",
        [3] = "leftSupport",
        [4] = "rightSupport"
    },
    [6] = {
        [1] = "leftFlank",
        [2] = "rightFlank",
        [3] = "rearSupport",
        [4] = "leftSupport",
        [5] = "rightSupport"
    }
}

posNames = { "Two", "Three", "Four", "Five", "Six" }

assignedShips = {}

configured = false


leader = nil
nameUnassigned = 'Epic Wing Token'
nameAssigned = '\'s Wing'
wingName = ''
configuration = 0

toolOpen = false

-- Save self state
function onSave()
    local state = {}
    state.configuration = configuration
    state.wingName = wingName
    state.leader = leader
    state.assignedShips = assignedShips
    state.toolOpen = toolOpen
    state.configured = configured
    return JSON.encode(state)
end

-- Restore self state
function onLoad(save_state)
    nameAssigned = self.getName()
    if save_state ~= '' and save_state ~= 'null' and save_state ~= nil then
        local state = JSON.decode(save_state)
        configuration = state.configuration or 0
        configured = state.configured or false
        wingName = state.wingName or ''
        leader = state.leader
        assignedShips = state.assignedShips or {}
        for _, wingmate in ipairs(assignedShips) do
            local ship = getObjectFromGUID(wingmate.guid)
            if ship then
                ship.addContextMenuItem("Rejoin wing", function() rejoin(ship) end, false)
                ship.addContextMenuItem("Split from wing", function() split(ship) end, false)
            end
        end
        toolOpen = state.toolOpen or false
    end
    if configured then
        local formWingButton = {
            ['function_owner'] = self,
            ['click_function'] = 'SetWing',
            ['label'] = 'Form Wing',
            ['position'] = { 0, 0.25, 0 },
            ['rotation'] = { 0, 0, 0 },
            ['width'] = 700,
            ['height'] = 200,
            ['font_size'] = 100
        }
        self.createButton(formWingButton)
    else
        SpawnFirstButtons()
    end
end

function SpawnFirstButtons()
    if nameAssigned == 'Epic Wing Token' then
        self.clearButtons()
        local nameWingButton = {
            ['function_owner'] = self,
            ['click_function'] = 'nameWingButton',
            ['label'] =
            'Click to Start',
            ['position'] = { 0, 0.25, 0 },
            ['rotation'] = { 0, 0, 0 },
            ['width'] = 700,
            ['height'] = 200,
            ['font_size'] = 100
        }
        self.createButton(nameWingButton)
    else
        SpawnLastButtons()
    end
end

function onDrop()
    if toolOpen == true then
        AddWingmate()
    end
end

function SpawnLastButtons()
    self.clearButtons()
    local ResetButton = {
        ['function_owner'] = self,
        ['click_function'] = 'selfReset',
        ['label'] = 'Reset',
        ['position'] = { 0, 0.25, 0.8 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 700,
        ['height'] = 200,
        ['font_size'] = 100
    }
    self.createButton(ResetButton)
    local formWingButton = {
        ['function_owner'] = self,
        ['click_function'] = 'SetWing',
        ['label'] = 'Form Wing',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 700,
        ['height'] = 200,
        ['font_size'] = 100
    }
    self.createButton(formWingButton)
    toolOpen = true
    wingName = self.getName()
end

-- Unassign the ship
function selfReset()
    local selfParams = self.getCustomObject()
    selfParams.diffuse =
    "http://cloud-3.steamusercontent.com/ugc/772864005379607458/65B8F0711DA05AE27B198979B0A4BE951284FD4E/"
    self.setCustomObject(selfParams)
    assignedShips = {}
    self.clearButtons()
    self.setName(nameUnassigned)
    nameAssigned = nameUnassigned
    self.call('SpawnFirstButtons')
    local newSelf = self.reload()
end

-- assign ships to wing Place token on the ship and press the Left Wing Button
-- Assign on drop near a small base ship
-- Add a wingmate to the wing
function AddWingmate()
    --find which position to fill next
    local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 80 })
    leader_ship = getObjectFromGUID(leader)
    if nearest ~= nil then
        if leader == nil then
            printToAll('Epic wing token assigned to ' .. nearest.getName())
            leader = nearest.getGUID()
            SpawnFirstButtons()
        elseif #assignedShips < 5 then
            if nearest == leader_ship then
                printToAll("Unable to add " .. nearest.getName() .. " to " .. wingName .. ", it is already in it")
                return
            end
            for _, assignment in pairs(assignedShips) do
                if getObjectFromGUID(assignment.guid) == nearest then
                    printToAll("Unable to add " .. nearest.getName() .. " to " .. wingName .. ", it is already in it")
                    return
                end
            end
            table.insert(assignedShips, { guid = nearest.getGUID(), active = true })
            nearest.addContextMenuItem("Rejoin wing", function() rejoin(nearest) end, false)
            nearest.addContextMenuItem("Split from wing", function() split(nearest) end, false)
            printToAll(wingName .. ' ' .. posNames[#assignedShips] .. ': assigned to ' .. nearest.getName())
            return
        else
            printToAll("Unable to add " .. nearest.getName() .. " to " .. wingName .. ", it is already full")
            return
        end
    end
end

-------------------------------------------
----Flavor Script for Naming Squadrons----

function nameWingButton()
    self.clearButtons()

    local SetRedSquadron = {
        ['function_owner'] = self,
        ['click_function'] = 'SetRedSquadron',
        ['label'] = 'Red Squadron',
        ['position'] = { -2.5, 0.25, 1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 900,
        ['height'] = 200,
        ['font_size'] = 100
    }
    self.createButton(SetRedSquadron)
    local SetGoldSquadron = {
        ['function_owner'] = self,
        ['click_function'] = 'SetGoldSquadron',
        ['label'] =
        'Gold Squadron',
        ['position'] = { -2.5, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 900,
        ['height'] = 200,
        ['font_size'] = 100
    }
    self.createButton(SetGoldSquadron)
    local SetBlueSquadron = {
        ['function_owner'] = self,
        ['click_function'] = 'SetBlueSquadron',
        ['label'] =
        'Blue Squadron',
        ['position'] = { -2.5, 0.25, -1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 900,
        ['height'] = 200,
        ['font_size'] = 100
    }
    self.createButton(SetBlueSquadron)
    local SetGreenSquadron = {
        ['function_owner'] = self,
        ['click_function'] = 'SetGreenSquadron',
        ['label'] =
        'Green Squadron',
        ['position'] = { 2.5, 0.25, 1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 900,
        ['height'] = 200,
        ['font_size'] = 100
    }
    self.createButton(SetGreenSquadron)
    local SetBlackSquadron = {
        ['function_owner'] = self,
        ['click_function'] = 'SetBlackSquadron',
        ['label'] =
        'Black Squadron',
        ['position'] = { 2.5, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 900,
        ['height'] = 200,
        ['font_size'] = 100
    }
    self.createButton(SetBlackSquadron)
    local SetWhiteSquadron = {
        ['function_owner'] = self,
        ['click_function'] = 'SetWhiteSquadron',
        ['label'] =
        'White Squadron',
        ['position'] = { 2.5, 0.25, -1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 900,
        ['height'] = 200,
        ['font_size'] = 100
    }
    self.createButton(SetWhiteSquadron)
end

function SetRedSquadron()
    wingName = 'Red'
    self.setName(wingName)
    local selfParams = self.getCustomObject()
    selfParams.diffuse =
    "{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tools/RedSquadron.png"
    self.setCustomObject(selfParams)
    local newSelf = self.reload()
    self.call('SpawnLastButtons')
end

function SetGoldSquadron()
    wingName = 'Gold'
    self.setName(wingName)
    local selfParams = self.getCustomObject()
    selfParams.diffuse =
    "{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tools/GoldSquadron.png"
    self.setCustomObject(selfParams)
    local newSelf = self.reload()
    self.call('SpawnLastButtons')
end

function SetBlueSquadron()
    wingName = 'Blue'
    self.setName(wingName)
    local selfParams = self.getCustomObject()
    selfParams.diffuse =
    "{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tools/BlueSquadron.png"
    self.setCustomObject(selfParams)
    self.call('SpawnLastButtons')
    local newSelf = self.reload()
end

function SetGreenSquadron()
    wingName = 'Green'
    self.setName(wingName)
    local selfParams = self.getCustomObject()
    selfParams.diffuse =
    "{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tools/GreenSquadron.png"
    self.setCustomObject(selfParams)
    self.call('SpawnLastButtons')
    local newSelf = self.reload()
end

function SetBlackSquadron()
    wingName = 'Black'
    self.setName(wingName)
    local selfParams = self.getCustomObject()
    selfParams.diffuse =
    "{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tools/BlackSquadron.png"
    self.setCustomObject(selfParams)
    self.call('SpawnLastButtons')
    local newSelf = self.reload()
end

function SetWhiteSquadron()
    wingName = 'White'
    self.setName(wingName)
    local selfParams = self.getCustomObject()
    selfParams.diffuse =
    "{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tools/WhiteSquadron.png"
    self.setCustomObject(selfParams)
    local newSelf = self.reload()
    self.call('SpawnLastButtons')
end

function SetWing()
    if not configured then
        if #assignedShips < 2 then
            printToAll('A Wing needs to have at least 3 ships to form')
            return
        end
        configured = true
        configuration = #assignedShips + 1
        toolOpen = false
    end
    self.clearButtons()
    WingMateLand(1, true)
    local formWingButton = {
        ['function_owner'] = self,
        ['click_function'] = 'SetWing',
        ['label'] = 'Form Wing',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 700,
        ['height'] = 200,
        ['font_size'] = 100
    }
    self.createButton(formWingButton)
end

function WingMateLand(index, recursive)
    local ship = getObjectFromGUID(assignedShips[index].guid)
    local wingpos = wingPositions[wingConfigurations[configuration][index]]
    local leader_ship = getObjectFromGUID(leader)
    if ship ~= nil and assignedShips[index].active then
        desiredPos = LocalPos(leader_ship, wingpos.posOffset)

        local success = Global.call("epicMoveWingmate", { ship, desiredPos, leader_ship.getRotation() })
        if not success then
            printToAll(wingpos.posName .. ' needs to break off') -- Break from wing, and mark for movement after all other wing members have been moved
            assignedShips[index].active = false
        end
    end
    if index < configuration - 1 and recursive then
        if ship ~= nil then
            Wait.condition(function() WingMateLand(index + 1, recursive) end,
                function() return ship.resting and not ship.isSmoothMoving() end)
        else
            WingMateLand(index + 1, recursive)
        end
    end
end

function rejoin(ship)
    for i, shipinfo in pairs(assignedShips) do
        if getObjectFromGUID(shipinfo.guid) == ship then
            assignedShips[i].active = true
            WingMateLand(i, false)
            return
        end
    end
end

function split(ship)
    for i, shipinfo in pairs(assignedShips) do
        if getObjectFromGUID(shipinfo.guid) == ship then
            assignedShips[i].active = false
            return
        end
    end
end

-------
-- Local Reference function, for spawning items relative to the quick build card
function LocalPos(object, position)
    local rot = object.getRotation()
    local lPos = { position[1], position[2], position[3] }
    -- Z-X-Y extrinsic
    local zRot = RotMatrix('z', rot['z'])
    lPos = RotateVector(zRot, lPos)
    local xRot = RotMatrix('x', rot['x'])
    lPos = RotateVector(xRot, lPos)
    local yRot = RotMatrix('y', rot['y'])
    lPos = RotateVector(yRot, lPos)

    return Vect.Sum(lPos, object.getPosition())
end

function RotMatrix(axis, angDeg)
    local ang = math.rad(angDeg)
    local cs = math.cos
    local sn = math.sin

    if axis == 'x' then
        return {
            { 1, 0,       0 },
            { 0, cs(ang), -1 * sn(ang) },
            { 0, sn(ang), cs(ang) }
        }
    elseif axis == 'y' then
        return {
            { cs(ang),      0, sn(ang) },
            { 0,            1, 0 },
            { -1 * sn(ang), 0, cs(ang) }
        }
    elseif axis == 'z' then
        return {
            { cs(ang), -1 * sn(ang), 0 },
            { sn(ang), cs(ang),      0 },
            { 0,       0,            1 }
        }
    end
end

-- Apply given rotation matrix on given vector
-- (multiply matrix and column vector)
function RotateVector(rotMat, vect)
    local out = { 0, 0, 0 }
    for i = 1, 3, 1 do
        for j = 1, 3, 1 do
            out[i] = out[i] + rotMat[i][j] * vect[j]
        end
    end
    return out
end
