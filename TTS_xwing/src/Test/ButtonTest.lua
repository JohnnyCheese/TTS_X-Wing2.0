local Sequence = require("Test.Sequence")

TestButton = {}

TestButton.Click = function(seq, host_obj, label_pattern, player_color, alternate_key)
    seq = seq or Sequence.NoSeq

    local target = nil
    Wait.condition(function()
        TestButton.pressButton(target, host_obj, player_color, alternate_key)
        seq:next()
    end, function()
        target = TestButton.findButton(host_obj, label_pattern)
        return target ~= nil and (not target.spawning)
    end, 5.0)
end

TestButton.findButton = function(host_obj, label_pattern)
    local buttons = host_obj.getButtons()
    local target = nil
    for _, button in ipairs(buttons) do
        if string.match(button.label, label_pattern) then
            target = button
            break
        end
    end
    return target
end

TestButton.pressButton = function(target, host_obj, player_color, alternate_key)
    if host_obj == nil then
        printToAll("pressButton: host_obj is nil", { 1, 0, 0 })
        return
    end
    if target == nil then
        printToAll("Button Press Test Failed: Button not found", { 1, 0, 0 })
        return
    end

    host_obj.call(target.click_function, { host_obj, player_color, alternate_key })
end

return TestButton
