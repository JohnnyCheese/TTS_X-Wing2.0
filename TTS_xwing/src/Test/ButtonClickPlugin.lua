local ClickPlugin = {}

function ClickPlugin.init(sequence)
    print("ClickPlugin registered with Sequence!")
end

function ClickPlugin.clickButton(seq, host_obj, label_pattern, player_color, alternate_key)
    assert(host_obj, "Host object is nil in ClickPlugin:clickButton.")
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

return ClickPlugin
