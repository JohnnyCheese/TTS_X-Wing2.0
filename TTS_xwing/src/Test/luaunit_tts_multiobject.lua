-- luaunit_tts_multiobject.lua
-- Drop‑in replacement that routes LuaUnit output to multiple destinations
-- (TTS chat, system log, etc.) while *re‑using* upstream formatters.

---------------------------------------------------------------
-- 1  Dependencies
---------------------------------------------------------------
local M = require("Test.luaunit") -- upstream LuaUnit 3.x

---------------------------------------------------------------
-- 2  Colour palette (user‑overridable)
---------------------------------------------------------------
local defaultPalette = {
    SUCCESS = "#00FF00", -- green
    FAIL    = "#FF0000", -- bright red (assert fail)
    ERROR   = "#CC0000", -- darker red (runtime error)
    SKIP    = "#FFFF00", -- yellow
    UNKNOWN = "#FF00FF", -- magenta
    START   = "#FFFF99", -- light yellow (suite start)
    INFO    = "#FFFDD0", -- cream (generic info)
    FINISH  = "#FFFF99", -- light yellow (suite end)
    NEUTRAL = "#FFFFFF", -- white (grid squares before status)
}

---------------------------------------------------------------
-- 3  BufferedEmitter mix‑in  (tab expansion + line buffering)
---------------------------------------------------------------
local Emitter = {}

function Emitter:init()
    printToAll("Emitter:init ", Color.Brown)
    self.buffer = ""
end

function Emitter:emit(...)
    -- Convert each argument to string and expand tabs
    local tabWidth = 8  -- Standard console tab width
    for _, arg in ipairs({ ... }) do
        local str = tostring(arg)
        -- Replace tabs with spaces, preserving alignment
        str = str:gsub("\t", function()
            local pos = #self.buffer % tabWidth
            return string.rep(" ", tabWidth - pos)
        end)
        self.buffer = self.buffer .. str
    end
    
    if self.buffer:find("\n") then
        for line in self.buffer:gmatch("([^\n]*)\n") do
            self:flush(line)
        end
        self.buffer = self.buffer:match("\n(.*)$") or ""
    end
end

function Emitter:emitLine(line)
    self:emit(line or "", "\n")
end

---------------------------------------------------------------
-- 4  Composite root – TTSMultiOutput
---------------------------------------------------------------
local TTSMultiOutput = {}
TTSMultiOutput.__index = TTSMultiOutput                     -- Ensure methods are accessible in TTSMultiOutput
setmetatable(TTSMultiOutput, { __index = M.genericOutput }) -- Inherit from genericOutput
TTSMultiOutput.__class__ = "TTSMultiOutput"

function TTSMultiOutput.new(runner)
    local t = M.genericOutput.new(runner)
    t.children = {} -- Initialize an empty list of children
    return setmetatable(t, TTSMultiOutput)
end

function TTSMultiOutput:add(child)
    table.insert(self.children, child)
end

-- Delegate all lifecycle methods to child outputs
setmetatable(TTSMultiOutput, {
    __index = function(_, method)
        return function(self, ...)
            for _, child in ipairs(self.children) do
                if child[method] then
                    child[method](child, ...)
                end
            end
            -- Call the superclass implementation if it exists
            if M.genericOutput[method] then
                M.genericOutput[method](self, ...)
            end
        end
    end
})

---------------------------------------------------------------
-- 5  ChatOutput  (inherits TextOutput formatting)
---------------------------------------------------------------
--[[────────────────────────────────────────────────────────────────────────────
    ChatOutput: Subclasses LuaUnit outputters (TextOutput or TapOutput)
    Dynamically switches based on the desired format.
────────────────────────────────────────────────────────────────────────────]] --

local ChatOutput = {}
ChatOutput.__index = ChatOutput
ChatOutput.__class__ = "ChatOutput"

local function createOutput(runner, palette, format, flushFunc)
    local baseClass = (format == "TAP") and M.TapOutput or M.TextOutput
    local t = baseClass.new(runner)

    -- Add Emitter methods directly to the instance
    for k, v in pairs(Emitter) do
        t[k] = v
    end
    t:init() -- Initialize buffer

    t.colors = palette or defaultPalette
    t.flushFunc = flushFunc
    return t
end

function ChatOutput.new(runner, palette, format)
    local flushFunc = function(line, color)
        printToAll(line, color)
    end
    local t = createOutput(runner, palette, format or "TEXT", flushFunc)

    -- Create a metatable that checks ChatOutput first, then falls back to base formatter
    return setmetatable(t, {
        __index = function(instance, key)
            local v = ChatOutput[key]
            if v ~= nil then return v end
            -- Get from base formatter
            return ((format or "TEXT") == "TAP" and M.TapOutput or M.TextOutput)[key]
        end
    })
end

function ChatOutput:flush(line)
    local node = self.result.currentNode
    local status = node and node.status or "INFO"
    local clrHex = self.colors[status] or self.colors.NEUTRAL
    self.flushFunc(line, Color.fromHex(clrHex))
end

---------------------------------------------------------------
-- 6  LogOutput  (inherits TapOutput formatting)
---------------------------------------------------------------
--[[────────────────────────────────────────────────────────────────────────────
    LogOutput: Subclasses LuaUnit outputters (TextOutput or TapOutput)
    Dynamically switches based on the desired format.
────────────────────────────────────────────────────────────────────────────]] --

local LogOutput = {}
LogOutput.__index = LogOutput
LogOutput.__class__ = "LogOutput"

function LogOutput.new(runner, palette, format)
    local flushFunc = function(line)
        log(line)
    end
    local t = createOutput(runner, palette, format or "TAP", flushFunc)
    return setmetatable(t, {
        __index = function(instance, key)
            local v = ChatOutput[key]
            if v ~= nil then return v end
            -- Get from base formatter
            return ((format or "TEXT") == "TAP" and M.TapOutput or M.TextOutput)[key]
        end
    })

    -- First ensure LogOutput inherits from proper formatter
    -- setmetatable(LogOutput, { __index = (format == "TAP" and M.TapOutput or M.TextOutput) })

    -- Then set instance metatable to LogOutput
    -- return setmetatable(t, { __index = LogOutput })
end

function LogOutput:flush(line)
    self.flushFunc(line)
end

--[[────────────────────────────────────────────────────────────────────────────
    GridOutput: Grid-based UI output for TTS
────────────────────────────────────────────────────────────────────────────]] --
-- Utility function to recursively find an element by its ID
local function findElementById(elements, id)
    for _, element in ipairs(elements or {}) do
        if element.attributes and element.attributes.id == id then
            return element
        end
        if element.children then
            local found = findElementById(element.children, id)
            if found then
                return found
            end
        end
    end
    return nil
end

GridOutput = {
    __class__ = "GridOutput"
}
setmetatable(GridOutput, { __index = M.genericOutput })

function GridOutput.new(runner, colors)
    printToAll("GridOutput.new()", Color.Orange)
    local t = M.genericOutput.new(runner)
    t.hostObject = runner.hostObject
    t.colors = colors
    t.squareIds = {}
    t.testOutputs = {}
    return setmetatable(t, { __index = GridOutput })
end

function GridOutput:startSuite()
    local uiTable = self.hostObject.UI.getXmlTable()
    if not uiTable or #uiTable == 0 then
        printToAll(self.__class__ .. ": Failed to get UI table", Color.fromHex(self.colors.ERROR))
        return
    end

    function onClick(player, value, id)
        local testResult = M.prettystr(self.testOutputs[id])
        local colorHex = self.hostObject.UI.getAttribute(id, "color")
        printToAll(testResult, Color.fromHex(colorHex))
    end

    local panels = {}
    local totalTests = self.runner.result.selectedCount
    for i = 1, totalTests do
        local id = "TestSquare" .. i
        self.squareIds[i] = id
        table.insert(panels, {
            tag = "Panel",
            attributes = {
                id = id,
                color = self.colors.NEUTRAL,
                onClick = "onClick"
            }
        })
    end

    local testGrid = findElementById(uiTable, "TestGrid")
    if not testGrid then
        printToAll(self.__class__ .. ": TestGrid not found", Color.fromHex(self.colors.ERROR))
        return
    end
    testGrid.children = panels
    self.hostObject.UI.setXmlTable(uiTable)
    coroutine.yield(0)
end

function GridOutput:endTest(node)
    local completedTests = node.number
    local status = node.status or "UNKNOWN"
    local colorHex = self.colors[status] or self.colors.UNKNOWN

    local id = "TestSquare" .. node.number
    self.testOutputs[id] = node

    local squareId = self.squareIds[completedTests]
    self.hostObject.UI.setAttribute(squareId, "color", colorHex)
    if self.runner.result.selectedCount > 100 then
        local percent = 1 - (completedTests / self.runner.result.selectedCount)
        self.hostObject.UI.setAttribute("TestScroll", "verticalNormalizedPosition", tostring(percent))
    end
    if completedTests % 10 == 0 then
        coroutine.yield(0)
    end
end

function GridOutput:totalTests()
    return self.runner.result.selectedCount
end

---------------------------------------------------------------
-- 8  Factory to build a complete output graph
---------------------------------------------------------------
local function buildTTSOutput(runner, cfg)
    cfg = cfg or {}

    -- Create the composite root
    local root = TTSMultiOutput.new(runner)

    -- Add ChatOutput if enabled
    if cfg.chat and cfg.chat.enabled then
        local chat = ChatOutput.new(runner, cfg.chat.palette or defaultPalette, cfg.chat.format or "TEXT")
        chat.verbosity = cfg.chat.verbosity or M.VERBOSITY_DEFAULT
        root:add(chat)
    end

    -- Add LogOutput if enabled
    if cfg.log and cfg.log.enabled then
        local log = LogOutput.new(runner, cfg.log.palette or defaultPalette, cfg.log.format or "TAP")
        log.verbosity = cfg.log.verbosity or M.VERBOSITY_DEFAULT
        root:add(log)
    end

    -- Add GridOutput if enabled and hostObject exists
    if cfg.grid ~= false and runner.hostObject then
        local grid = GridOutput.new(runner, cfg.grid and cfg.grid.palette or defaultPalette)
        root:add(grid)
    end

    return root
end

---------------------------------------------------------------
-- 9  Public helper to simplify user setup
---------------------------------------------------------------
local function configureLuaUnit(lu, opts)
    opts = opts or {}
    lu.LuaUnit.outputType = {
        new = function(runner, verbosity)
            opts.chat = opts.chat or { verbosity = verbosity }
            opts.log = opts.log or { verbosity = verbosity }
            return buildTTSOutput(runner, opts)
        end
    }
end

-- optional one‑liner convenience when this file is required directly
return {
    build = buildTTSOutput, -- advanced users
    configure = configureLuaUnit,
    palette = defaultPalette,
}
