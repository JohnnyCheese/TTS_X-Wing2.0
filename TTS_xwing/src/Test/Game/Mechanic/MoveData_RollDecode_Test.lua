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

function TestMoveDataRollDecode:test_roll_r2l3_decodes_prefix_speed_and_offset()
    local ship = { getTable = function() return { Size = "small" } end }
    local info = MoveData.DecodeInfo("r2l3", ship)
    lu.assertEquals("roll2", info.type)
    lu.assertEquals("left", info.dir)
    lu.assertEquals(3, info.speed)
    lu.assertTrue(info.traits.full)
    lu.assertFalse(info.traits.part)
end

function TestMoveDataRollDecode:test_roll_rl_defaults_center_and_speed1()
    local ship = { getTable = function() return { Size = "small" } end }
    local info = MoveData.DecodeInfo("rl", ship)
    lu.assertEquals("roll", info.type)
    lu.assertEquals("left", info.dir)
    lu.assertEquals(2, info.speed)
end

function TestMoveDataRollDecode:test_roll_prefix_family_and_suffix_offset()
    local ship = { getTable = function() return { Size = "small" } end }

    local i1 = MoveData.DecodeInfo("rl", ship) -- legacy default
    lu.assertEquals("roll", i1.type)
    lu.assertEquals("left", i1.dir)
    lu.assertEquals(2, i1.speed) -- center default

    local i2 = MoveData.DecodeInfo("rr3", ship)
    lu.assertEquals("roll", i2.type)
    lu.assertEquals("right", i2.dir)
    lu.assertEquals(3, i2.speed)

    local i3 = MoveData.DecodeInfo("r2l1", ship)
    lu.assertEquals("roll2", i3.type)
    lu.assertEquals("left", i3.dir)
    lu.assertEquals(1, i3.speed)

    local i4 = MoveData.DecodeInfo("r3r2", ship)
    lu.assertEquals("roll3", i4.type)
    lu.assertEquals("right", i4.dir)
    lu.assertEquals(2, i4.speed)
    -- v1… should be identical to legacy v… (no prefix)
    local iA = MoveData.DecodeInfo("vrf2", ship)  -- legacy
    local iB = MoveData.DecodeInfo("v1rf2", ship) -- with explicit 1
    lu.assertEquals(iA.type, iB.type)             -- "viperF"
    lu.assertEquals(iA.dir, iB.dir)               -- "right"
    lu.assertEquals(iA.speed, iB.speed)           -- 2

    -- vt1… same idea
    local iC = MoveData.DecodeInfo("vtlb3", ship)
    lu.assertEquals("viperTurnB", iC.type)
    lu.assertEquals("left", iC.dir)
    lu.assertEquals(3, iC.speed)
end

return TestMoveDataRollDecode
