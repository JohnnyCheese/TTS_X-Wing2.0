# LuaUnit for Tabletop Simulator (TTS)

This is a custom port of [LuaUnit](https://github.com/bluebird75/luaunit) adapted for use inside **Tabletop Simulator**
(TTS), which runs Lua scripts using the **MoonSharp** interpreter.

The port tried to be minimal and unobtrusive, preserving original scripting where possible, but enabling a powerful
developer testing experience inside TTS.

## Features

- ✅ **1-line require()** for easy drop-in
- 🎨 Optional **visual test runner** with customizable color-coded grid UI
- 📦 Compatible with [LuaBundler](https://github.com/Spellcaster/lua-bundler)
- 🔁 Supports `assert`, `assertEquals`, and all standard LuaUnit assertions
- ⚠️ Skip tests with `luaunit.skip("reason")`

---

## Installation & File Overview

These examples assume the following Lua files are in a `Test/` directory inside your mod or bundler config:

| File                     | Purpose                                                                            |
|--------------------------|------------------------------------------------------------------------------------|
| `luaunit.lua`            | ✅ minimally modified LuaUnit v3.4                                                  |
| **`luaunit_tts.lua`**    | ✅ TTS test runner this is the file to `require()` in your test files |
| `luaunit_tts_env.lua`    | ✅ `os`, `io`, and `print` stubs                                                    |
| `luaunit_tts_output.lua` | ✅ Unified grid/chat output handler + color configuration                            |
| `luaunit_tts_output.xml` | ✅ XML GUI layout for grid                                                          |

---

## Usage

```lua
local lu = require("Test.luaunit_tts")

lu.LuaUnit:run()
```

It's convenient to encapsulate and control running the tests with a
function. e.g. `runTests()` is a popular choice

```lua
local lu = require("Test.luaunit_tts")

function runTests()
    lu.LuaUnit.hostObject = self           -- enables GUI
    lu.LuaUnit:run()
end
```

---

## Writing Tests

Create test tables with function names beginning with `test_`:

```lua
TestExample = {}

function TestExample:test_addition()
    lu.assertEquals(2 + 2, 4)
end

function TestExample:test_skip()
    lu.skip("This is not yet implemented")
end
```

Tests are detected and run automatically if their table names start with `Test`.

---

## How Output Mode is Selected

| Condition           | UI Grid | Chat Output |
| ------------------- | ------- | ----------- |
| `hostObject = nil`  | ❌ No    | ✅ Yes       |
| `hostObject = self` | ✅ Yes   | ✅ Optional  |

---

## Symbolic Color Table

All visual output, chat or grid, uses `TTSOutput.colors`, which you can override:

```lua
TTSOutput.colors = {
    SUCCESS = "#00FF00", -- green
    FAIL    = "#FF0000", -- bright red
    ERROR   = "#CC0000", -- red (distinct from FAIL, can override)
    SKIP    = "#FFFF00", -- yellow
    INFO    = "#9999FF", -- soft blue
    START   = "#FFFF99", -- light yellow
    FINISH  = "#FFFF99", -- matches START by default, intended for final summary line
    NEUTRAL = "#FFFFFF", -- white
    UNKNOWN = "#FF00FF", -- magenta
}
```

### Customizing Color Output
You can override the color for particular results as follows:

```lua
lu.LuaUnit.outputType.colors.FAIL = "#FFA500" -- override red with orange
```

### Manual Class Runner

```lua
local runner = lu.LuaUnit.new()
runner.hostObject = self
runner.testClasses = { TestExample }
return runner:runSuite()
```

---

## XML GUI Layout: luaunit_tts_output.xml

Load this layout to enable grid UI:

```xml
<Include src="Test/luaunit_tts_output.xml"/>
```
And set the `hostObject` appropriately.
```lua
lu.LuaUnit.hostObject = self                      -- enables GUI
```

TTSOutput will auto-update color squares based on test results.

---

## Credits

- Original LuaUnit: [Philippe Fremy](https://github.com/bluebird75/luaunit)
- TTS port by BeardedGamer

---

## License

LuaUnit is licensed under the BSD license.

---

Happy testing! 🎲
