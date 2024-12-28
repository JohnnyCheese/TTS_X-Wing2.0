local Sequence = {}
Sequence.__index = Sequence

function Sequence:new(autoRegisterPlugins)
    local seq = setmetatable({ tasks = {}, context = {}, current = 0, plugins = {} }, Sequence)
    if autoRegisterPlugins then
        seq:registerPlugin("Click", require("Test.ButtonClickPlugin"))
        -- Add additional plugins here if needed
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
        task(...)
        seq:next()
    end, ...)
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

function Sequence:registerPlugin(name, plugin)
    assert(type(plugin) == "table", "Plugin must be a table or a valid module name.")
    self.plugins[name] = plugin
    if type(plugin.init) == "function" then
        plugin.init(self) -- Allow plugin to initialize with the Sequence instance
    end
    for method, func in pairs(plugin) do
        if method ~= "init" then
            assert(type(method) == "string" and type(func) == "function", "Invalid plugin format.")
            self[method] = func
        end
    end
end

Sequence.NoSeq = Sequence:new()

return Sequence
