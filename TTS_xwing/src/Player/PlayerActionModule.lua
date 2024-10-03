-- ~~~~~~
-- Script by Eirik 'Flippster' Munthe
--
--
-- X-Wing player action module
local DiceControlModule = require("Game.Component.Dice.DiceControl")

-- Define actions for various tags
-- Each tag has a handler for each Player.Action
local tagActions = {
    NonDeletable = {
        [Player.Action.Delete] = function(object, player)
            return false
        end
    },
    ConfigCard = {
        [Player.Action.FlipOver] = function(object, player)
            for _, ship in pairs(getObjectsWithTag("Ship")) do
                local ship_data = ship.getTable("Data")
                if ship_data.Config and (ship_data.Config.CardGUID == object.getGUID()) then
                    ship.call("SetConfiguration", { ConfigId = object.is_face_down and 1 or 2 })
                    break
                end
            end
        end
    },
    Flippable = {
        [Player.Action.FlipOver] = function(object, player)
            object.call("onFlip", { player = player }) -- Calls the flip behavior for Flippable objects
        end
    },
    DiceControl = {
        [Player.Action.Randomize] = function(object, player)
            DiceControlModule.onObjectRandomize(object, player) -- Handle randomizing objects
        end
    },
    RemoveOnFlip = {
        [Player.Action.FlipOver] = function(object, player)
            return Global.call("API_RemoveTokenOnFlip", { object = object, player = player })
        end
    }
}

-- Handles the player actions based on tags
function onPlayerAction(player, action, targets)
    for _, object in pairs(targets) do
        local tags = object.getTags()
        for _, tag in ipairs(tags) do
            local tagAction = tagActions[tag]
            if tagAction and tagAction[action] then
                if tagAction[action](object, player) == false then
                    return false
                end
            end
        end
    end
    return true
end

-- The following are Player.Action.* constants. They are `int`s
--Copy | Copy (or commence cloning) the targets.
--Cut | Cut (copy and delete) the targets.
--Delete | Delete the targets.
--FlipIncrementalLeft | Incrementally rotate the targets counter-clockwise around their flip axes, typically the scene's Z-axis.
--FlipIncrementalRight | Incrementally rotate the targets clockwise around their flip axes, typically the scene's Z-axis.
--FlipOver | Rotate the targets 179 degrees around their flip axes, typically the scene's Z-axis i.e. toggle the targets between face up and face down.
--Group | Group the targets.
--Paste | Paste (spawn) the targets.
--PickUp | Pick up the targets.
--Randomize | Randomize the targets.
--RotateIncrementalLeft | Rotate the targets incrementally, typically counter-clockwise around the scene's Y-axis. Instead of being rotated exclusively around the Y-axis, dice will be rotated to the previous rotation value.
--RotateIncrementalRight | Rotate the targets incrementally, typically clockwise around the scene's Y-axis. Instead of being rotated exclusively around the Y-axis, dice will be rotated to the next rotation value.
--RotateOver | Rotate the targets 179 degrees around the scene's Y-axis.
--Select | Add the targets to the player's selection.
--Under | Move the targets underneath objects below them on table.
