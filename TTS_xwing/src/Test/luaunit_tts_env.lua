--[[────────────────────────────────────────────────────────────────────────────
    LuaUnit Environment Shim for TTS
    Provides TTS-compatible implementations of standard Lua I/O functions
    needed by LuaUnit (print, io.stdout, os.getenv, etc.)
────────────────────────────────────────────────────────────────────────────]]--

-- luaunit_tts_env.lua
-- TTS-safe LuaUnit output handling with buffered print and dynamic color

--[[────────────────────────────────────────────────────────────────────────────
    Emitter: Buffered output with tab expansion
    Core functionality used by both direct output and formatters
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
    if line then
        self:emit(line)
    end
    self:emit("\n")
end

-- Export Emitter globally so other modules can use it
_G.Emitter = Emitter

-- Create a global output emitter for print/io
local stdoutEmitter = setmetatable({}, { __index = Emitter })
stdoutEmitter:init()
stdoutEmitter.flush = function(self, line)
    printToAll(line)
end

-- Replace global print with Emitter-based version
_G.print = function(...)
    for i, arg in ipairs({ ... }) do
        if i > 1 then stdoutEmitter:emit("\t") end
        stdoutEmitter:emit(tostring(arg))
    end
    stdoutEmitter:emit("\n")
end

-- Replace io.stdout with Emitter-based version
io = io or {}
io.stdout = {}
io.stdout.write = function(_, ...)
    for _, arg in ipairs({ ... }) do
        stdoutEmitter:emit(tostring(arg))
    end
end

io.stdout.flush = function()
    -- Already handled by Emitter
end

function os.getenv(key)
    local fake_env = {
        LUAUNIT_OUTPUT = "text",
        LUAUNIT_JUNIT_FNAME = "junit.xml",
        LUAUNIT_DATEFMT = "%Y-%m-%d %H:%M:%S"
    }
    return fake_env[key] or nil
end

os.exit = function()
    error("os.exit() is disabled in TTS")
end

io.open = function(fname, mode)
    return nil, "io.open is disabled in TTS"
end
