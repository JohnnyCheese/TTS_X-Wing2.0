-- List Builder for X-Wing 2.0
-- ~~~~~~
-- Script by Johnny Cheese
--
-- This module creates a set of buttons and text input on an object.
-- Script has 3 main modules: FFG spawner, TTS spawner and Squad Builder.
-- FFG spawner receives the link for a saved FFG web site squad and spawns said squad.
-- TTS spawner receives a string containingthe name of all pilots and upgrades and set up a table wich will be passed to the global newSpawner function.
-- Squad Builder offers options to build a squad, but does not apply any restrictions other than faction specific cards.
-- The cards with the same name are diferentiated by faction when possible, and will if needed, the script inquires the player wich version is being summoned.
-- The inquire happens in cases of pilots on the same faction using different ships (Sabine, Ezra, "Zeb") and in cases of upgrades with the same name (R2-D2 crew and astromech)
-- ~~~~~~

require("TTS_Lib.Util.Math")
require("TTS_Lib.Util.Table")
require("TTS_Lib.Util.String")
local Vect = require("TTS_lib.Vector.Vector")
local Sequence = require("TTS_lib.Sequence.Sequence")
local PlayerArea = require("Player.PlayerArea")

self.interactable = false

tintColors = {}
tintColors[0] = Color(0, 0, 0, 0.0)        -- Transparent/Invisible
tintColors[1] = Color(1, 0, 0, 1.0)        -- Red
tintColors[2] = Color(1, 1, 0, 1.0)        -- Yellow
tintColors[3] = Color(0, 0.5, 0, 2.0)      -- Green
tintColors[4] = Color(0, 0, 1, 1.0)        -- Blue
tintColors[5] = Color(1, 0, 0.8, 1.0)      -- Pink/Purple
tintColors[6] = Color(0.5, 0.25, 0.1, 1.0) -- Brown
tintColors[7] = Color(1, 1, 1, 1.0)        -- White
tintColors[8] = Color(0.5, 0.5, 0.5, 1.0)  -- Gray

validFactions = {
    dummy = true
}

cardBackDB = {}
cardBackDB.dummy = ''
cardBackDB.rebelalliance =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Rebelback.png'
cardBackDB.galacticempire =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Empireback.png'
cardBackDB.scumandvillainy =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Scumback.png'
cardBackDB.resistance =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Resback.jpg'
cardBackDB.firstorder = 'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/FOback.png'
cardBackDB.galacticrepublic =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/REPback.jpg'
cardBackDB.separatistalliance =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/CISback.jpg'
cardBackDB['Talent'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Eptupgrade.png'  -- EPT
cardBackDB['Sensor'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/systemupg.png'   -- Sensor
cardBackDB['Cannon'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Cannonup.png'    -- Cannon
cardBackDB['Cannon Dual'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Cannonup.png'    -- Dule Cannon NEEDS ART
cardBackDB['Turret'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/turrups.png'     -- Turret
cardBackDB['Torpedo'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/torpups.png'     -- Torpedo
cardBackDB['Missile'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/missileupg.png'  -- Missile
cardBackDB['Missile Dual'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/DualMissile.png' -- Dual Missile
cardBackDB[''] =
''                                                                                                            --
cardBackDB['Crew'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Crew.png'        -- Crew
cardBackDB['Crew Dual'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/DualCrew.png'    -- Dual Crew
cardBackDB['Astromech'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Astro.png' --Astromech
cardBackDB['Payload'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Device.png'       -- Device
cardBackDB['Payload Dual'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/DualDevice.png'   -- DualDevice
cardBackDB['Illicit'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Illicit.png'      -- Ilicit
cardBackDB['Modification'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Modification.png' -- Modification
cardBackDB['Title'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Title.png'        -- Title
cardBackDB['Gunner'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Gunner.png'       -- Gunner
cardBackDB['Force Power'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Force.png'        -- Force Power
cardBackDB['Configuration'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Config.png'       -- Configuration
cardBackDB['Tech'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Tech.jpg'         -- Tech
cardBackDB['Relay'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Relay.jpg'        -- Droid (PLACEHOLDER - TO DO)
cardBackDB['Command'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Epic.png'    -- Command
cardBackDB['Cargo'] =
'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Cargo.png'  -- Cargo
cardBackDB['Team'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Staff.png'   -- Team
cardBackDB['Hardpoint'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Staff.png'   -- Hardpoint (PlACEHOLDER - TODO)
cardBackDB['Hyperdrive'] =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/Back_Staff.png'   -- Hyperspace ring (PlACEHOLDER - TODO)

cardBackDB['Weapon Hardpoint'] = cardBackDB['Hardpoint']


cardBackDB.mc =
'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/cardback/ModConfig.jpg' -- mod and config


masterShipDB = require("Game.Component.Spawner.ShipDb")
amgPilotDB = require("Game.Component.Spawner.PilotDb")
amgUpgradesDB = require("Game.Component.Spawner.UpgradeDb")
xwaPilotDB = require("Game.Component.Spawner.XwaPilotDb")
xwaUpgradesDB = require("Game.Component.Spawner.XwaUpgradeDb")
legacyPilotDB = require("Game.Component.Spawner.LegacyPilotDb")
legacyUpgradesDB = require("Game.Component.Spawner.LegacyUpgradeDb")

xwaMasterPilotDB = table.join_sparse(amgPilotDB, xwaPilotDB)
xwaMasterUpgradesDB = table.join_sparse(amgUpgradesDB, xwaUpgradesDB)
legacyMasterPilotDB = table.join_sparse(amgPilotDB, legacyPilotDB)
legacyMasterUpgradesDB = table.join_sparse(amgUpgradesDB, legacyUpgradesDB)

masterPilotDB = amgPilotDB
masterUpgradesDB = amgUpgradesDB

ffgSpecial = {}
ffgSpecial[315] = 'Crew'         --r2d2crew
ffgSpecial[324] = 'Astr'         --r2d2astro
ffgSpecial[321] = 'Rebel Gunner' --hanReb
ffgSpecial[389] = 'Scum Gunner'  --hanScu
ffgSpecial[474] = 'Resist. Crew' --Han Res
ffgSpecial[311] = 'Rebel Crew'   --landoReb
ffgSpecial[385] = 'Scum Crew'    --landoScu
ffgSpecial[306] = 'Rebel Crew'   --chewReb
ffgSpecial[382] = 'Scum Crew'    --chewScu
ffgSpecial[473] = 'Resist. Crew' --chewRes
ffgSpecial[472] = 'Resist. Crew' --3po Res
ffgSpecial[304] = 'Rebel Crew'   --3po Reb

VERSION_DATA = {
    ruleset = "none",
    pilots = {},
    upgrades = {}
}

-- on load initiate the process
function onLoad(save_state)
    initiate()
end

function onSave()
end

hasSpawned = false

-- Initial function: Creates a start button for each mode: FFG Spawner (paste the link of the squad in the FFG web site and spawn), TTS Spawner (write or paste a snippet and spawn) and List Builder (offers options to build a squadron on the fly)
function initiate()
    self.clearButtons()
    self.clearInputs()
    -- self.createButton({ click_function = 'xwsStart', function_owner = self, label = 'XWS Spawner', position = { 0.5, 0.45, -0.1 }, width = 1600, height = 380, font_size = 250, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'singleSpawner', function_owner = self, label = 'Single Spawner', position = { -0.5, 0.45, 0.15 }, width = 1600, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    -- self.createButton({ click_function = 'spawnerStart', function_owner = self, label = 'TTS Spawner', position = { -0.5, 0.45, 0.4 }, width = 1600, height = 380, font_size = 250, scale = { 0.25, 0.25, 0.25 } })
    -- self.createButton({ click_function = 'builderStart', function_owner = self, label = 'Builder', position = { 0.5, 0.45, 0.4 }, width = 1600, height = 380, font_size = 250, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'assetSpawn', function_owner = self, label = "Asset Spawner", position = { 0.5, 0.45, 0.15 }, width = 1600, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'configuration', function_owner = self, label = "Configuration", position = { -0.5, 0.45, -0.1 }, width = 1600, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'scenario', function_owner = self, label = "Scenario Setup", position = { 0.5, 0.45, -0.1 }, width = 1600, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'spawnStart', function_owner = self, label = 'Spawn List', position = { 0, 0.45, 0.45 }, width = 2000, height = 500, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    if hasSpawned then
        self.createButton({ click_function = 'relocateSpawned', function_owner = self, label = 'Move To Player', position = { 0.6, 0.45, 0.8 }, width = 1600, height = 380, font_size = 200, scale = { 0.15, 0.15, 0.15 } })
    end
end

function spawnStart()
    self.clearButtons()
    self.createButton({ click_function = 'amgPoints', function_owner = self, label = "AMG Points", position = { 0, 0.45, -0.1 }, width = 1600, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'xwaPoints', function_owner = self, label = "XWA Points", position = { 0, 0.45, 0.2 }, width = 1600, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'x2poPoints', function_owner = self, label = "Legacy Points", position = { 0, 0.45, 0.5 }, width = 1600, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    addResetButton()
end

function addResetButton()
    self.createButton({
        click_function = 'initiate',
        function_owner = self,
        label = 'Back',
        position = { 0.4, 0.43, 0.8 },
        width = 1650,
        height = 520,
        font_size = 240,
        scale = { 0.15, 0.15, 0.15 }
    })
end

function amgPoints()
    masterPilotDB = amgPilotDB
    upgradeDB = amgUpgradesDB
    loadPoints("AMG")
    spawnOptions("AMG")
end

function xwaPoints()
    masterPilotDB = xwaMasterPilotDB
    masterUpgradesDB = xwaMasterUpgradesDB
    loadPoints("XWA")
    spawnOptions("XWA")
end

function x2poPoints()
    masterPilotDB = legacyMasterPilotDB
    masterUpgradesDB = legacyMasterUpgradesDB
    loadPoints("X2PO")
    spawnOptions("X2PO")
end

function spawnOptions(versionversion)
    self.clearButtons()
    self.createButton({ click_function = 'xwsStart', function_owner = self, label = 'XWS Spawner', position = { 0.0, 0.45, -0.1 }, width = 1600, height = 380, font_size = 250, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'spawnerStart', function_owner = self, label = 'TTS Spawner', position = { 0.0, 0.45, 0.2 }, width = 1600, height = 380, font_size = 250, scale = { 0.25, 0.25, 0.25 } })
    if versionversion ~= "X2PO" then
        self.createButton({ click_function = 'builderStart', function_owner = self, label = 'Builder', position = { 0.0, 0.45, 0.5 }, width = 1600, height = 380, font_size = 250, scale = { 0.25, 0.25, 0.25 } })
    end
    addResetButton()
end

function scenario()
    self.clearButtons()
    self.createButton({
        click_function = 'scenarioAssault',
        function_owner = self,
        label = 'Assault at the Sattelite Array',
        position = { 0.5, 0.45, -0.3 },
        width = 1750,
        height = 350,
        font_size = 140,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({
        click_function = 'scenarioChance',
        function_owner = self,
        label = 'Chance Engagement',
        position = { 0.5, 0.43, -0.05 },
        width = 1750,
        height = 350,
        font_size = 140,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({
        click_function = 'scenarioSalvage',
        function_owner = self,
        label = 'Salvage Mission',
        position = { -0.45, 0.45, -0.3 },
        width = 1750,
        height = 350,
        font_size = 140,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({
        click_function = 'scenarioScramble',
        function_owner = self,
        label = 'Scramble the Transmissions',
        position = { -0.45, 0.43, -0.05 },
        width = 1750,
        height = 350,
        font_size = 140,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({
        click_function = 'scenarioBoYavin',
        function_owner = self,
        label = 'Battle of Yavin',
        position = { 0.5, 0.43, 0.2 },
        width = 1750,
        height = 350,
        font_size = 140,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({
        click_function = 'scenarioSoC',
        function_owner = self,
        label = 'Siege of Coruscant',
        position = { -0.45, 0.43, 0.2 },
        width = 1750,
        height = 350,
        font_size = 140,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({
        click_function = 'scenarioAce',
        function_owner = self,
        label = "Ace's High",
        position = { 0.025, 0.43, 0.45 },
        width = 1750,
        height = 350,
        font_size = 140,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({
        click_function = 'initiate',
        function_owner = self,
        label = 'Back',
        position = { 0.4, 0.43, 0.8 },
        width = 1650,
        height = 520,
        font_size = 240,
        scale = { 0.15, 0.15, 0.15 }
    })
end

function scenarioAce()
    initiate()
    local red_blue_mat = getObjectFromGUID('0db84a')
    red_blue_mat.call('SelectAH')
end

function scenarioSoC()
    initiate()
    local red_blue_mat = getObjectFromGUID('0db84a')
    red_blue_mat.call("clearScenario", nil)
    local custom = red_blue_mat.getCustomObject()
    custom.diffuse = 'http://i.imgur.com/8tDK0x8.png'
    red_blue_mat.setCustomObject(custom)
    red_blue_mat = red_blue_mat.reload()
    Wait.condition(function() red_blue_mat.call('SelectSoC') end,
        function() return (not red_blue_mat.loading_custom) and (not red_blue_mat.spawning) end)
end

function scenarioAssault()
    initiate()
    local red_blue_mat = getObjectFromGUID('0db84a')
    red_blue_mat.call('SelectAssault')
end

function scenarioChance()
    initiate()
    local red_blue_mat = getObjectFromGUID('0db84a')
    red_blue_mat.call('SelectEngagment')
end

function scenarioSalvage()
    initiate()
    local red_blue_mat = getObjectFromGUID('0db84a')
    red_blue_mat.call('SelectSalvage')
end

function scenarioScramble()
    initiate()
    local red_blue_mat = getObjectFromGUID('0db84a')
    red_blue_mat.call('SelectScramble')
end

function scenarioBoYavin()
    initiate()
    local red_blue_mat = getObjectFromGUID('0db84a')
    red_blue_mat.call("clearScenario", nil)
    local custom = red_blue_mat.getCustomObject()
    custom.diffuse =
    'https://steamusercontent-a.akamaihd.net/ugc/1863954854624717161/2BEED383E5A41762625D3C0A3D3F8AB7BF0B9863/'
    red_blue_mat.setCustomObject(custom)
    red_blue_mat = red_blue_mat.reload()
    Wait.condition(function() red_blue_mat.call('SelectBoY') end,
        function() return (not red_blue_mat.loading_custom) and (not red_blue_mat.spawning) end)
end

function configuration()
    local tokenSizeStr = { [1] = "Small", [2] = "Medium", [3] = "Large" }
    local tokenSize = Global.call("API_GetTokenSize", {}) or 1
    self.clearButtons()
    self.createButton({
        click_function = 'toggleTokenSize',
        function_owner = self,
        label = 'Token size: ' .. tokenSizeStr[tokenSize],
        position = { 0, 0.45, -0.2 },
        width = 2600,
        height = 360,
        font_size = 240,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({ click_function = 'toggleAnnouncement', function_owner = self, label = 'Toggle announcement', position = { 0, 0.45, 0.0 }, width = 2600, height = 360, font_size = 240, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'resetXwsData', function_owner = self, label = 'Fetch XWS values', position = { 0.0, 0.45, 0.2 }, width = 2600, height = 360, font_size = 240, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'toggleStarForge', function_owner = self, label = 'Toggle StarForge', position = { 0.0, 0.45, 0.4 }, width = 2600, height = 360, font_size = 240, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'initiate', function_owner = self, label = 'Back', position = { 0.3, 0.45, 0.7 }, width = 1800, height = 520, font_size = 240, scale = { 0.15, 0.15, 0.15 } })
end

function toggleTokenSize()
    local tokenSize = Global.call("API_GetTokenSize", {}) or 1
    tokenSize = tokenSize + 1
    if tokenSize > 3 then
        tokenSize = 1
    end
    Global.call("API_SetTokenSize", { size = tokenSize })
    configuration()
end

function toggleAnnouncement(obj, player_color, alt_click)
    Global.call("API_ToggleAnnouncmentVisibility", { player = player_color })
    configuration()
end

function toggleStarForge()
    starforge = getObjectFromGUID("5500bc")
    local hidden = starforge.getVar("hidden")
    showStarForge = not showStarForge
    if hidden then
        starforge.call("show", {})
    else
        starforge.call("hide", {})
    end
    configuration()
end

--Spawn from XWS
function xwsStart()
    self.clearButtons()
    self.createButton({ click_function = 'DummyFFG', function_owner = self, label = 'Paste XWS', position = { 0, 0.45, -0.3 }, width = 1800, height = 520, font_size = 240, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'xwsClick', function_owner = self, label = 'Spawn Ships', position = { -0.3, 0.45, 0.6 }, width = 1800, height = 520, font_size = 240, scale = { 0.15, 0.15, 0.15 } })
    self.createButton({ click_function = 'xwsSave', function_owner = self, label = 'Spawn as Disk', position = { 0.3, 0.45, 0.6 }, width = 1800, height = 520, font_size = 240, scale = { 0.15, 0.15, 0.15 } })
    self.createInput({ input_function = 'xwsAction', function_owner = self, position = { 0, 0.45, 0.2 }, width = 1000, height = 500, font_size = 50, scale = { 0.5, 0.5, 0.5 } })
    self.createButton({ click_function = 'initiate', function_owner = self, label = 'Back', position = { -0.5, 0.45, 0.8 }, width = 1000, height = 300, font_size = 150, scale = { 0.21, 0.21, 0.21 } })
end

--XWS spawner input field
function xwsAction(obj, playerColor, value, editing)
    if not editing then
        lista = value
    else
        nl_index = string.find(value, '\n')
        if nl_index ~= nil then
            lista = string.sub(value, 1, nl_index - 1)
            xwsLoad(playerColor)
        end
    end
end

--XWS spawner button
function xwsClick(obj, playerColor, alt_click)
    savingList = false
    xwsLoad(playerColor)
end

--XWS spawner disk button
function xwsSave(obj, playerColor, alt_click)
    savingList = true
    xwsLoad(playerColor)
end

function xwsLoad(playerColor)
    if lista ~= nil then
        local list = JSON.decode(lista)
        xwsSpawn(list, playerColor)
    else
        print('Please paste XWS')
    end
end

function loadPoints(ruleset)
    if VERSION_DATA.ruleset == ruleset then
        return
    end
    VERSION_DATA = {
        pilots = {},
        upgrades = {},
        ruleset = ruleset
    }
    loadVersion(ruleset)
end

function loadVersion(ruleset)
    WebRequest.get('https://raw.githubusercontent.com/eirikmun/xwing-points/main/points-version.json',
        function(request)
            if request.is_error then
                print("Failed to load X-Wing points manifest.")
            elseif request.is_done then
                loadVersionData(ruleset, json.parse(request.text))
            end
        end)
end

function loadVersionData(ruleset, point_versions)
    if point_versions[ruleset] then
        WebRequest.get(
            'https://raw.githubusercontent.com/eirikmun/xwing-points/main/' .. point_versions[ruleset].location,
            function(request)
                if request.is_error then
                    print("Failed to load X-Wing points data for " .. ruleset .. " points version")
                elseif request.is_done then
                    loadVersionRevisions(ruleset, json.parse(request.text))
                end
            end)
    else
        print("Data for " .. ruleset .. " is not available")
    end
end

function loadVersionRevisions(ruleset, version_revisions)
    if version_revisions.current_revision then
        WebRequest.get(
            'https://raw.githubusercontent.com/eirikmun/xwing-points/main/' .. version_revisions.current_revision,
            function(request)
                if request.is_error then
                    print("Failed to load X-Wing points data for " .. ruleset .. " points version")
                elseif request.is_done then
                    loadVersionRevision(ruleset, json.parse(request.text))
                end
            end)
    else
        print("Current revision for " + ruleset + " is not available")
    end
end

function loadVersionRevision(ruleset, version_revision)
    for file, path in pairs(version_revision.files) do
        URL = 'https://raw.githubusercontent.com/eirikmun/xwing-points/main/' .. path
        WebRequest.get('https://raw.githubusercontent.com/eirikmun/xwing-points/main/' .. path,
            function(request)
                if request.is_error then
                    print("Failed to " .. file .. " points data for " .. ruleset .. " points version")
                elseif request.is_done then
                    if file == "upgrades" then
                        loadUpgrades(ruleset, json.parse(request.text))
                    else
                        loadPilots(ruleset, json.parse(request.text))
                    end
                end
            end)
    end
end

function normalizePointsValue(cost)
    if type(cost) == "table" then
        return tonumber(cost.value)
    end
    return tonumber(cost)
end

function loadUpgrades(ruleset, upgrades)
    for upgrade_xws_id, upgrade in pairs(upgrades) do
        local cost = normalizePointsValue(upgrade.cost)
        if cost ~= nil then
            upgrade.cost = cost
            VERSION_DATA.upgrades[upgrade_xws_id] = upgrade
        end
    end
end

function loadPilots(ruleset, ships)
    for ship_xws_id, ship in pairs(ships) do
        for pilot_xws_id, pilot in pairs(ship) do
            local cost = normalizePointsValue(pilot.cost)
            if cost ~= nil then
                pilot.cost = cost
                VERSION_DATA.pilots[pilot_xws_id] = pilot
            end
        end
    end
end

function findByXws(table, xws_id)
    if table[xws_id] ~= nil then
        return xws_id
    end
    return nil
end

function validatePilotId(pilot_xws_id)
    local valid = (type(pilot_xws_id) == 'string') and (masterPilotDB[pilot_xws_id] ~= nil)
    if not valid then
        local message = 'Invalid pilot id key: ' .. tostring(pilot_xws_id)
        if printToAll ~= nil then
            printToAll(message, { 1, 0, 0 })
        else
            print(message)
        end
    end
    return valid
end

function validatePilotIds(idTable)
    for _, pilot_xws_id in pairs(idTable.Pilots or {}) do
        if not validatePilotId(pilot_xws_id) then
            return false
        end
    end
    return true
end

function validateFaction(faction)
    if validFactions[faction] ~= true and (factions == nil or factions[faction] ~= true) then
        local message = 'Invalid faction key: ' .. tostring(faction)
        if printToAll ~= nil then
            printToAll(message, { 1, 0, 0 })
        else
            print(message)
        end
        return false
    end
    return true
end

function listToFormat(ruleset, version, vendor)
    if version and string.find(version, '2.0.') then
        return "2.0-legacy"
    else
        return "2.5"
    end
end

factions =
{
    rebelalliance = true,
    galacticempire = true,
    scumandvillainy = true,
    resistance = true,
    firstorder = true,
    galacticrepublic = true,
    separatistalliance = true
}

--Takes the XWS JSON and the xws <-> FFG ID map and constructs a parts list to pass to idSpawner
function xwsSpawn(list, playerColor)
    if list then
        local parts = {}
        parts.Pilots = {}
        parts.Upgrades = {}
        parts.spawnCard = self
        parts.Faction = list.faction
        if not validateFaction(parts.Faction) then
            return
        end
        parts.Obstacles = {}
        parts.Format = listToFormat(list.ruleset, list.version, list.vendor)

        for k, pilot in pairs(list.pilots) do
            local pilot_xws_id = findByXws(masterPilotDB, pilot.id)
            if pilot_xws_id == nil then
                printToAll("Unable to find pilot with xws value: " .. pilot.id, { 1, 0, 0 })
                break;
            end
            parts.Pilots[k] = pilot_xws_id
            parts.Upgrades[k] = {}

            if pilot.upgrades then
                local upgradeCount = 1
                for slot, upgrades in pairs(pilot.upgrades) do
                    for i, upgrade_xws_id in pairs(upgrades) do
                        if masterUpgradesDB[upgrade_xws_id] == nil then
                            printToAll("Unable to find upgrade with xws value: " .. upgrade_xws_id, { 1, 0, 0 })
                            break;
                        end
                        parts.Upgrades[k][upgradeCount] = upgrade_xws_id
                        upgradeCount = upgradeCount + 1
                    end
                end
            end
        end

        if list.obstacles then
            for i, obstacle in ipairs(list.obstacles) do
                if obstacleNames[obstacle] then
                    table.insert(parts.Obstacles, obstacleNames[obstacle])
                else
                    printToAll("Unable to find obstacle: " .. obstacle .. " please check correct spelling", { 1, 0, 0 })
                end
            end
        end

        idSpawner(parts)

        local player  = Player[playerColor]
        local message = player.steam_name .. " spawned a list"

        if list.name then
            message = message .. " \"" .. list.name .. "\""
        end

        if list.points then
            message = message .. ". The list reports " .. list.points .. " points"
        end

        print(message .. ".");

        initiate()
    else
        print('Please paste XWS')
    end
end

--TTS spawner input field
function action(obj, playerColor, value, editing)
    if not editing then
        lista = value
    else
        nl_index = string.find(value, '\n')
        if nl_index ~= nil then
            lista = string.sub(value, 1, nl_index - 1)
            validCheck()
        end
    end
end

-- Single Spawner input field
function action3(obj, playerColor, value, editing)
    if not editing then
        single = value
    else
        nl_index = string.find(value, '\n')
        if nl_index ~= nil then
            single = string.sub(value, 1, nl_index - 1)
            singleSearch()
        end
    end
end

extraAssets = {
    damage_decks = {
        label = "Damage Decks",
        items = {
            rebel = { label = "Rebel", tag = "rebeldamagedeck" },
            empire = { label = "Empire", tag = "empiredamagedeck" },
            scum = { label = "Scum", tag = "scumdamagedeck" },
            resistance = { label = "Resistance", tag = "resistancedamagedeck" },
            firstorder = { label = "First Order", tag = "firstorderdamagedeck" },
            republic = { label = "Republic", tag = "republicdamagedeck" },
            separatists = { label = "Separatists", tag = "separatistsdamagedeck" }
        }
    },
    man_cards = {
        label = "Manoeuvre Cards",
        items = {
            rebel = { label = "Rebel", tag = "rebelmancards" },
            empire = { label = "Empire", tag = "empiremancards" },
            scum = { label = "Scum", tag = "scummancards" },
            resistance = { label = "Resistance", tag = "resistancemancards" },
            firstorder = { label = "First Order", tag = "firstordermancards" },
            republic = { label = "Republic", tag = "republicmancards" },
            separatists = { label = "Separatists", tag = "separatistsmancards" },
            generic = { label = "Generic", tag = "mancard" },
        }
    },
    coop_assets = {
        label = "HotAC/FGA",
        items = {
            { label = "Transport Freighter", tag = "transportfreighter" },
            { label = "AI Squad Wing Tool",  tag = "formationtool" },
        }
    },
}

extraAssetsGUID = "a3690e"

function assetSpawn()
    self.clearInputs()
    self.clearButtons()

    self.createButton({ click_function = 'Dummy1', function_owner = self, label = 'Asset Spawning', position = { 0, 0.45, -0.3 }, width = 1800, height = 520, font_size = 240, scale = { 0.25, 0.25, 0.25 } })

    i = 0
    for category, elements in pairs(extraAssets) do
        local position = vector(-0.45 + (i % 2) * 0.9, 0.45, math.floor(i / 2) * 0.20)
        self.setVar("assetCategory_" .. category, function() self.call("assetCategory", { category = category }) end)
        self.createButton({
            click_function = "assetCategory_" .. category,
            function_owner = self,
            label = elements.label,
            position = position,
            width = 1500,
            height = 280,
            font_size = 200,
            scale = { 0.25, 0.25, 0.25 }
        })
        i = i + 1
    end

    self.createButton({ click_function = 'initiate', function_owner = self, label = 'Back', position = { 0.7, 0.45, 0.8 }, width = 1000, height = 300, font_size = 150, scale = { 0.21, 0.21, 0.21 } })
end

function assetCategory(args)
    self.clearInputs()
    self.clearButtons()

    self.createButton({ click_function = 'Dummy1', function_owner = self, label = extraAssets[args.category].label, position = { 0, 0.45, -0.3 }, width = 1800, height = 520, font_size = 240, scale = { 0.25, 0.25, 0.25 } })

    i = 0
    for key, asset in pairs(extraAssets[args.category].items) do
        local position = vector(-0.45 + (i % 2) * 0.9, 0.45, math.floor(i / 2) * 0.20)
        self.setVar("spawnAssetItem_" .. key, function() self.call("spawnAssetItem", { tag = asset.tag }) end)

        local font_size = 200
        if asset.label:len() > 15 then
            font_size = font_size * 0.8
        end
        self.createButton({
            click_function = 'spawnAssetItem_' .. key,
            function_owner = self,
            label = asset.label,
            position = position,
            width = 1500,
            height = 280,
            font_size = font_size,
            scale = { 0.25, 0.25, 0.25 }
        })
        i = i + 1
    end

    self.createButton({ click_function = 'initiate', function_owner = self, label = 'Back', position = { 0.7, 0.45, 0.8 }, width = 1000, height = 300, font_size = 150, scale = { 0.21, 0.21, 0.21 } })
end

function spawnAssetItem(args)
    local asset_bag = getObjectFromGUID(extraAssetsGUID)
    if asset_bag then
        for _, containedObject in ipairs(asset_bag.getObjects()) do
            if containedObject.gm_notes == args.tag then
                local addRot = Vector(180, 180, 0)
                if containedObject.gm_notes == 'transportfreighter' or containedObject.gm_notes == 'formationtool' then
                    addRot = Vector(0, 0, 0)
                end
                asset = asset_bag.takeObject({
                    index = containedObject.index,
                    position = self.getPosition() + Vector(10, 2, 0),
                    rotation = self.getRotation() + addRot,
                })
                assetClone = asset.clone()
                asset_bag.putObject(assetClone)
                break
            end
        end
    end
    initiate()
end

-- Single Spawner: Receives a string, then goes across all card names and spawns that card with its appropriate components.
function singleSpawner()
    if VERSION_DATA.ruleset == "none" then
        masterPilotDB = xwaMasterPilotDB
        masterUpgradesDB = xwaMasterUpgradesDB
        loadPoints("XWA")
    end

    self.clearInputs()
    self.clearButtons()
    self.createButton({ click_function = 'DummyFFG', function_owner = self, label = 'Type a card name', position = { 0, 0.45, -0.37 }, width = 1800, height = 280, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'singleSearch', function_owner = self, label = 'Search', position = { 0.45, 0.45, -0.17 }, width = 1200, height = 320, font_size = 200, scale = { 0.15, 0.15, 0.15 } })
    self.createInput({ input_function = 'action3', function_owner = self, position = { -0.3, 0.45, -0.17 }, width = 1800, height = 200, font_size = 160, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'initiate', function_owner = self, label = 'Back', position = { 0.7, 0.45, 0.8 }, width = 1000, height = 300, font_size = 150, scale = { 0.21, 0.21, 0.21 } })
    self.createButton({ click_function = 'DummyFFG', function_owner = self, label = 'Pilots', position = { -0.45, 0.45, -0.025 }, width = 1000, height = 280, font_size = 200, scale = { 0.20, 0.20, 0.20 } })
    self.createButton({ click_function = 'DummyFFG', function_owner = self, label = 'Upgrades', position = { 0.45, 0.45, -0.025 }, width = 1000, height = 280, font_size = 200, scale = { 0.20, 0.20, 0.20 } })
end

function singleSearch()
    savingList = false
    self.clearButtons()
    self.clearInputs()
    singleSpawner()
    butPilCount = 0
    butPilData = {}
    butUpCount = 0
    butUpData = {}
    if single ~= nil then
        for pilot_xws_id, pilot in pairs(masterPilotDB) do
            if string.find(string.lower(pilot.name), string.lower(single), 1, true) then
                if butPilCount < 7 then
                    butPilCount = butPilCount + 1
                    local title = ''
                    if pilot.title ~= nil then
                        title = ' - ' .. pilot.title
                    end
                    self.createButton({
                        click_function = 'singlePil' .. butPilCount,
                        function_owner = self,
                        label = pilot
                            .name .. title .. ' (' .. masterShipDB[pilot.ship_type].name .. ')',
                        position = { -0.45, 0.45, 0 + butPilCount * 0.09 },
                        width = 2800,
                        height = 230,
                        font_size = 120,
                        scale = { 0.15, 0.15, 0.15 }
                    })
                    butPilData[butPilCount] = pilot_xws_id
                end
            end
        end
        for upgrade_xws_id, upgrade in pairs(masterUpgradesDB) do
            if string.find(string.lower(upgrade.name), string.lower(single), 1, true) then
                if butUpCount < 7 then
                    butUpCount = butUpCount + 1

                    local title = ''
                    if upgrade.title ~= nil then
                        title = ' - ' .. upgrade.title
                    end
                    local upName = upgrade.name .. title
                    if ffgSpecial[upgrade_xws_id] ~= nil then
                        upName = upName .. title .. ' (' .. ffgSpecial[upgrade_xws_id] .. ')'
                    end

                    butUpData[butUpCount] = upgrade_xws_id
                    self.createButton({ click_function = 'singleUp' .. butUpCount, function_owner = self, label = upName, position = { 0.45, 0.45, 0 + butUpCount * 0.09 }, width = 2800, height = 230, font_size = 120, scale = { 0.15, 0.15, 0.15 } })
                end
            end
        end
    else
        print('Please type a card name')
    end
    single = nil
end

function singlePil1()
    local pilotPick = butPilData[1]
    singlePilotSpawn(pilotPick)
end

function singlePil2()
    local pilotPick = butPilData[2]
    singlePilotSpawn(pilotPick)
end

function singlePil3()
    local pilotPick = butPilData[3]
    singlePilotSpawn(pilotPick)
end

function singlePil4()
    local pilotPick = butPilData[4]
    singlePilotSpawn(pilotPick)
end

function singlePil5()
    local pilotPick = butPilData[5]
    singlePilotSpawn(pilotPick)
end

function singlePil6()
    local pilotPick = butPilData[6]
    singlePilotSpawn(pilotPick)
end

function singlePil7()
    local pilotPick = butPilData[7]
    singlePilotSpawn(pilotPick)
end

function singleUp1()
    local upPick = butUpData[1]
    singleUpSpawn(upPick)
end

function singleUp2()
    local upPick = butUpData[2]
    singleUpSpawn(upPick)
end

function singleUp3()
    local upPick = butUpData[3]
    singleUpSpawn(upPick)
end

function singleUp4()
    local upPick = butUpData[4]
    singleUpSpawn(upPick)
end

function singleUp5()
    local upPick = butUpData[5]
    singleUpSpawn(upPick)
end

function singleUp6()
    local upPick = butUpData[6]
    singleUpSpawn(upPick)
end

function singleUp7()
    local upPick = butUpData[7]
    singleUpSpawn(upPick)
end

function singlePilotSpawn(Id)
    if not validatePilotId(Id) then
        return
    end
    partList = {}
    partList.spawnCard = self
    partList.Pilots = {}
    partList.Pilots[1] = Id
    partList.Upgrades = {}
    partList.Upgrades[1] = {}
    partList.Faction = masterPilotDB[Id].faction
    partList.Format = "2.5"
    if VERSION_DATA.ruleset == "X2PO" then
        partList.Format = "2.0-legacy"
    end
    idSpawner(partList)
    singleSpawner()
end

function singleUpSpawn(upId)
    partList = {}
    partList.spawnCard = self
    partList.Pilots = {}
    partList.Pilots[1] = ''
    partList.Upgrades = {}
    partList.Upgrades[1] = {}
    partList.Upgrades[1][1] = upId
    partList.Faction = 'dummy'
    partList.Format = "2.5"
    if VERSION_DATA.ruleset == "X2PO" then
        partList.Format = "2.0-legacy"
    end
    idSpawner(partList)
    singleSpawner()
end

--[[
   id table should look like this:
   idTable.Pilots = {[1]=id1, [2]=id2}
   idTable.Upgrades = {[1] = {[1]=upId1, [2]=upId2},
                       [2]={[1]=upId3, [2]=upId3}}
   idTable.Faction = masterPilotDB[id1].faction
]]

dialSkin = {
    rebelalliance = 'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/dial/skin/1/Rebel.png',
    galacticempire = 'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/dial/skin/1/Empire.png',
    scumandvillainy = 'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/dial/skin/1/Scum.png',
    resistance = 'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/dial/skin/1/Resistance.png',
    firstorder = 'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/dial/skin/1/FO.png',
    galacticrepublic = 'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/dial/skin/1/Republic.png',
    separatistalliance = 'http://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/dial/skin/1/CIS.png',
}

function calculateShipIndicators(idTable)
    if not validatePilotIds(idTable) then
        return {}
    end
    shipTable = {}
    for k, pilot_xws_id in pairs(idTable.Pilots) do
        local ship = masterPilotDB[pilot_xws_id].ship_type
        if shipTable[ship] == nil then
            shipTable[ship] = { k }
        else
            table.insert(shipTable[ship], k)
        end
    end
    pilotIndicators = {}
    local i = 1
    for ship, pilots in pairs(shipTable) do
        if #pilots > 1 then
            for k, pilot in pairs(pilots) do
                pilotIndicators[pilot] = i
                i = i + 1
            end
        else
            pilotIndicators[pilots[1]] = 0
        end
    end
    return pilotIndicators
end

function idSpawner(idTable)
    if not validatePilotIds(idTable) then
        return
    end
    spawnedPilotList = {}
    fList = {}
    fList.SqdExecOptions = {}
    fList.Pilots = {}
    fList.Upgrades = {}
    fList.Remotes = {}
    fList.Obstacles = idTable.Obstacles
    fList.Customization = {}
    if idTable.Faction == nil then
        fList.Faction = masterPilotDB[idTable.Pilots[1]].faction
    else
        fList.Faction = idTable.Faction
    end
    if not validateFaction(fList.Faction) then
        return
    end
    fList.factionDial = dialSkin[fList.Faction]
    fList.sqdAction = {}
    local Format = idTable.Format or "2.5"
    local repo = "eirikmun"
    if Format == "2.0-legacy" then
        repo = "SogeMoge"
    end
    pilotIndicators = calculateShipIndicators(idTable)
    for k, pilot_xws_id in pairs(idTable.Pilots) do
        --print(tostring(k) .. " " .. pilot_xws_id  )
        local pilotName = masterPilotDB[pilot_xws_id].name
        spawnedPilotList[pilotName] = spawnedPilotList[pilotName] or 0
        spawnedPilotList[pilotName] = spawnedPilotList[pilotName] + 1
        if spawnedPilotList[pilotName] > 1 then
            pilotName = pilotName .. ' ' .. tostring(spawnedPilotList[pilotName])
        end
        fList.Pilots[k] = {}
        fList.Pilots[k].id = pilot_xws_id
        fList.Pilots[k].name = pilotName
        local cost = 50
        if VERSION_DATA.pilots[pilot_xws_id] then
            cost = VERSION_DATA.pilots[pilot_xws_id].cost
        end
        fList.Pilots[k].cost = cost
        fList.Customization[pilotName] = masterPilotDB[pilot_xws_id].customization or {}
        fList.Customization[pilotName].tint = tintColors[pilotIndicators[k]]
        if (masterPilotDB[pilot_xws_id].tint_friendly ~= nil) and (pilotIndicators[k] > 0) then
            fList.Customization[pilotName].modeltint = tintColors[pilotIndicators[k]]
            fList.Customization[pilotName].texture = masterPilotDB[pilot_xws_id].tint_friendly.texture
            fList.Customization[pilotName].model = masterPilotDB[pilot_xws_id].tint_friendly.mesh
        end
        --fList.Pilots[k].tint = tintColors[pilotIndicators[k]]
        --fList.Pilots[k].card = masterPilotDB[pilot_xws_id].card
        fList.Pilots[k].card = "{verifycache}https://raw.githubusercontent.com/" ..
            repo .. "/x-wing2.0-project-goldenrod/" ..
            Format .. "/src/images/En/pilots/" .. pilot_xws_id .. ".png"
        fList.Pilots[k].cardB = cardBackDB[fList.Faction]
        fList.Pilots[k].standardized_loadout = masterPilotDB[pilot_xws_id].standardized_loadout
        fList.Pilots[k].standardized_upgrades = masterPilotDB[pilot_xws_id].standardized_upgrades
        local Ship = masterPilotDB[pilot_xws_id].ship_type
        fList.Pilots[k].Ship = Ship
        fList.Pilots[k].peg = masterShipDB[Ship].peg
        fList.Pilots[k].Size = masterShipDB[Ship].size
        fList.Pilots[k].Shield = masterPilotDB[pilot_xws_id].shield or masterShipDB[Ship].shield
        fList.Pilots[k].Hull = masterShipDB[Ship].hull
        fList.Pilots[k].list = pilotName .. ' - ' .. masterShipDB[Ship].name .. '\n'
        fList.Pilots[k].newSpawner = masterShipDB[Ship].new_spawner or false
        fList.Pilots[k].bombD = 's1'
        fList.Pilots[k].Docking = masterShipDB[Ship].docking
        fList.Pilots[k].Data = {}
        fList.Pilots[k].Data.name = pilotName
        fList.Pilots[k].Data.xws = pilot_xws_id
        fList.Pilots[k].Data.mesh = masterPilotDB[pilot_xws_id].mesh or masterShipDB[Ship].mesh
        fList.Pilots[k].Data.texture = masterPilotDB[pilot_xws_id].texture
        fList.Pilots[k].Data.textures = masterShipDB[Ship].textures
        fList.Pilots[k].Data.limited = masterPilotDB[pilot_xws_id].limited
        fList.Pilots[k].Data.shipId = Ship
        fList.Pilots[k].Data.initiative = masterPilotDB[pilot_xws_id].initiative
        fList.Pilots[k].Data.moveSet = masterPilotDB[pilot_xws_id].move_set or masterShipDB[Ship].move_set
        fList.Pilots[k].Data.Config = masterShipDB[Ship].config
        fList.Pilots[k].Data.customization_parts = masterShipDB[Ship].customization_parts
        fList.Pilots[k].Data.mountingPoints = masterShipDB[Ship].mounting_points or { main = { 0, 0 } }

        if masterPilotDB[pilot_xws_id].arcs then
            fList.Pilots[k].Data.arcs = table.deepcopy(masterPilotDB[pilot_xws_id].arcs)
        else
            fList.Pilots[k].Data.arcs = table.deepcopy(masterShipDB[Ship].arcs)
        end
        fList.Pilots[k].Data.actSet = table.deepcopy(masterPilotDB[pilot_xws_id].action_set)
        fList.Pilots[k].Data.executeOptions = masterPilotDB[pilot_xws_id].execute_options or {}
        fList.Pilots[k].Data.movethrough = masterPilotDB[pilot_xws_id].movethrough or false
        fList.Pilots[k].Data.ProximityHider = masterShipDB[Ship].proximity_hider or false

        if masterPilotDB[pilot_xws_id].squad_execute_options ~= nil then
            table.insert(fList.SqdExecOptions, masterPilotDB[pilot_xws_id].squad_execute_options)
        end

        fList.Pilots[k].Data.Faction = fList.Faction
        fList.Pilots[k].Data.Size = fList.Pilots[k].Size
        if pilot_xws_id == 'emonazzameen' then        -- Emon Azzameen special drops
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':s3:tr3:te3'
        elseif pilot_xws_id == 'solsixxa' then        -- Sol Sixxa special drops
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':te1:be1:br1:tr1'
        elseif pilot_xws_id == 'scimitar3-battleoverendor' then -- Parting Gift upgrade special drop
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':s1r:br1r:bl1r'
        elseif pilot_xws_id == 'adonfox-battleoverendor' then   -- Adon Fox BoE (Parting Gift + sideways)
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':s1r:br1r:bl1r:be1:br1:ss1:ps1'
        elseif pilot_xws_id == 'constablezuvio' then  -- Constable Zuvio
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':s1r'
        elseif pilot_xws_id == 'bombardmentdrone' then -- Bombardment Drone
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':s1r'
        elseif pilot_xws_id == 'deathfire-swz98' then -- SL Deathfire
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':be3:br3:s3:s3r'
        elseif pilot_xws_id == 'finchdallow-evacuationofdqar' then
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':be1:br1:s2:be2:br2'
        elseif pilot_xws_id == 'vennie-evacuationofdqar' then -- Vennie sideways drops
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':ss1:ps1'
        elseif pilot_xws_id == 'captainjonus-swz98' then
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':s3r:be3r:br3r'
        elseif pilot_xws_id == 'braylenstramm-battleoverendor' or pilot_xws_id == 'ginamoonsong-battleoverendor' then -- BoE B-Wings sideways drops
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':ss1:ps1'
        end

        if Ship == 'tiesabomber' then -- TIE Bomber special drops
            fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':be1:br1'
        end

        if masterPilotDB[pilot_xws_id].bomb then
            fList.Pilots[k].Bomb = true
        end

        if masterPilotDB[pilot_xws_id].condition ~= nil then
            fList.Pilots[k].Condition = masterPilotDB[pilot_xws_id].condition
        end
        for K, V in pairs(masterPilotDB[pilot_xws_id].add_squad_action or {}) do
            table.insert(fList.sqdAction, V)
        end

        fList.Pilots[k].Charge = (masterShipDB[Ship].charge or 0) + (masterPilotDB[pilot_xws_id].charge or 0)
        fList.Pilots[k].Force = masterPilotDB[pilot_xws_id].force or 0
        fList.Pilots[k].Energy = masterShipDB[Ship].energy or 0
        fList.Upgrades[k] = {}
        local skilled_bombardier = false
        local loadout = 0
        for key, upgrade_xws_id in pairs(idTable.Upgrades[k]) do
            --print("Upg[" .. tostring(k) .. "] = ".. tostring(upgrade_xws_id))
            local name = masterUpgradesDB[upgrade_xws_id].name
            local upSlot = masterUpgradesDB[upgrade_xws_id].slot
            fList.Upgrades[k][key] = {}
            fList.Upgrades[k][key].name = name
            local cost = 50
            local xws_data = VERSION_DATA.upgrades[upgrade_xws_id]
            local resolved_cost = xws_data and normalizePointsValue(xws_data.cost)
            if resolved_cost ~= nil then
                cost = resolved_cost
            end
            fList.Pilots[k].list = fList.Pilots[k].list .. '   ' .. name .. ' (' .. tostring(cost) .. ')\n'
            loadout = loadout + cost

            --fList.Upgrades[k][key].card = masterUpgradesDB[upgrade_xws_id].card
            fList.Upgrades[k][key].card = "{verifycache}https://raw.githubusercontent.com/" ..
                repo .. "/x-wing2.0-project-goldenrod/" ..
                Format .. "/src/images/En/upgrades/" .. upgrade_xws_id .. ".png"
            if masterUpgradesDB[upgrade_xws_id].dual == true then
                fList.Upgrades[k][key].cardB = "{verifycache}https://raw.githubusercontent.com/" ..
                    repo .. "/x-wing2.0-project-goldenrod/" ..
                    Format .. "/src/images/En/upgrades/" .. upgrade_xws_id .. "-sideb.png"
            elseif masterUpgradesDB[upgrade_xws_id].card_back == nil then
                fList.Upgrades[k][key].cardB = cardBackDB[verifySlotName(upSlot)]
            else
                fList.Upgrades[k][key].cardB = masterUpgradesDB[upgrade_xws_id].card_back
            end
            for K, V in pairs(masterUpgradesDB[upgrade_xws_id].add_action or {}) do --Upgrades that adds an action to a ship
                table.insert(fList.Pilots[k].Data.actSet, V)
            end
            for K, V in pairs(masterUpgradesDB[upgrade_xws_id].add_squad_action or {}) do --upgrades that adds an action to the whole squad, sets up a list of actions that will be added later
                table.insert(fList.sqdAction, V)
            end

            if masterUpgradesDB[upgrade_xws_id].charge ~= nil then
                fList.Upgrades[k][key].Charge = masterUpgradesDB[upgrade_xws_id].charge
            else
                fList.Upgrades[k][key].Charge = 0
            end
            fList.Upgrades[k][key].extended_width = masterUpgradesDB[upgrade_xws_id].extended_width == true
            if masterUpgradesDB[upgrade_xws_id].arcs then
                if masterUpgradesDB[upgrade_xws_id].arcs.fixed then
                    fList.Pilots[k].Data.arcs.fixed = fList.Pilots[k].Data.arcs.fixed or { name = 'primary', type = {} }
                    if masterUpgradesDB[upgrade_xws_id].arcs.fixed.ion ~= nil then
                        fList.Pilots[k].Data.arcs.fixed.ion = fList.Pilots[k].Data.arcs.fixed.ion or
                            masterUpgradesDB[upgrade_xws_id].arcs.fixed.ion
                    end
                    for new_arc_idx, new_arc in pairs(masterUpgradesDB[upgrade_xws_id].arcs.fixed.type) do
                        local found = false
                        for arc_idx, arc in pairs(fList.Pilots[k].Data.arcs.fixed.type) do
                            -- check if new arc allready in arc list
                            if arc == new_arc then
                                found = true
                            end
                        end
                        if not found then
                            -- new arc, insert into list
                            table.insert(fList.Pilots[k].Data.arcs.fixed.type, new_arc)
                        end
                    end
                end
                if masterUpgradesDB[upgrade_xws_id].arcs.turret then
                    local mounting_point = nil
                    local found = false
                    fList.Pilots[k].Data.arcs.turret = fList.Pilots[k].Data.arcs.turret or {}
                    for mount, pos in pairs(fList.Pilots[k].Data.mountingPoints) do
                        -- Find next available mounting point
                        if not found and not fList.Pilots[k].Data.arcs.turret[mount] then
                            --print("Found mounting point " .. mount .. " for " .. masterUpgradesDB[upgrade_xws_id].arcs.turret.name )
                            mounting_point = mount
                            found = true
                        end
                    end
                    if found then
                        -- Add the turret to the available mounting point
                        fList.Pilots[k].Data.arcs.turret[mounting_point] = masterUpgradesDB[upgrade_xws_id].arcs.turret
                    end
                end
                if masterUpgradesDB[upgrade_xws_id].arcs.weapon and not fList.Pilots[k].standardized_loadout then
                    fList.Pilots[k].Data.arcs.weapon = fList.Pilots[k].Data.arcs.weapon or {}
                    local weapon_arc = table.deepcopy(masterUpgradesDB[upgrade_xws_id].arcs.weapon)
                    if weapon_arc.follow_turret == nil and masterShipDB[Ship].cannon_follow_turret then
                        weapon_arc.follow_turret = masterShipDB[Ship].cannon_follow_turret
                    end
                    table.insert(fList.Pilots[k].Data.arcs.weapon, weapon_arc)
                end
            end
            if masterUpgradesDB[upgrade_xws_id].force ~= nil then
                fList.Pilots[k].Force = fList.Pilots[k].Force + masterUpgradesDB[upgrade_xws_id].force
            end
            if masterUpgradesDB[upgrade_xws_id].shd ~= nil then
                fList.Pilots[k].Shield = fList.Pilots[k].Shield + masterUpgradesDB[upgrade_xws_id].shd
            end
            if masterUpgradesDB[upgrade_xws_id].energy ~= nil then
                fList.Pilots[k].Energy = fList.Pilots[k].Energy + masterUpgradesDB[upgrade_xws_id].energy
            end
            if masterUpgradesDB[upgrade_xws_id].hull ~= nil then
                fList.Pilots[k].Hull = fList.Pilots[k].Hull + masterUpgradesDB[upgrade_xws_id].hull
            end

            fList.Upgrades[k][key].Condition = masterUpgradesDB[upgrade_xws_id].condition or nil
            for i, r in pairs(masterUpgradesDB[upgrade_xws_id].remotes or {}) do
                table.insert(fList.Remotes, { name = r, Charge = masterUpgradesDB[upgrade_xws_id].remote_charge or 0 })
            end

            if masterUpgradesDB[upgrade_xws_id].bomb then
                fList.Pilots[k].Bomb = true
            elseif verifySlotName(upSlot) == 'Configuration' then
                fList.Upgrades[k][key].Config = true
            end
            if masterUpgradesDB[upgrade_xws_id].docking ~= nil then
                fList.Pilots[k].Docking = masterUpgradesDB[upgrade_xws_id].docking
            end
            fList.Pilots[k].Data.movethrough = masterUpgradesDB[upgrade_xws_id].movethrough or fList.Pilots[k].Data.movethrough
            if masterUpgradesDB[upgrade_xws_id].wingleader ~= nil then
                fList.Pilots[k].wingleader = masterUpgradesDB[upgrade_xws_id].wingleader
            end
            --print("Test value:".. tostring(upgrade_xws_id) .. " name:" .. masterUpgradesDB[upgrade_xws_id].name .. tostring(masterUpgradesDB[upgrade_xws_id].execute_options))
            if masterUpgradesDB[upgrade_xws_id].execute_options ~= nil then
                --print("Got upgrade execute options")
                local newexecuteoptions = masterUpgradesDB[upgrade_xws_id].execute_options(idTable, idTable.Pilots[k])
                --print("Test " .. masterUpgradesDB[upgrade_xws_id].name)
                combineExecuteOptions(fList.Pilots[k].Data.executeOptions, newexecuteoptions)
            end

            if masterUpgradesDB[upgrade_xws_id].squad_execute_options ~= nil then
                table.insert(fList.SqdExecOptions, masterUpgradesDB[upgrade_xws_id].squad_execute_options)
            end

            if upgrade_xws_id == 'skilledbombardier' then -- Skilled Bombardier special drops
                skilled_bombardier = true
                --fList.Pilots[k].bombD = fList.Pilots[k].bombD ..  ':s2:tr2:te2:be2:br2'
            elseif upgrade_xws_id == 'trajectorysimulator' then  -- Trajectory Simulator special drop
                fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':s5r'
            elseif upgrade_xws_id == 'electrochaffmissiles' then -- Electro-Chaff Missiles
                fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':s4r:be3r:br3r'
            elseif upgrade_xws_id == 'partinggift-legendsandrelics' then -- Parting Gift (Legends and Relics)
                fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':s1:br1:be1:be1r:s1r:br1r'
            elseif upgrade_xws_id == 'thermaldetonators' then    -- Thermal Detinators
                if Ship == 'tiesabomber' then           -- TIE Bomber special drops
                    fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':be2:s2:br2'
                else
                    fList.Pilots[k].bombD = fList.Pilots[k].bombD .. ':s2'
                end
            end
        end
        if skilled_bombardier then
            local bombD = fList.Pilots[k].bombD
            parts = mysplit(bombD, ':')
            for k, part in pairs(parts) do
                pre, speedstr, post = string.match(part, "(%a+)(%d)(%a*)")
                speed = tonumber(speedstr)
                if speed > 1 then
                    bombD = bombD .. ":" .. pre .. tostring(speed - 1) .. post
                end
                if (pre == 's' and (speed < 5)) or (speed < 3) then
                    bombD = bombD .. ":" .. pre .. tostring(speed + 1) .. post
                end
            end
            fList.Pilots[k].bombD = bombD
        end
        local list_summary = ''
        if Format == "2.0-legacy" then
            cost = cost + loadout
        elseif VERSION_DATA.pilots[pilot_xws_id] then
            list_summary = '\nLoadout: ' ..
                tostring(loadout) .. '/' .. tostring(VERSION_DATA.pilots[pilot_xws_id].loadout)
        end
        fList.Pilots[k].Data.points = cost
        fList.Pilots[k].Data.half_points = math.floor(cost / 2)
        fList.Pilots[k].list = fList.Pilots[k].list ..
            list_summary ..
            '\nShip Points: ' ..
            cost ..
            ' (' ..
            math.floor(cost / 2) .. ')\nHalf Damage: ' .. math.ceil((fList.Pilots[k].Shield + fList.Pilots[k].Hull) / 2)
    end
    for k, v in pairs(fList.sqdAction) do -- adds Squad actions coming from specific upgrades
        for K, V in pairs(fList.Pilots) do
            table.insert(V.Data.actSet, v)
        end
    end

    for _, sqExOpt in pairs(fList.SqdExecOptions) do
        for k, pilot in pairs(fList.Pilots) do
            local newexecuteoptions = sqExOpt(fList, fList.Pilots[k])
            combineExecuteOptions(pilot.Data.executeOptions, newexecuteoptions)
        end
    end
    fList.listCost = 0
    for k, v in pairs(fList.Pilots) do
        --print(v.list)
        fList.listCost = fList.listCost + v.cost
    end
    --print('Total List Cost = '.. fList.listCost)
    if savingList == true then
        saveToDisk(fList)
    else
        fList.spawnCard = self
        spawnNow(fList)
    end
end

cardLua = [[
self.createButton({
 click_function = 'spawnerCaller',
 function_owner = self,
 label          = 'Spawn',
 position       = {0,0.02,0.35},
 rotation       = {0,0,0},
 scale          = {0.1,0.1,0.1},
 width          = 2000,
 height         = 500,
 font_size      = 400,
 color          = 'Black',
 font_color     = 'White',
 tooltip        = 'Click here to spawn the saved list',
})

customizing = true

function spawnerCaller()
   spawnTable = self.getTable("List")
   spawnTable.spawnCard = self
   Global.call('newSpawner', spawnTable)
   spawnTable = nil
end

function onSave()
   if state == nil then
       local state = {cardData=self.getTable("List")}
       return JSON.encode(state)
   end
end

function onObjectDrop(player_color, dropped_object)
   if customizing then
       local relpos = self.positionToLocal(dropped_object.getPosition())
       local distance = math.sqrt(relpos[1]*relpos[1] + relpos[2]*relpos[2] + relpos[3]*relpos[3])
       if distance < 1 then
           if (dropped_object.tag == 'Figurine') and (dropped_object.getVar("__XW_Ship") == true) then
               printToAll(self.getName() .. " gets the customization of " .. dropped_object.getName(), color(1.0,0.5,0.0))
               local customobj = dropped_object.getCustomObject()
               customization = List.Customization[dropped_object.getName()] or {}
               customization.model = customobj.mesh
               customization.texture = customobj.diffuse
               customization.modeltint = dropped_object.getColorTint()
               local shipfound = false
               for i, attachment in pairs(dropped_object.getAttachments()) do
                   if attachment.name == "Ship" then
                     id = dropped_object.removeAttachment(attachment.index)
                     customization.texture = id.getCustomObject().diffuse
                     customization.modeltint = id.getColorTint()
                     dropped_object.addAttachment(id)
                     shipfound = true
                   end
               end
               if not shipfound then -- Is probably a ship without base mesh
                 for i, attachment in pairs(dropped_object.getAttachments()) do
                     if attachment.name == "Config" then
                       id = dropped_object.removeAttachment(attachment.index)
                       customization.texture = id.getCustomObject().diffuse
                       customization.modeltint = id.getColorTint()
                       dropped_object.addAttachment(id)
                       break
                     end
                 end
               end

               for i, attachment in pairs(dropped_object.getAttachments()) do
                   if attachment.name == "ColorId" then
                     id = dropped_object.removeAttachment(attachment.index)
                     customization.tint = id.getColorTint(tint)
                     dropped_object.addAttachment(id)
                   end
               end
               List.Customization[dropped_object.getName()] = customization
           elseif dropped_object.tag == 'Card' then
             printToAll(self.getName() .. " gets the customization of " .. dropped_object.getName() .." card", color(1.0,0.5,0.0))
              customization = List.Customization[dropped_object.getName()] or {}
              customization.face = dropped_object.getCustomObject().face
              customization.back = dropped_object.getCustomObject().back
              List.Customization[dropped_object.getName()] = customization
           end
       end
   end
end

-- Restore self state
function onLoad(savedData)
   --print("OnLoad: ".. self.getName() .. " " .. savedData)
   if savedData ~= "" then
       self.setTable("List", JSON.decode(savedData).cardData)
   end
end
]]

function saveToDisk(finalList)
    print('Saving to Disk')
    local accBag = getObjectFromGUID('53ad3d') -- Accessories bag
    local accList = accBag.getObjects()
    for k, v in pairs(accBag.getObjects()) do
        if v.name == 'Data Card' then
            dataDisk = accBag.takeObject({
                position = { -66, 1, -15 },
                rotation = { 0, 90, 0 },
                scale = { 3.75, 3.75, 3.75 },
                guid = v.guid
            })
            dataDiskClone = dataDisk.clone()
            accBag.putObject(dataDiskClone)
            dataDisk.setTable("List", finalList)
            dataDisk.setName("New Disk")
            dataDisk.setLuaScript(cardLua)
            print("Done")
        end
    end
    initiate()
end

-- Builder first step: sets up basic list table and select faction.
function builderStart()
    self.clearButtons()
    partList = {}
    partList.Pilots = {}
    --partList.Upgrades = {}
    partList.nameCounts = {}
    partList.spawnCard = self
    availablePilots = {}
    availableUps = {}
    shipSlots = {}
    currentIndex = nil
    totalCost = nil
    self.createButton({ click_function = 'Dummy1', function_owner = self, label = 'Choose Faction', position = { 0, 0.45, -0.3 }, width = 1800, height = 520, font_size = 240, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'buiReb', function_owner = self, label = 'Rebel', position = { -0.6, 0.45, 0.1 }, width = 1000, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'buiImp', function_owner = self, label = 'Imperial', position = { -0.6, 0.45, 0.4 }, width = 1000, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'buiScu', function_owner = self, label = 'Scum', position = { -0.6, 0.45, 0.7 }, width = 1000, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'buiRes', function_owner = self, label = 'Resistance', position = { 0, 0.45, 0.1 }, width = 1000, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'buiFor', function_owner = self, label = 'First Order', position = { 0, 0.45, 0.4 }, width = 1000, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'initiate', function_owner = self, label = 'Back', position = { 0.55, 0.45, 0.75 }, width = 900, height = 320, font_size = 150, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'buiRep', function_owner = self, label = 'Republic', position = { 0.6, 0.45, 0.1 }, width = 1000, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'buiCis', function_owner = self, label = 'CIS', position = { 0.6, 0.45, 0.4 }, width = 1000, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
end

-- One function for each faction, forwards to main menu.
function buiReb()
    partList.Faction = 'rebelalliance'
    mainMenu()
end

function buiImp()
    partList.Faction = 'galacticempire'
    mainMenu()
end

function buiScu()
    partList.Faction = 'scumandvillainy'
    mainMenu()
end

function buiRes()
    partList.Faction = 'resistance'
    mainMenu()
end

function buiFor()
    partList.Faction = 'firstorder'
    mainMenu()
end

function buiRep()
    partList.Faction = 'galacticrepublic'
    mainMenu()
end

function buiCis()
    partList.Faction = 'separatistalliance'
    mainMenu()
end

function initialSetUp()

end

-- Main Menu: shows wich ship is on the list, indicates how many points is dedicated to each ship.
-- Offers 3 options: reset (Back to initiate), add ship and spawn.
function mainMenu()
    totalCost = {}
    self.clearButtons()
    self.createButton({ click_function = 'addShip', function_owner = self, label = 'Add Ship', position = { -0.45, 0.45, -0.3 }, width = 1300, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'builderSpawn', function_owner = self, label = 'Spawn List', position = { 0.45, 0.45, -0.3 }, width = 1300, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    for i, pilot in pairs(partList.Pilots) do
        local cost = pilot.cost
        local loadout = 0
        for k, upgrade in pairs(pilot.upgrades) do
            loadout = loadout + upgrade.cost
            cost = cost + upgrade.point_modifier
        end
        local row = (i - 1) % 5
        local col = math.floor((i - 1) / 5)
        self.createButton({
            click_function = 'selectShip' .. i,
            function_owner = self,
            label = pilot.name ..
                ' (' .. cost .. ')',
            position = { -0.6 + col * 0.6, 0.45, -0.05 + row * 0.15 },
            width = 1100,
            height = 300,
            font_size = 100,
            scale = { 0.25, 0.25, 0.25 }
        })
        totalCost[i] = cost
    end
    listCost = 0
    for i, cost in pairs(totalCost) do
        listCost = listCost + cost
    end
    self.createButton({ click_function = 'Dummy1', function_owner = self, label = 'List cost: ' .. listCost, position = { 0.4, 0.45, 0.8 }, width = 1300, height = 320, font_size = 150, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'initiate', function_owner = self, label = 'RESET', position = { -0.5, 0.45, 0.8 }, width = 1300, height = 320, font_size = 150, scale = { 0.25, 0.25, 0.25 } })
end

-- Adding a ship will open a list of all available ship types.
function addShip()
    self.clearButtons()

    local modelIndex = 1
    local aux = 1
    local auxB = 0
    availableShips = {}
    for i, shipModel in pairs(masterShipDB) do
        for k, fac in pairs(shipModel.factions) do
            if k == partList.Faction then
                Font = 100
                availableShips[modelIndex] = i
                local row = ((modelIndex - 1) % 8) + 1
                local column = math.floor((modelIndex - 1) / 8)
                if string.len(i) > 18 then
                    Font = 80
                end
                self.createButton({
                    click_function = 'selectModel' .. modelIndex,
                    function_owner = self,
                    label =
                        shipModel.name,
                    position = { -0.54 + column * 0.6, 0.45, row * 0.16 - 0.5 },
                    width = 1000,
                    height = 220,
                    font_size =
                        Font,
                    scale = { 0.25, 0.25, 0.25 }
                })
                modelIndex = modelIndex + 1
            end
        end
    end
end

function selectModelGeneric(arg)
    chosenModel = availableShips[arg]
    availableShips = {}
    self.clearButtons()
    availablePilots = {}

    local aux = 0
    local auxB = 0
    local index = 1
    for pilot_xws_id, pilot in pairs(masterPilotDB) do
        if pilot.ship_type == chosenModel then
            local validOption = true
            if pilot.limited ~= nil then
                if pilot.limited <= (partList.nameCounts[pilot.name] or 0) then
                    validOption = false
                end
            end
            if validOption and pilot.faction == partList.Faction then
                local cost = pilot.cost or 50
                local loadout = 0
                if VERSION_DATA.pilots[pilot_xws_id] then
                    cost = VERSION_DATA.pilots[pilot_xws_id].cost
                    loadout = VERSION_DATA.pilots[pilot_xws_id].loadout
                end
                availablePilots[index] = { id = pilot_xws_id, name = pilot.name, cost = cost, loadout = loadout, keywords = {}, upgrades = {} }
                for _, keyword in pairs(masterShipDB[chosenModel].keywords or {}) do
                    table.insert(availablePilots[index].keywords, keyword)
                end
                local title = ''
                if pilot.title ~= nil then
                    title = '\n' .. pilot.title
                end
                self.createButton({
                    click_function = 'setPilot' .. index,
                    function_owner = self,
                    label = pilot.name ..
                        title .. ' (' .. cost .. ')',
                    position = { -0.615 + auxB * 0.65, 0.45, aux * 0.13 - 0.4 },
                    width = 1200,
                    height = 220,
                    font_size = 90,
                    scale = { 0.25, 0.25, 0.25 }
                })


                aux = aux + 1
                if aux > 9 then
                    aux = 0
                    auxB = auxB + 1
                end
                index = index + 1
            end
        end
    end
    chosenModel = nil
    if index == 1 then
        addShip()
    end
end

--selecting a ship type will open a list of every pilot for that ship. MUST REWRITE! 18 ship types, with more to come. Each option should set a variable and call an unified function to spawn the pilot buttons!
function selectModel1()
    selectModelGeneric(1)
end

function selectModel2()
    selectModelGeneric(2)
end

function selectModel3()
    selectModelGeneric(3)
end

function selectModel4()
    selectModelGeneric(4)
end

function selectModel5()
    selectModelGeneric(5)
end

function selectModel6()
    selectModelGeneric(6)
end

function selectModel7()
    selectModelGeneric(7)
end

function selectModel8()
    selectModelGeneric(8)
end

function selectModel9()
    selectModelGeneric(9)
end

function selectModel10()
    selectModelGeneric(10)
end

function selectModel11()
    selectModelGeneric(11)
end

function selectModel12()
    selectModelGeneric(12)
end

function selectModel13()
    selectModelGeneric(13)
end

function selectModel14()
    selectModelGeneric(14)
end

function selectModel15()
    selectModelGeneric(15)
end

function selectModel16()
    selectModelGeneric(16)
end

function selectModel17()
    selectModelGeneric(17)
end

function selectModel18()
    selectModelGeneric(18)
end

function selectModel19()
    selectModelGeneric(19)
end

function selectModel20()
    selectModelGeneric(20)
end

function selectModel21()
    selectModelGeneric(21)
end

function selectModel22()
    selectModelGeneric(22)
end

function selectModel23()
    selectModelGeneric(23)
end

function selectModel24()
    selectModelGeneric(24)
end

function selectModel25()
    selectModelGeneric(25)
end

function selectModel26()
    selectModelGeneric(26)
end

function selectModel27()
    selectModelGeneric(27)
end

-- Selecting a pilot will add ship model and pilot to part list, update max index and go back to main menu. MUST REWRITE! Each pilot option should set variables and call an unified function to set up the part list!
function setPilotGeneric(arg)
    self.clearButtons()
    local name = availablePilots[arg].name
    partList.nameCounts[name] = (partList.nameCounts[name] or 0) + 1
    table.insert(partList.Pilots, availablePilots[arg])
    shipIndex = #partList.Pilots
    for _, keyword in pairs(masterPilotDB[availablePilots[arg].id].keywords or {}) do
        table.insert(partList.Pilots[shipIndex].keywords, keyword)
    end
    availablePilots = nil
    mainMenu()
end

function setPilot1()
    setPilotGeneric(1)
end

function setPilot2()
    setPilotGeneric(2)
end

function setPilot3()
    setPilotGeneric(3)
end

function setPilot4()
    setPilotGeneric(4)
end

function setPilot5()
    setPilotGeneric(5)
end

function setPilot6()
    setPilotGeneric(6)
end

function setPilot7()
    setPilotGeneric(7)
end

function setPilot8()
    setPilotGeneric(8)
end

function setPilot9()
    setPilotGeneric(9)
end

function setPilot10()
    setPilotGeneric(10)
end

function setPilot11()
    setPilotGeneric(11)
end

function setPilot12()
    setPilotGeneric(12)
end

function setPilot13()
    setPilotGeneric(13)
end

function setPilot14()
    setPilotGeneric(14)
end

function setPilot15()
    setPilotGeneric(15)
end

function setPilot16()
    setPilotGeneric(16)
end

function setPilot17()
    setPilotGeneric(17)
end

function setPilot18()
    setPilotGeneric(18)
end

function setPilot19()
    setPilotGeneric(19)
end

function setPilot20()
    setPilotGeneric(20)
end

function setPilot21()
    setPilotGeneric(21)
end

function setPilot22()
    setPilotGeneric(22)
end

function setPilot23()
    setPilotGeneric(23)
end

function setPilot24()
    setPilotGeneric(24)
end

function setPilot25()
    setPilotGeneric(25)
end

function setPilot26()
    setPilotGeneric(26)
end

function setPilot27()
    setPilotGeneric(27)
end

function setPilot28()
    setPilotGeneric(28)
end

function setPilot29()
    setPilotGeneric(29)
end

function setPilot30()
    setPilotGeneric(30)
end

function setPilot31()
    setPilotGeneric(31)
end

function setPilot32()
    setPilotGeneric(32)
end

data_pad_spawn_area = {
    origin = Vector(-64.00, 0.0, -30.00),
    direction = Vector(0, 0, 1),
    type = 3,
    size = Vector(14, 10, 5),
    orientation = Vector(0, 0, 0),
    max_distance = 45,
    debug = false
}

function relocateSpawned(args, player_color, alt_click)
    hasSpawned = false
    if args and player_color == nil and type(args.getName) ~= "function" then
        player_color = args[2] -- the test script can't pass multiple args, so we need to get it from the args
    end
    printToAll("Relocating pieces for player " .. tostring(player_color), player_color or Color.Pink)

    local playerArea = PlayerArea:new(Player[player_color])
    local seq = Sequence:new(true)

    -- seq:addTask(builderSpawn)
    -- seq:waitFrames(120)
    seq:physicsCast(data_pad_spawn_area, function(obj)
        return obj.locked == false and obj.interactable == true
    end)
    seq:waitCondition(function()
        playerArea:translate(seq.result:getObjects())
    end, function()
        return seq.result:allAtRest()
    end)

    seq:start()
end

function builderSpawn()
    hasSpawned = true
    finalList = {}
    finalList.Pilots = {}
    finalList.Upgrades = {}
    for i, pilot in pairs(partList.Pilots) do
        finalList.Pilots[i] = pilot.id
        finalList.Upgrades[i] = {}
        for j, upgrade in pairs(pilot.upgrades) do
            table.insert(finalList.Upgrades[i], upgrade.id)
        end
    end
    finalList.Faction = partList.Faction
    finalList.spawnCard = partList.spawnCard

    finalList.Format = "2.5"
    if VERSION_DATA.ruleset == "X2PO" then
        finalList.Format = "2.0-legacy"
    end
    idSpawner(finalList)
end

-- Selecting a ship that is on the main menu will show wich slots are empty and wich ones are taken, indicating how many points are being used on this ship and how many points the list as a whole is using.
-- To Do: Set up auxiliary table with slots and upgrades so the correct buttons are spawned. Stablishes variables for special cases (Froce Powers, dual slots). Show point costs of each ship and full squad.
function selectShipGeneric(arg)
    self.clearButtons()
    shipIndex = arg
    local pilot_id = partList.Pilots[shipIndex].id
    local pilot = masterPilotDB[pilot_id]
    local free_slots = {}
    local loadout_value = 0
    local cost = 50
    -- print("Slots for " .. pilot.name)
    free_slots['Command'] = 1
    if VERSION_DATA.pilots[pilot_id] then
        loadout_value = VERSION_DATA.pilots[pilot_id].loadout
        cost = VERSION_DATA.pilots[pilot_id].cost
        for _, slot in pairs(VERSION_DATA.pilots[pilot_id].slots) do
            slot = verifySlotName(slot)
            free_slots[slot] = (free_slots[slot] or 0) + 1
            --   print(i .. ":" .. slot  )
        end
    end
    for _, slot_id in pairs(pilot.add_slots or {}) do
        local slot = verifySlotName(slot_id)
        free_slots[slot] = (free_slots[slot] or 0) + 1
    end

    local loadout_cost = 0

    slot_buttons = {}
    -- Alter free slots depending on equipped upgrades
    for i, upgrade in pairs(partList.Pilots[shipIndex].upgrades) do
        --print("Upgrade " .. tostring(upgrade.name))
        local upgrade_entry = masterUpgradesDB[upgrade.id]
        table.insert(slot_buttons, { slot_name = verifySlotName(upgrade_entry.slot), upgrade = upgrade })
        loadout_cost = loadout_cost + upgrade.cost
        loadout_value = loadout_value + upgrade.loadout_modifier
        cost = cost + upgrade.point_modifier
        for _, slot_id in pairs(upgrade_entry.add_slots or {}) do
            local slot = verifySlotName(slot_id)
            free_slots[slot] = (free_slots[slot] or 0) + 1
        end
        for _, slot_id in pairs(upgrade_entry.remove_slots or {}) do
            local slot = verifySlotName(slot_id)
            free_slots[slot] = (free_slots[slot] or 0) - 1
        end
        local slot = verifySlotName(upgrade_entry.slot)
        free_slots[slot] = (free_slots[slot] or 0) - 1
    end

    for slot, num in pairs(free_slots) do
        for k = 1, num, 1 do
            --print("Free slot: " .. slot)
            table.insert(slot_buttons, { slot_name = slot, upgrade = nil })
        end
    end

    for i, slot in pairs(slot_buttons) do
        row = ((i - 1) % 5) + 1
        column = math.floor((i - 1) / 5)
        if slot.upgrade == nil then
            self.createButton({ click_function = 'selectSlot' .. i, function_owner = self, label = slot.slot_name, position = { -0.4 + column * 0.8, 0.45, -0.22 + row * 0.15 }, width = 1500, height = 300, font_size = 120, scale = { 0.25, 0.25, 0.25 } })
        else
            self.createButton({
                click_function = 'selectSlot' .. i,
                function_owner = self,
                label = slot.upgrade.name ..
                    ' (' .. slot.upgrade.cost .. ')',
                position = { -0.4 + column * 0.8, 0.45, -0.22 + row * 0.15 },
                width = 1500,
                height = 300,
                font_size = 120,
                scale = { 0.25, 0.25, 0.25 }
            })
        end
    end


    self.createButton({
        click_function = 'Dummy',
        function_owner = self,
        label = partList.Pilots[shipIndex].name ..
            ' (' .. cost .. ')',
        position = { -0.3, 0.45, -0.35 },
        width = 2000,
        height = 320,
        font_size = 150,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({ click_function = 'mainMenu', function_owner = self, label = 'Back', position = { 0.5, 0.45, -0.35 }, width = 1000, height = 320, font_size = 150, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'removeShip', function_owner = self, label = 'Remove Ship', position = { 0.6, 0.45, 0.75 }, width = 1000, height = 320, font_size = 150, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({
        click_function = 'Dummy',
        function_owner = self,
        label = 'Loadout: ' ..
            tostring(loadout_cost) .. '/' .. tostring(loadout_value),
        position = { -0.6, 0.45, 0.8 },
        width = 1000,
        height = 220,
        font_size = 150,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({ click_function = 'Dummy', function_owner = self, label = 'List cost: ' .. listCost, position = { 0, 0.45, 0.8 }, width = 1000, height = 220, font_size = 150, scale = { 0.25, 0.25, 0.25 } })
end

function removeShip()
    partList.Pilots[shipIndex] = nil
    partList.Upgrades[shipIndex] = nil
    totalCost[shipIndex] = nil
    for i, index in pairs(partList.Pilots) do
        if i > shipIndex then
            partList.Pilots[i - 1] = partList.Pilots[i]
            partList.Pilots[i] = nil
            partList.Upgrades[i - 1] = partList.Upgrades[i]
            partList.Upgrades[i] = nil
            totalCost[i - 1] = totalCost[i]
            totalCost[i] = nil
        end
    end
    mainMenu()
end

function selectShip1()
    selectShipGeneric(1)
end

function selectShip2()
    selectShipGeneric(2)
end

function selectShip3()
    selectShipGeneric(3)
end

function selectShip4()
    selectShipGeneric(4)
end

function selectShip5()
    selectShipGeneric(5)
end

function selectShip6()
    selectShipGeneric(6)
end

function selectShip7()
    selectShipGeneric(7)
end

function selectShip8()
    selectShipGeneric(8)
end

function selectShip9()
    selectShipGeneric(9)
end

function selectShip10()
    selectShipGeneric(10)
end

function selectShip11()
    selectShipGeneric(11)
end

function selectShip12()
    selectShipGeneric(12)
end

function selectShip13()
    selectShipGeneric(13)
end

function selectShip14()
    selectShipGeneric(14)
end

function selectShip15()
    selectShipGeneric(15)
end

function selectShip16()
    selectShipGeneric(16)
end

function selectShip17()
    selectShipGeneric(17)
end

function selectShip18()
    selectShipGeneric(18)
end

function selectShip19()
    selectShipGeneric(19)
end

function selectShip20()
    selectShipGeneric(20)
end

function selectSlotGeneric(slotIndex)
    self.clearButtons()

    if slot_buttons[slotIndex].upgrade then
        for i, upgrade in pairs(partList.Pilots[shipIndex].upgrades) do
            if upgrade.id == slot_buttons[slotIndex].upgrade.id then
                partList.nameCounts[upgrade.name] = (partList.nameCounts[upgrade.name] or 1) - 1
                table.remove(partList.Pilots[shipIndex].upgrades, i)
                break
            end
        end
    end

    local loadout_value = partList.Pilots[shipIndex].loadout
    local loadout_cost = 0
    for i, upgrade in pairs(partList.Pilots[shipIndex].upgrades) do
        loadout_cost = loadout_cost + upgrade.cost
        loadout_value = loadout_value + upgrade.loadout_modifier
    end
    local loadout_remaining = loadout_value - loadout_cost

    slotId = verifySlotName(slot_buttons[slotIndex].slot_name)
    --slotId = partList.Upgrades[shipIndex][slotIndex].slot             -- Value tied for this function!
    currSlotInd = slotIndex
    local index = 1
    local row = 1
    local column = 0
    self.createButton({ click_function = 'selectUpNone', label = 'None (0)', function_owner = self, position = { -0.45, 0.45, -0.2 }, width = 1500, height = 220, font_size = 120, scale = { 0.25, 0.25, 0.25 } })
    for upgrade_xws_id, up in pairs(masterUpgradesDB) do
        local up_cost = up.cost or 50
        if VERSION_DATA.upgrades[upgrade_xws_id] then
            up_cost = normalizePointsValue(VERSION_DATA.upgrades[upgrade_xws_id].cost) or up_cost
        end
        if verifySlotName(up.slot) == slotId then
            local validUp = true
            if up_cost > loadout_remaining then
                validUp = false
            end
            if up.restriction ~= nil then
                if up.restriction.faction ~= nil then
                    if up.restriction.faction[partList.Faction] ~= true then
                        validUp = false
                    end
                end
                if up.restriction.size ~= nil then
                    if up.restriction.size[masterShipDB[masterPilotDB[partList.Pilots[shipIndex].id].ship_type].size] ~= true then
                        validUp = false
                    end
                end
                if up.restriction.ship ~= nil then
                    if up.restriction.ship[masterPilotDB[partList.Pilots[shipIndex].id].ship_type] ~= true then
                        validUp = false
                    end
                end
                if up.restriction.initiative_greater_than ~= nil then
                    if masterPilotDB[partList.Pilots[shipIndex].id].initiative <= up.restriction.initiative_greater_than then
                        validUp = false
                    end
                end
                if up.restriction.is_limited ~= nil then
                    if up.restriction.is_limited ~= ((masterPilotDB[partList.Pilots[shipIndex].id].limited or 0) > 0) then
                        validUp = false
                    end
                end
                if up.restriction.has_force ~= nil then
                    if up.restriction.has_force ~= ((masterPilotDB[partList.Pilots[shipIndex].id].force or 0) > 0) then
                        validUp = false
                    end
                end
                if up.restriction.keywords ~= nil then
                    for _, restrictedkeyword in pairs(up.restriction.keywords) do
                        local found = false
                        for _, keyword in pairs(partList.Pilots[shipIndex].keywords) do
                            if restrictedkeyword == keyword then
                                found = true
                                break
                            end
                        end
                        if not found then
                            validUp = false
                            break
                        end
                    end
                end
            end
            if up.limited ~= nil then
                if up.limited <= (partList.nameCounts[up.name] or 0) then
                    validUp = false
                end
            end
            if validUp == true then
                local title = ''
                if up.title ~= nil then
                    title = '\n' .. up.title
                end
                availableUps[index] = {
                    id = upgrade_xws_id,
                    name = up.name,
                    cost = up_cost,
                    loadout_modifier = up.loadout_modifier,
                    point_modifier =
                        up.point_modifier
                }
                self.createButton({
                    click_function = 'selectUp' .. index,
                    label = up.name .. title .. ' (' ..
                        up_cost .. ')',
                    function_owner = self,
                    position = { -0.53 + column * 0.58, 0.45, row * 0.1 - 0.1 },
                    width = 1100,
                    height = 200,
                    font_size = 100,
                    scale = { 0.25, 0.25, 0.25 }
                })
                row = row + 1
                index = index + 1
                if row > 9 then
                    row = 1
                    column = column + 1
                end
            end
        elseif slotId == 'Weapon Hardpoint' then
            local hpCheck = { Cannon = true, Torpedo = true, Missile = true }
            if hpCheck[verifySlotName(up.slot)] == true then
                availableUps[index] = {
                    id = upgrade_xws_id,
                    name = up.name,
                    cost = up_cost,
                    loadout_modifier = up.loadout_modifier,
                    point_modifier =
                        up.point_modifier
                }
                self.createButton({
                    click_function = 'selectUp' .. index,
                    label = up.name .. ' (' .. up_cost .. ')',
                    function_owner =
                        self,
                    position = { -0.53 + column * 0.58, 0.45, row * 0.1 - 0.1 },
                    width = 1100,
                    height = 200,
                    font_size = 100,
                    scale = { 0.25, 0.25, 0.25 }
                })
                row = row + 1
                index = index + 1
                if row > 9 then
                    row = 1
                    column = column + 1
                end
            end
        end
    end
    self.createButton({ click_function = 'backFromSelectUp', function_owner = self, label = 'Back', position = { 0.5, 0.45, -0.35 }, width = 1000, height = 320, font_size = 150, scale = { 0.25, 0.25, 0.25 } })
end

function backFromSelectUp()
    selectShipGeneric(shipIndex)
end

function selectSlot1()
    selectSlotGeneric(1)
end

function selectSlot2()
    selectSlotGeneric(2)
end

function selectSlot3()
    selectSlotGeneric(3)
end

function selectSlot4()
    selectSlotGeneric(4)
end

function selectSlot5()
    selectSlotGeneric(5)
end

function selectSlot6()
    selectSlotGeneric(6)
end

function selectSlot6()
    selectSlotGeneric(6)
end

function selectSlot7()
    selectSlotGeneric(7)
end

function selectSlot8()
    selectSlotGeneric(8)
end

function selectSlot9()
    selectSlotGeneric(9)
end

function selectSlot10()
    selectSlotGeneric(10)
end

function selectSlot11()
    selectSlotGeneric(11)
end

function selectSlot12()
    selectSlotGeneric(12)
end

function selectSlot13()
    selectSlotGeneric(13)
end

function selectSlot14()
    selectSlotGeneric(14)
end

function selectSlot14()
    selectSlotGeneric(14)
end

function selectSlot15()
    selectSlotGeneric(15)
end

function selectSlot16()
    selectSlotGeneric(16)
end

function selectSlot17()
    selectSlotGeneric(17)
end

function selectSlot18()
    selectSlotGeneric(18)
end

function selectSlot19()
    selectSlotGeneric(19)
end

function selectSlot99()
    selectSlotGeneric(99)
end

function selectUpNone()
    selectShipGeneric(shipIndex)
end

function selectUpGeneric(arg)
    table.insert(partList.Pilots[shipIndex].upgrades,
        { id = availableUps[arg].id, name = availableUps[arg].name, cost = availableUps[arg].cost, loadout_modifier = (availableUps[arg].loadout_modifier or 0), point_modifier = (availableUps[arg].point_modifier or 0) })
    local name = availableUps[arg].name
    partList.nameCounts[name] = (partList.nameCounts[name] or 0) + 1
    selectShipGeneric(shipIndex)
end

function selectUp1()
    selectUpGeneric(1)
end

function selectUp2()
    selectUpGeneric(2)
end

function selectUp3()
    selectUpGeneric(3)
end

function selectUp4()
    selectUpGeneric(4)
end

function selectUp5()
    selectUpGeneric(5)
end

function selectUp6()
    selectUpGeneric(6)
end

function selectUp7()
    selectUpGeneric(7)
end

function selectUp8()
    selectUpGeneric(8)
end

function selectUp9()
    selectUpGeneric(9)
end

function selectUp10()
    selectUpGeneric(10)
end

function selectUp11()
    selectUpGeneric(11)
end

function selectUp12()
    selectUpGeneric(12)
end

function selectUp13()
    selectUpGeneric(13)
end

function selectUp14()
    selectUpGeneric(14)
end

function selectUp15()
    selectUpGeneric(15)
end

function selectUp16()
    selectUpGeneric(16)
end

function selectUp17()
    selectUpGeneric(17)
end

function selectUp18()
    selectUpGeneric(18)
end

function selectUp19()
    selectUpGeneric(19)
end

function selectUp20()
    selectUpGeneric(20)
end

function selectUp21()
    selectUpGeneric(21)
end

function selectUp22()
    selectUpGeneric(22)
end

function selectUp23()
    selectUpGeneric(23)
end

function selectUp24()
    selectUpGeneric(24)
end

function selectUp25()
    selectUpGeneric(25)
end

function selectUp26()
    selectUpGeneric(26)
end

function selectUp27()
    selectUpGeneric(27)
end

function selectUp28()
    selectUpGeneric(28)
end

-- List Spawner starts here
-- First step: Create the table that ultimately will be provided to newSpawner. Then, inquires player wich faction his list belongs to.
function spawnerStart()
    self.clearButtons()
    finalList = {}
    finalList.Pilots = {}
    finalList.Upgrades = {}
    finalList.Faction = 'dummy'
    finalList.Aux = {}
    finalList.AuxU = {}
    finalList.spawnCard = self
    self.createButton({ click_function = 'Dummy1', function_owner = self, label = 'Choose Faction', position = { 0, 0.45, -0.3 }, width = 1800, height = 520, font_size = 240, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'Reb', function_owner = self, label = 'Rebel', position = { -0.4, 0.45, 0 }, width = 1200, height = 280, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'Imp', function_owner = self, label = 'Imperial', position = { -0.4, 0.45, 0.2 }, width = 1200, height = 280, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'Rep', function_owner = self, label = 'Republic', position = { -0.4, 0.45, 0.4 }, width = 1200, height = 280, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'Res', function_owner = self, label = 'Resistance', position = { 0.4, 0.45, 0 }, width = 1200, height = 280, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'For', function_owner = self, label = 'First Order', position = { 0.4, 0.45, 0.2 }, width = 1200, height = 280, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'CIS', function_owner = self, label = 'CIS', position = { 0.4, 0.45, 0.4 }, width = 1200, height = 280, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'Scu', function_owner = self, label = 'Scum', position = { -0.4, 0.45, 0.6 }, width = 1200, height = 280, font_size = 200, scale = { 0.25, 0.25, 0.25 } })


    self.createButton({ click_function = 'initiate', function_owner = self, label = 'Back', position = { 0.55, 0.45, 0.75 }, width = 900, height = 320, font_size = 180, scale = { 0.25, 0.25, 0.25 } })
end

--Set up faction in the table
function Reb()
    finalList.Faction = 'rebelalliance'
    inputList()
end

function Imp()
    finalList.Faction = 'galacticempire'
    inputList()
end

function Scu()
    finalList.Faction = 'scumandvillainy'
    inputList()
end

function Res()
    finalList.Faction = 'resistance'
    inputList()
end

function For()
    finalList.Faction = 'firstorder'
    inputList()
end

function Rep()
    finalList.Faction = 'galacticrepublic'
    inputList()
end

function CIS()
    finalList.Faction = 'separatistalliance'
    inputList()
end

-- Dummy functions for label buttons
function Dummy()
end

function Dummy1()
    print('Please pick a faction')
end

function Dummy2()
    print('Please choose a ship for this pilot:')
end

function Dummy3()
    print('Please type or paste your list. Refer to the manual if help is needed formating the list!')
end

function Dummy4()
    print('Please choose a slot for this upgrade card:')
end

-- Second step: Create the input field where the list should be pasted/typed. Offers a button to spawn the list and a button to save to a data disk (FEATURE NOT IMPLEMENTED YET)
function inputList()
    savingList = false
    self.clearButtons()
    self.createButton({
        click_function = 'Dummy3',
        function_owner = self,
        label = 'Please type or paste your list',
        position = { -0, 0.45, -0.4 },
        width = 2500,
        height = 280,
        font_size = 200,
        scale = { 0.4, 0.4, 0.4 },
        tooltip =
        'Click here to spawn yout list',
        scale = { 0.25, 0.25, 0.25 }
    })
    --self.createButton({click_function = 'printInput', function_owner = self, label = 'print', position = {-0.5,0.45,-1}, width = 800, height = 240, font_size = 100, scale = {0.4,0.4,0.4}, tooltip = 'Click here to spawn yout list',  scale = {0.25,0.25,0.25}})
    self.createInput({ input_function = 'action', function_owner = self, position = { 0, 0.45, 0.12 }, width = 3200, height = 1600, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({
        click_function = 'validCheck',
        function_owner = self,
        label = 'Spawn Ships',
        position = { -0.5, 0.45, 0.7 },
        width = 1400,
        height = 400,
        font_size = 200,
        scale = { 0.4, 0.4, 0.4 },
        tooltip =
        'Click here to spawn yout list',
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({
        click_function = 'saveList',
        function_owner = self,
        label = 'Spawn as Disk',
        position = { 0.5, 0.45, 0.7 },
        width = 1400,
        height = 400,
        font_size = 200,
        scale = { 0.4, 0.4, 0.4 },
        tooltip =
        'Click here to save your list in a data disk',
        scale = { 0.25, 0.25, 0.25 }
    })
end

--[[ This function is supposed to store the list in the script of the
    data disk object and set up a button wich will spawn the stored list
    calling the list parser and providing the string.
]]
--[[ The disk can be saved in the TTS chest for easy retrieval. Could
it be set up in a way to store and spawn several lists?
]]

function saveList()
    print('Saving List')
    savingList = true
    validCheck()
end

-- print function to test the input
function printInput()
    print(lista)
    lista = string.gsub(lista, 'v2', '')
    print(lista)
end

-- Checks if the input is a valid string. If it is, call the list parser. If not, returns to the input list.
function validCheck()
    if lista == '' then
        Dummy3()
        inputList()
    else
        parseList()
    end
end

pilotsWithDash = {}
pilotsWithDash["g4r-gor v"] = true
pilotsWithDash["g4r-g0r v"] = true

alternateSpelling = {}
alternateSpelling["0-66"] = 'O-66'
alternateSpelling["g4r-gor v/m"] = 'G4R-G0R V/M'
alternateSpelling["integrated s-foils (closed)"] = 'Integrated S-foils'
alternateSpelling["servomotor s-foils (closed)"] = 'Servomotor S-foils'
alternateSpelling["stabilized s-foils (open)"] = 'Stabilized S-foils'
alternateSpelling["landing struts (closed)"] = 'Landing Struts'
alternateSpelling["grappling struts (closed)"] = 'Grappling Struts'
alternateSpelling["vectored cannons"] = 'Vectored Cannons (RZ-1)'



obstacleNames = {
    coreasteroid0 = "Asteroid 6",
    coreasteroid1 = "Asteroid 3",
    coreasteroid2 = "Asteroid 5",
    coreasteroid3 = "Asteroid 4",
    coreasteroid4 = "Asteroid 2",
    coreasteroid5 = "Asteroid 1",
    yt2400debris0 = "Debrisfield 6",
    yt2400debris1 = "Debrisfield 5",
    yt2400debris2 = "Debrisfield 1",
    vt49decimatordebris0 = "Debrisfield 4",
    vt49decimatordebris1 = "Debrisfield 2",
    vt49decimatordebris2 = "Debrisfield 3",
    core2asteroid0 = "TFA Asteroid 4",
    core2asteroid1 = "TFA Asteroid 5",
    core2asteroid2 = "TFA Asteroid 6",
    core2asteroid3 = "TFA Asteroid 3",
    core2asteroid4 = "TFA Asteroid 1",
    core2asteroid5 = "TFA Asteroid 2",
    gascloud1 = "Gas Cloud 3",
    gascloud2 = "Gas Cloud 2",
    gascloud3 = "Gas Cloud 1",
    gascloud4 = "Gas Cloud 6",
    gascloud5 = "Gas Cloud 4",
    gascloud6 = "Gas Cloud 5",
    pomasteroid1 = "POM Asteroid 1",
    pomasteroid2 = "POM Asteroid 2",
    pomasteroid3 = "POM Asteroid 3",
    pomdebris1 = "POM Debris Cloud 1",
    pomdebris2 = "POM Debris Cloud 2",
    pomdebris3 = "POM Debris Cloud 3",
}

-- Third Step: This function will decompose the input string and will propperly alocate each value on the propper position in the table.
-- Then, it calls for the next function, either inquiring for ships and version of upgrades or calling the spawner.
function parseList()
    self.clearButtons()
    self.clearInputs()
    if lista ~= nil then
        parsedList = {}
        splitlist = mysplit(lista, '|', true)
        ships = splitlist[1]
        obstacles = splitlist[2]
        finalList.Obstacles = {}
        finalList.Format = "2.5"
        if VERSION_DATA.ruleset == "X2PO" then
            finalList.Format = "2.0-legacy"
        end
        if obstacles ~= nil then
            obstacleList = mysplit(obstacles, '/', true)
            for i, obstacle in ipairs(obstacleList) do
                if obstacleNames[obstacle] ~= nil then
                    table.insert(finalList.Obstacles, obstacleNames[obstacle])
                else
                    printToAll("Unable to find obstacle: " .. obstacle .. " please check correct spelling", { 1, 0, 0 })
                end
            end
        end

        pilotsList = mysplit(ships, '/', true)
        local rest = ""
        for i, pilot in ipairs(pilotsList) do
            pilot = rest .. pilot
            if pilotsWithDash[string.lower(pilot)] ~= nil then
                rest = pilot .. "/"
            else
                table.insert(parsedList, mysplit(pilot, '+', true))
                rest = ""
            end
        end
        pilotIndex = 0
        Aux = 0
        for i, pilot in ipairs(parsedList) do
            pilotIndex = pilotIndex + 1
            for k, cardN in ipairs(pilot) do
                cardN = string.gsub(cardN, 'Hardpoint: ', '')
                if alternateSpelling[string.lower(cardN)] ~= nil then
                    cardN = alternateSpelling[string.lower(cardN)]
                end
                if k == 1 then -- First card, the pilot
                    finalList.Aux[pilotIndex] = {}
                    finalList.AuxU[pilotIndex] = {}
                    local found = false
                    for pilot_xws_id, pilot in pairs(masterPilotDB) do
                        if (string.lower(pilot.name) == string.lower(cardN)) and (pilot.faction == finalList.Faction) then
                            Aux = Aux + 1
                            finalList.Aux[pilotIndex][Aux] = pilot_xws_id
                            finalList.Upgrades[pilotIndex] = {}
                            found = true
                        end
                    end
                    if not found then
                        printToAll("Unable to find pilot: " .. cardN .. " please check correct spelling", { 1, 0, 0 })
                        pilotIndex = pilotIndex - 1
                        break
                    end
                    if Aux == 1 then
                        finalList.Pilots[pilotIndex] = finalList.Aux[pilotIndex][1]
                        finalList.Aux[pilotIndex] = nil
                    end
                    Aux = 0
                else -- The remaining cards, the upgrades
                    finalList.AuxU[pilotIndex][k] = {}
                    local found = false
                    local restricted = false
                    for upgrade_xws_id, upg in pairs(masterUpgradesDB) do
                        if string.lower(upg.name) == string.lower(cardN) then
                            if (upg.restriction == nil) or (upg.restriction.faction == nil) or (upg.restriction.faction[finalList.Faction] == true) then
                                Aux = Aux + 1
                                finalList.AuxU[pilotIndex][k][Aux] = upgrade_xws_id
                                found = true
                            else
                                restricted = true
                            end
                        end
                    end
                    if not found then
                        if restricted then
                            printToAll('Upgrade "' .. cardN .. '" is restricted to another faction', { 1, 0, 0 })
                        else
                            printToAll("Unable to find upgrade: " .. cardN .. " please check correct spelling",
                                { 1, 0, 0 })
                        end
                        goto continue
                        finalList.Upgrades[pilotIndex][k - 1] = nil
                    end
                    if Aux == 1 then
                        finalList.Upgrades[pilotIndex][k - 1] = finalList.AuxU[pilotIndex][k][Aux]
                        finalList.AuxU[pilotIndex][k] = nil
                    end
                    ::continue::
                    Aux = 0
                end -- if Pilot and upgrade
            end     -- for card
        end
        pChecker()
    else
        Dummy3()
        initiate()
    end
end

-- Fourth step: This function checks for pilots with the same name in the same
-- faction and stores de data por future inquire. If no inquire is needed, it
-- calls the newSpawner function and reset all buttons.
function pChecker()
    repPN = 0
    for i, pilot in pairs(finalList.Aux) do
        currPIndex = i
        repPL = {}
        for k, v in pairs(pilot) do
            repPL[k] = v
            repPN = repPN + 1
        end
        pilot = nil
    end
    if repPN ~= 0 then
        pilotChoice(repPL)
    else
        uChecker()
    end
end

function uChecker()
    repUN = 0
    repUL = {}
    for pilot, s in pairs(finalList.AuxU) do
        repUL[pilot] = {}
        for slot, up in pairs(s) do
            currIndex = pilot
            currSlot = slot
            repUL[pilot][currSlot] = {}
            for k, v in pairs(up) do
                repUL[pilot][slot][k] = v
                repUN = repUN + 1
            end
        end
    end
    if repUN == 0 then
        repUL = nil
    end

    if repUN ~= 0 then
        upChoice(repUL)
    else
        idSpawner(finalList)
    end
end

-- luke skywalker+sense
-- luke skywalker + r2-d2
-- lando calrissian+han solo
-- sabine wren/luke skywalker + r2-d2
-- sabine wren/norra wexley+r2-d2
-- norra wexley+r2-d2/sabine wren
-- luke skywalker + r2-d2/sabine wren

-- Fifth Step: If pilots with several options of ships are present, for each pilot will create an inquire asking wich ship the pilot is in.
function pilotChoice(options)
    local name = (masterPilotDB[options[1]].name)
    self.clearButtons()
    self.createButton({
        click_function = 'Dummy2',
        function_owner = self,
        label =
        'Please choose a ship for the following pilot',
        position = { 0, 0.45, -0.4 },
        width = 3400,
        height = 380,
        font_size = 170,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({ click_function = 'Dummy2', function_owner = self, label = name, position = { 0, 0.45, -0.1 }, width = 1600, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })

    for i, option in pairs(options) do
        local name = masterPilotDB[option].name
        if masterPilotDB[option].title ~= nil then
            name = name .. ' - ' .. masterPilotDB[option].title .. '\n'
        end
        name = name .. ' (' .. masterShipDB[masterPilotDB[option].ship_type].name .. ')'
        self.createButton({ click_function = 'setShip' .. i, function_owner = self, label = name, position = { 0, 0.45, -0.1 + i * 0.2 }, width = 3000, height = 380, font_size = 160, scale = { 0.25, 0.25, 0.25 } })
    end
end

-- Stores the ship option for each pilot if needed. If there is no other inquire needed, will call upgrade inquire if need, if not, will call the newSpawner function.
function setShip1()
    finalList.Pilots[currPIndex] = repPL[1]
    finalList.Aux[currPIndex] = nil
    repPL = nil
    repPN = 0
    repUN = 0
    currPIndex = nil
    pChecker()
end

function setShip2()
    finalList.Pilots[currPIndex] = repPL[2]
    finalList.Aux[currPIndex] = nil
    repPL = nil
    repPN = 0
    repUN = 0
    currPIndex = nil
    pChecker()
end

function setShip3()
    finalList.Pilots[currPIndex] = repPL[3]
    finalList.Aux[currPIndex] = nil
    repPL = nil
    repPN = 0
    repUN = 0
    currPIndex = nil
    pChecker()
end

function setShip4()
    finalList.Pilots[currPIndex] = repPL[4]
    finalList.Aux[currPIndex] = nil
    repPL = nil
    repPN = 0
    repUN = 0
    currPIndex = nil
    pChecker()
end

function setShip5()
    finalList.Pilots[currPIndex] = repPL[5]
    finalList.Aux[currPIndex] = nil
    repPL = nil
    repPN = 0
    repUN = 0
    currPIndex = nil
    pChecker()
end

function setShip6()
    finalList.Pilots[currPIndex] = repPL[6]
    finalList.Aux[currPIndex] = nil
    repPL = nil
    repPN = 0
    repUN = 0
    currPIndex = nil
    pChecker()
end

function setShip7()
    finalList.Pilots[currPIndex] = repPL[7]
    finalList.Aux[currPIndex] = nil
    repPL = nil
    repPN = 0
    repUN = 0
    currPIndex = nil
    pChecker()
end

function setShip8()
    finalList.Pilots[currPIndex] = repPL[8]
    finalList.Aux[currPIndex] = nil
    repPL = nil
    repPN = 0
    repUN = 0
    currPIndex = nil
    pChecker()
end

validSlotNames = {
    Talent = true,
    Sensor = true,
    Cannon = true,
    Turret = true,
    Torpedo = true,
    Missile = true,
    Crew = true,
    Astromech = true,
    Payload = true,
    Illicit = true,
    Modification = true,
    Title = true,
    Gunner = true,
    ['Force Power'] = true,
    Configuration = true,
    Tech = true,
    Relay = true,
    Command = true,
    Cargo = true,
    Team = true,
    Hardpoint = true,
    Hyperdrive = true,
    ['Weapon Hardpoint'] = true
}

function verifySlotName(slot)
    if validSlotNames[slot] ~= true then
        local message = 'Invalid upgrade slot key: ' .. tostring(slot)
        if printToAll ~= nil then
            printToAll(message, { 1, 0, 0 })
        else
            print(message)
        end
    end
    return slot
end




-- Sixth Step: If Upgrades with several options in the same faction are present, for each upgrade will create an inquire asking wich slot the upgrade is in.
function upChoice(options)
    local name = (masterUpgradesDB[options[currIndex][currSlot][1]].name)
    local title1 = ''
    if masterUpgradesDB[options[currIndex][currSlot][1]].title then
        title1 = masterUpgradesDB[options[currIndex][currSlot][1]].title .. " - "
    end
    local Up1 = title1 .. verifySlotName(masterUpgradesDB[options[currIndex][currSlot][1]].slot)
    local title2 = ''
    if masterUpgradesDB[options[currIndex][currSlot][2]].title then
        title2 = masterUpgradesDB[options[currIndex][currSlot][2]].title .. " - "
    end
    local Up2 = title2 .. verifySlotName(masterUpgradesDB[options[currIndex][currSlot][2]].slot)
    self.clearButtons()
    self.createButton({
        click_function = 'Dummy4',
        function_owner = self,
        label =
        'Please choose a slot for the following upgrade',
        position = { 0, 0.45, -0.4 },
        width = 3400,
        height = 380,
        font_size = 170,
        scale = { 0.25, 0.25, 0.25 }
    })
    self.createButton({ click_function = 'Dummy4', function_owner = self, label = name, position = { 0, 0.45, -0.1 }, width = 1600, height = 380, font_size = 200, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'setUp1', function_owner = self, label = Up1, position = { 0, 0.45, 0.1 }, width = 1800, height = 380, font_size = 180, scale = { 0.25, 0.25, 0.25 } })
    self.createButton({ click_function = 'setUp2', function_owner = self, label = Up2, position = { 0, 0.45, 0.3 }, width = 1800, height = 380, font_size = 180, scale = { 0.25, 0.25, 0.25 } })
    if options == 3 then
        local Up3 = verifySlotName(masterUpgradesDB[options[currIndex][currSlot][3]].slot)
        self.createButton({ click_function = 'setUp3', function_owner = self, label = Up3, position = { 0, 0.45, 0.8 }, width = 1200, height = 380, font_size = 180, scale = { 0.25, 0.25, 0.25 } })
    end
end

function setUp1()
    finalList.Upgrades[currIndex][currSlot - 1] = finalList.AuxU[currIndex][currSlot][1]
    finalList.AuxU[currIndex][currSlot] = nil
    repUL = nil
    repUN = 0
    currSlot = nil
    currIndex = nil
    uChecker()
end

function setUp2()
    finalList.Upgrades[currIndex][currSlot - 1] = finalList.AuxU[currIndex][currSlot][2]
    finalList.AuxU[currIndex][currSlot] = nil
    repUL = nil
    repUN = 0
    currSlot = nil
    currIndex = nil
    uChecker()
end

function setUp3()
    finalList.Upgrades[currIndex][currSlot - 1] = finalList.AuxU[currIndex][currSlot][3]
    finalList.AuxU[currIndex][currSlot] = nil
    repUL = nil
    repUN = 0
    currSlot = nil
    currIndex = nil
    uChecker()
end

-- Calls the newSpawner, wich will set up a propper postition for the spawning ships (POSITION NEEDS TO BE REFERCENCED TO SELF, NOT GLOBAL)
function spawnNow(arg)
    storePos = self.getPosition()
    pos = LocalPos(self, { 3.5, 1, 4 })
    rot = self.getRotation()
    self.setPosition(pos)
    self.setRotation({ 0, rot.y, rot.z })
    Global.call('newSpawner', arg)
    self.setPosition(storePos)
    self.setRotation(rot)
    initiate()
end

-- String split function
function mysplit(inputstr, sep, trim)
    if inputstr ~= nil then
        if sep == nil then
            sep = "%s"
        end
        local t = {}
        for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
            if trim then
                str = str:match '^%s*(.*%S)' or ''
            end
            if str ~= "" then
                table.insert(t, str)
            end
        end
        return t
    end
end

-- Combine two execute option tables
function combineExecuteOptions(tab1, tab2)
    for k, newOptions in pairs(tab2) do
        if tab1[k] ~= nil then
            for i, opt in pairs(newOptions) do
                if table.find(tab1[k], opt) == nil then
                    table.insert(tab1[k], opt)
                end
            end
        else
            tab1[k] = newOptions
        end
    end
end

-------
-- Local Reference function, for spawning items relative to the quick build card
function LocalPos(object, position)
    local rot = object.getRotation()
    local lPos = { position[1], position[2], position[3] }
    -- Z-X-Y extrinsic
    local zRot = RotMatrix('z', rot.z)
    lPos = RotateVector(zRot, lPos)
    local xRot = RotMatrix('x', rot.x)
    lPos = RotateVector(xRot, lPos)
    local yRot = RotMatrix('y', rot.y)
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
