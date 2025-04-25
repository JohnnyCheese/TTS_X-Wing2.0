--[[────────────────────────────────────────────────────────────────────────────
    LuaUnit Bootstrap for TTS
    Thin bootstrap that loads upstream LuaUnit, installs the TTS‑specific
    environment stubs and wires in our multi‑destination output module.
────────────────────────────────────────────────────────────────────────────]] --

-- luaunit_tts.lua
-- Thin bootstrap that loads upstream LuaUnit, installs the TTS‑specific
-- environment stubs and wires in our multi‑destination output module.
--
--  Usage inside an object script:
--    local lu = require("Test.luaunit_tts")
--    lu.LuaUnit.hostObject = self                 -- optional (for ChatOutput colour grid)
--    -- optionally tweak sinks / verbosity:
--    lu.configureOutput{
--        chat = { enabled=true,  verbosity=lu.VERBOSITY_VERBOSE },
--        log  = { enabled=false, verbosity=lu.VERBOSITY_LOW     }
--    }
--    lu.LuaUnit:run()
--
--  The returned value *is* the upstream LuaUnit table so all standard
--  API calls remain unchanged.

---------------------------------------------------------------
-- 1  Upstream LuaUnit + TTS environment shim
---------------------------------------------------------------
local lu = require("Test.luaunit") -- upstream distribution (cached once)
require("Test.luaunit_tts_env")    -- os/print/io stubs for MoonSharp / TTS

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

-- Wrap all runner methods that might update the UI
lu.LuaUnit.run = wrapInCoroutine(lu.LuaUnit.run)
lu.LuaUnit.runSuite = wrapInCoroutine(lu.LuaUnit.runSuite)
lu.LuaUnit.runSuiteByNames = wrapInCoroutine(lu.LuaUnit.runSuiteByNames)
lu.LuaUnit.runSuiteByInstances = wrapInCoroutine(lu.LuaUnit.runSuiteByInstances)

---------------------------------------------------------------
-- 2  Install composite‑output for TTS
---------------------------------------------------------------
local ttsOut = require("Test.luaunit_tts_output")

-- Set initial outputType before any tests run
lu.LuaUnit.outputType = {
    chat = { format = "TAP", verbosity = lu.VERBOSITY_VERBOSE },
    log = { format = "TEXT", verbosity = lu.VERBOSITY_LOW },
    grid = true,
    -- Factory function called by LuaUnit to create output handler
    new = function(runner)
        return ttsOut.build(runner, lu.LuaUnit.outputType)
    end
}

-- Ensure our outputType is used
-- local originalStartSuite = lu.LuaUnit.startSuite
-- function lu.LuaUnit:startSuite(...)
--     -- Skip the outputType reset
--     self.output = self.outputType.new(self)
--     self.output:startSuite()
--     -- ...rest of original implementation
-- end

---------------------------------------------------------------
-- 3  Expose for require() callers
---------------------------------------------------------------
return lu
