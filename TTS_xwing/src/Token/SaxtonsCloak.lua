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
        ['click_function'] = 'decloakFDec',
        ['label'] = '-1',
        ['position'] = { 0, 0.25, -2 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakF',
        ['label'] = 'F',
        ['position'] = { 0, 0.25, -3.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakFInc',
        ['label'] = '+1',
        ['position'] = { 0, 0.25, -5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLInc',
        ['label'] = '+1',
        ['position'] = { -3.5, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakL',
        ['label'] = 'L',
        ['position'] = { -2.5, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLDec',
        ['label'] = '-1',
        ['position'] = { -1.5, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRInc',
        ['label'] = '+1',
        ['position'] = { 3.5, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakR',
        ['label'] = 'R',
        ['position'] = { 2.5, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRDec',
        ['label'] = '-1',
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
        ['click_function'] = 'decloakFLDec',
        ['label'] =
        '-1',
        ['position'] = { -0.75, 0.25, -2 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakFL',
        ['label'] =
        'FL',
        ['position'] = { -0.75, 0.25, -3.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakFLInc',
        ['label'] =
        '+1',
        ['position'] = { -0.75, 0.25, -5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakFRDec',
        ['label'] =
        '-1',
        ['position'] = { 0.75, 0.25, -2 },
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
        ['position'] = { 0.75, 0.25, -3.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakFRInc',
        ['label'] =
        '+1',
        ['position'] = { 0.75, 0.25, -5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLFDec',
        ['label'] = '-1',
        ['position'] = { -1.5, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLF',
        ['label'] = 'LF',
        ['position'] = { -2.5, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLFInc',
        ['label'] = '+1',
        ['position'] = { -3.5, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLBDec',
        ['label'] = '-1',
        ['position'] = { -1.5, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLB',
        ['label'] = 'LB',
        ['position'] = { -2.5, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLBInc',
        ['label'] = '+1',
        ['position'] = { -3.5, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRFDec',
        ['label'] = '-1',
        ['position'] = { 1.5, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRF',
        ['label'] = 'RF',
        ['position'] = { 2.5, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRFInc',
        ['label'] = '+1',
        ['position'] = { 3.5, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRBDec',
        ['label'] = '-1',
        ['position'] = { 1.5, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRB',
        ['label'] = 'RB',
        ['position'] = { 2.5, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    })
	    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRBInc',
        ['label'] = '+1',
        ['position'] = { 3.5, 0.25, 1.1 },
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
-- Extra Echo DECLOAK MOVES with repos

--------
--  Left

--------
-- DECLOAK LeftForward -1

function decloakLFDec()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLFDecForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLFDecMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLFDecBackAligned',
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

function decloakLFDecForwardAligned()
    if Global.call('API_PerformMove', { code = 'v1lf1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakLFDecMiddleAligned()
    if Global.call('API_PerformMove', { code = 'v1lf2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakLFDecBackAligned()
    if Global.call('API_PerformMove', { code = 'v1lf3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end



--------
-- DECLOAK LeftForward +1

function decloakLFInc()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLFIncForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLFIncMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLFIncBackAligned',
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

function decloakLFIncForwardAligned()
    if Global.call('API_PerformMove', { code = 'v3lf1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakLFIncMiddleAligned()
    if Global.call('API_PerformMove', { code = 'v3lf2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakLFIncBackAligned()
    if Global.call('API_PerformMove', { code = 'v3lf3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

--------
-- DECLOAK LeftBackward -1

function decloakLBDec()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLBDecForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLBDecMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLBDecBackAligned',
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

function decloakLBDecForwardAligned()
    if Global.call('API_PerformMove', { code = 'v1lb1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakLBDecMiddleAligned()
    if Global.call('API_PerformMove', { code = 'v1lb2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakLBDecBackAligned()
    if Global.call('API_PerformMove', { code = 'v1lb3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

--------
-- DECLOAK LeftBackward +1

function decloakLBInc()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLBIncForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLBIncMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLBIncBackAligned',
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

function decloakLBIncForwardAligned()
    if Global.call('API_PerformMove', { code = 'v3lb1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakLBIncMiddleAligned()
    if Global.call('API_PerformMove', { code = 'v3lb2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakLBIncBackAligned()
    if Global.call('API_PerformMove', { code = 'v3lb3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end



--------
--  Right

--------
-- DECLOAK RightForward -1

function decloakRFDec()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRFDecForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRFDecMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRFDecBackAligned',
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

function decloakRFDecForwardAligned()
    if Global.call('API_PerformMove', { code = 'v1rf1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakRFDecMiddleAligned()
    if Global.call('API_PerformMove', { code = 'v1rf2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakRFDecBackAligned()
    if Global.call('API_PerformMove', { code = 'v1rf3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


--------
-- DECLOAK RightForward +1

function decloakRFInc()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRFIncForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRFIncMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRFIncBackAligned',
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

function decloakRFIncForwardAligned()
    if Global.call('API_PerformMove', { code = 'v3rf1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakRFIncMiddleAligned()
    if Global.call('API_PerformMove', { code = 'v3rf2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakRFIncBackAligned()
    if Global.call('API_PerformMove', { code = 'v3rf3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

--------
-- DECLOAK RightBackward -1

function decloakRBDec()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRBDecForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRBDecMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRBDecBackAligned',
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

function decloakRBDecForwardAligned()
    if Global.call('API_PerformMove', { code = 'v1rb1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakRBDecMiddleAligned()
    if Global.call('API_PerformMove', { code = 'v1rb2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakRBDecBackAligned()
    if Global.call('API_PerformMove', { code = 'v1rb3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

--------
-- DECLOAK RightBackward +1

function decloakRBInc()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRBIncForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRBIncMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRBIncBackAligned',
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

function decloakRBIncForwardAligned()
    if Global.call('API_PerformMove', { code = 'v3rb1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakRBIncMiddleAligned()
    if Global.call('API_PerformMove', { code = 'v3rb2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakRBIncBackAligned()
    if Global.call('API_PerformMove', { code = 'v3rb3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


--------
-- Extra normal DECLOAK MOVES with repos


--------
-- DECLOAK Left -1

function decloakLDec()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLDecForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLDecMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLDecBackAligned',
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

function decloakLDecForwardAligned()
    if Global.call('API_PerformMove', { code = 'r1l1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakLDecMiddleAligned()
    if Global.call('API_PerformMove', { code = 'r1l2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakLDecBackAligned()
    if Global.call('API_PerformMove', { code = 'r1l3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end



--------
-- DECLOAK Left +1

function decloakLInc()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLIncForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLIncMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakLIncBackAligned',
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

function decloakLIncForwardAligned()
    if Global.call('API_PerformMove', { code = 'r3l1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakLIncMiddleAligned()
    if Global.call('API_PerformMove', { code = 'r3ll2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakLIncBackAligned()
    if Global.call('API_PerformMove', { code = 'r3l3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


--------
-- DECLOAK Right -1

function decloakRDec()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRDecForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRDecMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRDecBackAligned',
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

function decloakRDecForwardAligned()
    if Global.call('API_PerformMove', { code = 'r1r1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakRDecMiddleAligned()
    if Global.call('API_PerformMove', { code = 'r1r2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakRDecBackAligned()
    if Global.call('API_PerformMove', { code = 'r1r3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end



--------
-- DECLOAK Right +1

function decloakRInc()
    __XW_TokenIdle = false
    self.clearButtons()
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRIncForwardAligned',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRIncMiddleAligned',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    })
    self.createButton({
        ['function_owner'] = self,
        ['click_function'] = 'decloakRIncBackAligned',
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

function decloakRIncForwardAligned()
    if Global.call('API_PerformMove', { code = 'r3r1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end


function decloakRIncMiddleAligned()
    if Global.call('API_PerformMove', { code = 'r3r2', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakRIncBackAligned()
    if Global.call('API_PerformMove', { code = 'r3r3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

--------
-- END

--------
-- DECLOAK MOVES Forward normal

function decloakFDec()
    if Global.call('API_PerformMove', { code = 's1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end
function decloakF()
    if Global.call('API_PerformMove', { code = 'cs', ship = assignedShip }) then
        spawnFinalButtons()
    end
end
function decloakFInc()
    if Global.call('API_PerformMove', { code = 's3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

--------
-- end

--------
-- DECLOAK MOVES Forward Echo


function decloakFRDec()
    if Global.call('API_PerformMove', { code = 'br1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakFR()
    if Global.call('API_PerformMove', { code = 'esr', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakFRInc()
    if Global.call('API_PerformMove', { code = 'br3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakFLDec()
    if Global.call('API_PerformMove', { code = 'bl1', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakFL()
    if Global.call('API_PerformMove', { code = 'ese', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

function decloakFLInc()
    if Global.call('API_PerformMove', { code = 'bl3', ship = assignedShip }) then
        spawnFinalButtons()
    end
end

--------
-- end


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
