-- Runs under Global (via require("Test.GlobalSuite") in Global.lua).
-- Safe to access Global vars and to stub MoveModule functions here.

local lu = require("Test.luaunit_tts")

-- Minimal fake ship object matching what XW_cmd.Process reads/writes.
-- Minimal fake ship object matching Global's dot-call style (no implicit self)
local function newShip(name, size)
    local s          = {
        _name = name or "Test Ship",
        _desc = "",
        _vars = { Data = { Size = size or "small" } },
    }

    -- TTS-style dot-call safe closures (no self parameter)
    s.getName        = function() return s._name end
    s.setDescription = function(d) s._desc = d end
    s.getDescription = function() return s._desc end

    -- Tags / data access used by Process and helpers
    s.hasTag         = function(tag) return tag == "Ship" end
    s.getTable       = function(k) return s._vars[k] end
    s.setTable       = function(k, v) s._vars[k] = v end
    s.getVar         = function(k) return s._vars[k] end
    s.setVar         = function(k, v) s._vars[k] = v end

    -- Commonly touched object APIs (safe no-ops / constants)
    s.lock           = function() end
    s.getButtons     = function() return nil end
    s.clearButtons   = function() end
    s.getPosition    = function() return { 0, 0, 0 } end
    s.getRotation    = function() return { 0, 0, 0 } end
    s.createButton   = function() end

    -- call(...) usage guard (some code paths use obj.call('Fn', {...}))
    s.call           = function(fn, args) return nil end

    return s
end



TestGlobalXWCmdBarrelRoll = {}

function TestGlobalXWCmdBarrelRoll:setUp()
    -- Access Global-owned symbols directly (we are inside Global's env)
    self.XW_cmd = XW_cmd
    lu.assertNotNil(self.XW_cmd, "XW_cmd not found in Global.")

    -- Global-anchored capture to avoid upvalue surprises across call stacks.
    __XW_TEST_calls_BR = {} -- store on _G
    self._origPerformMove = MoveModule.PerformMove

    MoveModule.PerformMove = function(cmd, ship)
        local t = __XW_TEST_calls_BR
        t[#t + 1] = { cmd = cmd, obj = ship }
        -- no real movement; no Physics.cast
    end

    self.ship = newShip()
end

function TestGlobalXWCmdBarrelRoll:tearDown()
    MoveModule.PerformMove = self._origPerformMove
    __XW_TEST_calls_BR = nil
end

-- ---- CheckCommand characterization (expected first) -------------------

function TestGlobalXWCmdBarrelRoll:test_check_roll_right_default()
    lu.assertEquals("actionMove", self.XW_cmd.CheckCommand("rr"))
end

function TestGlobalXWCmdBarrelRoll:test_check_roll_left_dist2()
    lu.assertEquals("actionMove", self.XW_cmd.CheckCommand("rl2"))
end

function TestGlobalXWCmdBarrelRoll:test_check_viper_right_forward_1()
    lu.assertEquals("actionMove", self.XW_cmd.CheckCommand("vrf1"))
end

function TestGlobalXWCmdBarrelRoll:test_check_viper_left_backward_3()
    lu.assertEquals("actionMove", self.XW_cmd.CheckCommand("vlb3"))
end

function TestGlobalXWCmdBarrelRoll:test_check_viper_turn_edge_forward_1()
    lu.assertEquals("actionMove", self.XW_cmd.CheckCommand("vtef1"))
end

function TestGlobalXWCmdBarrelRoll:test_check_unknown_is_nil()
    lu.assertIsNil(self.XW_cmd.CheckCommand("not-a-command"))
end

-- ---- Process dispatch → PerformMove (captured) ------------------------

local function process(self, cmd)
    self.ship:setDescription(cmd)
    self.XW_cmd.Process(self.ship, cmd)
end

function TestGlobalXWCmdBarrelRoll:test_process_roll_rl2_calls_PerformMove_once()
    process(self, "rl2")
    lu.assertEquals(1, #__XW_TEST_calls_BR)
    lu.assertEquals("rl2", __XW_TEST_calls_BR[1].cmd)
    lu.assertEquals(self.ship, __XW_TEST_calls_BR[1].obj)
end

function TestGlobalXWCmdBarrelRoll:test_process_viper_vrf1_calls_PerformMove_once()
    process(self, "vrf1")
    lu.assertEquals(1, #__XW_TEST_calls_BR)
    lu.assertEquals("vrf1", __XW_TEST_calls_BR[1].cmd)
end

function TestGlobalXWCmdBarrelRoll:test_process_vt_vtef1_calls_PerformMove_once()
    process(self, "vtef1")
    lu.assertEquals(1, #__XW_TEST_calls_BR)
    lu.assertEquals("vtef1", __XW_TEST_calls_BR[1].cmd)
end

return TestGlobalXWCmdBarrelRoll
