-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'Energy'

-- Assign to the nearest ship on drop (mirrors Token/Cloak.lua:66-76).
function onDropped()
    local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 80 })
    if nearest ~= nil then
        Global.call("API_AssignToken", { token = self, ship = nearest })
        printToAll('Energy token assigned to ' .. nearest.getName(), { 0.2, 0.2, 1 })
    end
end

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
