require("TTS_lib.Util.Math")
require("TTS_lib.Util.Table")
XmlDropdown = require("TTS_lib.XmlGui.XmlDropdown")
local Dim = require("Dim")
local Sequence = require("TTS_lib.Sequence.Sequence")

--- TODO:
--- rename WingTool to FormationTool

local offset = Dim.Convert_mm_igu(8.3)

local squadronFormations = {
    [1] = {
        Vector(0.0, 0.0, -offset),
        Vector(-2.0 * offset, 0.0, -offset),
        Vector(2.0 * offset, 0.0, -offset),
        Vector(0.0, 0.0, offset),
        Vector(-2.0 * offset, 0.0, offset),
        Vector(2.0 * offset, 0.0, offset)
    },
    [2] = {
        Vector(0.0, 0.0, -offset),
        Vector(0.0, 0.0, offset)
    },
    [3] = {
        Vector(offset, 0.0, -offset),
        Vector(-offset, 0.0, -offset),
        Vector(offset, 0.0, offset),
        Vector(-offset, 0.0, offset),
    }
}

local factions = { "Rebel", "Empire", "Scum" }

-- Faction-specific squadron name lists
local factionNames = {
    ["Rebel"] = { "Blue", "Green", "Grey", "Red", "Rogue", "Skull", "Vassal" },
    ["Empire"] = { "Alpha", "Beta", "Delta", "Gamma", "Epsilon", "Elite", "Inquisitor" },
    ["Scum"] = { "Adam", "Baker", "Bandit", "Black Sun", "Cartel", "Charlie", "Syndicate" }
}

-- Faction-specific color names (faction color first, then alphabetical order)
local factionColors = {
    ["Rebel"] = { "Rebel Red", "Blue", "Bone", "Gold", "Green", "Grey", "Plum", "Red", "Sand", },
    ["Empire"] = { "Imperial", "Frost", "Green", "Inquisitor", "Onyx", "Royal Red", "Slate", "Solar Yellow", "Sunset", "White", },
    ["Scum"] = { "Scum", "Amber", "Indigo", "Murk", "Rust", "Sand", "Sewer", "Smog Blue", "Sun", "Teal", "Venom" }
}

-- Color values mapped by name (brightened and thematic for each faction)
local colorValues = {
    Amber = Color(0.70, 0.50, 0.30),          -- Scummy Yellow/Gold, slightly muted but bright
    Blue = Color(0.30, 0.40, 0.60),           -- Standard bright blue for Rebels/Empire
    Bone = Color(0.95, 0.90, 0.85),           -- Creamy off-white for Rebel Skull, bone-like
    Dust = Color(0.48, 0.41, 0.32),           -- (Unused)
    Frost = Color(0.65, 0.70, 0.75),          -- Light bluish-grey for Empire, icy and cold
    Gold = Color(0.90, 0.70, 0.20),           -- Bright gold for Rebel valor
    Green = Color(0.40, 0.50, 0.35),          -- Earthy green for Rebels, muted green for Empire
    Grey = Color(0.50, 0.55, 0.57),           -- Neutral grey for Rebels, practical
    Imperial = Color(0.29, 0.41, 0.50),       -- Bright bluish-grey for Empire, TIE Fighter theme
    Indigo = Color(0.45, 0.35, 0.50),         -- Deep purple-blue for Scum, mysterious
    Inquisitor = Color(0.40, 0.30, 0.50),     -- Purple for Empire, elite and dark
    Murk = Color(0.40, 0.42, 0.25),           --
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
    Steel = Color(0.55, 0.58, 0.60),          -- (Unused, replaced with Slate for consistency)
    Sun = Color(0.95, 0.92, 0.41),
    ["Solar Yellow"] = Color(1.0, 0.71, 0.0), -- Bright yellow-orange for Empire, fiery
    Sunset = Color(0.90, 0.50, 0.30),         -- Bright orange-yellow for Empire, fiery
    Teal = Color(0.30, 0.50, 0.50),           -- (Removed, not needed in new scheme)
    Venom = Color(0.35, 0.50, 0.25),          -- Bright green for Scum, toxic and vibrant
    ["White"] = Color(1.0, 1.0, 1.0),         -- Bright white for Empire, Snowtroopers/Stormtroopers
}

-- Current settings stored in squadron
local squadron = {
    shipCount = 4,
    ships = {},
    squadronName = "Alpha",
    ai = "ai",
    squadronColor = colorValues["Imperial"],
    ownerColor = "Black",
    faction = "Empire"
}

function clearSquadron()
    squadron.ships = {}
end

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

    local rotation = self.getRotation()
    rotation.y = (rotation.y + 180) % 360 -- Ensures proper rotation without exceeding 360 degrees
    ship.setRotationSmooth(rotation, false, true)
end

function onObjectDrop(player_color, ship)
    if not isNearByShip(ship) then return end
    addSquadronMate(ship, squadron)
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
    squadron.faction = selectedFaction

    local seq = Sequence:new(true)
    local index = table.index_of(factions, selectedFaction) or 1

    seq:waitCondition(function()
        -- This should be unnecessary, but TTS calls the handler function before updating the UI table/XML.
        self.UI.setAttribute(dropdownId, "value", index - 1)
    end, function() return not self.UI.loading end)

    seq:waitCondition(function()
        self.UI.setAttribute("faction", "color", selectedFaction)
        self.UI.setAttribute("squadronPopup", "image", tostring(index) .. "BG")
    end, function() return not self.UI.loading end)

    seq:waitCondition(function()
        local isStrike = squadron.ai:startsWith("strike") or false
        local isActive = isStrike and 1 or 0

        if isStrike then
            local targets = string.match(squadron.ai, "strike (.*)")
            self.UI.setAttribute("aiStrikeTargets", "text", targets)
            self.UI.setAttribute("aiStrikeTargets", "active", tostring(isStrike))
        end
        self.UI.setAttribute("aiDropdown", "value", isActive)
    end, function() return not self.UI.loading end)

    seq:waitCondition(function()
        local names = factionNames[selectedFaction] or {}
        onSquadronNameDropdownChange(player, updateNameDropdown(names), "squadronNameDropdown")
    end, function() return not self.UI.loading end)

    seq:waitCondition(function()
        local factionColorsList = getFactionColors(selectedFaction)
        squadron.squadronColor = updateColorDropdown(factionColorsList)
        onSquadronColorChange(player, squadron.squadronColor, "squadronColorDropdown")
    end, function() return not self.UI.loading end)

    seq:waitCondition(function()
        self.UI.setAttribute("colorPreview", "color", "#" .. squadron.squadronColor:toHex(true))
    end, function() return not self.UI.loading end)

    seq:start()
end

function getAiLogic(value)
    local logic = { Attack = "ai", Strike = "strike" }
    if value == "Strike" then
        local targets = self.UI.getValue("aiStrikeTargets")
        if targets then
            return logic[value] .. " " .. tostring(targets)
        end
    end
    return logic[value] or "ai"
end

function onAiDropdownChange(player, value, id)
    squadron.ai = getAiLogic(value)
    local isStrike = value == "Strike"
    self.UI.setAttribute("aiStrikeTargets", "active", tostring(isStrike))
end

function onAiStrikeTargetsChange(player, value, id)
    squadron.ai = "strike " .. tostring(value)
end

function onSquadronNameDropdownChange(player, selectedSquadron, dropdownId)
    squadron.squadronName = selectedSquadron
    self.UI.setAttribute("squadronNameInput", "text", selectedSquadron)
end

function onSquadronNameChange(player, value, id)
    squadron.squadronName = value
end

function onSquadronColorChange(player, selectedColorName, dropdownId)
    local color = getColorByName(selectedColorName)
    if color then
        self.UI.setAttribute("colorPreview", "color", "#" .. color:toHex(true))
        squadron.squadronColor = color
    end
end

function applySquadronSettings()
    self.UI.setAttribute("squadronPopup", "active", "false")
    clearSquadron()
end

function colorPreviewClicked(player, value, id)
    local player = player or Player["White"]
    local color = self.UI.getAttribute("colorPreview", "color")
    player.showColorDialog(color, function(newColor)
        if newColor then
            squadron.squadronColor = newColor
            self.UI.setAttribute("colorPreview", "color", "#" .. newColor:toHex(true))
        end
    end)
end

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

function computeShipName(slot, squadron)
    if squadron.shipCount == 1 then
        return squadron.squadronName
    end
    return squadron.squadronName .. " " .. (squadron.shipCount - slot + 1)
end

function addSquadronMate(ship, squad)
    local slot = (#squad.ships % squad.shipCount) + 1
    table.insert(squad.ships, ship)

    local seq = Sequence:new(true)

    seq:addTask(positionShipInSquadron, ship, slot)
    seq:waitFrames(function()
        overrideAITint(ship, squad.squadronColor)
    end, 1)
    seq:waitCondition(function()
            ship.setDescription("name " .. computeShipName(slot, squad))
        end,
        function() return Global.call("API_XWcmd_isReady", { ship = ship }) end)
    seq:waitCondition(function()
            ship.setDescription(squad.ai)
        end,
        function() return Global.call("API_XWcmd_isReady", { ship = ship }) end)
    seq:waitCondition(function()
        ship.setVar('owningPlayer', squad.ownerColor)
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
    squadron.shipCount = tonumber(value) or 1
end

function toggleSquadronPopup()
    local isActive = self.UI.getAttribute("squadronPopup", "active")
    self.UI.setAttribute("squadronPopup", "active", isActive == "false" and "true" or "false")
end

function onLoad(savedData)
    self.createButton({
        click_function = "toggleSquadronPopup",
        color = { 0.80, 0.80, 0.80, 1.0 },
        function_owner = self,
        label = "▲",
        position = { 0, 0.0749, 0 },
        rotation = { 0, 180, 0 },
        scale = { 0.65, 0.65, 0.65 },
        width = 50,
        height = 50,
        font_size = 50,
        font_color = { 23 / 255, 22 / 255, 21 / 255 }
    })

    onFactionChange(nil, squadron.faction, "Faction")
end
