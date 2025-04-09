-- luaunit_tts.lua
-- Provides LuaUnit configured for Tabletop Simulator compatibility (headless)

require("Test.luaunit_tts_env")      -- Install TTS-safe os/io/etc
local lu = require("Test.luaunit")   -- Load close to base LuaUnit

return lu
