-- Hotkey module, By Eirik W. Munthe (eirikmun)
local EventSub = require("TTS_Lib.EventSub.EventSub")
local ObjType = require("TTS_Lib.ObjType.ObjType")
local H = {}

H.arcCheckFixedArcs = function(player_color, hovered_object, world_position, key_down_up)
    if hovered_object and ObjType.IsOfType(hovered_object, 'ship') then
        local fixed_arcs = hovered_object.call("GetFixedArcs")
        if #fixed_arcs > 0 then
            hovered_object.setDescription(Global.getTable("arcToCmnd")[fixed_arcs[1]])
        end
    end
end

H.arcCheckTurretArcs = function(player_color, hovered_object, world_position, key_down_up)
    if hovered_object and ObjType.IsOfType(hovered_object, 'ship') then
        hovered_object.setDescription("turret")
    end
end

H.TlAndRangeCheck = function(player_color, hovered_object, world_position, key_down_up)
    if hovered_object and ObjType.IsOfType(hovered_object, 'ship') then
        hovered_object.setDescription("r3a")
        proxyPerformAction({ hovered_object, 'Target Lock', player_color })
    end
end

H.onLoad = function()
    addHotkey("Arc Check, Fixed arcs", H.arcCheckFixedArcs, false)
    addHotkey("Arc Check, Turret arcs", H.arcCheckTurretArcs, false)
    addHotkey("R3 and TL", H.TlAndRangeCheck, false)
end

EventSub.Register('onLoad', H.onLoad)

return H
