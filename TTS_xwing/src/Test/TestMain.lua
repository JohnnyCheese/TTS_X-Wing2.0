-- TestMain.lua
-- Entry point for all registered test files

--[[TODO:   Provide color Summary information, especially the last line "Ok" to be in green.
            Create the LogOutput class to log to the TTS console
            Create the mechanism for spawning a Test "Checker"
            Create an OS script which will generate a `testSuites` table for all test files
            Flush text output on endClass()
            Possibly put an endSuite() in TTSOutput (or inject into genericOuput) to handle the
            self:emit() "\t" tabs don't print, they get removed
            BTW `/clear` will clear the chat window, but not the console
            move hostObject from runner (LuaUnit) to TTSOutput 
]]

local lu = require("Test.luaunit_tts")

TestFailures = {}

function TestFailures:test_wrongassert()
    lu.assertEquals(2, 1 + 3)
end

function TestFailures:test_skip()
    lu.skip("not implemented")
    lu.assertEquals(2, 1 + 3)
end

function TestFailures:test_errorfromtest()
    local id = getObjectFromGUID("123456")
    id.call("nonexistentFunction")
    lu.assertEquals(2, 1 + 3)
end

-- Manually require and register each test suite globally
local testSuites = {
    TestVector = require("Test.TTS_lib.TestVector"),
    TestMath   = require("Test.TTS_lib.TestMath"),
    TestString = require("Test.TTS_lib.TestString"),
    TestTable  = require("Test.TTS_lib.TestTable"),
}

TestBulk = {}
for i = 1, 200 do
    TestBulk["test_pass_" .. i] = function()
        lu.assertEquals(i, i)
    end
end

for name, suite in pairs(testSuites) do
    _G[name] = suite
end

TestChat = {}

function TestChat:testFirst()
    printToAll("Running FIRST test...", { 1, 1, 0 })
    lu.assertEquals(1, 1)
end

function TestChat:testSecond()
    printToAll("Running SECOND test...", { 0, 1, 1 })
    lu.assertEquals(2, 2)
end

function TestChat:testThird()
    printToAll("Running THIRD test...", { 1, 0, 1 })
    local val = ""
    for i = 1, 30000, 1 do
        val = val .. i
    end
    lu.assertEquals(3, 3)
end

function runTests()
    lu.LuaUnit.outputType.chat = true -- Enable chat output
    -- lu.LuaUnit.outputType.hostObject = self
    lu.LuaUnit.hostObject = self      -- Attach to object for grid UI
    -- lu:setVerbosity(lu.VERBOSITY_QUIET)
    -- lu:setVerbosity(lu.VERBOSITY_LOW)
    -- lu:setVerbosity(lu.VERBOSITY_DEFAULT)
    lu:setVerbosity(lu.VERBOSITY_VERBOSE)
    -- lu.LuaUnit:setOutputType("TAP")
    -- lu.LuaUnit:setOutputType("TEXT")
    lu.LuaUnit:run()
end

function onDrop()
    Wait.condition(function()
        printToAll("Checker landed - Running tests", Color.Pink)
        runTests()
    end, function() return self.resting end)
end

function onLoad()
    if self.is_face_down then self.flip() end
    Global.call("showMe", { self.getGUID() })
    printToAll("Checker loaded - UI initialized", Color.White)
end
