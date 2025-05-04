Maneuver = require("Game.Mechanic.Movement.Maneuver")
Dim = require("Dim")

Data = {
    Size = Dim.mm_baseSize["objective"], -- size in mm of the Objective
    forwardAdjustment = 90               -- Adjust the forward vector to point towards the front of the objective
}

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
            "https://steamusercontent-a.akamaihd.net/ugc/16165383809089729786/91158470F9F6595B9CAFE8BEC5B6ABC6F296805E/",
        },
        {
            name = "2lbank",
            url =
            "https://steamusercontent-a.akamaihd.net/ugc/11835582287334705483/AF214D2D983BE579B49B613618D00ACC309BBDBE/",
        },
        {
            name = "2rbank",
            url =
            "https://steamusercontent-a.akamaihd.net/ugc/15921586568094763089/ADFDF12B39E39B0F010E6562A8D0AAE29D235FAF/"
        },
        {
            name = "2str",
            url =
            "https://steamusercontent-a.akamaihd.net/ugc/17674308348775822287/098DE4D5B1C3B9BEA935A0F853A9A3487D134ED7/",
        },
        {
            name = "3lbank",
            url =
            "https://steamusercontent-a.akamaihd.net/ugc/10169599065932991240/A102AD078F7D79CD499E9E5B7BB47EC98977C339/",
        },
        {
            name = "3lturn",
            url =
            "https://steamusercontent-a.akamaihd.net/ugc/13027851640763692630/9D8F1D773602C1B36E510502AE9DA785992948FF/",
        },
        {
            name = "3rbank",
            url =
            "https://steamusercontent-a.akamaihd.net/ugc/15936576224159661294/C3B41163694B334CE8FA444310B1C5CFA2492D72/",
        },
        {
            name = "3rturn",
            url =
            "https://steamusercontent-a.akamaihd.net/ugc/14656121321639792830/02490F087A0602F79FA1CB15C49BA5F46785406E/",
        },
        {
            name = "3str",
            url =
            "https://steamusercontent-a.akamaihd.net/ugc/15181445424374346036/817AFFC7556575484CC2DC4C3BF632E41C7057A0/",
        },
        {
            name = "4str",
            url =
            "https://steamusercontent-a.akamaihd.net/ugc/16534616205232610856/78D5C4711B117F5B5B94EE5278650F31039A14E7/",
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

-- Move your panel out 'offsetDist' meters from whatever your object considers "forward"
local function repositionPanel(offsetDist)
    -- 1) World-space forward vector (unit length)
    local fwd = self.getTransformForward() -- :contentReference[oaicite:0]{index=0}
    -- 2) World-space target point = object center + fwd * offsetDist
    local worldTarget = {
        x = self.getPosition().x + fwd.x * offsetDist,
        y = self.getPosition().y + fwd.y * offsetDist,
        -- z = self.getPosition().z + fwd.z * offsetDist,
        z = 10
    }
    -- 3) Convert that back into local UI coords
    local localPos = self.positionToLocal(worldTarget) -- :contentReference[oaicite:1]{index=1}

    -- 4) Write it into your panel’s XML
    local posStr = string.format("%.3f %.3f %.3f", localPos.x, localPos.y, localPos.z)
    self.UI.setAttribute("btnPanelB", "position", posStr) -- :contentReference[oaicite:2]{index=2}
end

function onLoad()
    if self.is_face_down then self.flip() end
    -- repositionPanel(52)
    setupAssets()
    Global.call("showMe", { self.getGUID() })
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

-- function onObjectLeave(player_color, left)
--     if left == self then
--         self.UI.setAttribute("btnPanelA", "active", "false")
--     end
-- end
