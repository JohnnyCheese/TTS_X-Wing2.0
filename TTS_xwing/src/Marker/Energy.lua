-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'Energy'

function onFlip(args)
    player = args.player
    local ship = Global.call("getShipTokenIsAssignedTo", { token = self })
    local energy_owner = self.getVar("energy_owner")
    local spent = " spent "
    if self.is_face_down then
        spent = " recovered "
    end
    if ship then
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. ship.getName() .. "s energy token[-]")
    elseif energy_owner then
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. energy_owner .. "s energy token[-]")
    else
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. "a energy token[-]")
    end
end
