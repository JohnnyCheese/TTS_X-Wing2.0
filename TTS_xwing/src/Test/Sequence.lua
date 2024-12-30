local Sequence = {}
Sequence.__index = Sequence

function Sequence:new(autoRegisterPlugins)
    local seq = setmetatable({
        tasks = {},
        result = nil, -- Framework-managed result
        vars = {},    -- User-defined space
        current = 0,
        plugins = {}
    }, Sequence)

    if autoRegisterPlugins then
        seq:registerPlugin("Click", require("Test.ButtonClickPlugin"))
        seq:registerPlugin("Cast", require("Test.CastGroupPlugin"))
        seq:registerPlugin("Mover", require("Test.MoverPlugin"))
    end

    return seq
end

function Sequence:add(...)
    self:addStep(...)
end

function Sequence:addStep(step, ...)
    assert(type(step) == "function", "Expected a function for step, got " .. tostring(step))
    table.insert(self.tasks, { func = step, args = { ... } })
end

function Sequence:addTask(task, ...)
    assert(type(task) == "function", "Expected a function for task, got " .. tostring(task))
    self:addStep(function(seq, ...)
        seq.result = task(...)
        seq:next()
    end, ...)
end

function Sequence:next()
    if self.current <= #self.tasks then
        local task = self.tasks[self.current]
        self.current = self.current + 1
        task.func(self, table.unpack(task.args)) -- Assign result to framework result
    end
end

function Sequence:start()
    self.current = 1
    self:next()
end

function Sequence:waitCondition(runFunc, conditionFunc, timeout, timeoutFunc)
    self:addStep(function(seq)
        Wait.condition(function()
            if runFunc then
                runFunc()
            end
            seq:next()
        end, conditionFunc, timeout, timeoutFunc)
    end)
end

function Sequence:waitFrames(frames)
    self:addStep(function(seq)
        Wait.frames(function()
            seq:next()
        end, frames)
    end)
end

function Sequence:registerPlugin(name, plugin)
    assert(type(plugin) == "table", "Plugin must be a table or a valid module name.")
    self.plugins[name] = plugin
    for method, func in pairs(plugin) do
        assert(type(method) == "string" and type(func) == "function", "Invalid plugin format.")
        self[method] = function(self, ...)
            self:add(func, ...)
        end
    end
end

Sequence.NoSeq = Sequence:new()

return Sequence
