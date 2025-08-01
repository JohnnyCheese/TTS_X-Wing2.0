---@class ButtonClickPlugin
--- A plugin to simulate button clicks in Tabletop Simulator.
--- Allows for automated button interactions as part of a sequence.

--- Warning: Argument passing to a button's click_function is treated as a table of values.
--- This behavior differs from expected direct argument passing.
--- Some modification may be necessary to detect individual arguments versus a table of arguments.

local ButtonClickPlugin = {}

--- Simulates a button click on an object by searching for a button with a specific label pattern.
--- If a matching button is found, it triggers the button's `click_function` with the provided parameters.
--- @param seq Sequence The Sequence instance managing the flow of operations.
--- @param host_obj table The object hosting the buttons to be clicked.
--- @param label_pattern string The pattern to match against button labels.
--- @param player_color string The player's color initiating the click.
--- @param alternate_key boolean|nil Optional alternate key for the button click.
function ButtonClickPlugin.clickButton(seq, host_obj, label_pattern, player_color, alternate_key)
    assert(host_obj, "Host object is nil in clickButton().")
    assert(type(label_pattern) == "string", "Label pattern must be a string.")

    local function findButton(obj, pattern)
        for _, button in ipairs(obj.getButtons() or {}) do
            if string.match(button.label, pattern) then
                return button
            end
        end
        return nil
    end

    local button = nil

    Wait.condition(function()
        if button ~= nil then
            host_obj.call(button.click_function, { host_obj, player_color, alternate_key })
        end
        seq:next()
    end, function()
        button = findButton(host_obj, label_pattern)
        return button ~= nil and (not button.spawning)
    end, 4.0)
end

return ButtonClickPlugin
