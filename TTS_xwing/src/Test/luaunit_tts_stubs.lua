-- luaunit_tts_stubs.lua
-- Simplified stubs for running LuaUnit in Tabletop Simulator

-- TTS provides os.clock, os.difftime, os.date, and os.time via OS_Time
-- We only need to stub os.getenv and os.exit
os = os or {}
os.getenv = function(var)
    -- Useful defaults for LuaUnit in TTS
    local defaults = {
        ["LUAUNIT_OUTPUT"] = "text",                     -- Default to text output for chat
        ["LUAUNIT_JUNIT_FNAME"] = "tts_junit_output.xml" -- Unused but included for compatibility
    }
    return defaults[var] or nil
end

os.exit = function(code)
    -- Simulate exit by logging and stopping execution
    print("os.exit called with code: " .. tostring(code or 0))
    error("Simulated os.exit in TTS")
end

-- Stub out io library (TTS doesn’t support it)
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

io.close = function(file)
    -- No-op since no files are opened
end

-- Ensure print is available
print = print or function(msg) end

-- Return marker to confirm stubs are loaded
return { loaded = true }
