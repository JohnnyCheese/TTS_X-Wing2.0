-- At the top of luaunit_progress.lua
printToAll("Loading luaunit_progress.lua", { 1, 1, 0 }) -- Yellow

-- luaunit_progress.lua
local M = require('Test.luaunit') -- Access LuaUnit module
local TextOutput = M.LuaUnit.outputType

-- Define ProgressOutput class, inheriting from TextOutput
ProgressOutput = setmetatable({}, { __index = TextOutput })
ProgressOutput.__class__ = 'ProgressOutput'

function ProgressOutput.new(runner)
    local t = TextOutput.new(runner)
    t.totalTests = runner.result.selectedCount               -- Total number of tests to run
    t.completedTests = 0
    printToAll("ProgressOutput instance created", { 1, 1, 0 }) -- Yellow
    return setmetatable(t, { __index = ProgressOutput })
end

function ProgressOutput:startSuite()
    TextOutput.startSuite(self)
    printToAll("Starting test suite with " .. self.totalTests .. " tests", { 0, 1, 0 }) -- Green
    UI.setAttribute("TestProgressBar", "percentage", 0)
end

function ProgressOutput:endTest(node)
    TextOutput.endTest(self, node)
    self.completedTests = self.completedTests + 1
    local progress = (self.completedTests / self.totalTests) * 100
    if node:isSuccess() then
        printToAll("Test " .. self.completedTests .. " passed", { 0, 1, 0 }) -- Green
    else
        printToAll("Test " .. self.completedTests .. " failed", { 1, 0, 0 }) -- Red
    end
    UI.setAttribute("TestProgressBar", "percentage", progress)
end

function ProgressOutput:endSuite()
    TextOutput.endSuite(self)
    printToAll("Test suite completed", { 0, 0, 1 }) -- Blue
    UI.setAttribute("TestProgressBar", "percentage", 100)
end

-- Setup function to configure LuaUnit with ProgressOutput
local function setup(luaunitModule)
    luaunitModule.LuaUnit.outputType = ProgressOutput
end

setup(M) -- Call setup to configure LuaUnit with ProgressOutput

-- return { setup = setup, ProgressOutput = ProgressOutput }
return M
