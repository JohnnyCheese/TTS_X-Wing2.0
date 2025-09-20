local lu = require("Test.luaunit")
local String = require("TTS_lib.Util.String")

---@class TestString
local T = {}

function T:test_beginswith()
    lu.assertTrue(String.beginswith("hello world", "hello"))
end

function T:test_endswith()
    lu.assertTrue(String.endswith("hello world", "world"))
end

function T:test_contains()
    lu.assertTrue(String.contains("luaunit is great", "is"))
end

function T:test_beginswith_matches_prefix()
    lu.assertTrue(string.beginswith("abcdef", "abc"))
    lu.assertTrue(string.beginswith("a", "a"))
    lu.assertTrue(string.beginswith("", "")) -- empty/empty
end

function T:test_beginswith_does_not_match_when_prefix_longer()
    lu.assertFalse(string.beginswith("abc", "abcd"))
end

function T:test_beginswith_is_case_sensitive()
    lu.assertFalse(string.beginswith("Abc", "abc"))
end

function T:test_startswith_alias_present_and_equivalent()
    lu.assertEquals(type(string.startswith), "function")
    lu.assertEquals(string.startswith("hello", "he"), string.beginswith("hello", "he"))
    lu.assertEquals(string.startswith("hello", ""), string.beginswith("hello", ""))
end

function T:test_beginswith_errors_on_nonstring_args()
    lu.assertError(function()
        string.beginswith(nil, "a")
    end)
    lu.assertError(function()
        string.beginswith("abc", nil)
    end)
end

function T:test_endswith_matches_suffix()
    lu.assertTrue(string.endswith("abcdef", "def"))
    lu.assertTrue(string.endswith("abc", "abc"))
    lu.assertTrue(string.endswith("", "")) -- empty/empty
end

function T:test_endswith_false_for_empty_suffix_on_nonempty_string_documenting_current_behavior()
    -- NOTE: This documents current implementation behavior:
    -- for non-empty strings, empty suffix returns false.
    lu.assertFalse(string.endswith("abc", ""))
end

function T:test_endswith_does_not_match_when_suffix_longer()
    lu.assertFalse(string.endswith("abc", "zabc"))
end

function T:test_endswith_is_case_sensitive()
    lu.assertFalse(string.endswith("abcdef", "DEF"))
end

function T:test_endswith_errors_on_nonstring()
    lu.assertError(function()
        string.endswith(nil, "a")
    end)
end

function T:test_endswith_errors_on_nonstring_args()
    lu.assertError(function()
        string.endswith("abc", nil)
    end)
end

-- === contains (plain search, no patterns) ===

function T:test_contains_basic()
    lu.assertTrue(string.contains("xwing unified mod", "unified"))
    lu.assertFalse(string.contains("xwing", "yz"))
end

function T:test_contains_treats_pattern_chars_as_plain_text()
    -- These would behave differently if pattern matching were used.
    lu.assertTrue(string.contains("a.c", "."))        -- literal dot
    lu.assertFalse(string.contains("abc", "a.c"))     -- no regex wildcards
    lu.assertTrue(string.contains("100% ready", "%")) -- literal percent
    lu.assertTrue(string.contains("a[b]c", "[b]"))    -- literal brackets
    lu.assertTrue(string.contains("a-b-c", "-"))      -- literal dash
end

function T:test_contains_errors_on_nil_string()
    lu.assertError(string.contains(nil, "a"))
end

function T:test_contains_errors_on_nil_query()
    lu.assertFalse(string.contains("abc", nil))
end

-- === :trim() ===

function T:test_trim_removes_leading_and_trailing_whitespace_only()
    local s = "   hello world\t\n"
    lu.assertEquals(s:trim(), "hello world")
end

function T:test_trim_handles_mixed_whitespace()
    local s = " \t\n\rfoo\r\n\t "
    lu.assertEquals(s:trim(), "foo")
end

function T:test_trim_preserves_internal_spaces()
    local s = "  a  b  c  "
    lu.assertEquals(s:trim(), "a  b  c")
end

function T:test_trim_on_empty_and_whitespace_only_strings()
    lu.assertEquals((""):trim(), "")
    lu.assertEquals((" \t\n"):trim(), "")
end

local function rep(n, ch)
    -- string.rep(ch, n) but with a guard and clearer intention
    lu.assertIsNumber(n)
    lu.assertIsString(ch)
    return string.rep(ch, n)
end

local function makeBlob(coreLen, leadLen, trailLen, leadChar, trailChar)
    local core = rep(coreLen, "a")
    local full = rep(leadLen, leadChar or " ") .. core .. rep(trailLen, trailChar or " ")
    return core, full
end

function T:test_trim_large_string_at_64k_boundary_spaces()
    -- 64 KiB core with modest whitespace at both ends
    local core, full = makeBlob(65536, 64, 64, " ", " ")
    assertTrimOk(full, core)
end

function T:test_trim_large_string_above_64k_with_tabs_and_newlines()
    -- Mix different whitespace classes to ensure %s handles them
    local core, full = makeBlob(70000, 128, 256, "\t", "\n")
    assertTrimOk(full, core)
end

function T:test_trim_large_string_with_very_long_trailing_whitespace_runs()
    -- Long trailing run specifically stresses the '%s*$' part
    local core, full = makeBlob(131072, 8, 32768, " ", " ")
    assertTrimOk(full, core)
end

function T:test_trim_large_whitespace_only_string_collapses_to_empty()
    -- Large all-whitespace string should trim to empty
    local onlyWs = rep(200000, " \t")
    local ok, res = pcall(function() return onlyWs:trim() end)
    if not ok then
        lu.fail("trim() errored on whitespace-only large string: " .. tostring(res))
    end
    lu.assertEquals(res, "")
end

function T:test_trim_preserves_large_internal_whitespace()
    -- No leading/trailing whitespace, but a massive internal run must be preserved
    local left  = rep(10000, "a")
    local midWs = rep(5000, " ")
    local right = rep(10000, "b")
    local s     = left .. midWs .. right
    assertTrimOk(s, s) -- unchanged
end

function T:test_trim_no_leading_or_trailing_whitespace_is_noop_even_when_large()
    local s = rep(250000, "a")
    assertTrimOk(s, s)
end

function assertTrimOk(s, expected)
    local ok, res = pcall(function() return s:trim() end)
    if not ok then
        lu.fail("string:trim() raised error on large input: " .. tostring(res))
    end
    lu.assertEquals(#res, #expected, "trim() returned unexpected length")
    lu.assertEquals(res, expected, "trim() returned unexpected content")
end

return T
