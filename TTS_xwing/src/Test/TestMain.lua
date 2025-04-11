-- TestMain.lua
-- Entry point for all registered test files

local lu = require("Test.luaunit_tts")

-- Manually require and register each test suite globally
-- These names must begin with 'Test' to be picked up by collectTests()
local testSuites = {
    TestVector = require("Test.TTS_lib.TestVector"),
    TestMath   = require("Test.TTS_lib.TestMath"),
    TestString = require("Test.TTS_lib.TestString"),
    TestTable  = require("Test.TTS_lib.TestTable"),
}

for name, suite in pairs(testSuites) do
    _G[name] = suite
end

function runTests()
    lu.LuaUnit.outputType.printText = true  -- Enable chat output
    lu.LuaUnit.hostObject = self            -- Attach to object for grid UI
    lu.LuaUnit:run()
end

function onDrop()
    Wait.condition(function()
        printToAll("Checker landed - Running tests", Color.White)
        runTests()
    end, function() return self.resting end)
end

function onLoad()
    if self.is_face_down then self.flip() end
    Global.call("showMe", { self.getGUID() })
    printToAll("Checker loaded - UI initialized", Color.White)
end
