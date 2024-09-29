-- ~~~~~~
-- Script by Eirik 'Flippster' Munthe
--
--
-- X-Wing player action module
-- Handles playe action events
local DiceControlModule = require("TTS_xwing.src.Game.Component.Dice.DiceControl")
local PlayerActionModule = {}

function onPlayerAction(player, action, targets)
    if action == Player.Action.Randomize then
        if DiceControlModule.enabled then
            for _, object in pairs(targets) do
                DiceControlModule.onObjectRandomize(object, player)
            end
        end
    elseif action == Player.Action.Delete then
        for _, object in pairs(targets) do
            if object.hasTag("NonDeletable") then
                return false
            end
        end
        return true
    elseif action == Player.Action.FlipOver then
        for _, object in pairs(targets) do
            if object.hasTag("ConfigCard") then
                for _, ship in pairs(getObjectsWithTag("Ship")) do
                    ship_data = ship.getTable("Data")
                    if ship_data.Config and (ship_data.Config.CardGUID == object.getGUID()) then
                        ship.call("SetConfiguration", { ConfigId = object.is_face_down and 1 or 2 })
                        break
                    end
                end
            elseif object.hasTag("Flippable") then
                object.call("onFlip", { player = player })
            end
        end
    end
end

return PlayerActionModule
