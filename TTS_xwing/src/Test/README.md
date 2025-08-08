# LuaUnit for Tabletop Simulator (TTS)

A drop-in port and extension of [LuaUnit](https://github.com/bluebird75/luaunit) for Tabletop Simulator (TTS), supporting output to the chat window, system log, and an interactive test grid UI.

**Goal:** Provide a fast, visual, developer-friendly unit test framework for TTS mods, fully compatible with upstream LuaUnit and idiomatic Lua best practices.

---

## LuaUnit Features

- ✅ **1-line require:** Easy drop-in: `require("Test.luaunit_tts")`
- 🎨 **Visual grid UI:** Interactive GUI GridLayout test grid
- 💻 **Chat & log output:** Results can be directed to both TTS chat and log
- 📦 **Bundler friendly:** Works with [Rolandostar's TTS Lua](https://marketplace.visualstudio.com/items?itemName=rolandostar.tabletopsimulator-lua) & [LuaBundler](https://github.com/Benjamin-Dobell/luabundler)
- 🔁 **Most LuaUnit assertions:** `assertEquals()`, `assertTrue()`, etc.
- ⚠️ **Skip support:** `lu.skip("reason")`
- 🔍 **Auto-discovers test classes:** Any global table named `Test*`
- 🔊 **Verbosity modes:** QUIET, LOW, DEFAULT, VERBOSE

---

## Installation

All the Lua files and this document assume the following folder structure under `Test/`.

```
Test/                      # Top-level test directory
├── luaunit.lua            # Core LuaUnit framework (minimally patched for TTS)
├── luaunit_tts_env.lua    # TTS/MoonSharp sandbox stubs for os/io/print (needed by TTS runner)
├── luaunit_tts_output.lua # TTS output handlers (needed by TTS runner)
├── luaunit_tts.lua        # TTS runner, 1-line require(), includes everything above
└── TestMain.lua           # Example test runner script
```

---

## Quick Start

**Assumptions:**  
You’re using a VSCode plugin or similar that supports static `require()`.

1. Spawn a test object (e.g. Checker from *Objects → Components → Checkers*).
2. Attach this Lua script:
    ```lua
    require("Test.TestMain")
    ```
3. Save and reload your game.
4. Drop the object to run tests!  
   - See results in chat, log, and grid.  
   - Click a grid square to view details for that test.

---

### Which `require()` do I use?

- Use `require("Test.luaunit_tts")` **everywhere** during testing.  
  (It’s a superset: it includes the original `luaunit.lua` and adds TTS support.)

> **Tip:** ⚠️ Don’t ship your final mod with test code or LuaUnit.

---

## Writing Tests

1. **`require("Test.luaunit_tts")`** the LuaUnit-TTS module.
2. **Define a test class** *global* table name starts with `Test*` (case-insensitive)
3. **Define test cases** function name starts with `test*` (case-insensitive).
4. **Call the runner** it auto-discovers test classes (tables) and runs their test cases (functions).

**Minimal Example:**

```lua
local lu = require("Test.luaunit_tts")

TestMath = {}                   -- global table (test class)

function TestMath:test_addition()
    lu.assertEquals(4, 2 + 2)   -- LuaUnit assertion, the first value is what is expected,
end                             --                    the second is the actual computed value

lu.LuaUnit:run()                -- invoke the runner
```

**More practical example:**

The above really gives no control over when the LuaUnit `run()` is invoked.

A more practical example allows you to run the tests repeatedly under your control. An object to kick off the tests is far more convenient. Hence the `runTests()` method and `onDrop()` method to invoke it.

```lua
local lu = require("Test.luaunit_tts")

TestMath = {}

function TestMath:test_subtraction()
    lu.assertEquals(2, 3 - 1)
end

function runTests()
    lu.LuaUnit:run()
end

function onDrop()
    Wait.condition(runTests, function() return self.resting end)
end

function onLoad()
    if self.is_face_down then self.flip() end
    printToAll("Drop this checker to run tests.", { 1, 1, 1 })
end
```

---

### Names, Scope, and Discovery

* **Test Class:** Any global table named `Test*` (ignores case).
  e.g., `TestVector = {}`
* **Test Case:** Any function in a test class table named `test*` (ignores case).
* **Discovery:**

    * ✅ `TestMath = require("Test.TTS_lib.TestMath")` (global) — discovered
    * ❌ `local TestMath = {}` *not* discovered
    * ✅ TestMath = require("Test.TTS_lib.TestMath") — works
    * ❌ local TestMath = require(...) — ignored, again the issue is not with require, but with local, which prevents the table from being added to _G

The following also works if it's used as follows. Assume the following is in a file named `Add.lua`.

```lua
-- File: Add.lua
local lu = require("Test.luaunit_tts")

local T = {}
function T:test_addition()
    lu.assertEquals(4, 2 + 2)
end

return T
```
Now before we invoke the runner, we give the test module a global (`_G`) key:

```lua
local lu = require("Test.luaunit_tts")  -- need the runner, so we require the `_tts` file.

_G.TestAdd = require("Add")             -- assign the table to a global scoped key

lu.LuaUnit.run()
```

The variable assigned in `_G` doesn’t need to match the returned table name. What matters is the key. This is valid because `_G.TestAdd` begins with `Test` and is in global scope even though the file returns a local table named `T`.

**Pattern for TestMain.lua:**

This pattern is bundler-friendly and auto-discoverable:

```lua
local testClasses = {
    TestMath   = require("Test.TTS_lib.TestMath"),
    TestString = require("Test.TTS_lib.TestString"),
    TestVector = require("Test.TTS_lib.TestVector"),
}

for name, class in pairs(testClasses) do
    _G[name] = class
end
```

All assigned tables will be picked up as test classes.
>Default LuaUnit behavior is to sort the test classes first by class name then by function name.

---

## Assertions

LuaUnit supports expressive, self-documenting assertions.

This port follows the original xUnit ordering convention: `expected` first, `actual` second.

```lua
lu.assertEquals(expected, actual)
```

1. **expected:** the value you want the code under test to produce
2. **actual:**   the value the code under test actually produces
 
**Example:**
```lua
lu.assertEquals(4, math.add(2,2))
```

> **Tip:** LuaUnit does a nice job comparing tables for equality.
> It also has a nice formatter `lu.prettystr(obj)` for safely printing any type including tables.

Other common assertions:

* `lu.assertEquals(expected, actual)`
* `lu.assertAlmostEquals(expected, actual, delta)`
* `lu.assertStrContains(haystack, needle)`
* `lu.assertError(function, ...)`
* `lu.assertTrue(actual)`, `lu.assertFalse(actual)`
 
> See [LuaUnit assertion docs](https://github.com/bluebird75/luaunit#assertions) for a full list.

LuaUnit's *default* is contrary to the original xUnit pattern for assertions.

This port has the convention for assertions of listing the expected value first, that is the correct answer that you should expect, and the actual value second, that is the value computed or returned as a result of a call to your code under test.

`lu.assertEquals(expected, actual)` — *just as God and Kent Beck intended!*

---

## Skipping Tests

Use `lu.skip("reason")` to skip a test without commenting it out.

```lua
function TestSomething:test_notReady()
    lu.skip("Feature not yet implemented")
end
```

---

## Output Configuration

LuaUnit-TTS supports **three output channels**: Chat, Log, Grid. All enabled by default.

### Channel defaults

```lua
lu.LuaUnit.outputType.chat = { format = "TAP",   verbosity = lu.VERBOSITY_VERBOSE }
lu.LuaUnit.outputType.log  = { format = "TEXT",  verbosity = lu.VERBOSITY_LOW }
lu.LuaUnit.outputType.gridOwner = self  -- (usually the test object)
```

**Disabling channels:** (improves performance)

```lua
lu.LuaUnit.outputType.chat = false
lu.LuaUnit.outputType.log = false
lu.LuaUnit.outputType.grid = false
```

**Changing format/verbosity:**

```lua
lu.LuaUnit.outputType.chat.format = "TEXT"
lu.LuaUnit.verbosity = lu.VERBOSITY_LOW
```

**Customizing colors:**

```lua
lu.LuaUnit.outputType.colors.ERROR = "#FFA500"
```

**Default color table:**

```lua
lu.LuaUnit.outputType.colors = {
    SUCCESS = "#00FF00",  -- passed, bright green
    FAIL    = "#FF0000",  -- failed, bright red
    ERROR   = "#FF6600",  -- runtime error, orange
    SKIP    = "#FFFF00",  -- skipped, yellow
    INFO    = "#FFFDD0",  -- info, cream
    UNKNOWN = "#FF00FF",  -- unknown, magenta
}
```

---

### GUI Test Grid

* Displays test progress visually and updates during the run.
* Each cell = 1 test; click for details.
* By default, grid is attached to the running object (`self`).
* If run in `Global` without an object to anchor, the grid display is on-screen.

**To use an object as the anchor from `Global.lua`**

```lua
function runTests(arg)
    local guid = type(arg) == "table" and arg[1] or arg
    local host = getObjectFromGUID(guid)
    if not host then error("runTests: invalid GUID " .. tostring(guid)) end
    
    lu.LuaUnit.outputType.gridOwner = host
    lu.LuaUnit:run()
end
```

In test object:

```lua
function runTests()
    Global.call("runTests", { self.getGUID() })
end
function onDrop()
    Wait.condition(runTests, function() return self.resting end)
end
```

---

## Yield Frequency

* Controls how often the runner yields control back to TTS, allowing UI and text output to update.
* Configure with:

  ```lua
  lu.LuaUnit.outputType.yieldFrequency = 10   -- (default: 10)
  ```
* Higher values = faster run, but less frequent UI updates.

---
### Remove Duplication with Setup & Teardown

It's useful to put common repetitive setup code in one place.
LuaUnit provides **setup** & **teardown** fixture hooks. There are three types:
1. Per-test hooks run before and after each test function
2. Per-class hooks run before and after each test class
3. Per-suite hooks run before and after the entire test suite

If you define any of the following functions (exact case), they’ll be invoked automatically.

1. **Per-test hooks** (typically the most common)
   * `setUp(self)` / `tearDown(self)` inside a test class.
   * `setUp` runs immediately before each `test*` method; `tearDown` runs immediately after.
   * **Example:**
     ```lua
     TestVector = {}
 
     function TestVector:setUp()
         -- create a fresh vector for each test
         self.v = Vector(1, 2, 3)
     end
 
     function TestVector:tearDown()
         -- clear the vector or perform any cleanup
         self.v = nil
     end
 
     function TestVector:test_length()
         local len = self.v:magnitude()
         lu.assertAlmostEquals(3.7417, len, 0.0001)
     end
     ```
2. **Class-level hooks** (when you want something in existance during the run of all the tests in a class)
   * `setupClass(self)` / `teardownClass(self)` inside a test class table.
   * Executed once before/after any of that class’s `test*` methods.
   * **Example:**
     ```lua
     TestMath = {}

     function TestMath:setupClass()
         -- e.g. compute some table needed by TestMath methods
         self.lookup = { [1]=1, [2]=4, [3]=9 }
     end

     function TestMath:teardownClass()
         -- e.g. nil out self.lookup 
         self.lookup = nil
     end

     function TestMath:test_square_of_2()
         lu.assertEquals(4, self.lookup[2])
     end
     ```
3. **Suite-level hooks**
   - `setupSuite()` / `teardownSuite()`
   - Placed in any global script (e.g. in `TestMain.lua`).
   - `setupSuite()` runs once before *all* tests; `teardownSuite()` runs once after *all* tests.
   - **Example:**
     ```lua
     function setupSuite()
         -- e.g. initialize shared test data or spawn a helper object
     end
 
     function teardownSuite()
         -- e.g. clean up or destroy that helper object
     end
     ```

---

## Asynchronous Tests

When your code under test relies on TTS timing or events, you can suspend
and resume tests with `lu.await()`.
Under the hood this just calls `yield()` to allow control to pass to
TTS’s coroutine runner so the UI, chat, and grid updates continue
while you wait.

- `lu.await(0)` – yields for 1-frame before continuing.
- `lu.await(condFn)` – yields until `condFn()` returns `true` (evaluated each frame).

### Example: 1-frame delay

```lua
function TestDoor:testAutoClose()
    -- wait 1 frames 
    await(0)
    lu.assertTrue(door.isClosed)
    
    -- now wait until the “locked” flag is set
    await(function() return door.isLocked end)
    lu.assertTrue(door.isLocked)
end
```

---

## Testing Hints, Tips and Best Practices

As this port is new, there isn't a lot of prior history that can be offered, but here are tips gleaned from codebases in other languages.

### Arrange, Act, Assert

A common skeleton for test methods are three clear steps:

1. **Arrange** – set up any data or objects you need.
2. **Act**     – invoke the method or function under test.
3. **Assert**  – verify the outcome with one or possibly more assertions.

**Example:**
```lua
function TestVector:test_vector_length_calculation()
    -- Arrange
    local v = Vector(3, 4, 0)
    
    -- Act
    local len = v:magnitude()
    
    -- Assert
    lu.assertEquals(5, len)
end
```

>Resist the temptation to bundle multiple scenarios into a single test.
 
Don't intersperse asserts with arrange & act code.
<br/>e.g. arrange, act, assert, followed by more arrange or act code, followed by more asserts all in one test method.

Instead, split each scenario into separate `test` methods:

### Naming
Test method names need to start with `test`, we can't get around that, but try to convey a specific behavior or outcome with the rest of the test name.

What's being asserted in the test and the name of the test should feel related. When the test fails, it's helpful that the name tells you what's wrong.
1. avoid meaningless names `test_doit()`, `test1()`, or `testFoo()`
2. using the word `should` or `should_not` can be useful in this regard.
   - e.g. `test_object_should_spawn_at_origin()`
     ```lua
     TestSpawner = {}

     function TestSpawner:test_object_should_spawn_at_origin()
         local origin = Vector(0, 0, 0)
         local spawner = Spawner.new()
         local obj = spawner:spawn("ObjectUnderTest")
     
         lu.await(function() return self.obj.resting end)
   
         lu.assertEquals(origin, obj.getPosition())
     end
     ```
> Keep names concise but intention-revealing. If a test fails, its name should tell you what broke.

### Keep Tests Small and Focused

Here are some good rules for tests:
1. **A test should fail reliably for an expected reason.** (A test has only one reason to fail.)
2. **A test should never fail for any other reason.** (Don't give a test multiple reasons to fail.)
3. **There are no other tests that fail for the same reason.** (Don't duplicate tests that will all fail for the same reason.)

One way to ensure this is keep it to one assertion per behavior, wherever practical.
If you need multiple assertions, group them under a single logical behavior.

Ensure each `test` method verifies exactly one “unit of behavior.” This makes it easier to locate and fix failures quickly.

##### Approach 1: Using `setUp()` / `tearDown()` with one assert per test

```lua
TestSpawner = {}

-- Runs once before any test methods
function TestSpawner:setupClass()
    -- Common setup: spawn the object under test
    self.origin  = Vector(0, 0, 0)
    self.spawner = Spawner.new()
    self.obj     = self.spawner:spawn("ObjectUnderTest")
end

-- Runs once after all these test methods
function TestSpawner:teardownClass()
    -- Clean up: destroy the spawned object and clear references
    self.obj:destroy()
    self.obj     = nil
    self.spawner = nil
end

-- Each test only contains a single assertion about the spawned object:

function TestSpawner:test_object_should_spawn_at_origin()
    lu.assertEquals(self.origin, self.obj:getPosition())
end

function TestSpawner:test_object_should_be_rotated_clockwise_90_degrees()
    local expectedRotation = Rotation(0, 90, 0)
    lu.assertEquals(expectedRotation, self.obj:getRotation())
end

function TestSpawner:test_object_should_be_half_scale()
    local expectedScale = Vector(0.5, 0.5, 0.5)
    lu.assertEquals(expectedScale, self.obj:getScale())
end
```

Benefit: each test is tiny and low‐risk—if one behavior breaks, the tests tell you exactly which behvavior you broke.

#### Approach 2: Single‐block assertions all inside one `test` method

```lua
TestSpawner = {}

function TestSpawner:test_object_should_spawn_with_correct_properties()
    local expectedPosition = Vector(0, 0, 0)
    local expectedRotation = Rotation(0, 90, 0)
    local expectedScale    = Vector(0.5, 0.5, 0.5)

    local spawner = Spawner.new()
    local obj     = spawner:spawn("ObjectUnderTest")

    lu.assertEquals(expectedPosition, obj:getPosition())
    lu.assertEquals(expectedRotation, obj:getRotation())
    lu.assertEquals(expectedScale,    obj:getScale())

    obj:destroy()
end
```
All assertions in one place:
* You only spawn once, then immediately check every relevant property.

* If any of these assertions fails, the entire test is marked failing.

Benefit: shorter setup/teardown boilerplate; fewer named test functions.

However, a single failure in the block may require inspecting multiple assertions to pinpoint which property broke.

#### Avoid repeating asserts
If you opt for Approach 2, don't fall into the trap of asserting the same things over again in every test. Once one test covers a property or behavior, you don’t need to repeat it elsewhere—duplication just means a single bug will break half your test suite. Trust that “one place,” you don't need to reassert or retest it everywhere else, move on to testing something new.

### Always preserve test isolation

* Tests should run alone.
* Tests should run all together.
* Tests should run in any order.
* Each test should create its own state and clean up afterward.
    * Don't depend on one test leaving a state you depend on in another test.

* Don’t make tests depend on one another implicitly or explicitly.
  * Never call a test from inside another test.
  * Instead, factor out common code and call it, or incorporate it into a `setUp()` method.

* Use `setupClass(self)` when you need an expensive, read‐only setup that’s shared by all tests in a class.
* Use `setupSuite()` only for constants or static reference data that doesn't change during the entire run.
  * Don't use it for global state modification.

---

## Differences With Upstream LuaUnit

* **No JUnit XML Output:** TTS does not support file I/O.
* **No file output:** All output goes to chat, log, or grid.
* **No command line:** Test selection is determined by what is in global scope, not by command line pattern matching.
* **MoonSharp sandbox:** No `io.open`, `os.exit`, or real `os.getenv` support. Additionally, there is no per character output via `io.stdout.write()`.
* **Coroutine runner:** Test runner yields to TTS to allow GUI and text window updates.
* **assertEquals(expected, actual):** This assertion order matches xUnit conventions.

---

## Credits

* LuaUnit by [Philippe Fremy](https://github.com/bluebird75/luaunit)
* TTS port and multi-output by [Mike Rieser](https://github.com/mikerieser/LuaUnit-TTS)

---

## License

* **LuaUnit** (original): BSD 3-Clause License
* **LuaUnit-TTS** port: BSD 3-Clause License

---

## Happy testing 🎲

---
#3488443936
