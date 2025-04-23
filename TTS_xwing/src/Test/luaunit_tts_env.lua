-- luaunit_tts_env.lua
-- TTS-safe LuaUnit output handling with buffered print and dynamic color

local stdoutBuffer = ""

local function flushBufferedLines()
    local start = 1
    while true do
        local stop = stdoutBuffer:find("\n", start, true)
        if not stop then break end

        local line = stdoutBuffer:sub(start, stop - 1):gsub("\t", "    ")
        printToAll(line)

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
