-- luaunit_tts.lua
-- One-stop TTS-compatible LuaUnit setup with unified output

require("Test.luaunit_tts_env")
local lu = require("Test.luaunit")
lu.LuaUnit.outputType = require("Test.luaunit_tts_output").TTSOutput

return lu
