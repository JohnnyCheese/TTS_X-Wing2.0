-- tts_output.lua
local M = require('Test.luaunit') -- Access LuaUnit module

-- Define TTSOutput as a standalone class
TTSOutput = { __class__ = 'TTSOutput' }

function TTSOutput.new(runner)
    local t = {
        runner = runner,
        result = runner.result,
        verbosity = runner.verbosity or M.VERBOSITY_DEFAULT,
        totalTests = runner.result.selectedCount,
        completedTests = 0
    }
    printToAll("TTSOutput instance created", {1, 1, 0}) -- Yellow
    return setmetatable(t, { __index = TTSOutput })
end

function TTSOutput:startSuite()
    printToAll("TTO: Starting test suite with " .. self.totalTests .. " tests", { 0, 1, 0 }) -- Green
    UI.setAttribute("TestProgressBar", "percentage", 0)
end

function TTSOutput:startClass(className)
    if self.verbosity > M.VERBOSITY_LOW then
        printToAll("TTO: Starting class: " .. className, { 1, 1, 0 }) -- Yellow
    end
end

function TTSOutput:startTest(testName)
    if self.verbosity > M.VERBOSITY_DEFAULT then
        printToAll("TTO: Starting test: " .. testName, { 1, 1, 0 }) -- Yellow
    end
end

function TTSOutput:updateStatus(node)
    if node:isSkipped() then
        printToAll("TTO: Test skipped: " .. node.testName, { 0, 0, 1 }) -- Blue
    elseif node:isFailure() then
        printToAll("TTO: Test failed: " .. node.testName, { 1, 0, 0 }) -- Red
    elseif node:isError() then
        printToAll("TTO: Test error: " .. node.testName, { 1, 0, 0 }) -- Red
    end
end

function TTSOutput:endTest(node)
    self.completedTests = self.completedTests + 1
    local progress = (self.completedTests / self.totalTests) * 100
    if node:isSuccess() then
        printToAll("TTO: Test " .. self.completedTests .. " passed", { 0, 1, 0 }) -- Green
    else
        printToAll("TTO: Test " .. self.completedTests .. " failed", { 1, 0, 0 }) -- Red
    end
    UI.setAttribute("TestProgressBar", "percentage", progress)
end

function TTSOutput:endClass()
    if self.verbosity > M.VERBOSITY_LOW then
        printToAll("TTO: Ending class", { 1, 1, 0 }) -- Yellow
    end
end

function TTSOutput:endSuite()
    printToAll("TTO: Test suite completed", { 0, 0, 1 })     -- Blue
    UI.setAttribute("TestProgressBar", "percentage", 100)
    printToAll(M.LuaUnit.statusLine(self.result), { 1, 1, 0 }) -- Yellow
end

M.LuaUnit.outputType = TTSOutput

return M
