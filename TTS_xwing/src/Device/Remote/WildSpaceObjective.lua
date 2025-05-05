ObjectiveTokenData = require("Marker.Scenario.ObjectiveTokenData")
Maneuver = require("Game.Mechanic.Movement.Maneuver")
Dim = require("Dim")

Data = {
    Size = "objective",
    forwardAdjustment = 90 -- Adjust the forward vector to point towards the front of the objective
}

rulers = {}
rulerstype = nil

relocator = Maneuver:new()

function relocate(player, value, id)
    printToAll("Relocating to " .. tostring(id), Color.Orange)
    relocator:execute(self, id)
    printToAll("Relocated")
end

function setupAssets()
    local AntillesIcons = {
        {
            name = "1str",
            url =
            "https://i.imgur.com/rfeMqjQ.png",
        },
        {
            name = "2lbank",
            url =
            "https://i.imgur.com/ZtmNw9W.png",
        },
        {
            name = "2rbank",
            url =
            "https://i.imgur.com/78NqNAv.png"
        },
        {
            name = "2str",
            url =
            "https://i.imgur.com/TRFRPiO.png",
        },
        {
            name = "3lbank",
            url =
            "https://i.imgur.com/TRpVkDC.png",
        },
        {
            name = "3lturn",
            url =
            "https://i.imgur.com/JqcjtHM.png",
        },
        {
            name = "3rbank",
            url =
            "https://i.imgur.com/c2wIKIC.png",
        },
        {
            name = "3rturn",
            url =
            "https://i.imgur.com/jNagAyf.png",
        },
        {
            name = "3str",
            url =
            "https://i.imgur.com/U2G7yp0.png",
        },
        {
            name = "4str",
            url =
            "https://i.imgur.com/BlBpwFq.png",
        }
    }
    -- helper to find an asset by name in a list
    local function findAssetByName(assets, name)
        for _, a in ipairs(assets) do
            if a.name == name then
                return a
            end
        end
        return nil
    end

    -- 1) grab current assets (may include totally unrelated entries)
    local current = (self.UI and self.UI.getCustomAssets and self.UI.getCustomAssets()) or {}
    -- 2) start new list as a shallow copy of current
    local merged = {}
    for _, a in ipairs(current) do
        merged[#merged + 1] = { name = a.name, url = a.url }
    end

    -- 3) for each expected icon, add or update
    local changed = false
    for _, exp in ipairs(AntillesIcons) do
        local existing = findAssetByName(merged, exp.name)
        if not existing then
            -- missing: add it
            merged[#merged + 1] = { name = exp.name, url = exp.url }
            changed = true
        elseif existing.url ~= exp.url then
            -- wrong URL: update it
            existing.url = exp.url
            changed = true
        end
    end

    -- 4) if anything changed, write back the full merged list
    if changed then
        self.UI.setCustomAssets(merged)
        printToAll("🔄 Antilles icons updated/added", Color.Orange)
    else
        printToAll("✅ All Antilles icons already present", Color.Green)
    end
end

function showPanel(player, value, id)
    self.UI.setAttribute(id, "active", "true")
end

function hidePanel(player, value, id)
    self.UI.setAttribute(id, "active", "false")
end

function onObjectHover(player_color, hovered)
    if hovered == self then
        self.UI.setAttribute("btnPanelA", "active", "true")
    end
end

function SetupContextMenu()
    self.clearContextMenu()
	self.addContextMenuItem("Check 0-3 Bubble", check360, false)
end

function onLoad(save_state)
    local state = JSON.decode(save_state)
    self.setVar("owningPlayer", "Black")
    if state then
        linedrawing = state.linedrawing or true
        -- self.setVar("owningPlayer", state.owningPlayer)
        -- self.setVar("dropped", state.dropped or false)
    end

    SetupContextMenu()
end

function onSave()
    return JSON.encode({ linedrawing = linedrawing })
end

function check360()
    checkArc("full", 3, true)
end

function checkArc(type, range, friendly)
    self.clearButtons()
    for _, ruler in pairs(rulers) do
        destroyObject(ruler)
    end
    rulers = {}
    if rulerstype == type .. range then
        rulerstype = nil
    else
        if type == "full" then
            printToAll("Checking for ships at range " .. tostring(range) .. " from " .. self.getName(),
                color(1.0, 1.0, 0.2, 0.9))
        end
        rulers = Global.call("CheckArc", { ship = self, arctype = type, range = range, include_friendly_ships = friendly })
    end
    if rulers and #rulers > 0 then
        rulerstype = type .. range
        arcsopen = true
        local rotation = vector(0, -90, 0)
        local up = vector(0, 1, 0)
        if self.is_face_down then
            up = -1 * up
            rotation = rotation + vector(0, 0, 180)
        end
        local raise = 0.03 * up
        self.createButton({
            click_function = "removeArcs",
            function_owner = self,
            label          = "Remove",
            position       = raise,
            rotation       = rotation,
            width          = 170,
            height         = 150,
            font_size      = 40
        })
    else
        rulerstype = nil
        arcsopen = false
    end
end

function removeArcs()
    self.clearButtons()
    for _, ruler in pairs(rulers) do
        destroyObject(ruler)
        rulers = {}
    end
    rulerstype = nil
    arcsopen = false
end
