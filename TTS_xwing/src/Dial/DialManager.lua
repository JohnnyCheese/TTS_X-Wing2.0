-- Dial manager module, By Eirik W. Munthe (eirikmun)
local D = {}

D.announceColor = color(0.1, 1, 0.1)

D.assignedDials = {}

D.assignDial = function(dial, ship, player)
    if ship then
        D.assignedDials[dial.getGUID()] = { dial = dial, ship = ship, player = player, set = false }
    else
        D.assignedDials[dial.getGUID()] = nil
    end
end

D.setDial = function(dial)
    local dialGUID = dial.getGUID()

    if D.assignedDials[dialGUID] then
        D.assignedDials[dialGUID].set = true

        local all_dials_set = true

        for _, assignedDial in pairs(D.assignedDials) do
            local playerColor = assignedDial.ship.getVar("owningPlayer") or ""

            if playerColor:lower() ~= "black" and assignedDial.set == false then
                all_dials_set = false
                break
            end
        end

        if all_dials_set then
            printToAll("All dials have been set by all players", D.announceColor)
        end
    else
        printToAll("Attempted to set dial, but dial not assigned", D.announceColor)
    end
end


D.unSetDial = function(dial)
    if D.assignedDials[dial.getGUID()] then
        D.assignedDials[dial.getGUID()].set = false
    else
        printToAll("Attempted to unset dial, but dial not assigned", D.announceColor)
    end
end

D.onObjectDestroyed = function(obj)
    --print("In table: " .. tostring(D.assignedDials[obj.getGUID()]))
    if D.assignedDials[obj.getGUID()] ~= nil then
        D.assignedDials[obj.getGUID()] = nil
        return
    end
    --print("Deleted obj: " .. tostring(obj))
    for idx, dial in pairs(D.assignedDials) do
        --print("In table: " .. tostring(dial.ship))
        if dial.ship == obj then
            D.assignedDials[idx] = nil
        end
    end
end

D.isAllDialsSet = function(player)
    for _, dial in D.assignedDials do
        if dial.player == player and dial.set == false then
            return false
        end
    end
    return true
end

return D
