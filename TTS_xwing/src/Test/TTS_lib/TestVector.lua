local lu = require("Test.luaunit")
local Vector = require("TTS_lib.Vector.Vector")

local TestMath = {}

function TestMath:test_Sum_basic()
    local result = Vector.Sum({1, 2, 3}, {4, 5, 6})
    lu.assertEquals(result, {5, 7, 9})
end

function TestMath:test_Inverse()
    local result = Vector.Inverse({2, 4})
    lu.assertEquals(result, {0.5, 0.25})
end

function TestMath:test_Scale()
    local result = Vector.Scale({1, 2, 3}, 2)
    lu.assertEquals(result, {2, 4, 6})
end

function TestMath:test_ScaleEach()
    local result = Vector.ScaleEach({1, 2, 3}, {2, 3, 4})
    lu.assertEquals(result, {2, 6, 12})
end

function TestMath:test_Length_3D()
    local result = Vector.Length({3, 0, 4})
    lu.assertEquals(result, 5)
end

function TestMath:test_DotProd()
    local result = Vector.DotProd({1, 2, 3}, {4, 5, 6})
    lu.assertEquals(result, 32)
end

function TestMath:test_Compare_equal()
    lu.assertTrue(Vector.Compare({1, 2, 3}, {1, 2, 3}))
end

function TestMath:test_Compare_unequal()
    lu.assertFalse(Vector.Compare({1, 2, 3}, {3, 2, 1}))
end

return TestMath
