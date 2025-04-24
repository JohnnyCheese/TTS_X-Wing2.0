--[[────────────────────────────────────────────────────────────────────────────
    LuaUnit Multi-Output Handler for TTS
    Drop-in replacement that routes LuaUnit output to multiple destinations
    (chat, system log, grid UI) while reusing upstream formatters.
────────────────────────────────────────────────────────────────────────────]]--

---------------------------------------------------------------
-- 1. Dependencies
---------------------------------------------------------------
local M = require("Test.luaunit") -- upstream LuaUnit 3.x

---------------------------------------------------------------
-- 2. Default Color Palette
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

--[[────────────────────────────────────────────────────────────────────────────
    BufferedEmitter: Mixin for buffered output with tab expansion
────────────────────────────────────────────────────────────────────────────]]--
local Emitter = {}

function Emitter:init()
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

--[[────────────────────────────────────────────────────────────────────────────
    TTSMultiOutput: Composite root that delegates to child outputs
────────────────────────────────────────────────────────────────────────────]]--
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

--[[────────────────────────────────────────────────────────────────────────────
    Output Class Hierarchy:

    M.genericOutput (LuaUnit base)
        |
        +-- TTSMultiOutput (composite root)
        |
        +-- M.TextOutput or M.TapOutput (format providers)
            |
            +-- ChatOutput (decorates either format with colored chat output)
            +-- LogOutput (decorates either format with system console output)
────────────────────────────────────────────────────────────────────────────]]--

-- Modify createOutput to be format-agnostic
local function createOutput(runner, palette, format, flushFunc)
    local baseFormatter = (format == "TAP") and M.TapOutput or M.TextOutput
    local t = baseFormatter.new(runner)

    -- Add Emitter methods
    for k, v in pairs(Emitter) do
        t[k] = v
    end
    t:init()

    t.colors = palette or defaultPalette
    t.flushFunc = flushFunc
    -- Don't set metatable here, let decorator do it
    return t
end

--[[────────────────────────────────────────────────────────────────────────────
    ChatOutput: Colored chat window output using TextOutput/TapOutput formatting
────────────────────────────────────────────────────────────────────────────]]--
local ChatOutput = {}
ChatOutput.__index = ChatOutput
ChatOutput.__class__ = "ChatOutput"

-- Make ChatOutput format-agnostic
function ChatOutput.new(runner, palette, format)
    local flushFunc = function(line, color)
        printToAll(line, color)
    end
    local t = createOutput(runner, palette, format or "TAP", flushFunc)  -- Default to TAP for newbies

    -- Create metatable that checks ChatOutput first, then base formatter
    return setmetatable(t, {
        __index = function(instance, key)
            local v = ChatOutput[key]
            if v ~= nil then return v end
            -- Get from base formatter
            local baseClass = (format or "TAP") == "TAP" and M.TapOutput or M.TextOutput
            return baseClass[key]
        end
    })
end

function ChatOutput:flush(line)
    local node = self.result.currentNode
    local status = node and node.status or "INFO"
    local clrHex = self.colors[status] or self.colors.NEUTRAL
    self.flushFunc(line, Color.fromHex(clrHex))
end

--[[────────────────────────────────────────────────────────────────────────────
    LogOutput: System console output using TapOutput formatting
────────────────────────────────────────────────────────────────────────────]]--
local LogOutput = {}
LogOutput.__index = LogOutput
LogOutput.__class__ = "LogOutput"

-- Make LogOutput format-agnostic
function LogOutput.new(runner, palette, format)
    local flushFunc = function(line)
        log(line)
    end
    local t = createOutput(runner, palette, format or "TEXT", flushFunc)  -- Default to TEXT for experts

    -- Create metatable that checks LogOutput first, then base formatter
    return setmetatable(t, {
        __index = function(instance, key)
            local v = LogOutput[key]
            if v ~= nil then return v end
            -- Get from base formatter
            local baseClass = (format or "TEXT") == "TAP" and M.TapOutput or M.TextOutput
            return baseClass[key]
        end
    })
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
-- Update buildTTSOutput with new defaults
local function buildTTSOutput(runner, cfg)
    cfg = cfg or {}
    local root = TTSMultiOutput.new(runner)

    -- Add ChatOutput by default for newbies (TAP format, verbose)
    if cfg.chat ~= false then  -- enabled by default
        local chat = ChatOutput.new(runner, cfg.chat and cfg.chat.palette, "TAP")
        chat.verbosity = cfg.chat and cfg.chat.verbosity or M.VERBOSITY_VERBOSE
        root:add(chat)
    end

    -- Add LogOutput if explicitly enabled (TEXT format, low verbosity)
    if cfg.log and cfg.log.enabled then
        local log = LogOutput.new(runner, cfg.log.palette, "TEXT")
        log.verbosity = cfg.log.verbosity or M.VERBOSITY_LOW
        root:add(log)
    end

    -- Add GridOutput by default if hostObject exists
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
