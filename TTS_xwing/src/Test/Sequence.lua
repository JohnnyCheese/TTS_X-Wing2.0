Sequence = {}
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

Sequence.NoSeq = Sequence:new()

return Sequence
