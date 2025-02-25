--- @class Sequence
--- A modular framework for managing and executing sequences of tasks in Lua.
--- Provides functionality for step-by-step execution, waiting for conditions, and integration with plugins.
--- @field steps   table[] Holds the sequence of steps (functions) to execute.
--- @field result  any     The return value of the last task function or explicitly set by a step.
--- @field ctx     table   User-defined space for storing intermediate data between steps.
--- @field current number  Index of the current step in the sequence.
--- @field plugins table   Table of registered plugins.
local Sequence = {}
Sequence.__index = Sequence

--- Creates a new Sequence instance.
--- Optionally integrates default plugins if `autoUsePlugins` is true.
--- @param autoUsePlugins boolean: Whether to auto-use common plugins.
--- @return Sequence: A new Sequence instance.
function Sequence:new(autoUsePlugins)
    local seq = setmetatable({ steps = {}, result = nil, ctx = {}, current = 0, plugins = {} }, Sequence)

    if autoUsePlugins then
        -- Automatically registers commonly used plugins.
        seq:usePlugin("Click", require("TTS_lib.Sequence.ButtonClickPlugin"))
        seq:usePlugin("Cast", require("TTS_lib.Sequence.PhysicsCastPlugin"))
    end

    return seq
end

--- Adds a new step to the sequence.
--- Steps are functions that take the sequence instance (`seq`) as their first argument.
--- They are responsible for their own control flow, including assigning `seq.result` and calling `seq:next()`.
--- @param step function: The function to execute as a step.
--- @param ... any: Additional arguments to pass to the step.
function Sequence:addStep(step, ...)
    assert(type(step) == "function", "Expected a function for step, got " .. tostring(step))
    assert(getmetatable(self) == Sequence, "addStep must be called on a Sequence instance.")
    table.insert(self.steps, { func = step, args = { ... } }) -- Stores the step and its arguments.
end

--- Adds a task to the sequence that automatically progresses after execution.
--- Tasks differ from steps in that they do not take `seq` as an argument and automatically advance the sequence after execution.
--- Tasks return values that are automatically assigned to `seq.result`.
--- @param task function: The task function to execute.
--- @param ... any: Additional arguments to pass to the task.
function Sequence:addTask(task, ...)
    assert(type(task) == "function", "Expected a function for task, got " .. tostring(task))
    self:addStep(function(seq, ...)
        seq.result = task(...) -- Executes the task and assigns its return value to seq.result.
        seq:next()             -- Automatically progresses the sequence after the task completes.
    end, ...)
end

--- Advances the sequence to the next step.
--- Executes the current task or step, storing the result in `seq.result` if applicable.
--- Steps handle their own control flow explicitly, while tasks are automatically progressed.
--- @usage seq:next()
function Sequence:next()
    if self.current <= #self.steps then
        local step = self.steps[self.current]    -- Fetches the current step.
        self.current = self.current + 1          -- Moves to the next step.
        step.func(self, table.unpack(step.args)) -- Executes the step and stores the result.
    end
end

--- Starts the sequence from the beginning.
--- Resets the sequence and begins execution from the first step.
function Sequence:start()
    self.current = 1 -- Resets to the first step.
    self:next()      -- Starts execution.
end

--- Adds a step that waits for a condition to be met before progressing.
--- @param runFunc function | nil: A function to execute once the condition is met. (nilable)
--- @param conditionFunc function: The condition function to evaluate.
--- @param timeout number?: The maximum time to wait for the condition (optional).
--- @param timeoutFunc function?: A function to execute if the condition times out (optional).
function Sequence:waitCondition(runFunc, conditionFunc, timeout, timeoutFunc)
    self:addStep(function(seq)
        Wait.condition(function()
            if runFunc then
                runFunc() -- Executes a function once the condition is met.
            end
            seq:next()    -- Advances the sequence.
        end, conditionFunc, timeout, timeoutFunc)
    end)
end

--- Adds a step that waits for a specific number of frames before progressing.
--- Accepts either:
---   - A number (frames to wait), or
---   - A function (callback(seq) to execute after default frames).
--- @param arg1 number|function: Frames or callback function.
--- @param arg2 number?: Frames to wait if `arg1` is a callback.
function Sequence:waitFrames(arg1, arg2)
    local callback = nil
    local frames = nil

    if type(arg1) == "function" then
        callback = arg1
        frames = arg2 or 1 -- Default to 1 frame if no frames are specified
    elseif type(arg1) == "number" then
        callback = nil
        frames = arg1
    else
        error("Invalid argument for waitFrames: Expected number or function.")
    end

    self:addStep(function(seq)
        Wait.frames(function()
            if callback then
                callback(seq) -- Execute the user-defined function
            end
            seq:next() -- Proceed to the next step in the sequence
        end, frames)
    end)
end

--- Integrates a plugin with the sequence, making its methods callable within the sequence.
--- @param name string: The name of the plugin.
--- @param plugin table: A table containing plugin methods.
function Sequence:usePlugin(name, plugin)
    assert(type(plugin) == "table", "Plugin must be a table or a valid module name.")
    self.plugins[name] = plugin
    for method, func in pairs(plugin) do
        assert(type(method) == "string" and type(func) == "function", "Invalid plugin format.")
        -- Wraps plugin methods to integrate seamlessly into the sequence.
        self[method] = function(self, ...)
            self:addStep(func, ...)
        end
    end
end

--- A reusable no-operation sequence instance for testing or placeholders.
Sequence.NoSeq = Sequence:new(false)

return Sequence
