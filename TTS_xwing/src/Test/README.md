# LuaUnit for Tabletop Simulator (TTS)

This is a custom port of [LuaUnit](https://github.com/bluebird75/luaunit) adapted for use inside **Tabletop Simulator** (TTS), which uses the **MoonSharp** Lua interpreter.

The goal is to provide a fast, visual, developer-friendly test framework for mods, while staying unobtrusive and
compatible with upstream LuaUnit.

---

## Features

- ✅ **1-line require()** for easy drop-in: `require("Test.luaunit_tts")`
- 🎨 Optional **visual test grid** using XML layout + scripting object
- 📦 Works with [LuaBundler](https://github.com/Spellcaster/lua-bundler)
- 🔁 Supports all standard LuaUnit assertions: `assertEquals()`, `assertTrue()`, etc.
- ⚠️ Supports skipping tests: `lu.skip("reason")`
- 🔍 Detects any global table whose name starts with `Test`
- 🔊 Verbosity modes for output: `LOW`, `DEFAULT`, `VERBOSE`

---

## File Overview

```
Test/                                # Top-level test directory
├── luaunit.lua                      # Core LuaUnit framework
├── luaunit_tts.lua                  # TTS-compatible test runner (what you require)
├── luaunit_tts_env.lua              # MoonSharp stubs for os/io/print
├── luaunit_tts_output.lua           # Grid + chat output handler
├── luaunit_tts_output.xml           # Grid layout (include this in your object)
└── TestMain.lua                     # Main test entry point for all test files
```

---

## Quick Start

This guide assumes you're using [LuaBundler](https://github.com/Spellcaster/lua-bundler) (e.g. via Rolandostar's TTS Lua
VSCode plugin), which supports static `require()` and `<Include>` statements.

To run tests with both the visual grid and chat output:

1. Spawn an object to host your test runner (e.g. a Checker from *Objects → Components → Checkers → White*).
2. Add the XML layout to that object’s scripting panel:
   ```xml
   <Include src="Test/luaunit_tts_output.xml"/>
   ```
3. Add this Lua script to the object:
    ```lua
    local lu = require("Test.luaunit_tts")

    TestSuite = {}

    function TestSuite:testSuccess()
        local result = 1 + 1
        lu.assertEquals(2, result)
    end

    function TestSuite:testFail()
        local result = 1 + 1
        lu.assertEquals(3, result)
    end

    function runTests()
        lu.LuaUnit.outputType.printText = true -- optional: shows chat results
        lu.LuaUnit.hostObject = self           -- enables grid output
        lu.LuaUnit:run()
    end

    function onDrop()
        Wait.condition(function()
            printToAll("Checker landed - Running tests", Color.White)
            runTests()
        end, function() return self.resting end)
    end

    function onLoad()
        if self.is_face_down then self.flip() end
    end
    ```

4. Save & Play
5. Pickup and Drop the Checker
6. Click on a grid square result to see the corresponding test name.

✅ You now have a working grid-based test runner.

---

## Writing Tests

To be discovered automatically, test function names **must** begin with `test`.

```lua
local lu = require("Test.luaunit_tts")

local T = {}
function T:test_addition()
    lu.assertEquals(2 + 2, 4)
end

return T
```

### Common Assertions

By default, this port sets `lu.ORDER_ACTUAL_EXPECTED = false`
which supports the original xUnit convention of `lu.assertEquals(expected, actual)` — *this is the way*.

LuaUnit supports expressive, self-documenting assertions:

- `lu.assertEquals(expected, actual)`
- `lu.assertAlmostEquals(a, b, delta)`
- `lu.assertStrContains(haystack, needle)`
- `lu.assertError(function, ...)`
- `lu.assertTrue(value)` / `lu.assertFalse(value)`


> You can also use `lu.assert(value)` as a truthiness check — similar to Lua’s native `assert()`, but integrated into
> the test framework.

For more, see [LuaUnit’s assertion list](https://github.com/bluebird75/luaunit#assertions).

---

## Global Namespace Requirement

LuaUnit automatically collects all test tables in `_G` whose name begins with `Test`.

- ✅ `TestMath = {}` — discovered
- ❌ `local TestMath = {}` — ignored
- ✅ `TestMath = require("Test.TTS_lib.TestMath")` — works
- ❌ `local TestMath = require(...)` — ignored

The variable assigned in `_G` **doesn’t need to match** the returned table name. What matters is the key:
`_G.TestFoo = require(...)` is valid even if the file returns a table named `T`.

### Pattern for `TestMain.lua`

This pattern is bundler-friendly and discoverable:

```lua
local testSuites = {
    TestVector = require("Test.TTS_lib.TestVector"),
    TestMath   = require("Test.TTS_lib.TestMath"),
}

for name, suite in pairs(testSuites) do
    _G[name] = suite
end
```

---

## Verbosity Modes

Set verbosity to control the amount of output:

```lua
lu.LuaUnit.verbosity = lu.VERBOSITY_LOW      -- Only summary
lu.LuaUnit.verbosity = lu.VERBOSITY_DEFAULT  -- Summary + test names
lu.LuaUnit.verbosity = lu.VERBOSITY_VERBOSE  -- Full: classes, tests, details
```

---

## Enabling Chat Output

Enable this to see test results in the TTS chat window:

```lua
lu.LuaUnit.outputType.printText = true
```

Must be set **before** running tests. Useful even when the grid UI is disabled or unavailable.

---

## GUI Output Grid

To show visual test progress:

- Include the grid layout XML in your object:
  ```xml
  <Include src="Test/luaunit_tts_output.xml"/>
  ```
- In Lua, set:
  ```lua
  lu.LuaUnit.hostObject = self
  ```

> The `hostObject` becomes the anchor for grid placement and attribute updates.

---

## Customizing Colors

You can override visual output colors like so:

```lua
lu.LuaUnit.outputType.colors = {
    SUCCESS = "#00FF00",
    FAIL    = "#FF3333",
    ERROR   = "#FFA500",  -- Orange
    SKIP    = "#FFFF00",
    NEUTRAL = "#FFFFFF",
    START   = "#FFFF99",
    FINISH  = "#FFFF99",
    INFO    = "#9999FF",
    UNKNOWN = "#FF00FF",
}
```

Or override individual entries:

```lua
lu.LuaUnit.outputType.colors.ERROR = "#FFA500"
```

---

## Manual Runner (Advanced)

In most cases, you'll just call:

```lua
lu.LuaUnit:run()
```

However, for full control — such as explicitly specifying which test suites to run, bypassing automatic discovery, or managing multiple contexts — you can create and run your own LuaUnit instance:

```lua
function runTests()
    local runner = lu.LuaUnit.new()
    runner.hostObject = self
    runner.testClasses = { TestExample }
    runner:runSuite()
end
```

---

## Credits

- LuaUnit by [Philippe Fremy](https://github.com/bluebird75/luaunit)
- TTS Port by BeardedGamer

---

Happy testing 🎲
