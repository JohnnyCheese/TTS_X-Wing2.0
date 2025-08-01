require("TTS_lib.Util.Table")
local Dim = require("Dim")
local Players = require("Player.Players")

--[[
TODO: swiped from Dial onDropped(). Would be nice to have a library
    function to locate nearest/onDropped ship.
]]
function onDrop(player_color)
    local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 80 })
    if nearest ~= nil then
        local ship = nearest
        local owner_color = ship.getVar('owningPlayer')
        local owner_name = Players.getPlayerName(owner_color)
        local player_name = Players.getPlayerName(player_color)

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

