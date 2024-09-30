require("TTS_lib.Util.Table")
local Dim = require("Dim")
local Team = require("Player.Team")

--[[
TODO: swiped from Dial onDropped(). Would be nice to have a library
    function to locate nearest/onDropped ship.
]]
function onDrop(player_color)
    local spos = self.getPosition()
    local nearest = nil
    local minDist = Dim.Convert_mm_igu(80)
    for _, ship in pairs(getObjects()) do
        if ship.type == 'Figurine' and ship.name ~= '' then
            local pos = ship.getPosition()
            local dist = math.sqrt(math.pow((spos[1] - pos[1]), 2) + math.pow((spos[3] - pos[3]), 2))
            if dist < minDist then
                nearest = ship
                minDist = dist
            end
        end
    end
    if nearest ~= nil then
        local ship = nearest
        local owner_color = ship.getVar('owningPlayer')
        local owner_name = Team.getPlayerName(owner_color)
        local player_name = Team.getPlayerName(player_color)

        local initValue = string.match(self.getName(), ".*(%d)")
        ship.setDescription("init" .. initValue)

        local message = ""
        local orange = Color.Orange:toHex()
        if owner_color == player_color then
            message = string.format("%s assigned [%s]Initiative %d[-] to %s", player_name, orange, initValue,
                ship.getName())
        else
            message = string.format("%s assigned [%s]Initiative %d[-] to %s's %s ", player_name, orange, initValue,
                owner_name, ship.getName())
        end
        printToAll(message, player_color)
        self.destruct()
    end
end

