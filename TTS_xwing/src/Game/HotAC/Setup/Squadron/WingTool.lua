require("TTS_lib.Util.Math")
require("TTS_lib.Util.Table")
XmlDropdown = require("TTS_lib.XmlGui.XmlDropdown")
local Dim = require("Dim")
local Sequence = require("TTS_lib.Sequence.Sequence")

--- TODOD:
--- align the label and panel layout in the UI
--- add Strike AI and corresponding target list in a separate input panel
--- rename WingTool to FormationTool
--- handle restarting the cycle after all ships have been dropped
--- find a way to spawn it into a game.

local offset = Dim.Convert_mm_igu(8.3)

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
        { x = -offset, y = 0.0, z = offset },
    }
}

local factions = { "Empire", "Rebel", "Scum" }

-- Faction-specific squadron name lists
local factionNames = {
    ["Empire"] = { "Alpha", "Beta", "Delta", "Gamma", "Epsilon", "Elite", "Inquisitor" },
    ["Rebel"] = { "Blue", "Green", "Grey", "Red", "Rogue", "Skull", "Vassal" },
    ["Scum"] = { "Adam", "Baker", "Bandit", "Black Sun", "Cartel", "Charlie", "Syndicate" }
}

-- Faction-specific color names (faction color first, then alphabetical order)
local factionColors = {
    ["Empire"] = { "Imperial", "Frost", "Green", "Inquisitor", "Onyx", "Royal Red", "Slate", "Solar Yellow", "Sunset", "White", },
    ["Rebel"] = { "Rebel Red", "Blue", "Bone", "Gold", "Green", "Grey", "Plum", "Red", "Sand", },
    ["Scum"] = { "Scum", "Amber", "Indigo", "Murk", "Rust", "Sand", "Sewer", "Smog Blue", "Sun", "Teal", "Venom" }
}

-- Color values mapped by name (brightened and thematic for each faction)
local colorValues = {
    Amber = Color(0.70, 0.50, 0.30),          -- Scummy Yellow/Gold, slightly muted but bright
    Blue = Color(0.30, 0.40, 0.60),           -- Standard bright blue for Rebels/Empire
    Bone = Color(0.95, 0.90, 0.85),           -- Creamy off-white for Rebel Skull, bone-like
    Dust = Color(0.48, 0.41, 0.32),           -- (Removed)
    Frost = Color(0.65, 0.70, 0.75),          -- Light bluish-grey for Empire, icy and cold
    Gold = Color(0.90, 0.70, 0.20),           -- Bright gold for Rebel valor
    Green = Color(0.40, 0.50, 0.35),          -- Earthy green for Rebels, muted green for Empire
    Grey = Color(0.50, 0.55, 0.57),           -- Neutral grey for Rebels, practical
    Imperial = Color(0.29, 0.41, 0.50),       -- Bright bluish-grey for Empire, TIE Fighter theme
    Indigo = Color(0.45, 0.35, 0.50),         -- Deep purple-blue for Scum, mysterious
    Inquisitor = Color(0.40, 0.30, 0.50),     -- Purple for Empire, elite and dark
    Murk = Color(0.40, 0.42, 0.25),           -- (Removed, not needed in new scheme)
    Onyx = Color(0.25, 0.30, 0.30),           -- Dark black for Empire, Stormtroopers
    Plum = Color(0.70, 0.50, 0.70),           -- Deeper purple for Rebel Vassal, masculine and loyal
    ["Rebel Red"] = Color(0.65, 0.12, 0.14),  -- Rebel Red faction color
    Red = Color(1.0, 0.11, 0.11),             -- Bright red for Luke Skywalker’s Red Squadron, Rebels
    ["Royal Red"] = Color(0.80, 0.20, 0.20),  -- Bright, regal red for Imperial Guard
    Rust = Color(0.725, 0.30, 0.10),          -- Scummy red, gritty but bright
    Sand = Color(0.90, 0.80, 0.60),           -- Light sandy beige for Rebels/Scum, earthy
    Scum = Color(0.33, 0.36, 0.20),           -- Muted olive-green for Scum, gritty
    Sewer = Color(0.44, 0.23, 0.09),          -- Darker brownish, muddy color for Scum, scummy
    ["Smog Blue"] = Color(0.30, 0.40, 0.45),  -- Dull, polluted blue for Scum, scummy
    Slate = Color(0.50, 0.55, 0.57),          -- Greyish-blue for Empire, industrial
    Steel = Color(0.55, 0.58, 0.60),          -- (Removed, replaced with Slate for consistency)
    Sun = Color(243 / 255, 234 / 255, 105 / 255),
    ["Solar Yellow"] = Color(1.0, 0.71, 0.0), -- Bright yellow-orange for Empire, fiery
    Sunset = Color(0.90, 0.50, 0.30),         -- Bright orange-yellow for Empire, fiery
    Teal = Color(0.30, 0.50, 0.50),           -- (Removed, not needed in new scheme)
    Venom = Color(0.35, 0.50, 0.25),          -- Bright green for Scum, toxic and vibrant
    ["White"] = Color(1.0, 1.0, 1.0),         -- Bright white for Empire, Snowtroopers/Stormtroopers
}

-- Current settings stored in squadronMate
local squadronMate = {
    shipCount = 4,
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
            table.insert(result, { option = name, value = colorValue })
        end
    end
    return result
end

function getSquadronFormation()
    return squadronFormations[self.getStateId()] or squadronFormations[3]
end

function positionShipInSquadron(ship, slot)
    local pos = getSquadronFormation()[slot]
    pos = self.positionToWorld(pos):setAt('y', 1.15)
    ship.setPositionSmooth(pos, false, true)
    ship.setRotationSmooth(self.getRotation():setAt('y', 180), false, true)
end

function onObjectDrop(player_color, dropped_object)
    if not isNearByShip(dropped_object) then return end
    local ship = dropped_object
    local slot = shipCount - nextSlot
    nextSlot = (nextSlot % shipCount) + 1
    if slot == 0 then
        nextSlot = 1
        slot = shipCount - nextSlot
    end

    addSquadronMate(ship, squadronMate.squadronName, slot, squadronMate.ai, squadronMate.squadronColor,
        squadronMate.ownerColor)
end

-- UI Handling
function updateNameDropdown(names)
    local nameDropdown = XmlDropdown.new(self, "squadronNameDropdown")
    nameDropdown:clearOptions()
    nameDropdown:setOptions(names, names[1] or "")
    nameDropdown:apply()

    return names[1] or ""
end

function updateColorDropdown(factionColorsList)
    local colorDropdown = XmlDropdown.new(self, "squadronColorDropdown")

    colorDropdown:clearOptions()
    colorDropdown:setOptions(factionColorsList, factionColorsList[1].option or "")
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
        squadronMate.squadronColor = seq.ctx.color
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
        squadronMate.squadronColor = color
    end
end

function applySquadronSettings()
    self.UI.setAttribute("squadronPopup", "active", "false")
    nextSlot = 0
end

function colorPreviewClicked(player, value, id)
    local player = player or Player["White"]
    local color = self.UI.getAttribute("colorPreview", "color")
    player.showColorDialog(color, function(newColor)
        if newColor then
            squadronMate.squadronColor = newColor
            self.UI.setAttribute("colorPreview", "color", "#" .. newColor:toHex(true))
        end
    end)
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
    seq:waitCondition(function() ship.setDescription("name " .. mate.squadronName .. " " .. (shipCount - slot + 1)) end,
        function() return Global.call("API_XWcmd_isReady", { ship = ship }) end)
    seq:waitCondition(function() ship.setDescription(mate.ai) end,
        function() return Global.call("API_XWcmd_isReady", { ship = ship }) end)
    seq:waitCondition(function()
        ship.setVar('owningPlayer', mate.ownerColor)
        ship.setVar("finished_setup", true)
        ship.call("initContextMenu")
        ship.setLock(false)
    end, function() return ship.resting end)

    seq:start()
end

function isNearByShip(obj)
    if not Global.call("API_IsShipType", { ship = obj }) then
        return false
    end
    local oPos = obj.getPosition():setAt('y', 0)
    local wPos = self.getPosition():setAt('y', 0)
    local nearby = Dim.Convert_mm_igu(35)
    return wPos:distance(oPos) <= nearby
end

function onShipCountChange(player, value, id)
    shipCount = tonumber(value) or 1
end

function onSave()
    return JSON.encode({ squadronMate = squadronMate })
end

function onLoad(savedData)
    if savedData ~= "" then
        local data = JSON.decode(savedData)
        squadronMate = data.squadronMate or squadronMate
    end
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
        nextSlot = 0 -- Reset to 0 for next drop, starting with slot N
    end
    self.UI.setAttribute("squadronPopup", "active", isActive == "false" and "true" or "false")
end
