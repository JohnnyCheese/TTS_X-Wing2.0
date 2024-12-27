local Sequence = {}
Sequence.__index = Sequence

function Sequence:new()
    return setmetatable({ tasks = {}, context = {}, current = 0 }, Sequence)
end

function Sequence:add(task, ...)
    assert(type(task) == "function", "Expected a function for task, got " .. tostring(task))
    table.insert(self.tasks, { func = task, args = { ... } })
end

function Sequence:next()
    if self.current <= #self.tasks then
        local task = self.tasks[self.current]
        self.current = self.current + 1
        task.func(self, table.unpack(task.args))
    end
end

function Sequence:start()
    self.current = 1
    self:next()
end

local function _executeButtonClick(seq, host_obj, label_pattern, player_color, alternate_key)
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

function Sequence:clickButton(host_obj, label_pattern, player_color, alternate_key)
    assert(host_obj, "Host object is nil in Sequence:push.")
    assert(type(label_pattern) == "string", "Label pattern must be a string.")
    self:add(_executeButtonClick, host_obj, label_pattern, player_color, alternate_key)
end

Sequence.NoSeq = Sequence:new()

return Sequence
