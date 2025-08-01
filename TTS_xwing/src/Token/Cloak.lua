-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- Token for easy barrel rolls with StarViper Mk.II title
-- ~~~~~~
local Dim = require("Dim")

-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = false
__XW_TokenType = 'cloak'

-- Ref to assigned ship if there is one
assignedShip = nil

-- The current decload direction
decloakCode = nil

-- Save self state
function onSave()
    if assignedShip ~= nil then
        local state = { assignedShipGUID = assignedShip.getGUID() }
        return JSON.encode(state)
    end
end

-- Restore self state
function onLoad(save_state)
    if save_state ~= '' and save_state ~= 'null' and save_state ~= nil then
        local assignedShipGUID = JSON.decode(save_state).assignedShipGUID
        if assignedShipGUID ~= nil and getObjectFromGUID(assignedShipGUID) ~= nil then
            assignedShip = getObjectFromGUID(assignedShipGUID)
            spawnFirstButtons()
        end
    end
end

-- Spawn initial decloak/delete buttons
function spawnFirstButtons()
    __XW_TokenIdle = true
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'spawnDecloakButtons',
        ['label'] = 'Decloak',
        ['position'] = { 0, 0.25, -1.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1000,
        ['height'] = 500,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'selfDestruct',
        ['label'] = 'Delete',
        ['position'] = { 0, 0.25, 1.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1000,
        ['height'] = 500,
        ['font_size'] = 250
    })
end

-- Assign on drop near a small base ship
function onDropped()
    if assignedShip == nil then
        local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 80 })
        if nearest ~= nil then
            printToAll('Cloak token assigned to ' .. nearest.getName(), { 0.2, 0.2, 1 })
            self.setRotation(nearest.getRotation())
            spawnFirstButtons()
            assignedShip = nearest
        end
    end
end

-- Spawn undo/delete/slide buttons (after a move)
function spawnFinalButtons()
    undoToBackCount = 1
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'performUndo',
        ['label'] = 'Undo',
        ['position'] = { 0, 0.25, -1.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1000,
        ['height'] = 500,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'selfDestruct',
        ['label'] = 'Delete',
        ['position'] = { 0, 0.25, 1.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1000,
        ['height'] = 500,
        ['font_size'] = 250
    })
end

function spawnDecloakAllignmentSet()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakBackAligned',
        ['label'] = 'Backward',
        ['position'] = { 0, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'resetToFirst',
        ['label'] = 'Back',
        ['position'] = { 0, 0.25, 2.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 500,
        ['font_size'] = 250
    })
end


function spawnNormalDecloakOptions()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakF',
        ['label'] = 'F',
        ['position'] = { 0, 0.25, -2 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakL',
        ['label'] = 'L',
        ['position'] = { -1.5, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakR',
        ['label'] = 'R',
        ['position'] = { 1.5, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
end


function spawnEchoDecloakOptions()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakFL',
        ['label'] =
        'FL',
        ['position'] = { -0.75, 0.25, -2 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakFR',
        ['label'] =
        'FR',
        ['position'] = { 0.75, 0.25, -2 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLF',
        ['label'] = 'LF',
        ['position'] = { -1.5, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLB',
        ['label'] = 'LB',
        ['position'] = { -1.5, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRF',
        ['label'] = 'RF',
        ['position'] = { 1.5, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRB',
        ['label'] = 'RB',
        ['position'] = { 1.5, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
end


-- Spawn back/delete/moves buttons (regular or Echo)
function spawnDecloakButtons()
    __XW_TokenIdle = false
    self.clearButtons()
    if assignedShip.getTable('Data').xws ~= "echo" then
        spawnNormalDecloakOptions()
    end
    if assignedShip.getName():find('Echo') ~= nil then
        spawnEchoDecloakOptions()
    end
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'selfDestruct',
        ['label'] = 'Delete',
        ['position'] = { 0, 0.25, 2 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 750,
        ['height'] = 500,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'resetToFirst',
        ['label'] = 'Back',
        ['position'] = { 0, 0.25, 1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 750,
        ['height'] = 500,
        ['font_size'] = 250
    })
end


function decloakL()
    decloakCode = "cl"
    spawnDecloakAllignmentSet()
end

function decloakR()
    decloakCode = "cr"
    spawnDecloakAllignmentSet()
end

function decloakLF()
    decloakCode = "elf"
    spawnDecloakAllignmentSet()
end

function decloakLB()
    decloakCode = "elb"
    spawnDecloakAllignmentSet()
end

function decloakRF()
    decloakCode = "erf"
    spawnDecloakAllignmentSet()
end

function decloakRB()
    decloakCode = "erb"
    spawnDecloakAllignmentSet()
end


--------
-- DECLOAK MOVES
function decloakF()
    if Global.call('API_PerformMove', { code = 'cs', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakFR()
    if Global.call('API_PerformMove', { code = 'esr', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakFL()
    if Global.call('API_PerformMove', { code = 'ese', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakForwardAligned()
    if Global.call('API_PerformMove', { code = decloakCode .. '1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakMiddleAligned()
    if Global.call('API_PerformMove', { code = decloakCode .. '2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakBackAligned()
    if Global.call('API_PerformMove', { code = decloakCode .. '3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

-- END DECLOAK MOVES
--------

-- Destroy self
function selfDestruct()
    self.destruct()
end

-- Back to first buttons
function resetToFirst()
    spawnFirstButtons()
end

-- Undo move, if undid all back to decloak buttons
function performUndo()
    assignedShip.setDescription('q')
    undoToBackCount = undoToBackCount - 1
    if undoToBackCount <= 0 then
        spawnDecloakButtons()
    end
end
