-- Runs under Global; verifies that classic move codes go through PerformMove and clear Description.
local lu = require("Test.luaunit_tts")

-- minimal dot-call safe ship (same pattern as the other Global test)
local function newShip()
    local s = { _desc = "", _vars = { Data = { Size = "small" } } }
    s.getName        = function() return "Test Ship" end
    s.setDescription = function(d) s._desc = d end
    s.getDescription = function() return s._desc end
    s.hasTag         = function(tag) return tag == "Ship" end
    s.getTable       = function(k) return s._vars[k] end
    s.setTable       = function(k, v) s._vars[k] = v end
    s.getVar         = function(k) return s._vars[k] end
    s.setVar         = function(k, v) s._vars[k] = v end
    s.lock           = function() end
    s.getButtons     = function() return nil end
    s.clearButtons   = function() end
    s.getPosition    = function() return {0,0,0} end
    s.getRotation    = function() return {0,0,0} end
    s.createButton   = function() end
    s.call           = function(fn, args) return nil end
    return s
end

TestGlobalXWCmdCoreMove = {}

function TestGlobalXWCmdCoreMove:setUp()
    self.XW_cmd = XW_cmd
    lu.assertNotNil(self.XW_cmd)

    __XW_TEST_calls_CORE = {}
    self._origPerformMove = MoveModule.PerformMove
    MoveModule.PerformMove = function(cmd, ship)
        __XW_TEST_calls_CORE[#__XW_TEST_calls_CORE + 1] = { cmd = cmd, obj = ship }
    end

    self.ship = newShip()
end

function TestGlobalXWCmdCoreMove:tearDown()
    MoveModule.PerformMove = self._origPerformMove
    __XW_TEST_calls_CORE = nil
end

local function process(self, cmd)
    self.ship:setDescription(cmd)
    return self.XW_cmd.Process(self.ship, cmd)
end

function TestGlobalXWCmdCoreMove:test_process_bank_triggers_PerformMove_and_clears()
    local ok = process(self, "bl2")
    lu.assertTrue(ok)
    lu.assertEquals(1, #__XW_TEST_calls_CORE)
    lu.assertEquals("bl2", __XW_TEST_calls_CORE[1].cmd)
    lu.assertEquals("", self.ship:getDescription())
end

function TestGlobalXWCmdCoreMove:test_process_turn_triggers_PerformMove_and_clears()
    local ok = process(self, "tr1")
    lu.assertTrue(ok)
    lu.assertEquals(1, #__XW_TEST_calls_CORE)
    lu.assertEquals("tr1", __XW_TEST_calls_CORE[1].cmd)
    lu.assertEquals("", self.ship:getDescription())
end

function TestGlobalXWCmdCoreMove:test_process_straight_triggers_PerformMove_and_clears()
    local ok = process(self, "s3")
    lu.assertTrue(ok)
    lu.assertEquals(1, #__XW_TEST_calls_CORE)
    lu.assertEquals("s3", __XW_TEST_calls_CORE[1].cmd)
    lu.assertEquals("", self.ship:getDescription())
end

return TestGlobalXWCmdCoreMove

