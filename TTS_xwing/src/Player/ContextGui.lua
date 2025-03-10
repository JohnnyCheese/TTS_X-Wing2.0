-- ~~~~~~
-- Script by Eirik 'Flippster' Munthe
-- Issues, history at: https://github.com/JohnnyCheese/TTS_X-Wing2.0
--
-- Module for handling object mouse over and contextual gui menus
-- ~~~~~~
local EventSub = require("TTS_Lib.EventSub.EventSub")

ContextGui = {}

ContextGui.playerTable = {}

ContextGui.onTimout = function(player_color, hovered_object)
    local prev_object = ContextGui.playerTable[player_color].context_object
    if prev_object ~= nil and prev_object.getVar("onContextClose") ~= nil then
        prev_object.call("onContextClose")
    end
    if hovered_object.getVar("onContextOpen") ~= nil then
        hovered_object.call("onContextOpen", player_color)
        ContextGui.playerTable[player_color].context_object = hovered_object
    end
end

ContextGui.onObjectHover = function(player_color, hovered_object)
    if ContextGui.playerTable[player_color] == nil then
        ContextGui.playerTable[player_color] = {}
    end
    local prev_object = ContextGui.playerTable[player_color].hover_object
    ContextGui.playerTable[player_color].hover_object = hovered_object
    if ContextGui.playerTable[player_color].timerid ~= nil then
        Wait.stop(ContextGui.playerTable[player_color].timerid)
    end
    if (prev_object ~= nil) and (prev_object.getVar("onHoverLeave") ~= nil) then
        prev_object.call("onHoverLeave", player_color)
    end
    if hovered_object ~= nil then
        if (hovered_object.getVar("onContextOpen") ~= nil) then
            ContextGui.playerTable[player_color].timerid = Wait.time(
                function() ContextGui.onTimout(player_color, hovered_object) end, 1)
        end
        if (hovered_object.getVar("onHoverEnter") ~= nil) then
            hovered_object.call("onHoverEnter", player_color)
        end
    end
end

EventSub.Register('onObjectHover', ContextGui.onObjectHover)

return ContextGui
