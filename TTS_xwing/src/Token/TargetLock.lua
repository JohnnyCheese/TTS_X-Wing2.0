-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- Target lock color and name script
-- ~~~~~~
local Dim = require("Dim")

-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'targetLock'

-- Was this lock tinted and named already?
set = false

-- Colors for tinting on pickup
colorTable = {}
colorTable['Red'] = { 1, 0, 0 }
colorTable['Brown'] = { 0.6, 0.4, 0 }
colorTable['White'] = { 1, 1, 1 }
colorTable['Pink'] = { 1, 0.4, 0.8 }
colorTable['Purple'] = { 0.8, 0, 0.8 }
colorTable['Blue'] = { 0, 0, 1 }
colorTable['Teal'] = { 0.2, 1, 0.8 }
colorTable['Green'] = { 0, 1, 0 }
colorTable['Yellow'] = { 1, 1, 0 }
colorTable['Orange'] = { 1, 0.4, 0 }
colorTable['Black'] = { 0.2, 0.2, 0.2 }

--[[
TODO: TargetLocks have an owner and an assigned ship. Perhaps we can handle these behaviors with tags?
]]
-- Save self state
function onSave()
    if set then
        local state = { set = set, text = self.UI.getAttribute("IdLabel", "text") }
        return JSON.encode(state)
    end
end

-- Restore self state
function onLoad(save_state)
    if save_state ~= '' and save_state ~= 'null' and save_state ~= nil then
        local state = JSON.decode(save_state)
        set = state.set
        if state.text then
            self.UI.setAttribute("IdLabel", "text", state.text)
        end
    end
end

function onFlip(args)
    if set then
        player = args.player
        local target = Global.call("getShipTokenIsAssignedTo", { token = self })
        if target then
            printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. " spent " .. self.getName() .. "s target lock on " .. target.getName() .. "[-]")
        else
            printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. " spent " .. self.getName() .. "s target lock[-]")
        end

        self.destruct()
    end
end

-- Set function for external calls
function manualSet(arg)
    set = true
    if arg.color then
        self.setColorTint(colorTable[arg.color])
    end
end

-- Tint on pick up
function onPickedUp()
    if not set and self.held_by_color ~= nil then
        self.setColorTint(colorTable[self.held_by_color])
    end
end

-- Set name on drop near a ship or obstacle
function onDropped(player_color)
    local spos = self.getPosition()
    local nearest = nil
    local minDist = Dim.Convert_mm_igu(100)
    for _, object in pairs(getObjectsWithAnyTags({ 'Ship', 'Obstacle' })) do
        local pos = object.getPosition()
        local dist = math.sqrt(math.pow((spos[1] - pos[1]), 2) + math.pow((spos[3] - pos[3]), 2))
        if dist < minDist then
            nearest = object
            minDist = dist
        end
    end

    if not set then
        if nearest ~= nil and nearest.hasTag('Ship') then
            setOwner({ ship = nearest, player = player_color })
        end
    else -- Allready set, now Assign to target
        assignToShip({ ship = nearest })
    end
end

-- Sets the owner of the token. This is the ship responsible for the target
-- lock, and who it is named after. Externally accessible.
function setOwner(args)
    local ship = args.ship
    self.setName(ship.getName())
    printToAll('Target lock named for ' .. ship.getName(), { 0.2, 0.2, 1 })
    local displayName = true
    if args.player then
        if Global.call("API_GetPlayerConfig", { player_color = args.player, param_name = "TargetLockColorMode" }) == "ShipColorId" then
            local ColorId = ship.getTable("Data").ColorId or nil
            if ColorId and ColorId.a > 0 then
                self.setColorTint(ColorId)
            end
        end
        displayName = Global.call("API_GetPlayerConfig", {
            player_color = args.player,
            param_name =
            "TargetLockDisplayName"
        }) == "true"
    end
    if displayName then
        self.UI.setAttribute("IdLabel", "text", getIdText(ship.getName()))
    end
    self.setRotationSmooth(ship.getRotation(), false, true)
    set = true
end

-- Assigns the token to a ship. This is the ship being target locked, and which
-- the token sits beside. Externally accessible
function assignToShip(args)
    local ship = args.ship
    Global.call("API_AssignToken", { token = self, ship = ship })
end

function getIdText(fullName)
    trimmedname = fullName:match '^%s*"(.*%S)"' or fullName
    if #trimmedname < 20 then
        return trimmedname
    end
    initials = trimmedname:sub(1, 1)
    for m in string.gmatch(trimmedname, "%s(%w)") do
        initials = initials .. m
    end
    return initials
end
