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

function onContextOpen(player_color)
    showBtn()
end

function showBtn()
    if stat == false and ship ~= nil then
        if self.is_face_down then
            self.UI.setAttribute("btnPanel", "rotation", "180 0 0")
            self.UI.setAttribute("btnPanel", "position", "0 0 30")
        else
            self.UI.setAttribute("btnPanel", "rotation", "0 0 180")
            self.UI.setAttribute("btnPanel", "position", "0 0 -30")
        end
        self.UI.show("btnPanel")
        stat = true
    end
end

function hideBtn()
    if stat == true then
        self.UI.hide("btnPanel")
        stat = false
    end
end

function BstS()
    ship.setDescription('s1b')
end

function BlF()
    ship.setDescription('rl1')
end

function Bl()
    ship.setDescription('rl2')
end

function BlB()
    ship.setDescription('rl3')
end

function BrF()
    ship.setDescription('rr1')
end

function Br()
    ship.setDescription('rr2')
end

function BrB()
    ship.setDescription('rr3')
end

function RotL()
    ship.setDescription('tl4')
end

function RotR()
    ship.setDescription('tr4')
end

function Delete()
    self.destruct()
end
