require("TTS_lib.Util.Math")
require("TTS_lib.Util.Table")
XmlDropdown = require("TTS_lib.XmlGui.XmlDropdown")
local Dim = require("Dim")
local Sequence = require("TTS_lib.Sequence.Sequence")

--- TODOD:
--- The numbering of the squadron slots is not consistent with the squadron formation.
--- refine color scheme for Empire, Rebel and Scum factions
--- fix squadron formation slot positions
--- align the label and panel layout in the UI
--- add a color picker for the squadron color (have it change the dropdown to 'Custom' and update the color)
--- add Strike AI and corresponding target list in a separate input panel
--- rename WingTool to FormationTool
--- rename Squardron to Squadron

local offset = Dim.Convert_mm_igu(8.3)

-- Squadron formation slot positions (unchanged for brevity)
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
        { x = -offset, y = 0.0, z = offset },
        { x = offset,  y = 0.0, z = offset },
        { x = -offset, y = 0.0, z = -offset },
        { x = offset,  y = 0.0, z = -offset },
    }
}

local factions = { "Empire", "Rebel", "Scum" }

-- Faction-specific squadron name lists
local factionNames = {
    ["Empire"] = { "Alpha", "Beta", "Delta", "Gamma", "Epsilon", "Elite", "Inquisitor" },
    ["Rebel"] = { "Blue", "Green", "Grey", "Red", "Rogue", "Skull", "Vassal" },
    ["Scum"] = { "Adam", "Baker", "Bandit", "Black Sun", "Cartel", "Charlie", "Syndicate" }
}

-- Faction-specific color names
local factionColors = {
    ["Empire"] = { "Blue", "Frost", "Inquisitor", "Onyx", "Royal Red", "Steel", "Teal", },
    ["Rebel"] = { "Blue", "Gold", "Green", "Grey", "Red", "Sand", },
    ["Scum"] = { "Amber", "Dust", "Indigo", "Murk", "Rust", "Venom", }
}

-- Color values mapped by name
local colorValues = {
    Amber = Color(0.55, 0.37, 0.18),
    Blue = Color(0.15, 0.25, 0.45),
    Dust = Color(0.48, 0.41, 0.32),
    Frost = Color(0.54, 0.61, 0.66),
    Gold = Color(0.83, 0.63, 0.09),
    Green = Color(0.25, 0.35, 0.20),
    Grey = Color(0.37, 0.42, 0.44),
    Indigo = Color(0.29, 0.23, 0.37),
    Murk = Color(0.29, 0.31, 0.17),
    Onyx = Color(0.12, 0.15, 0.15),
    Inquisitor = Color(0.25, 0.15, 0.35),
    Red = Color(0.70, 0.15, 0.15),
    ["Royal Red"] = Color(0.45, 0.10, 0.10),
    Rust = Color(0.42, 0.29, 0.20),
    Sand = Color(0.81, 0.68, 0.48),
    Slate = Color(0.37, 0.42, 0.44),
    Steel = Color(0.42, 0.45, 0.47),
    Teal = Color(0.18, 0.35, 0.36),
    Venom = Color(0.24, 0.36, 0.18),
}

-- Current settings stored in squadronMate
local squadronMate = {
    ship = nil,
    squadronName = nil,
    slot = -1,
    ai = "ai",
    squadronColor = colorValues["Slate"],
    ownerColor = "Black",
    faction = "Empire"
}

local nextSlot = 0
local shipCount = 4

-- ### Helper Functions

local function getColorByName(name)
    return colorValues[name]
end

local function getFactionColors(faction)
    local names = factionColors[faction] or {}
    local result = {}
    for _, name in ipairs(names) do
        local colorValue = colorValues[name]
        if colorValue then
            table.insert(result, { name = name, value = colorValue })
        end
    end
    return result
end

function getSquadronFormation()
    return squadronFormations[self.getStateId()] or squadronFormations[3]
end

function positionShipInSquadron(ship, slot)
    local pos = getSquadronFormation()[nextSlot]
    -- local pos = getSquadronFormation()[slot]
    printToAll("Squadron: " .. slot .. " exceeds shipCount " .. shipCount .. ". Resetting nextSlot.", Color.Green)
    pos = self.positionToWorld(pos):setAt('y', 1.15)
    ship.setPositionSmooth(pos, false, true)
    ship.setRotationSmooth(self.getRotation(), false, true)
end

function onObjectDrop(player_color, dropped_object)
    if not isNearByShip(dropped_object) then return end
    local ship = dropped_object
    local slot = shipCount - nextSlot
    nextSlot = (nextSlot % shipCount) + 1
    if slot == 0 then
        printToAll("Warning: Slot " .. slot .. " exceeds shipCount " .. shipCount .. ". Resetting nextSlot.", Color.Red)
        nextSlot = 1
        slot = shipCount - nextSlot
    end
    printToAll("Dropping ship - shipCount: " .. shipCount .. ", nextSlot: " .. nextSlot .. ", slot: " .. slot,
        Color.Yellow)

    addSquadronMate(ship, squadronMate.squadronName, slot, squadronMate.ai, squadronMate.squadronColor,
        squadronMate.ownerColor)
end

-- UI Handling
function updateNameDropdown(names)
    printToAll("names: " .. JSON.encode_pretty(names), Color.Purple)

    local nameDropdown = XmlDropdown.new(self, "squadronNameDropdown")
    nameDropdown:clearOptions()
    nameDropdown:setOptions(names, names[1] or "")
    nameDropdown:apply()

    return names[1] or ""
end

function updateColorDropdown(factionColorsList)
    local colorDropdown = XmlDropdown.new(self, "squadronColorDropdown")

    colorDropdown:clearOptions()
    colorDropdown:setOptions(factionColorsList, factionColorsList[1].name or "")
    colorDropdown:apply()

    return factionColorsList[1].value or Color(1, 1, 1)
end

function onFactionChange(player, selectedFaction, dropdownId)
    squadronMate.faction = selectedFaction

    local seq = Sequence:new(true)

    seq:waitCondition(function()
        local index = table.index_of(factions, selectedFaction) or 1
        self.UI.setAttribute(dropdownId, "value", index - 1)
    end, function() return not self.UI.loading end)

    seq:waitCondition(function()
        local names = factionNames[selectedFaction] or {}
        onSquadronNameDropdownChange(player, updateNameDropdown(names), "squadronNameDropdown")
    end, function() return not self.UI.loading end)

    seq:waitCondition(function()
        local factionColorsList = getFactionColors(selectedFaction)
        seq.ctx.color = updateColorDropdown(factionColorsList)
        onSquadronColorChange(player, seq.ctx.color, "squadronColorDropdown")
    end, function() return not self.UI.loading end)

    seq:waitCondition(function()
        self.UI.setAttribute("colorPreview", "color", "#" .. seq.ctx.color:toHex(true))
    end, function() return not self.UI.loading end)

    seq:start()
end

function onSquadronNameDropdownChange(player, selectedSquadron, dropdownId)
    squadronMate.squadronName = selectedSquadron
    self.UI.setAttribute("squadronNameInput", "text", selectedSquadron)
end

function onSquadronNameChange(player, value, id)
    squadronMate.squadronName = value
end

function onSquadronColorChange(player, selectedColorName, dropdownId)
    local color = getColorByName(selectedColorName)
    if color then
        self.UI.setAttribute("colorPreview", "color", "#" .. color:toHex(true))
        printToAll("color: " .. color:toHex(true), color)
        squadronMate.squadronColor = color
    end
end

function applySquadronSettings()
    self.UI.setAttribute("squadronPopup", "active", "false")
    nextSlot = 0 -- Reset to 0 for next drop, starting with slot 1
end

function colorPreviewClicked(player, value, id)
    local player = player or Player["White"]
    local color = self.UI.getAttribute("colorPreview", "color")
    player.showColorDialog(
        color, function(newColor)
            if newColor then
                squadronMate.squadronColor = newColor
                self.UI.setAttribute("colorPreview", "color", "#" .. newColor:toHex(true))
            end
        end
    )
end

-- AI Color Override (unchanged for brevity)
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

-- Helper Functions (unchanged for brevity)
function addSquadronMate(ship, squadronName, slot, ai, squadronColor, ownerColor)
    local mate = {
        ship = ship,
        squadronName = squadronName,
        slot = slot,
        ai = ai,
        squadronColor = squadronColor,
        ownerColor = ownerColor,
        faction = squadronMate.faction
    }
    local seq = Sequence:new(true)
    seq:addTask(function() positionShipInSquadron(ship, slot) end) -- Pass slot directly
    seq:waitFrames(function() overrideAITint(ship, mate.squadronColor) end, 1)
    seq:waitCondition(function() ship.setDescription("name " .. mate.squadronName .. " " .. mate.slot) end,
        function() return Global.call("API_XWcmd_isReady", { ship = ship }) end)
    seq:waitCondition(function() ship.setDescription(mate.ai) end,
        function() return Global.call("API_XWcmd_isReady", { ship = ship }) end)
    seq:addTask(function() ship.setVar('owningPlayer', mate.ownerColor) end)
    seq:waitCondition(function()
        ship.setVar("finished_setup", true)
        ship.call("initContextMenu")
        ship.setLock(true)
    end, function() return ship.resting end)
    seq:start()
end

function isNearByShip(obj)
    if not Global.call("API_IsShipType", { ship = obj }) then
        return false
    end
    local oPos = obj.getPosition():setAt('y', 0)
    local wPos = self.getPosition():setAt('y', 0)
    local nearby = Dim.Convert_mm_igu(25)
    return wPos:distance(oPos) <= nearby
end

function onShipCountChange(player, value, id)
    shipCount = tonumber(value) or 1
    printToAll("Updated shipCount to: " .. shipCount, Color.Yellow) -- Debug print to verify
end

function onSave()
    return JSON.encode({ squadronMate = squadronMate })
end

function onLoad(savedData)
    if savedData ~= "" then
        local data = JSON.decode(savedData)
        squadronMate = data.squadronMate or squadronMate
    end
    printToAll("Initial shipCount: " .. shipCount, Color.Yellow) -- Debug initial value
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
    onFactionChange(nil, squadronMate.faction, "Faction")
    toggleSquadronPopup()
    Global.call("showMe", { self.guid })
end

function toggleSquadronPopup()
    local isActive = self.UI.getAttribute("squadronPopup", "active")
    if isActive == "false" then
        nextSlot = 0 -- Reset to 0 for next drop, starting with slot 1
    end
    self.UI.setAttribute("squadronPopup", "active", isActive == "false" and "true" or "false")
end
