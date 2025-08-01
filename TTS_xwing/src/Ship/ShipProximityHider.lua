-- Hotkey module, By Eirik W. Munthe (eirikmun)
local M = {}
M.update_delay = 0.2
M.hide_distance = 3.5
M.tint_values = { far = color(1, 1, 1, 1), close = color(1, 1, 1, 0.2) }

M.size_mod = { small = 0, medium = 0.8, large = 1.6, huge = 1.2 }

M.proximity_check = function()
    for _, hider_ship in pairs(getObjectsWithAllTags({ 'Ship', 'ProximityHider' })) do
        local is_close = "far"
        local hider_pos = hider_ship.getPosition()
        for _, other_ship in pairs(getObjectsWithTag('Ship')) do
            if hider_ship ~= other_ship then
                local size = other_ship.getTable('Data').Size or 'small'
                --print(string.format("Distance between %s and %s is %f", hider_ship.getName(), other_ship.getName(), hider_pos:distance(other_ship.getPosition())))
                if hider_pos:distance(other_ship.getPosition()) < (M.hide_distance + M.size_mod[size]) then
                    is_close = "close"
                    break
                end
            end
        end
        if hider_ship.getVar("SetProximityHiding") then
            hider_ship.call("SetProximityHiding", is_close == "close")
        else
            if hider_ship.getColorTint() ~= M.tint_values[is_close] then
                --print(string.format("Changing tint of %s", hider_ship.getName()))
                hider_ship.setColorTint(M.tint_values[is_close])
            end
        end
    end
end


return M
