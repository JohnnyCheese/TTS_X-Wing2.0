function onLoad(save_state)
    self.addContextMenuItem("Color by player color",
        function(player_color)
            Global.call("API_SetPlayerConfig",
                { player_color = player_color, param_name = "TargetLockColorMode", value = "PlayerColor" })
        end, false)
    self.addContextMenuItem("Color by ship color id",
        function(player_color)
            Global.call("API_SetPlayerConfig",
                { player_color = player_color, param_name = "TargetLockColorMode", value = "ShipColorId" })
        end, false)
    self.addContextMenuItem("Display name off",
        function(player_color)
            Global.call("API_SetPlayerConfig",
                { player_color = player_color, param_name = "TargetLockDisplayName", value = "false" })
        end, false)
    self.addContextMenuItem("Display name on",
        function(player_color)
            Global.call("API_SetPlayerConfig",
                { player_color = player_color, param_name = "TargetLockDisplayName", value = "true" })
        end, false)
end
