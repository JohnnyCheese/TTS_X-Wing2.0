local Dim = require("Dim")

ShipVerification = {}

ShipVerification.colliders = {
    small =
    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Small_base_Collider.obj',
    medium =
    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Medium_base_Collider.obj',
    large =
    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Large_base_Collider.obj',
    huge =
    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Huge_base_Collider.obj'
}

ShipVerification.VerifyShipBase = function(ship)
    if ship.getScale() ~= Dim.mm_ship_scale then
        printToAll("Ship " .. ship.getName() .. " has wrong scale, don't scale the ships please!", color(1, 0.2, 0.2))
        ship.setScale(Dim.mm_ship_scale)
    end
    local size = ship.getTable("Data").Size
    if size == nil then
        printToAll("Ship " .. ship.getName() .. " does not have size data! Please spawn a proper ship", color(1, 0.2, 0.2))
        return false
    else
        if ship.getCustomObject().collider ~= ShipVerification.colliders[size] then
            printToAll("Ship " .. ship.getName() .. " does not have proper collission data! Please spawn a proper ship", color(1, 0.2, 0.2))
            return false
        end
    end
    return true
end

return ShipVerification
