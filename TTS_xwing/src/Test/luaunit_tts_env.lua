-- luaunit_tts_env.lua
-- Fake system and environment stubs for running LuaUnit inside Tabletop Simulator

-- TTS provides os.clock, os.difftime, os.date, and os.time via OS_Time
-- We only need to stub os.getenv and os.exit
os = os or {}
function os.getenv(key)
    -- Custom environment variables for use by LuaUnit or other sandboxed code
    -- Useful defaults for LuaUnit in TTS
    local fake_env = {
        LUAUNIT_OUTPUT = "text",           -- "TAP", "text", "NIL", "JUNIT"
        LUAUNIT_JUNIT_FNAME = "junit.xml", -- output filename if using junit
        LUAUNIT_DATEFMT = "%Y-%m-%d %H:%M:%S"
    }

    return fake_env[key] or nil
end

os.exit = function(code)
    -- Simulate exit by logging and stopping execution
    print("os.exit called with code: " .. tostring(code or 0))
    --error("Simulated os.exit in TTS")
end

-- Stub out io library (TTS doesn’t support file I/O)
io = io or {}
io.stdout = {
    write = function(self, ...)
        -- Redirect to TTS print
        local args = { ... }
        local output = table.concat(args, "")
        print(output)
    end,
    flush = function() end -- No-op in TTS
}

io.open = function(filename, mode)
    -- Log file access attempts
    print("io.open attempted on " .. filename .. " with mode " .. (mode or "r") .. " - not supported in TTS")
    return nil, "File I/O not available in TTS"
end

io.close = function(file) end -- No-op since no files are opened

-- Ensure print is available
print = print or function(msg) end

-- Return marker to confirm stubs are loaded
return { loaded = true }
