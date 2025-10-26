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
    local found = Table.contains(t, {guid = "abc"}, function (a,b) return a.guid == b.guid end )
    lu.assertTrue(found)
end

function TestTable:test_join()
    local joined = Table.join({1,2}, {3,4})
    lu.assertEquals({1,2,3,4},joined)
end

function TestTable:test_size()
    lu.assertEquals(3, Table.size({a=1, b=2, c=3}) )
end

function TestTable:test_find_default_equality_strings()
    local t = {"a","b","c"}
    local k = Table.find(t, "b")          -- default raw equality
    lu.assertNotNil(k)
    lu.assertEquals("b", t[k] )
end

function TestTable:test_contains_default_equality_strings()
    local t = {"alpha","beta","gamma"}
    lu.assertTrue(Table.contains(t, "beta"))
    lu.assertFalse(Table.contains(t, "delta"))
end

function TestTable:test_find_with_custom_predicate()
    local t = { {name="Wedge"}, {name="Biggs"} }
    local k = Table.find(t, "biggs", function(v, needle)
        return v.name and v.name:lower() == tostring(needle):lower()
    end)
    lu.assertNotNil(k)
    lu.assertEquals(t[k].name, "Biggs")
end

function TestTable:test_find_default_equality_strings()
    local t = { "alpha", "beta", "gamma" }
    local k = Table.find(t, "beta")
    lu.assertNotNil(k)
    lu.assertEquals("beta", t[k])
end

function TestTable:test_find_with_alias_map_array_only()
    local t = { "alpha", "beta", "gamma" }
    t.aliases = { a = "alpha", b = "beta" }
    local k = Table.find(t, "b", function(v, needle, kIdx, tbl)
        local want = (tbl.aliases and tbl.aliases[needle]) or needle
        return type(kIdx) == "number" and v == want
    end)
    lu.assertEquals(2, k)
end

function TestTable:test_find_key_only_in_associative_map()
    local m = { alpha = 1, beta = 2 }
    local k = Table.find(m, "beta", function(_, needle, key)
        return key == needle
    end)
    lu.assertEquals("beta", k)
end

function TestTable:test_find_index_gating_after3()
    local t = { "a", "c", "b", "c", "c" }
    local k = Table.find(t, "c", function(v, needle, idx)
        return v == needle and idx > 3
    end)
    lu.assertEquals(4, k)
end

function TestTable:test_find_nested_field_case_insensitive_numeric_keys()
    local cards = { { pilot = { name = "Wedge" } }, { pilot = { name = "Biggs" } } }
    local k = Table.find(cards, "biggs", function(v, needle, idx)
        local name = v.pilot and v.pilot.name
        return type(idx) == "number" and name and name:lower() == tostring(needle):lower()
    end)
    lu.assertEquals(2, k)
end

function TestTable:test_find_not_found_returns_nil()
    local t = { "alpha", "beta", "gamma" }
    local k = Table.find(t, "delta")
    lu.assertNil(k)
end




return TestTable
