require("TTS_lib.Util.Math")
require("TTS_lib.Util.Table")
XmlDropdown = require("TTS_lib.XmlGui.XmlDropdown")
local Dim = require("Dim")
local Sequence = require("TTS_lib.Sequence.Sequence")

local offset = Dim.Convert_mm_igu(8.3)
dropdown = nil

-- Squadron formation slot positions (renamed from wingFormations)
local squadronFormations = {
    [1] = {
        { x = 0.0,           y = 0.0, z = -offset },
        { x = -2.0 * offset, y = 0.0, z = -offset },
        { x = 2.0 * offset,  y = 0.0, z = -offset },
        { x = 0.0,           y = 0.0, z = offset },
        { x = -2.0 * offset, y = 0.0, z = offset },
        { x = 2.0 * offset,  y = 0.0, z = offset }
    },
    [2] = {
        { x = 0.0, y = 0.0, z = -offset },
        { x = 0.0, y = 0.0, z = offset }
    },
    [3] = {
        { x = offset,  y = 0.0, z = -offset },
        { x = -offset, y = 0.0, z = -offset },
        { x = offset,  y = 0.0, z = offset },
        { x = -offset, y = 0.0, z = offset }
    }
}

local squadronMate = {
    ship = nil,
    squadronName = nil,
    slot = 0,
    ai = "ai",
    squadronColor = Color(0.29, 0.31, 0.17, 1), -- Renamed from squad_color
    ownerColor = "Black",                        -- Renamed from owner_color
    faction = "Imperial",
}

local nextSlot = 0
local shipCount = 4
local squadronColor = Color(0.29, 0.31, 0.17, 1) -- Renamed from squad_color
local squadronName = nil                          -- No initial default
local selectedColorIndex = 1

-- Color table with 6 colors per faction
local colors = {
    -- Rebel
    { name = "Rebel Slate",    value = Color(0.37, 0.42, 0.44) },
    { name = "Rebel Crimson",  value = Color(0.42, 0.18, 0.20) },
    { name = "Rebel Red",      value = Color(0.56, 0.11, 0.12) },
    { name = "Rebel Ochre",    value = Color(0.70, 0.35, 0.16) },
    { name = "Rebel Sand",     value = Color(0.81, 0.68, 0.48) },
    { name = "Rebel Gold",     value = Color(0.83, 0.63, 0.09) },
    -- Imperial
    { name = "Imperial Onyx",  value = Color(0.12, 0.15, 0.15) },
    { name = "Imperial Ash",   value = Color(0.18, 0.24, 0.28) },
    { name = "Imperial Teal",  value = Color(0.18, 0.35, 0.36) },
    { name = "Imperial Slate", value = Color(0.25, 0.36, 0.44) },
    { name = "Imperial Steel", value = Color(0.42, 0.45, 0.47) },
    { name = "Imperial Frost", value = Color(0.54, 0.61, 0.66) },
    -- Scum & Villainy
    { name = "Scum Venom",     value = Color(0.24, 0.36, 0.18) },
    { name = "Scum Indigo",    value = Color(0.29, 0.23, 0.37) },
    { name = "Scum Murk",      value = Color(0.29, 0.31, 0.17) },
    { name = "Scum Rust",      value = Color(0.42, 0.29, 0.20) },
    { name = "Scum Dust",      value = Color(0.48, 0.41, 0.32) },
    { name = "Scum Amber",     value = Color(0.55, 0.37, 0.18) }
}

-- Squadron names from HotAC histogram (shortened list from your version)
local squadronNames = {
    "Alpha", "Beta", "Delta", "Gamma", "Epsilon", "Elite"
}

-- === FORMATION HANDLING ===

function getSquadronFormation() -- Renamed from getWingFormation
    return squadronFormations[self.getStateId()] or squadronFormations[3]
end

function positionShipInSquadron(ship) -- Renamed from positionShipInWing
    local pos = getSquadronFormation()[nextSlot]
    pos = self.positionToWorld(pos):setAt('y', 1.30)

    ship.setPositionSmooth(pos, false, true)
    ship.setRotationSmooth(self.getRotation():setAt('y', 180), false, true)
end

function onObjectDrop(player_color, dropped_object)
    if not isNearByShip(dropped_object) then return end

    local ship = dropped_object
    local slot = shipCount - nextSlot
    nextSlot = nextSlot % shipCount + 1
    local ai = "AI"
    local owner_color = "Black"

    addSquadronMate(ship, squadronName, slot, ai, squadronColor, owner_color) -- Renamed
end

-- === UI HANDLING ===

function onSquadronNameChange(player, value, id) -- Renamed from onWingNameChange
    squadronName = value -- No default here; empty string is valid
end

function applySquadronSettings() -- Renamed from applyWingSettings
    -- Use input field value if set, else dropdown, else first squadronName
    local nameDropdown = XmlDropdown.new(self, "squadronNameDropdown")
    squadronName = self.UI.getAttribute("squadronNameInput", "text") or nameDropdown:getSelected() or squadronNames[1]
    self.UI.setAttribute("squadronPopup", "active", "false")
end

-- === AI COLOR OVERRIDE ===

function overrideAITint(ship, newTint)
    local data = ship.getTable("Data") or {}
    if data.dial then data.dial.setColorTint(newTint) end
    if data.ColorId then data.ColorId = newTint end
    ship.setTable("Data", data)

    for _, attachment in ipairs(ship.getAttachments()) do
        local id = ship.removeAttachment(attachment.index)
        if id.getName() == "ColorId" then
            id.setColorTint(newTint)
        end
        ship.addAttachment(id)
    end
end

-- === HELPER FUNCTIONS ===

function addSquadronMate(ship, squadronName, slot, ai, squadronColor, ownerColor) -- Renamed from addWingmate
    local mate = {
        ship = ship,
        squadronName = squadronName,
        slot = slot,
        ai = ai,
        squadronColor = squadronColor,
        ownerColor = ownerColor,
        faction = "Imperial" -- Parameterize later for faction campaigns
    }

    function setName()
        ship.setDescription("name " .. mate.squadronName .. " " .. mate.slot)
    end

    function setAI()
        ship.setDescription(mate.ai)
    end

    function setColorTint()
        overrideAITint(ship, mate.squadronColor)
    end

    function setOwner()
        ship.setVar('owningPlayer', mate.ownerColor)
    end

    function setPosition() -- Renamed from setPostion
        positionShipInSquadron(ship)
    end

    function finish_setup()
        ship.setVar("finished_setup", true)
        ship.call("initContextMenu")
        ship.setLock(true)
    end

    local seq = Sequence:new(true)

    seq:addTask(setPosition)
    seq:waitFrames(setColorTint, 1)
    seq:waitCondition(setName, function()
        return Global.call("API_XWcmd_isReady", { ship = ship })
    end)
    seq:waitCondition(setAI, function()
        return Global.call("API_XWcmd_isReady", { ship = ship })
    end)
    seq:addTask(setOwner)
    seq:waitCondition(finish_setup, function()
        return ship.resting
    end)

    seq:start()
end

function isNearByShip(obj)
    local oPos = obj.getPosition():setAt('y', 0)
    local wPos = self.getPosition():setAt('y', 0)
    local isNearBy = wPos:distance(oPos) <= Dim.Convert_mm_igu(25)
    return isNearBy and Global.call("API_IsShipType", { ship = obj })
end

-- Handle ship count selection
function onSquadronShipCountChange(player, value, id) -- Renamed from onWingShipCountChange
    shipCount = tonumber(value) or 1
end

function onSave()
    return JSON.encode({ squadronName = squadronName, selectedColorIndex = selectedColorIndex })
end

function onLoad(savedData)
    if savedData ~= "" then
        local data = JSON.decode(savedData)
        squadronName = data.squadName -- Match your saved key; no default
        selectedColorIndex = data.selectedColorIndex or 1
    end

    -- Create a small button on the table
    self.createButton({
        click_function = "toggleSquadronPopup",
        function_owner = self,
        label = "x",
        position = { 0, 0.08, 0 },
        rotation = { 0, 180, 0 },
        scale = { 0.6, 0.6, 0.6 },
        width = 50,
        height = 50,
        font_size = 50
    })

    -- self.UI.setAttribute("wingSquadNameInput", "text", squadName)
    populateDropdown()
    toggleSquadronPopup()
    Global.call("showMe", { "0a27e4" })
end

-- === POP-UP MENU HANDLING ===
function toggleSquadronPopup() -- Renamed from toggleWingPopup
    local isActive = self.UI.getAttribute("squadronPopup", "active")
    isHotACMode = true
    self.UI.setAttribute("squadronPopup", "active", isActive == "false" and "true" or "false")
    if not squadronName then
        self.UI.setAttribute("squadronNameInput", "text", self.UI.getAttribute("squadronNameDropdown", "text") or squadronNames[1])
    end
end

function onSquadronColorChange(player, selectedColor, dropdownId) -- Renamed from onWingColorChange
    local color = dropdown:getValue(selectedColor)

    if color then
        local hex = '#' .. color:toHex(true)

        self.UI.setAttribute("colorPreview", "color", hex)
        squadronColor = color
    end
end

function populateDropdown()
    -- Color dropdown
    dropdown = XmlDropdown.new(self, "squadronColorDropdown")
    dropdown:clearOptions()
    dropdown:setOptions(colors) -- No default specified; first option used
    dropdown:apply()

    -- Squadron name dropdown
    local squadDropdown = XmlDropdown.new(self, "squadronNameDropdown")
    squadDropdown:clearOptions()
    squadDropdown:setOptions(squadronNames, squadronNames[1]) -- First in list as default
    squadDropdown:apply()

    -- Set initial input field value from saved data or dropdown
    self.UI.setAttribute("squadronNameInput", "text", squadronName or squadDropdown:getSelected())
end

function onSquadronNameDropdownChange(player, selectedSquadron, dropdownId) -- Renamed
    self.UI.setAttribute("squadronNameInput", "text", selectedSquadron)
    squadronName = selectedSquadron
end

-- Handle manual edits to the input field
function onSquadronNameChange(player, value, id) -- Already renamed above
    squadName = value -- No default here
end
