-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'Shield'

function onFlip(args)
    player = args.player
    local ship = Global.call("getShipTokenIsAssignedTo", { token = self })
    local shield_owner = self.getVar("shield_owner")
    local spent = " lost "
    if self.is_face_down then
        spent = " recovered "
    end
    if ship then
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. ship.getName() .. "s shield token[-]")
    elseif shield_owner then
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. shield_owner .. "s shield token[-]")
    else
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. "a shield token[-]")
    end
end
