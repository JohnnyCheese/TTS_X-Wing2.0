-- luaunit_tts_env.lua
-- TTS-safe stdout redirection for LuaUnit with safe buffering and minimal assumptions

-- Shared buffer for all output
local stdoutBuffer = ""

-- Flushes complete lines using Moonsharp-safe logic
local function flushBufferedLines()
    local start = 1
    while true do
        local stop = stdoutBuffer:find("\n", start, true)
        if not stop then break end

        local line = stdoutBuffer:sub(start, stop - 1)
        printToAll(tostring(line):gsub("\t", "    "), {1, 1, 1})
        start = stop + 1
    end
    stdoutBuffer = stdoutBuffer:sub(start)
end

-- Flushes all content, even unterminated lines
local function forceFlushAll()
    flushBufferedLines()
    if stdoutBuffer ~= "" then
        printToAll(tostring(stdoutBuffer):gsub("\t", "    "), {1, 1, 1})
        stdoutBuffer = ""
    end
end

-- Replaces built-in print with tab-joined buffered version
_G.print = function(...)
    for i, arg in ipairs({ ... }) do
        if i > 1 then stdoutBuffer = stdoutBuffer .. "\t" end
        stdoutBuffer = stdoutBuffer .. tostring(arg)
    end
    stdoutBuffer = stdoutBuffer .. "\n"
    forceFlushAll()
end

-- Safe stdout.write/flush (avoids implicit self from colon calls)
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

-- Environment variable fallback for LuaUnit
function os.getenv(key)
    local fake_env = {
        LUAUNIT_OUTPUT = "text",
        LUAUNIT_JUNIT_FNAME = "junit.xml",
        LUAUNIT_DATEFMT = "%Y-%m-%d %H:%M:%S"
    }
    return fake_env[key] or nil
end

-- Prevent LuaUnit from exiting the script
os.exit = function()
    error("os.exit() is disabled in TTS")
end

-- Optional fallback for JUnit output (disabled in TTS)
io.open = function(fname, mode)
    return nil, "io.open is disabled in TTS"
end
