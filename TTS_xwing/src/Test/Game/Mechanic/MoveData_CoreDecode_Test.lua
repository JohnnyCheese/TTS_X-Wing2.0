local lu = require("Test.luaunit_tts")
local MoveData = require("Game.Mechanic.Movement.MoveData")

local function ship(size)
    return { getTable = function() return { Size = size or "small" } end }
end

TestMoveDataCoreDecode = {}

function TestMoveDataCoreDecode:test_decode_straight_s3_allows_partial()
    local info = MoveData.DecodeInfo("s3", ship())
    lu.assertEquals("straight", info.type)
    lu.assertEquals(3, info.speed)
    lu.assertTrue(info.traits.full)
    lu.assertTrue(info.traits.part)
end

function TestMoveDataCoreDecode:test_decode_bank_bl2_left_allows_partial()
    local info = MoveData.DecodeInfo("bl2", ship())
    lu.assertEquals("bank", info.type)
    lu.assertEquals("left", info.dir)
    lu.assertEquals(2, info.speed)
    lu.assertTrue(info.traits.full)
    lu.assertTrue(info.traits.part)
end

function TestMoveDataCoreDecode:test_decode_turn_tr1_right_allows_partial()
    local info = MoveData.DecodeInfo("tr1", ship())
    lu.assertEquals("turn", info.type)
    lu.assertEquals("right", info.dir)
    lu.assertEquals(1, info.speed)
    lu.assertTrue(info.traits.full)
    lu.assertTrue(info.traits.part)
end

function TestMoveDataCoreDecode:test_decode_roll_re1_maps_e_to_left()
    local info = MoveData.DecodeInfo("re1", ship())
    lu.assertEquals("roll", info.type)
    lu.assertEquals("left", info.dir) -- 'e' -> left
    lu.assertEquals(1, info.speed)
end

function TestMoveDataCoreDecode:test_decode_straight_reverse_keeps_partial()
    local info = MoveData.DecodeInfo("s2r", ship())
    lu.assertEquals("straight", info.type)
    lu.assertEquals(2, info.speed)
    lu.assertEquals("reverse", info.extra)
    lu.assertTrue(info.traits.full)
    lu.assertTrue(info.traits.part) -- only boost disables partial for straight
end

function TestMoveDataCoreDecode:test_decode_straight_boost_disables_partial()
    local info = MoveData.DecodeInfo("s2b", ship())
    lu.assertEquals("straight", info.type)
    lu.assertEquals(2, info.speed)
    lu.assertTrue(info.traits.full)
    lu.assertFalse(info.traits.part) -- boost is full-only
end

return TestMoveDataCoreDecode
