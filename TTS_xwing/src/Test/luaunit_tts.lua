-- luaunit_tts.lua
require('Test.luaunit_tts_stubs') -- Load stubs first
local tts_output = require('Test.tts_output') -- Load TTSOutput
local M = require('Test.luaunit')  -- Load LuaUnit

if tts_output then
    tts_output.setup(M) -- Configure LuaUnit to use TTSOutput
else
    printToAll("Error: tts_output.lua failed to load", {1, 0, 0}) -- Red
end

return M
