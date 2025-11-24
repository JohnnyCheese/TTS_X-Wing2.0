local lu = require("Test.luaunit_tts")

local testSuite = {
    TestMath = require("Test.TTS_lib.TestMath"),
    TestString = require("Test.TTS_lib.TestString"),
    TestTable = require("Test.TTS_lib.TestTable"),
    TestVector = require("Test.TTS_lib.TestVector"),
    TestMoveDataCoreDecode = require("Test.Game.Mechanic.MoveData_CoreDecode_Test"),
    TestMoveDataRollDecode = require("Test.Game.Mechanic.MoveData_RollDecode_Test"),
    TestMoveDataRollScale = require("Test.Game.Mechanic.MoveData_RollScale_Test"),
}

for name, testCase in pairs(testSuite) do
    _G[name] = testCase
end

function runTests()
    -- lu.LuaUnit.outputType.grid = false
    lu.LuaUnit.outputType.chat.format = "TEXT"
    lu.LuaUnit.outputType.chat.verbosity = lu.VERBOSITY_LOW
    -- lu.LuaUnit.outputType.log = false
    lu.LuaUnit:run()        -- runs the tests configured here.
    -- Global.call("runTests", { self.guid }) -- runs the tests configured in the global script.
    Global.call("runTests") -- runs the tests configured in the global script.
end

function onDrop()
    Wait.condition(runTests, function()
        return self.resting
    end)
end

function onLoad()
    if self.is_face_down then
        self.flip()
    end
    printToAll("Drop this checker to run tests.", Color.Orange)
    Global.call("showMe", { self.getGUID() })
end

function onChat(msg, _player)
    if msg:lower() == "!runtests" then
        runTests()
    end
end
