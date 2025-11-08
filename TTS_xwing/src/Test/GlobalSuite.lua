local lu = require("Test.luaunit_tts")

local testSuite = {
    -- TestFreighter = require("Test.HotAC.Setup.TestTransportFreighter"),
    -- TestRulerSet = require("Test.Game.Table.TestRulerSet"),
    TestGlobalXWCmdBarrelRoll          = require("Test.Game.Mechanic.Global_XW_cmd_BarrelRoll_Test"),
    TestGlobalXWCmdCoreMove            = require("Test.Game.Mechanic.Global_XW_cmd_CoreMove_Test"),
    TestGlobalXWCmdBarrelRoll_Golden   = require("Test.Game.Mechanic.Global_XW_cmd_BarrelRoll_Golden_Test"),
    TestGlobalXWCmd_Snapshot_Generator = require("Test.Game.Mechanic.Global_XW_cmd_Snapshot_Generator"),
}

for name, testCase in pairs(testSuite) do
    _G[name] = testCase
end

function runTests(arg)
    local guid = type(arg) == "table" and arg[1] or arg
    local host = getObjectFromGUID(guid)
    showMe(guid)
    if not host then
        printToAll("runTests: invalid GUID " .. tostring(guid), Color.Red)
        lu.LuaUnit.outputType.gridOwner = Global
    else
        lu.LuaUnit.outputType.gridOwner = host
    end

    -- lu.LuaUnit.outputType.grid = false
    -- lu.LuaUnit.outputType.chat = false
    lu.LuaUnit.outputType.chat.format = "TEXT"
    lu.LuaUnit.outputType.chat.verbosity = lu.VERBOSITY_LOW

    lu.LuaUnit.outputType.log = false
    lu.LuaUnit:run()
end

function onChat(msg, _player)
    if msg:lower() == "!runtests" then
        runTests()
    end
end
