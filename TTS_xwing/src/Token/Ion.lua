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
__XW_TokenType = 'ion'

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
        self.UI.hide("Move")
    end
end

-- Set function for external calls
function manualSet(arg)
    ship = arg.ref
    set = true
    self.setRotationSmooth(ship.getRotation())
end

-- Set name on drop near a ship
function onDropped()
    local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 100 })
    if nearest ~= nil then
        ship = nearest
        set = true
        self.setRotation(nearest.getRotation())

        printToAll(ship.getName() .. " takes an ion token")
    else
        ship = nil
        set = false
    end
end

stat = false

function onContextOpen(player_color)
    if set then
        showBtn()
    end
end

function showBtn()
    if stat == false and ship ~= nil then
        if self.is_face_down then
            self.UI.setAttribute("Center", "rotation", "180 0 0")
            self.UI.setAttribute("Center", "position", "0 0 30")
        else
            self.UI.setAttribute("Center", "rotation", "0 0 180")
            self.UI.setAttribute("Center", "position", "0 0 -30")
        end
        self.UI.show("Center")
        stat = true
    end
end

function hideBtn()
    if stat == true then
        self.UI.hide("Center")
        stat = false
    end
end

function ionMove()
    ship.setDescription('s1')
end

function ionMoveL()
    ship.setDescription('bl1')
end

function ionMoveR()
    ship.setDescription('br1')
end

function Delete()
    self.destruct()
end
