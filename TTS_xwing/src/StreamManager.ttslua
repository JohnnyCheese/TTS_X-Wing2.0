-- Stream manager, by Eirik Munthe
-- This manager display stream info
local M = {}

M.PresentedDice = {}

M.RollTimeout = 5

M.announcement_timer = nil

M.PanelOffset = {
    left = {
        "-400 200",
        "-400 0",
        "-400 -200",
        "-400 400",
        "-400 -400",
        "-400 600",
        "-400 -600"
    },
    right = {
        "400 200",
        "400 0",
        "400 -200",
        "400 400",
        "400 -400",
        "400 600",
        "400 -600"
    }
}

M.PanelRotation = {
    left = "0 0 0",
    right = "0 0 180"
}

M.PanelPlayerAlignment = {
    left = "UpperLeft",
    right = "LowerRight"
}

M.PanelPlayerOffset = {
    left = "10 -10",
    right = "-10 10"
}

M.PresentationCounter = 0

M.Dice = function(id, number)
    return
    {
        image = "Presentation" .. id .. "Die" .. number,
        modification = "Presentation" .. id .. "Die" .. number .. "Mod",
        presented = false,
        result = "Blank",
        dice_object = nil
    }
end

M.Presentation = function(color, side)
    local id = M.PresentationCounter + 1
    M.PresentationCounter = id
    local presentation = {
        timer_id = nil,
        panel = {
            ui = "PresentationPanel" .. id,
            background = "PresentationPanel" .. id .. "Background",
            side = side,
            player_name = "PresentationPanel" .. id .. "Player"
        },
        player = {
            color = color,
        },
        dice =
        {
            M.Dice(id, 1),
            M.Dice(id, 2),
            M.Dice(id, 3),
            M.Dice(id, 4),
            M.Dice(id, 5),
            M.Dice(id, 6),
        }
    }
    presentation.SetDiceResult = function(result)
        M.PresentedDice[result.die] = presentation
        for _, dice in pairs(presentation.dice) do
            if not dice.presented or dice.dice_object == result.die then
                Global.UI.setAttribute(dice.image, "image", result.type .. result.value)
                Global.UI.setAttribute(dice.image, "active", "true")
                dice.presented = true
                dice.dice_object = result.die
                break;
            end
        end
        --Global.UI.setAttribute(presentation.panel.ui, "active", "true")
        if presentation.timer_id then
            Wait.stop(presentation.timer_id)
        else
            Global.UI.show(presentation.panel.ui)
        end
        presentation.timer_id = Wait.time(presentation.Timout, M.RollTimeout)
    end

    presentation.Timout = function()
        for _, dice in pairs(presentation.dice) do
            Global.UI.setAttribute(dice.image, "image", "RedBlank")
            Global.UI.setAttribute(dice.image, "active", "false")
            if dice.dice_object then
                M.PresentedDice[dice.dice_object] = nil
            end
        end
        Global.UI.hide(presentation.panel.ui)
        --Global.UI.setAttribute(presentation.panel.ui, "active", "false")
        presentation.timer_id = nil
    end

    Global.UI.setAttribute(presentation.panel.background, "rotation", M.PanelRotation[side])
    Global.UI.setAttribute(presentation.panel.ui, "offsetXY", M.PanelOffset[side][id])
    Global.UI.setAttribute(presentation.panel.background, "color", "#" .. Color[color]:toHex(false) .. "88")
    Global.UI.setAttribute(presentation.panel.background, "active", "true")
    Global.UI.setAttribute(presentation.panel.player_name, "alignment", M.PanelPlayerAlignment[side])
    Global.UI.setAttribute(presentation.panel.player_name, "offsetXY", M.PanelPlayerOffset[side])
    --Global.UI.setAttribute(presentation.panel.ui, "active", "true")

    return presentation
end

M.Announce = function(text, color)
    if M.announcement_timer then
        Wait.stop(M.announcement_timer)
        Global.UI.hide("AnnouncementPanel")
        Wait.time(function() M.Announce(text, color) end, 0.5)
    else
        Global.UI.setAttribute("AnnouncementImage", "color", "#" .. Color[color]:toHex(false) .. "88")
        Global.UI.show("AnnouncementPanel")
        Global.UI.setValue("AnnouncementText", text)
        M.announcement_timer = Wait.time(
            function()
                Global.UI.hide("AnnouncementPanel")
                M.announcement_timer = nil
            end, 2)
    end
end

M.SetDiceData = function(DiceData, player)
    local natties = false
    if #DiceData > 2 then
        natties = true
    end
    for _, result in pairs(DiceData) do
        local presentation = nil
        if M.PresentedDice[result.die] then
            presentation = M.PresentedDice[result.die]
        else
            presentation = M.Presentations[player]
        end
        if presentation then
            presentation.SetDiceResult(result)
        end
        if (result.modified == true) or (result.value == "Blank") or (result.value == "Eye") then
            natties = false
        end
    end
    if natties then
        M.Announce("Natties!", player);
    end
end

M.Presentations = {
    --Blue = M.Presentation("Blue", "right"),
    --orange = M.Presentation("Orange", "left")
}


Wait.time(function()
    M.Presentations['Orange'] = M.Presentation("Orange", "left")
    M.Presentations['Blue'] = M.Presentation("Blue", "right")
end
, 1.0)

--[[
Wait.time(function()
  M.SetDiceData({
    {
      die = "temp",
      value = "Hit",
      modified = false,
      type = "Red",
    },
    {
      die = "temp2",
      value = "Crit",
      modified = false,
      type = "Red",
    },
    {
      die = "temp3",
      value = "Hit",
      modified = false,
      type = "Red",
    }
  }, Player.Blue.color)
end
  , 5.0)

Wait.time(function()
  M.SetDiceData({
    {
      die = "temp3",
      value = "Eye",
      modified = true,
      type = "Red",
    }
  }, Player.Blue.color)
end
  , 10.0)

Wait.time(function()
  M.SetDiceData({
    {
      die = "temp3",
      value = "Hit",
      modified = true,
      type = "Red",
    }
  }, Player.Blue.color)
end
  , 12.0)

  Wait.time(function()
    M.SetDiceData({
      {
        die = "g1",
        value = "Evade",
        modified = false,
        type = "Green",
      },
      {
        die = "g2",
        value = "Evade",
        modified = false,
        type = "Green",
      },
      {
        die = "g3",
        value = "Evade",
        modified = false,
        type = "Green",
      }
    }, Player.Orange.color)
  end
    , 14.0)

  Wait.time(function()
    M.SetDiceData({
      {
        die = "temp3",
        value = "Hit",
        modified = true,
        type = "Red",
      }
    }, Player.Blue.color)
  end
    , 20.0)
]]

M.AddPresentation = function(color, side)
    M.Presentations[color] = M.Presentation(color, side)
end

return M
