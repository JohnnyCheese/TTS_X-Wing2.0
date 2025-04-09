| `luaunit_tts_output.xml`   | ✅ XML UI layout for grid            |# LuaUnit for Tabletop Simulator (TTS)

This is a custom port of [LuaUnit](https://github.com/bluebird75/luaunit) adapted for use inside **Tabletop Simulator** (TTS), which runs Lua scripts using the **MoonSharp** interpreter.

The port is minimal and unobtrusive, preserving upstream compatibility where possible while enabling a powerful developer testing experience inside TTS.

## Features

- ✅ **1-line require()** for easy drop-in
- 🎨 Optional **visual test runner** with color-coded grid UI
- 📦 Compatible with [LuaBundler](https://github.com/Spellcaster/lua-bundler)
- 🔁 Supports `assert`, `assertEquals`, and all standard LuaUnit assertions
- ⚠️ Skip tests with `luaunit.skip("reason")`
- 🎨 Centralized symbolic color palette

---

## Installation & File Overview

Include the following Lua files in your `Test/` directory inside your mod or bundler config:

| File                    | Purpose                              |
|-------------------------|--------------------------------------|
| `luaunit.lua`           | ✅ Unmodified LuaUnit v3.4           |
| `luaunit_tts.lua`       | ✅ TTS-safe test runner + color logic|
| `luaunit_tts_env.lua`   | ✅ `os`, `io`, and `print` polyfills |
| `luaunit_tts_output.lua`| ✅ Unified grid/chat output handler  |
| `luaunit_tts_gui.xml`   | ✅ XML UI layout for grid            |

---

## Usage

```lua
local luaunit = require("Test.luaunit_tts")

luaunit.LuaUnit.hostObject = self                      -- enables GUI
luaunit.LuaUnit.outputType.printText = true            -- optional: also use chat

return luaunit.LuaUnit:run()
```

---

## How Output Mode is Selected

| Condition            | UI Grid | Chat Output |
|----------------------|---------|-------------|
| `hostObject = nil`   | ❌ No   | ✅ Yes       |
| `hostObject = self`  | ✅ Yes  | ✅ Optional  |

---

## Symbolic Color Table

All visual output uses `TTSOutput.namedColors`, which you can override:

```lua
TTSOutput.namedColors = {
    PASS    = "#00FF00",
    FAIL    = "#FF0000",
    ERROR   = "#FF0000",
    SKIP    = "#FFFF00",
    UNKNOWN = "#FF00FF",
    INFO    = "#9999FF",
    START   = "#FFFF99",
    NEUTRAL = "#FFFFFF"
}
```

In the UI or chat, you’ll only see symbolic names:

```lua
Color.fromHex(TTSOutput.namedColors.FAIL)
```

---

## Writing Tests

Create test tables with function names beginning with `test_`:

```lua
TestExample = {}

function TestExample:test_addition()
    assertEquals(2 + 2, 4)
end

function TestExample:test_skip()
    require("Test.luaunit").skip("This is not yet implemented")
end
```

Tests are detected and run automatically if their table names start with `Test`.

---

## main.lua Example (Bundler-Friendly)

```lua
local luaunit = require("Test.luaunit_tts")
luaunit.LuaUnit.hostObject = self
luaunit.LuaUnit.outputType.printText = true
return luaunit.LuaUnit:run()
```

When bundling:

```sh
luabundler bundle main.lua -o bundled_output.lua
```

---

## Advanced Usage

### Override Output

```lua
luaunit.LuaUnit.outputType.printText = false -- silence chat output
luaunit.LuaUnit.outputType.colors.FAIL = "#FFA500" -- override red with orange
```

### Manual Class Runner

```lua
local runner = luaunit.LuaUnit.new()
runner.hostObject = self
runner.testClasses = { TestExample }
return runner:runSuite()
```

---

## UI Layout: luaunit_tts_gui.xml

Load this layout to enable grid UI:

```lua
self.UI.setXmlTable(XML.fromString(xmlContent))
```

TTSOutput will auto-update color squares based on test result.

---

## Tips for Mod Developers

- `os.clock()` simulates long-running tests
- `printToAll()` supports color via `Color.fromHex()`
- Use symbolic color names for all visual output
- Override `TTSOutput.namedColors` to theme your mod

---

## Credits

- Original LuaUnit: [Philippe Fremy](https://github.com/bluebird75/luaunit)
- TTS port by [Your Name / Mod Team]

---

## License

LuaUnit is licensed under the BSD license.

---

Happy testing! 🎲
