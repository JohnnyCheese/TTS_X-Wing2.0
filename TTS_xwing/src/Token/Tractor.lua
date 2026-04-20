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
__XW_TokenType = 'tractor'

-- Was this lock tinted and named already?
set = false

-- Colors for tinting on pickup

-- Save self state
function onSave()
    if set then
        local state = { set = set }
        return JSON.encode(state)
    end
end

-- Restore self state
function onLoad(save_state)
    if save_state ~= '' and save_state ~= 'null' and save_state ~= nil then
        set = JSON.decode(save_state).set
        --[[
        assetTable = {
            {name="BoostS", url="http://cloud-3.steamusercontent.com/ugc/816750219423811083/7C1C7A560593EDFF93D9D5DA5A79B44ADF504860/"},
            {name="BarrelL", url="http://cloud-3.steamusercontent.com/ugc/816750219423807162/1DA310CD1B412508B5213EE37476F2A2EB9B4A38/"},
            {name="BarrelLF", url="http://cloud-3.steamusercontent.com/ugc/816750219423808004/8BEBBB8A447DA3F335AE361885BD3E8599C95490/"},
            {name="BarrelLB", url="http://cloud-3.steamusercontent.com/ugc/816750219423808688/985FC18E99432A2C05B54F2B0E5C151BD6B582D2/"},
            {name="BarrelR", url="http://cloud-3.steamusercontent.com/ugc/816750219423809409/5196FEE75132E292D9E22F7B3054F396CC4EB04A/"},
            {name="BarrelRF", url="http://cloud-3.steamusercontent.com/ugc/816750219423809765/75916DF74C1B0A8AC752204D20622EAC349D7723/"},
            {name="BarrelRB", url="http://cloud-3.steamusercontent.com/ugc/816750219423810373/C796629CCC0BE925B9CCFF9090439C21534EB9EC/"}}

        self.UI.setCustomAssets(assetTable)--]]
    end
end

-- Set function for external calls
function manualSet(arg)
    ship = arg.ref
    set = true
    self.UI.setAttribute("Center", "active", "true")
end

-- Set name on drop near a ship
function onDropped()
    local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 100 })
    if nearest ~= nil then
        ship = nearest
        set = true

        self.setRotation(nearest.getRotation())

        printToAll(ship.getName() .. " takes a tractor token")
    else
        ship = nil
        set = false
    end
end

stat = false
proxyMode = false

local function updatePanelFacing()
    if self.is_face_down then
        self.UI.setAttribute("BtnPanel", "rotation", "180 0 0")
        self.UI.setAttribute("BtnPanel", "position", "0 0 30")
        self.UI.setAttribute("ProxyPanel", "rotation", "180 0 0")
        self.UI.setAttribute("ProxyPanel", "position", "0 0 30")
    else
        self.UI.setAttribute("BtnPanel", "rotation", "0 0 180")
        self.UI.setAttribute("BtnPanel", "position", "0 0 -30")
        self.UI.setAttribute("ProxyPanel", "rotation", "0 0 180")
        self.UI.setAttribute("ProxyPanel", "position", "0 0 -30")
    end
end

local function showProxyPanel()
    updatePanelFacing()
    self.UI.show("ProxyPanel")
end

local function hideProxyPanel()
    self.UI.hide("ProxyPanel")
end

local function clearTractorProxies()
    if ship ~= nil then
        Global.call("DeleteShipProxies", { ship_guid = ship.getGUID() })
    end
    proxyMode = false
    hideProxyPanel()
end

function onProxyMoveSelected(args)
    proxyMode = false
    hideProxyPanel()
end

local function startTractorProxySelection(direction)
    if ship == nil then
        return
    end

    local move_codes = nil
    if direction == "left" then
        move_codes = {
            front = "rl1",
            center = "rl2",
            back = "rl3",
        }
    elseif direction == "right" then
        move_codes = {
            front = "rr1",
            center = "rr2",
            back = "rr3",
        }
    else
        return
    end

    clearTractorProxies()
    proxyMode = true
    Global.call("SpawnProxyOptions", {
        ship_guid = ship.getGUID(),
        move_codes = move_codes,
        callback_guid = self.getGUID(),
        callback_function = "onProxyMoveSelected",
    })
    hideBtn()
    showProxyPanel()
end

function onContextOpen(player_color)
    showBtn()
end

function showBtn()
    if stat == false and ship ~= nil and proxyMode == false then
        updatePanelFacing()
        self.UI.show("BtnPanel")
        stat = true
    end
end

function hideBtn()
    if stat == true then
        self.UI.hide("BtnPanel")
        stat = false
    end
end

function BstS()
    ship.setDescription('s1b')
end

function Bl()
    startTractorProxySelection("left")
end

function Br()
    startTractorProxySelection("right")
end

function RotL()
    ship.setDescription('tl4')
end

function RotR()
    ship.setDescription('tr4')
end

function Delete()
    clearTractorProxies()
    self.destruct()
end

function Cancel()
    clearTractorProxies()
end
