-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'stress'

onFlip = function(args)
    player = args.player

    local ship = Global.call("getShipTokenIsAssignedTo", { token = self })
    if ship then
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. " cleared " .. ship.getName() .. 's Stress Token[-]')
    else
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. " cleared a Stress Token[-]")
    end
    self.destruct()
end