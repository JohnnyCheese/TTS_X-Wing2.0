-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- Token for easy barrel rolls with StarViper Mk.II title
-- ~~~~~~
-- moved to external file 5/10/2024

local Dim = require("Dim")

-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'helper:viperRoll'

-- Ref to assigned ship if there is one
assignedShip = nil

-- Save self state
function onSave()
    if assignedShip ~= nil then
        local state = { assignedShipGUID = assignedShip.getGUID() }
        return JSON.encode(state)
    end
end

-- Restore self state
function onLoad(save_state)
    self.setName('StarViper Mk.II roll token')
    if save_state ~= '' and save_state ~= 'null' and save_state ~= nil then
        local assignedShipGUID = JSON.decode(save_state).assignedShipGUID
        if assignedShipGUID ~= nil and getObjectFromGUID(assignedShipGUID) ~= nil then
            assignedShip = getObjectFromGUID(assignedShipGUID)
            self.setName(assignedShip.getName() .. '\'s roll token')
            SpawnFirstButtons()
        end
    end
end

-- Spawn initial roll/unassign buttons
function SpawnFirstButtons()
    __XW_TokenIdle = true
    self.clearButtons()
    local decloakButton = {
        ['function_owner'] = self,
        ['click_function'] = 'SpawnRollButtons',
        ['label'] = 'Roll',
        ['position'] = { 0, 0.25, -1.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1000,
        ['height'] = 500,
        ['font_size'] = 250
    }
    self.createButton(decloakButton)
    local deleteButton = {
        ['function_owner'] = self,
        ['click_function'] = 'selfUnassign',
        ['label'] = 'Unassign',
        ['position'] = { 0, 0.25, 1.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1000,
        ['height'] = 500,
        ['font_size'] = 250
    }
    self.createButton(deleteButton)
end

-- Assign on drop near a small base ship
function onDropped()
    if assignedShip == nil then
        local spos = self.getPosition()
        local nearest = nil
        local minDist = Dim.Convert_mm_igu(80)
        for _, ship in pairs(getAllObjects()) do
            if ship.type == 'Figurine' and ship.name ~= '' then
                local pos = ship.getPosition()
                local dist = math.sqrt(math.pow((spos[1] - pos[1]), 2) + math.pow((spos[3] - pos[3]), 2))
                if dist < minDist then
                    nearest = ship
                    minDist = dist
                end
            end
        end
        if nearest ~= nil then
            printToAll('SV Mk.II roll token assigned to ' .. nearest.getName(), { 0.2, 0.2, 1 })
            self.setRotation(nearest.getRotation())
            SpawnFirstButtons()
            assignedShip = nearest
            self.setName(assignedShip.getName() .. '\'s roll token')
        end
    end
end

-- Spawn undo/OK/slide buttons (after a roll)
function SpawnFinalButtons()
    undoToBackCount = 1
    self.clearButtons()
    local undoButton = {
        ['function_owner'] = self,
        ['click_function'] = 'performUndo',
        ['label'] = 'Undo',
        ['position'] = { 0, 0.25, -1.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1000,
        ['height'] = 500,
        ['font_size'] = 250
    }
    self.createButton(undoButton)
    local deleteButton = {
        ['function_owner'] = self,
        ['click_function'] = 'resetToFirst',
        ['label'] = 'OK',
        ['position'] = { 0, 0.25, 1.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1000,
        ['height'] = 500,
        ['font_size'] = 250
    }
    self.createButton(deleteButton)
end

-- Spawn first set, choosing Right/Left and Front/Back
function SpawnRollButtons()
    __XW_TokenIdle = false
    self.clearButtons()
    local rollLF_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'spawnSetLF',
        ['label'] = 'LF',
        ['position'] = { -1.5, 0.25, -0.6 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(rollLF_Button)
    local rollLB_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'spawnSetLB',
        ['label'] = 'LB',
        ['position'] = { -1.5, 0.25, 0.6 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(rollLB_Button)
    local rollRF_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'spawnSetRF',
        ['label'] = 'RF',
        ['position'] = { 1.5, 0.25, -0.6 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(rollRF_Button)
    local rollRB_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'spawnSetRB',
        ['label'] = 'RB',
        ['position'] = { 1.5, 0.25, 0.6 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 365,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(rollRB_Button)
    local backButton = {
        ['function_owner'] = self,
        ['click_function'] = 'resetToFirst',
        ['label'] = 'Back',
        ['position'] = { 0, 0.25, 2 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 750,
        ['height'] = 500,
        ['font_size'] = 250
    }
    self.createButton(backButton)
end

-- Spawn second set, choosing front, middle and back adjustment
function spawnSetLF()
    __XW_TokenIdle = false
    self.clearButtons()
    local viperRollLF1_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollLF1',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollLF1_Button)
    local viperRollLF2_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollLF2',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollLF2_Button)
    local viperRollLF3_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollLF3',
        ['label'] = 'Backward',
        ['position'] = { 0, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollLF3_Button)
    local backButton = {
        ['function_owner'] = self,
        ['click_function'] = 'resetToFirst',
        ['label'] = 'Back',
        ['position'] = { 0, 0.25, 2.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 500,
        ['font_size'] = 250
    }
    self.createButton(backButton)
end

function spawnSetLB()
    __XW_TokenIdle = false
    self.clearButtons()
    local viperRollLB1_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollLB1',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollLB1_Button)
    local viperRollLB2_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollLB2',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollLB2_Button)
    local viperRollLB3_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollLB3',
        ['label'] = 'Backward',
        ['position'] = { 0, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollLB3_Button)
    local backButton = {
        ['function_owner'] = self,
        ['click_function'] = 'resetToFirst',
        ['label'] = 'Back',
        ['position'] = { 0, 0.25, 2.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 500,
        ['font_size'] = 250
    }
    self.createButton(backButton)
end

function spawnSetRF()
    __XW_TokenIdle = false
    self.clearButtons()
    local viperRollRF1_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollRF1',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollRF1_Button)
    local viperRollRF2_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollRF2',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollRF2_Button)
    local viperRollRF3_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollRF3',
        ['label'] = 'Backward',
        ['position'] = { 0, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollRF3_Button)
    local backButton = {
        ['function_owner'] = self,
        ['click_function'] = 'resetToFirst',
        ['label'] = 'Back',
        ['position'] = { 0, 0.25, 2.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 500,
        ['font_size'] = 250
    }
    self.createButton(backButton)
end

function spawnSetRB()
    __XW_TokenIdle = false
    self.clearButtons()
    local viperRollRB1_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollRB1',
        ['label'] = 'Forward',
        ['position'] = { 0, 0.25, -1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollRB1_Button)
    local viperRollRB2_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollRB2',
        ['label'] = 'Middle',
        ['position'] = { 0, 0.25, 0 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollRB2_Button)
    local viperRollRB3_Button = {
        ['function_owner'] = self,
        ['click_function'] = 'viperRollRB3',
        ['label'] = 'Backward',
        ['position'] = { 0, 0.25, 1.1 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 520,
        ['font_size'] = 250
    }
    self.createButton(viperRollRB3_Button)
    local backButton = {
        ['function_owner'] = self,
        ['click_function'] = 'resetToFirst',
        ['label'] = 'Back',
        ['position'] = { 0, 0.25, 2.5 },
        ['rotation'] = { 0, 0, 0 },
        ['width'] = 1200,
        ['height'] = 500,
        ['font_size'] = 250
    }
    self.createButton(backButton)
end

--------
-- ROLL MOVES
function viperRollRF1()
    if assignedShip.setDescription('vrf1') then
        SpawnFinalButtons()
    end
end

function viperRollRF2()
    if assignedShip.setDescription('vrf2') then
        SpawnFinalButtons()
    end
end

function viperRollRF3()
    if assignedShip.setDescription('vrf3') then
        SpawnFinalButtons()
    end
end

function viperRollRB1()
    if assignedShip.setDescription('vrb1') then
        SpawnFinalButtons()
    end
end

function viperRollRB2()
    if assignedShip.setDescription('vrb2') then
        SpawnFinalButtons()
    end
end

function viperRollRB3()
    if assignedShip.setDescription('vrb3') then
        SpawnFinalButtons()
    end
end

function viperRollLF1()
    if assignedShip.setDescription('vlf1') then
        SpawnFinalButtons()
    end
end

function viperRollLF2()
    if assignedShip.setDescription('vlf2') then
        SpawnFinalButtons()
    end
end

function viperRollLF3()
    if assignedShip.setDescription('vlf3') then
        SpawnFinalButtons()
    end
end

function viperRollLB1()
    if assignedShip.setDescription('vlb1') then
        SpawnFinalButtons()
    end
end

function viperRollLB2()
    if assignedShip.setDescription('vlb2') then
        SpawnFinalButtons()
    end
end

function viperRollLB3()
    if assignedShip.setDescription('vlb3') then
        SpawnFinalButtons()
    end
end

-- END DECLOAK MOVES
--------

-- Unassign ship
function selfUnassign()
    assignedShip = nil
    __XW_TokenIdle = false
    self.clearButtons()
    self.setName('StarViper Mk.II roll token')
end

-- Back to first buttons
function resetToFirst()
    SpawnFirstButtons()
end

-- Undo move, if undid all back to roll buttons
function performUndo()
    assignedShip.setDescription('q')
    undoToBackCount = undoToBackCount - 1
    if undoToBackCount <= 0 then
        SpawnRollButtons()
    end
end
