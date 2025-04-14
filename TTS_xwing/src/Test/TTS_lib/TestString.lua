local lu = require("Test.luaunit")
local String = require("TTS_lib.Util.String")

local TestString = {}

function TestString:test_beginswith()
    lu.assertTrue(String.beginswith("hello world", "hello"))
end

function TestString:test_endswith()
    lu.assertTrue(String.endswith("hello world", "world"))
end

function TestString:test_contains()
    lu.assertTrue(String.contains("luaunit is great", "is"))
end

return TestString
