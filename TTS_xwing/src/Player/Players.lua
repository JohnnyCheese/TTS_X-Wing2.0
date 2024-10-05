local Players = {}

-- Spieler
-- Function to get player by color
Players.getPlayerByColor = function(color)
    for _, player in pairs(Player.getPlayers()) do
        if player.color == color then
            return player
        end
    end
    return nil
end

Players.getPlayerName = function(player_color)
    local player = Players.getPlayerByColor(player_color)
    if player ~= nil then
        return player.steam_name or player_color
    end
    return player_color or "no one"
end

-- Function to check if two players are on the same team
Players.areAllies = function(color1, color2)
    if (color1 == color2) then
        return true
    end
    local player1 = Players.getPlayerByColor(color1)
    local player2 = Players.getPlayerByColor(color2)

    if player1 == nil or player2 == nil then
        print("One or both players not found.")
        return false
    end

    return player1.team == player2.team
end

return Players
