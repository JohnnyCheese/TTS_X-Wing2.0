-- ~~~~~~
-- Script by Eirik 'Flippster' Munthe
--
--
-- X-Wing configuration manager module,
-- Stores global table configurations, and per-player configurations
-- ~~~~~~
local EventSub = require("TTS_Lib.EventSub.EventSub")

ConfigManager = {
    PlayerConfigs = {},
    SetCallbacks = {},
    DefaultValues = {
        TargetLockColorMode = "ShipColorId",
        TargetLockDisplayName = "true"
    }
}

ConfigManager.GetPlayerName = function(player_color)
    local player = Player[player_color]
    return "[" .. Color.fromString(player.color):toHex(false) .. "]" .. player.steam_name .. "[-]"
end

ConfigManager.GetConfig = function(player_color, param_name)
    if ConfigManager.PlayerConfigs[player_color] then
        return ConfigManager.PlayerConfigs[player_color][param_name] or ConfigManager.DefaultValues[param_name]
    end
    return ConfigManager.DefaultValues[param_name] or nil
end

ConfigManager.SetConfig = function(player_color, param_name, value)
    if value then
        if ConfigManager.PlayerConfigs[player_color] == nil then
            ConfigManager.PlayerConfigs[player_color] = {}
        end
        ConfigManager.PlayerConfigs[player_color][param_name] = value
        printToAll( ConfigManager.GetPlayerName(player_color) .. " changed " .. param_name .. " configuration to " .. tostring(value), color(0.1, 1, 1))
        if ConfigManager.SetCallbacks[param_name] ~= nil then
            ConfigManager.SetCallbacks[param_name](player_color, value)
        end
    end
end

return ConfigManager
