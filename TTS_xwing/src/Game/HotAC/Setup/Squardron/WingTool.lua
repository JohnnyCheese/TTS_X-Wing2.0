require("TTS_lib.Util.Math")
require("TTS_lib.Util.Table")
XmlDropdown = require("TTS_lib.XmlGui.XmlDropdown")
local Dim = require("Dim")
local Sequence = require("TTS_lib.Sequence.Sequence")

local offset = Dim.Convert_mm_igu(8.3)
dropdown = nil

-- Wing formation slot positions
local wingFormations = {
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

local wingMate = {
    ship = nil,
    squadName = "Alpha",
    slot = 0,
    ai = "ai",
    squad_color = Color(0.29, 0.31, 0.17, 1),
    owner_color = "Black",
    faction = "Imperial",
}

local nextSlot = 0
local shipCount = 4
local squad_color = Color(0.29, 0.31, 0.17, 1)
local squadName = "Alpha"
local selectedColorIndex = 1

-- Color table with 6 colors per faction
local colors = {
    -- Rebel
    { name = "Rebel Slate  ",   value = Color(0.37, 0.42, 0.44) },
    { name = "Rebel Crimson",   value = Color(0.42, 0.18, 0.20) },
    { name = "Rebel Red    ",   value = Color(0.56, 0.11, 0.12) },
    { name = "Rebel Ochre  ",   value = Color(0.70, 0.35, 0.16) },
    { name = "Rebel Sand   ",   value = Color(0.81, 0.68, 0.48) },
    { name = "Rebel Gold   ",   value = Color(0.83, 0.63, 0.09) },
    -- Imperial
    { name = "Imperial Onyx ",  value = Color(0.12, 0.15, 0.15) },
    { name = "Imperial Ash  ",  value = Color(0.18, 0.24, 0.28) },
    { name = "Imperial Teal ",  value = Color(0.18, 0.35, 0.36) },
    { name = "Imperial Slate",  value = Color(0.25, 0.36, 0.44) },
    { name = "Imperial Steel",  value = Color(0.42, 0.45, 0.47) },
    { name = "Imperial Frost",  value = Color(0.54, 0.61, 0.66) },
    -- Scum & Villainy
    { name = "Scum Venom     ", value = Color(0.24, 0.36, 0.18) },
    { name = "Scum Indigo    ", value = Color(0.29, 0.23, 0.37) },
    { name = "Scum Murk      ", value = Color(0.29, 0.31, 0.17) },
    { name = "Scum Rust      ", value = Color(0.42, 0.29, 0.20) },
    { name = "Scum Dust      ", value = Color(0.48, 0.41, 0.32) },
    { name = "Scum Amber     ", value = Color(0.55, 0.37, 0.18) }
}

-- === FORMATION HANDLING ===

function getWingFormation()
    return wingFormations[self.getStateId()] or wingFormations[3]
end

function positionShipInWing(ship)
    local pos = getWingFormation()[nextSlot]
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

    addWingmate(ship, squadName, slot, ai, squad_color, owner_color)
end

-- === UI HANDLING ===

function onWingNameChange(player, value, id)
    squadName = value or "Alpha"
end

function applyWingSettings()
    self.UI.setAttribute("wingPopup", "active", "false")
end

-- === AI COLOR OVERRIDE ===

function overrideAITint(ship, newTint)
    -- Modify ship's stored data for consistency
    local data = ship.getTable("Data") or {}
    if data.dial then data.dial.setColorTint(newTint) end
    if data.ColorId then data.ColorId = newTint end
    ship.setTable("Data", data)

    -- Apply tint to ship attachments (Arc Indicators, etc.)
    for _, attachment in ipairs(ship.getAttachments()) do
        local id = ship.removeAttachment(attachment.index)
        if id.getName() == "ColorId" then
            id.setColorTint(newTint)
        end
        ship.addAttachment(id)
    end
end

-- === HELPER FUNCTIONS ===

function addWingmate(ship, squadName, slot, ai, squad_color, owner_color)
    function setName()
        ship.setDescription("name " .. squadName .. " " .. slot)
    end

    function setAI()
        ship.setDescription(ai)
    end

    function setColorTint()
        overrideAITint(ship, squad_color)
    end

    function setOwner()
        ship.setVar('owningPlayer', owner_color)
    end

    function setPostion()
        positionShipInWing(ship)
    end

    function finish_setup()
        ship.setVar("finished_setup", true)
        ship.call("initContextMenu")
        ship.setLock(true)
    end

    local seq = Sequence:new(true)

    seq:addTask(setPostion)
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
function onWingShipCountChange(player, value, id)
    shipCount = tonumber(value) or 1
end

function onSave()
    return JSON.encode({ squadName = squadName, selectedColorIndex = selectedColorIndex })
end

function onLoad(savedData)
    if savedData ~= "" then
        local data = JSON.decode(savedData)
        squadName = data.squadName or "Alpha"
        selectedColorIndex = data.selectedColorIndex or 1
    end

    -- Create a small button on the table
    self.createButton({
        click_function = "toggleWingPopup",
        function_owner = self,
        label = "x",
        position = { 0, 0.08, 0 }, -- 1.42 1.06 .. 1.20 1.06
        rotation = { 0, 180, 0 },
        scale = { 0.6, 0.6, 0.6 },
        width = 50,
        height = 50,
        font_size = 50
    })

    -- self.UI.setAttribute("wingSquadNameInput", "text", squadName)
    populateDropdown()
    toggleWingPopup()
    Global.call("showMe", { "0a27e4" })
end

-- === POP-UP MENU HANDLING ===
function toggleWingPopup()
    local isActive = self.UI.getAttribute("wingPopup", "active")
    isHotACMode = true
    self.UI.setAttribute("wingPopup", "active", isActive == "false" and "true" or "false")
    self.UI.setAttribute("wingSquadNameInput", "text", "Alpha")
end

function populateDropdown()
    dropdown = XmlDropdown.new(self, "wingColorDropdown") -- Fetches self.UI.getXmlTable() internally
    dropdown:clearOptions()
    dropdown:setOptions(colors, "Rebel Red")
    dropdown:apply() -- No argument needed
end

function onWingColorChange(player, selectedColor, dropdownId)
    local color = dropdown:getValue(selectedColor)

    if color then
        local hex = '#' .. color:toHex(true)

        self.UI.setAttribute("colorPreview", "color", hex)

        squad_color = color
    end
end
