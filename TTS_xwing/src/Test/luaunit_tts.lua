-- luaunit_tts.lua
-- One-stop TTS-compatible LuaUnit setup with unified output

require("Test.luaunit_tts_env")
local lu = require("Test.luaunit")
lu.LuaUnit.outputType = require("Test.luaunit_tts_output").TTSOutput

-- Automatically run all test entrypoints in a coroutine if hostObject is set
_G.__luaunit_runner_instance = nil
_G.__luaunit_runner_method = nil
_G.__luaunit_runner_args = nil

function __runLuaUnitCoroutine()
    local instance = _G.__luaunit_runner_instance
    local method = _G.__luaunit_runner_method
    local args = _G.__luaunit_runner_args or {}
    method(instance, table.unpack(args))
    return 1
end

local function wrapInCoroutine(method)
    return function(self, ...)
        if self.hostObject then
            _G.__luaunit_runner_instance = self
            _G.__luaunit_runner_method = method
            _G.__luaunit_runner_args = { ... }
            startLuaCoroutine(self.hostObject, "__runLuaUnitCoroutine")
            return
        end
        return method(self, ...)
    end
end

lu.LuaUnit.run = wrapInCoroutine(lu.LuaUnit.run)
lu.LuaUnit.runSuite = wrapInCoroutine(lu.LuaUnit.runSuite)
lu.LuaUnit.runSuiteByNames = wrapInCoroutine(lu.LuaUnit.runSuiteByNames)
lu.LuaUnit.runSuiteByInstances = wrapInCoroutine(lu.LuaUnit.runSuiteByInstances)

return lu
