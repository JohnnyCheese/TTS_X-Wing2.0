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
    for _, arg in ipairs({ ... }) do
        self.buffer = self.buffer .. tostring(arg)
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

---------------------------------------------------------------
-- 7  DiagnosticOutput  (logs lifecycle method calls)
---------------------------------------------------------------
--[[────────────────────────────────────────────────────────────────────────────
    DiagnosticOutput: Logs lifecycle method calls for debugging
────────────────────────────────────────────────────────────────────────────]] --

local DiagnosticOutput = {}
DiagnosticOutput.__index = DiagnosticOutput
DiagnosticOutput.__class__ = "DiagnosticOutput"

function DiagnosticOutput.new(runner)
    local t = M.genericOutput.new(runner)
    return setmetatable(t, DiagnosticOutput)
end

-- Log all lifecycle method calls
for _, method in ipairs({
    "startSuite", "startClass", "startTest", "updateStatus", "endTest", "endClass", "endSuite"
}) do
    DiagnosticOutput[method] = function(self, ...)
        local args = { ... }
        local argStr = table.concat(
            (function()
                local mapped = {}
                for i, arg in ipairs(args) do
                    mapped[i] = tostring(arg)
                end
                return mapped
            end)(),
            ", "
        )
        printToAll(string.format("DiagnosticOutput:%s(%s)", method, argStr), Color.Orange)
    end
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
