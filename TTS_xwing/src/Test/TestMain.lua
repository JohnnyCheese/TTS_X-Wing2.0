-- TestMain.lua
-- Entry point for all registered test files

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
-- for i = 1, 200 do
--    TestBulk["test_pass_" .. i] = function()
--        lu.assertEquals(i, i)
--    end
-- end

for name, suite in pairs(testSuites) do
    _G[name] = suite
end

function runTests()
    lu.LuaUnit.outputType.chat = true -- Enable chat output
    lu.LuaUnit.hostObject = self           -- Attach to object for grid UI
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
