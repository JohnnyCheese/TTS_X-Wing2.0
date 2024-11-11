-- ~~~~~~
-- Script by CrazyVulcan, based on BombDrop token by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- Shuttle launch gizmo token
-- ~~~~~~

local Dim = require("Dim")

-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = false
__XW_TokenType = 'helper:shuttleLaunch'

-- Ref to assigned ship if there is one
assignedShip = nil
assignedShuttle = nil
local s1 = 0.225
nameUnassigned = 'Shuttle Launcher (assigned to mothership)'
nameAssigned = '\'s Shuttle Launcher Token'

-- Save self state
function onSave()
    if assignedShip ~= nil then
        --       local state = {assignedShipGUID=assignedShip.getGUID()&& assignedShuttleGUID=assignedShuttle.getGUID()}
        --        return JSON.encode(state)
    end
end

-- Restore self state
function onLoad(save_state)
    self.setName(nameUnassigned)
    if save_state ~= '' and save_state ~= 'null' and save_state ~= nil then
        local assignedShipGUID = JSON.decode(save_state).assignedShipGUID
        if assignedShipGUID ~= nil and getObjectFromGUID(assignedShipGUID) ~= nil then
            assignedShip = getObjectFromGUID(assignedShipGUID)
            assignedShuttle = getObjectFromGUID(assignedShuttleGUID)
            self.setName(assignedShip.getName() .. nameAssigned)
            SpawnFirstButtons()
        end
    end
end

-- Spawn initial drop/unsassign buttons
function SpawnFirstButtons()
    self.clearButtons()
    local decloakButton = { ['function_owner'] = self, ['click_function'] = 'SpawnLaunchButtons', ['label'] =
    'Launch Shuttle', ['position'] = { 0, 0.25, -1.5 }, ['rotation'] = { 0, 0, 0 }, ['width'] = 1500, ['height'] = 500,
        ['font_size'] = 250 }
    self.createButton(decloakButton)
    local deleteButton = { ['function_owner'] = self, ['click_function'] = 'selfUnassign', ['label'] = 'Unassign',
        ['position'] = { 0, 0.25, 1.5 }, ['rotation'] = { 0, 0, 0 }, ['width'] = 1100, ['height'] = 500, ['font_size'] = 250 }
    self.createButton(deleteButton)
end

function SpawnShuttleFindButtons()
    self.clearButtons()
    local shuttleButton = { ['function_owner'] = self, ['click_function'] = 'SYNCshuttle', ['label'] = 'SYNC Shuttle',
        ['position'] = { 0, 0.25, -1.5 }, ['rotation'] = { 0, 0, 0 }, ['width'] = 1500, ['height'] = 500, ['font_size'] = 250 }
    self.createButton(shuttleButton)
end

-- Assign on drop near a small base ship
function onDropped()
    if assignedShip == nil then
        local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 80 })
        if nearest ~= nil then
            printToAll('Shuttle Launcher Token assigned to ' .. nearest.getName(), { 0.2, 0.2, 1 })
            SpawnShuttleFindButtons()
            assignedShip = nearest
            self.setName(assignedShip.getName() .. nameAssigned)
        end
    end
end

-- Assign Shuttle to this ship
function SYNCshuttle()
    if assignedShuttle == nil then
        local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 80 })
        if nearest ~= nil then
            printToAll(nearest.getName() .. ' is docked to ' .. assignedShip.getName())
            SpawnFirstButtons()
            assignedShuttle = nearest
            self.setName(assignedShuttle.getName() .. nameAssigned)
        end
    end
end

-- <><><><><><><><><><><><> --

function SpawnLaunchButtons()
    self.clearButtons()
    local launchShuttle = { ['function_owner'] = self, ['click_function'] = 'launchShuttleButton', ['label'] =
    'Launch Shuttle', ['position'] = { 0, 0.25, -1.5 }, ['rotation'] = { 0, 0, 0 }, ['width'] = 2000, ['height'] = 500,
        ['font_size'] = 250 }
    self.createButton(launchShuttle)
    local dropShuttle = { ['function_owner'] = self, ['click_function'] = 'dropShuttleButton', ['label'] = 'Drop Shuttle',
        ['position'] = { 0, 0.25, 1.5 }, ['rotation'] = { 0, 0, 0 }, ['width'] = 2000, ['height'] = 500, ['font_size'] = 250 }
    self.createButton(dropShuttle)
    local setShuttle = { ['function_owner'] = self, ['click_function'] = 'setShuttleButton', ['label'] = 'Set Shuttle',
        ['position'] = { 1, 0.25, 0 }, ['rotation'] = { 0, 0, 0 }, ['width'] = 2000, ['height'] = 500, ['font_size'] = 250 }
    self.createButton(setShuttle)
end

function dropShuttleButton()
    local MS_POS = assignedShip.getPosition()
    local MS_ROT = assignedShip.getRotation()
    assignedShuttle.setLock(true)
    assignedShip.setLock(true)
    assignedShuttle.setPosition({ MS_POS.x, MS_POS.y + 0.5, MS_POS.z })
    assignedShuttle.setRotation({ MS_ROT.x, MS_ROT.y + 180, MS_ROT.z })

    posZ = math.sin(math.rad(MS_ROT.y - 90)) * (s1 * 3)
    posX = math.cos(math.rad(MS_ROT.y - 90)) * (s1 * 3)

    assignedShuttle.setPosition({ MS_POS.x + posX, MS_POS.y, MS_POS.z - posZ })
    assignedShuttle.setPositionSmooth({ MS_POS.x + posX, MS_POS.y, MS_POS.z - posZ })
    assignedShuttle.setPosition({ MS_POS.x + posX, MS_POS.y, MS_POS.z - posZ })
end

function launchShuttleButton()
    local MS_POS = assignedShip.getPosition()
    local MS_ROT = assignedShip.getRotation()
    assignedShuttle.setLock(true)
    assignedShip.setLock(true)
    assignedShuttle.setPosition({ MS_POS.x, MS_POS.y + 0.5, MS_POS.z })
    assignedShuttle.setRotation({ MS_ROT.x, MS_ROT.y, MS_ROT.z })

    posZ = math.sin(math.rad(MS_ROT.y + 90)) * (s1 * 3)
    posX = math.cos(math.rad(MS_ROT.y + 90)) * (s1 * 3)

    assignedShuttle.setPosition({ MS_POS.x + posX, MS_POS.y, MS_POS.z - posZ })
    assignedShuttle.setPositionSmooth({ MS_POS.x + posX, MS_POS.y, MS_POS.z - posZ })
    assignedShuttle.setPosition({ MS_POS.x + posX, MS_POS.y, MS_POS.z - posZ })
end

-- Unassign the ship
function selfUnassign()
    assignedShip = nil
    assignedShuttle = nil
    self.clearButtons()
    self.setName(nameUnassigned)
end

function setShuttleButton()
    SpawnFirstButtons()
end

function dummy() return end
