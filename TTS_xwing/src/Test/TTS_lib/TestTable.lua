local lu = require("Test.luaunit")
local Table = require("TTS_lib.Util.Table")

local TestTable = {}

function TestTable:test_empty_true()
    lu.assertTrue(Table.empty({}))
end

function TestTable:test_empty_false()
    lu.assertFalse(Table.empty({1}))
end

function TestTable:test_contains_found()
    local t = { {guid = "abc"}, {guid = "xyz"} }
    local found = Table.contains(t, {guid = "abc"})
    lu.assertTrue(found)
end

function TestTable:test_join()
    local joined = Table.join({1,2}, {3,4})
    lu.assertEquals(joined, {1,2,3,4})
end

function TestTable:test_size()
    lu.assertEquals(Table.size({a=1, b=2, c=3}), 3)
end

return TestTable
