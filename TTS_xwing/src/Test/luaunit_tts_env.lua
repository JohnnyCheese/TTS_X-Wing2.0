--[[────────────────────────────────────────────────────────────────────────────
    LuaUnit Bootstrap for TTS
    Thin bootstrap that loads upstream LuaUnit, installs the TTS‑specific
    environment stubs, and handles tab expansion for output.
────────────────────────────────────────────────────────────────────────────]] --
local Emitter = {}

function Emitter:init()
    self.buffer = ""
end

function Emitter:emit(...)
    -- Convert each argument to string and expand tabs
    local tabWidth = 8 -- Standard console tab width
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
stdoutEmitter.flush = function(_, line)
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

io.stdout.flush = function() end

function os.getenv(key)
    local fake_env = {
        LUAUNIT_OUTPUT = "text",
        LUAUNIT_JUNIT_FNAME = "junit.xml",
        LUAUNIT_DATEFMT = "%Y-%m-%d %H:%M:%S"
    }
    return fake_env[key] or nil
end

os.exit = function()
    error("For Tabletop Simulator features related to the command line arguments are disabled.")
end

io.open = function(_, _)
    return nil, "io.open is disabled in TTS"
end
