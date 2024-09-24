-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'Force'

function onFlip(args)
    player = args.player
    local ship = Global.call("getShipTokenIsAssignedTo", { token = self })
    local force_owner = self.getVar("force_owner")
    local spent = " spent "
    if self.is_face_down then
        spent = " recovered "
    end
    if ship then
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. ship.getName() .. "s Force token[-]")
    elseif force_owner then
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. force_owner .. "s Force token[-]")
    else
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. "a Force token[-]")
    end
end
