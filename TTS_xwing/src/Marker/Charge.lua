-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'Charge'

function onFlip(args)
    player = args.player
    local ship = Global.call("getShipTokenIsAssignedTo", { token = self })
    local charge_name = self.getVar("charge_name")
    local charge_owner = self.getVar("charge_owner")
    if charge_name then
        charge_name = charge_name .. " "
    else
        charge_name = ""
    end
    local spent = " spent "
    if self.is_face_down then
        spent = " recovered "
    end
    if ship then
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. ship.getName() .. "s " .. charge_name .. "charge token[-]")
    elseif charge_owner then
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. charge_owner .. "s " .. charge_name .. "charge token[-]")
    else
        printToAll("[" .. Color.fromString(player.color):toHex() .. "]" .. player.steam_name .. spent .. "a " .. charge_name .. "charge token[-]")
    end
end
