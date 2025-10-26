require("TTS_lib.Util.Math")
require("TTS_lib.Util.Table")
XmlDropdown = require("TTS_lib.XmlGui.XmlDropdown")
local Dim = require("Dim")
local Sequence = require("TTS_lib.Sequence.Sequence")

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
    ["Empire"] = { "Alpha", "Beta", "Gamma", "Delta", "Epsilon", "Elite", "Inquisitor" },
    ["Scum"] = { "Adam", "Baker", "Bandit", "Black Sun", "Cartel", "Charlie", "Syndicate" }
}
local orderedHues = { "Faction", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Grey", "White", "Black" }

-- Each value is a *color name* that already exists in colorValues
local factionColors = {
    Rebel = {
        Faction = "Rebel Red",
        Red     = "Red",
        Orange  = "Alliance",
        Yellow  = "Saber Yellow",
        Green   = "RotJ Green",
        Blue    = "R2D2",
        Purple  = "Mace Purple",
        Grey    = "Grey",
        White   = "White",
        Black   = "Shadow Flight",
    },

    Empire = {
        Faction = "Imperial",
        Red     = "Royal Red",
        Orange  = "Sunset",
        Yellow  = "Gold",
        Green   = "Royal Green", -- bright; avoids Endor≈Vader problem
        Blue    = "Royal Blue",
        Purple  = "Inquisitor",
        Grey    = "Slate",
        White   = "Storm Trooper",
        Black   = "Vader",
    },

    Scum = {
        Faction = "Scum",
        Red     = "Maul",
        Orange  = "Amber",
        Yellow  = "Sun",
        Green   = "Venom",
        Blue    = "Cad Bane",
        Purple  = "Syndicate Violet",
        Grey    = "The Mandalorian",
        White   = "Bone",
        Black   = "Onyx",
    },
}

-- Color values mapped by name (brightened and thematic for each faction)
local colorValues = {
    ["Alliance"]          = "#E77A2F", -- Rebel
    ["Amber"]             = "#B2804C", -- Scum
    ["Blue"]              = "#4C6699",
    ["Bone"]              = "#F2E6D9", -- Scum
    ["C3PO"]              = "#faedcd",
    ["Caboose Red D&H"]   = "#691B25", -- Original 1975 Caboose Red Deleware and Hudson
    ["Caboose Red"]       = "#AB0000", -- Original 1975 Red Five color
    ["Cad Bane"]          = "#3f5a84", -- Scum
    ["Cold Blue"]         = "#241fa6",
    ["Dust"]              = "#7A6952",
    ["Endor"]             = "#233918",
    ["Firebrick Red"]     = "#B22222",
    ["Frost"]             = "#A6B2BF",
    ["Gold"]              = "#E6B233", -- Empire
    ["Greedo"]            = "#39756c",
    ["Green"]             = "#668059",
    ["Grey"]              = "#808C91", -- Rebel
    ["Imperial"]          = "#4A6980", -- Empire faction color
    ["Indigo"]            = "#735980",
    ["Inquisitor"]        = "#5522AA", -- Empire
    ["Jabba"]             = "#867a60",
    ["Leia"]              = "#f8f4ef",
    ["Lighting Blue"]     = "#aae3f1",
    ["Maul"]              = "#e21b2f", -- Scum
    ["Mace Purple"]       = "#B066FF", -- Rebel
    ["Murk"]              = "#666B40",
    ["Onyx"]              = "#404C4C", -- Scum
    ["Plum"]              = "#B280B2",
    ["R2D2"]              = "#1A26CC", -- Rebel
    ["Rebel Red"]         = "#862016", -- Rebel faction color
    ["Red Five"]          = "#7a3230",
    ["Red"]               = "#FF1C1C",
    ["RotJ Green"]        = "#12ee1a", -- Rebel
    ["Royal Blue"]        = "#1e1f98", -- Empire
    ["Royal Green"]       = "#1e981f", -- Empire
    ["Royal Guard"]       = "#981e1f",
    ["Royal Red"]         = "#CC3333", -- Empire
    ["Rust"]              = "#B94C1A",
    ["Sand"]              = "#E6CC99",
    ["Saber Yellow"]      = "#FFEA00", -- Rebel
    ["Scum"]              = "#545C33", -- Scum faction color
    ["Sewer"]             = "#703B17",
    ["Shadow Flight"]     = "#1c1c1c", -- Rebel
    ["Shadows of Empire"] = "#736b2b",
    ["Slate"]             = "#808C91", -- Empire
    ["Smog Blue"]         = "#4C6673",
    ["Solar Yellow"]      = "#FFB500",
    ["Steel"]             = "#8C9499",
    ["Storm Trooper"]     = "#f9fafa", -- Empire
    ["Sun"]               = "#F2EB69", -- Scum
    ["Sunset"]            = "#E6804C", -- Empire
    ["Syndicate Violet"]  = "#735980", -- Scum
    ["Tatooine"]          = "#efac51",
    ["Teal"]              = "#4C8080",
    ["The Mandalorian"]   = "#8a949d", -- Scum
    ["Vader"]             = "#221d19", -- Empire
    ["Venom"]             = "#598040", -- Scum
    ["White"]             = "#F9F9F9", -- Rebel
    ["Zann Consortium"]   = "#39756c",
    ["Zeb"]               = "#8d6f8e",
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

local PilotCardByShip = {}

local function buildPilotCardIndex()
    PilotCardByShip = {}, {}
    for _, o in ipairs(getAllObjects()) do
        -- the card will have a live 'ship' var set now:
        local s = o.getVar("ship")
        if s and s.guid then
            PilotCardByShip[s.guid] = o
        end
    end
end

function resetSquadron()
    squadron.ships = {}
    buildPilotCardIndex()
end

-- ### Helper Functions
function getColorByName(labelOrName, faction)
    local map = factionColors[faction]
    local key = (map and map[labelOrName]) or labelOrName -- label→name, else treat as name
    return colorValues[key]                               -- returns "#RRGGBB" or nil
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
    if table.empty(PilotCardByShip) then
        buildPilotCardIndex()
    end
end

-- UI Handling
function updateNameDropdown(names)
    local nameDropdown = XmlDropdown.new(self, "squadronNameDropdown")
    nameDropdown:clearOptions()
    nameDropdown:setOptions(names, names[1] or "")
    nameDropdown:apply()

    return names[1] or ""
end

function updateColorDropdown(labels)
    local opts = {}
    for _, label in ipairs(labels) do
        opts[#opts + 1] = { option = label }
    end

    local dd = XmlDropdown.new(self, "squadronColorDropdown")
    dd:clearOptions()
    dd:setOptions(opts, "Faction") -- default selection = first label
    dd:apply()

    return getColorByName("Faction", squadron.faction) or "#FFFFFF"
end

function updateColorDropdownOld(factionColorsList)
    local colorDropdown = XmlDropdown.new(self, "squadronColorDropdown")

    colorDropdown:clearOptions()
    colorDropdown:setOptions(factionColorsList, factionColorsList[1].option or "")
    colorDropdown:apply()

    return factionColorsList[1].value or "#FFFFFF"
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
        -- local factionColorsList = getFactionColors(selectedFaction)
        -- squadron.squadronColor = updateColorDropdown(factionColorsList)
        squadron.squadronColor = updateColorDropdown(orderedHues)
        onSquadronColorChange(player, "Faction", "squadronColorDropdown")
    end, function() return not self.UI.loading end)

    seq:waitCondition(function()
        self.UI.setAttribute("colorPreview", "color", squadron.squadronColor)
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
    local color = getColorByName(selectedColorName, squadron.faction)
    if color then
        self.UI.setAttribute("colorPreview", "color", color)
        squadron.squadronColor = color
    end
end

function applySquadronSettings()
    self.UI.setAttribute("squadronPopup", "active", "false")
    resetSquadron()
end

function colorPreviewClicked(player, value, id)
    local player = player or Player["White"]
    local color = self.UI.getAttribute("colorPreview", "color")
    player.showColorDialog(color, function(newColor)
        if newColor then
            squadron.squadronColor = newColor:toHex(true)
            self.UI.setAttribute("colorPreview", "color", "#" .. squadron.squadronColor)
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

function findPilotCardByShipGUID(shipGUID)
    return PilotCardByShip[shipGUID]
end

function findPilotCardByShipGUIDOld(shipGUID)
    local allObjects = getObjects()
    local card = table.find(allObjects, shipGUID, function(card, guid)
        local ship = card.getVar("ship")
        if ship ~= nil and ship.guid == guid then return true end
        return false
    end)
    return card and allObjects[card] or nil
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
    local name = computeShipName(slot, squad)

    local seq = Sequence:new(true)

    seq:addTask(positionShipInSquadron, ship, slot)
    seq:waitFrames(function()
        local card = findPilotCardByShipGUID(ship.guid)
        if card ~= nil then
            card.setName(name)
            card.setColorTint(Color.fromHex(squad.squadronColor))
            card.call("tint_check")
        else
            overrideAITint(ship, Color.fromHex(squad.squadronColor))
        end
    end, 1)
    seq:waitCondition(function()
            ship.setDescription("name " .. name)
        end,
        function() return Global.call("API_XWcmd_isReady", { ship = ship }) end)
    seq:waitCondition(function()
            ship.setDescription(squad.ai)
        end,
        function() return Global.call("API_XWcmd_isReady", { ship = ship }) end)
    seq:waitCondition(function()
            ship.setDescription("init 1")
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
        color = Color.fromHex("#CCCCCC"),
        function_owner = self,
        label = "▲",
        position = { 0, 0.0749, 0 },
        rotation = { 0, 180, 0 },
        scale = { 0.65, 0.65, 0.65 },
        width = 50,
        height = 50,
        font_size = 50,
        font_color = Color.fromHex("#171615")
    })

    onFactionChange(nil, squadron.faction, "Faction")
end
