-- luaunit_tts_env.lua
-- TTS-safe LuaUnit output handling with buffered print and dynamic color

TTSOutput = {
    __class__ = "TTSOutput",
    chat = true,      -- default: chat logging off
    log = false,      -- default: console log logging off
    hostObject = nil, -- default: no host object (TTS)
    colors = {
        SUCCESS = "#00FF00",
        FAIL    = "#FF0000",
        ERROR   = "#FFA500",
        SKIP    = "#FFFF00",
        START   = "#FFFF97", -- light yellow
        FINISH  = "#FFFF97", -- matches START by default, intended for final summary line
        INFO    = "#9997FF", -- soft blue
        NEUTRAL = "#FFFFFF", -- white
    }
}
setmetatable(TTSOutput, { __index = lu.genericOutput })

local stdoutBuffer = ""
local originalGenericNew = lu.genericOutput.new

function lu.genericOutput.new(runner, default_verbosity, ...)
    _G.luaunit_runner = runner
    return originalGenericNew(runner, default_verbosity, ...)
end

-- Resolve color based on current test node status in active runner
local function currentOutputColor()
    local runner = _G.luaunit_runner
    if runner and runner.result and runner.result.currentNode then
        local status = tostring(runner.result.currentNode.status or ""):upper()
        return Color.fromHex(TTSOutput.colors[status] or TTSOutput.colors.NEUTRAL)
    end
    return Color.fromHex(TTSOutput.colors.NEUTRAL)
end

local function flushBufferedLines()
    local start = 1
    while true do
        local stop = stdoutBuffer:find("\n", start, true)
        if not stop then break end

        local line = stdoutBuffer:sub(start, stop - 1):gsub("\t", "    ")
        printToAll(line, currentOutputColor())

        start = stop + 1
    end
    stdoutBuffer = stdoutBuffer:sub(start)
end

local function forceFlushAll()
    flushBufferedLines()
    if stdoutBuffer ~= "" then
        printToAll(stdoutBuffer:gsub("\t", "    "), currentOutputColor())
        stdoutBuffer = ""
    end
end

_G.print = function(...)
    for i, arg in ipairs({ ... }) do
        if i > 1 then stdoutBuffer = stdoutBuffer .. "\t" end
        stdoutBuffer = stdoutBuffer .. tostring(arg)
    end
    stdoutBuffer = stdoutBuffer .. "\n"
    forceFlushAll()
end

io = io or {}
io.stdout = {}

function io.stdout.write(_, ...)
    for _, arg in ipairs({ ... }) do
        stdoutBuffer = stdoutBuffer .. tostring(arg)
    end
    flushBufferedLines()
end

function io.stdout.flush()
    flushBufferedLines()
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
