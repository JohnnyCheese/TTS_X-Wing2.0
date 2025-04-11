local lu = require("Test.luaunit_tts")
local Math = require("TTS_lib.Util.Math")

local TestMath = {}

function TestMath:test_round_integer()
    lu.assertEquals(Math.round(2.7), 3)
end

function TestMath:test_round_decimal()
    lu.assertEquals(Math.round(2.74, 1), 2.7)
end

function TestMath:test_clamp_middle()
    lu.assertEquals(Math.clamp(5, 1, 10), 5)
end

function TestMath:test_clamp_below()
    lu.assertEquals(Math.clamp(-5, 1, 10), 1)
end

function TestMath:test_clamp_above()
    lu.assertEquals(Math.clamp(15, 1, 10), 10)
end

function TestMath:test_sign()
    lu.assertEquals(Math.sgn(-7), -1)
    lu.assertEquals(Math.sgn(0), 0)
    lu.assertEquals(Math.sgn(42), 1)
end

return TestMath
