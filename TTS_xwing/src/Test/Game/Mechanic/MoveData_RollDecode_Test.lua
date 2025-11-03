-- Characterize: DecodeInfo for roll/viper/vt fields (type/dir/speed/extra/traits)
local lu = require("Test.luaunit_tts")

-- IMPORTANT: In TTS, each object has its own Lua env. Require the module here so
-- MoveData is available in THIS script's environment.
local MoveData = require("Game.Mechanic.Movement.MoveData")
lu.assertNotNil(MoveData, "MoveData module not found; check search paths.")

local function newShip(size) -- only Size matters for DecodeInfo defaults
    return {
        getTable = function(self, k) return { Size = size or "small" } end
    }
end

TestMoveDataRollDecode = {}

function TestMoveDataRollDecode:test_roll_rl2()
    local info = MoveData.DecodeInfo("rl2", newShip("small"))
    lu.assertEquals(info.type, "roll")
    lu.assertEquals(info.dir, "left")
    lu.assertEquals(info.speed, 2)
    lu.assertTrue(info.traits.full)
    lu.assertFalse(info.traits.part) -- rolls are full-only
end

function TestMoveDataRollDecode:test_viper_vrf1()
    local info = MoveData.DecodeInfo("vrf1", newShip())
    lu.assertEquals(info.type, "viperF") -- bank template, forward
    lu.assertEquals(info.dir, "right")
    lu.assertEquals(info.speed, 1)
    lu.assertEquals(info.extra, "forward")
    lu.assertTrue(info.traits.full)
    lu.assertFalse(info.traits.part)
end

function TestMoveDataRollDecode:test_viper_turn_vteb3()
    local info = MoveData.DecodeInfo("vteb3", newShip())
    -- viper-turn uses turn template; backward variant, 'e' maps to left
    lu.assertEquals(info.type, "viperTurnB")
    lu.assertEquals(info.dir, "left")
    lu.assertEquals(info.speed, 3)
    lu.assertEquals(info.extra, "backward")
    lu.assertTrue(info.traits.full)
    lu.assertFalse(info.traits.part)
end

return TestMoveDataRollDecode
