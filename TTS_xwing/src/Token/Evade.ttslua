-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'evade'

function onFlip(args)
    player = args.player

    local ship = Global.call("getShipTokenIsAssignedTo", { token = self })
    if ship then
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. " spent " .. ship.getName() .. 's evade token[-]')
    else
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. " spent a evade token[-]")
    end
    self.destruct()
end
