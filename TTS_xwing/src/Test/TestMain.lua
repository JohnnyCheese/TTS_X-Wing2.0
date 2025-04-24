-- TestMain.lua
-- Entry point for all registered test files

--[[TODO:   
    1. Code Organization & Structure
        - Move Emitter to luaunit_tts_env.lua since it's fundamental

    2. Inheritance & Method Resolution
        - Consider extracting common output functionality

    3. Output Handling
        - Fix tab character handling in Emitter
        - Add proper flush handling for partial lines
        - Make LogOutput use TTS's native log styles
        - Add color summary information (especially "Ok" in green)
        - Flush text output on endClass()

    4. Grid UI
        - Keep working grid implementation but simplify panel creation
        - Move onClick handler registration to object load
        - Consider separating UI XML manipulation from test logic
        - Add proper error handling for missing UI elements

    5. Configuration & Defaults
        - Move configuration defaults to a single location
        - Make palette configuration consistent across outputs
        - Add validation for configuration options
        - Document all configuration options

    6. Documentation
        - Update README to reflect current architecture
        - Add inline documentation for key functions
        - Document the output handler lifecycle
        - Add examples for common customization scenarios

    7. Error Handling
        - Add proper error handling for UI operations
        - Add validation for hostObject references
        - Improve error messages for common setup issues
        - Add debug logging option for troubleshooting

    8. Testing
        - Add self-tests for output handlers
        - Add validation for configuration
        - Test error conditions and recovery
        - Test with large test suites

    9. Infrastructure
        - Create the mechanism for spawning a Test "Checker"
        - Create an OS script to generate testSuites table
        - Move hostObject from runner to TTSOutput

    Notes:
        - BTW `/clear` will clear the chat window, but not the console
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
-- for i = 1, 200 do
--     TestBulk["test_pass_" .. i] = function()
--         lu.assertEquals(i, i)
--     end
-- end

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
    -- for i = 1, 30000, 1 do
    --     val = val .. i
    -- end
    lu.assertEquals(3, 3)
end

function runTests()
    lu.configureOutput {
        chat = { enabled = true, format = "TAP", verbosity = lu.VERBOSITY_VERBOSE },
        log  = { enabled = true, format = "TEXT", verbosity = lu.VERBOSITY_LOW },
        grid = { enabled = true },
    }

    lu.LuaUnit.hostObject = self -- Attach to object for grid UI
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
