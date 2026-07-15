local M = {}
local Players = require("Player.Players")
local Dim = require("Dim")

M.enabled = false
M.range = Dim.Convert_mm_igu(400) -- Range 4

M.fog_check = function()
    if not M.enabled then return end

    local all_ships = getObjectsWithTag('Ship')
    local player_colors = {}

    -- Build list of active non-spectator player colors
    for _, p in ipairs(Player.getPlayers()) do
        if p.color ~= "Grey" and p.color ~= "Black" and p.color ~= "White" then
            table.insert(player_colors, p.color)
        end
    end

    for _, ship in pairs(all_ships) do
        local owner = ship.getVar('owningPlayer')
        if owner then
            local hide_from = {}
            for _, pc in ipairs(player_colors) do
                if not Players.areAllies(owner, pc) then
                    -- Check if any of pc's ships are within range 4
                    local visible = false
                    for _, friendly in pairs(all_ships) do
                        local friendly_owner = friendly.getVar('owningPlayer')
                        if friendly_owner and Players.areAllies(friendly_owner, pc) then
                            if ship.getPosition():distance(friendly.getPosition()) < M.range then
                                visible = true
                                break
                            end
                        end
                    end
                    if not visible then
                        table.insert(hide_from, pc)
                    end
                end
            end
            ship.setInvisibleTo(hide_from)
        end
    end
end

M.toggle = function()
    M.enabled = not M.enabled
    if not M.enabled then
        -- Unhide all ships
        for _, ship in pairs(getObjectsWithTag('Ship')) do
            ship.setInvisibleTo({})
        end
    end
    printToAll("Fog of War: " .. (M.enabled and "ON" or "OFF"), {1, 0.4, 0})
end

return M
