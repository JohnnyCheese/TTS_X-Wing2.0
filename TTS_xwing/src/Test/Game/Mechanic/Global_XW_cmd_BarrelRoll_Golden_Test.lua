-- Runs under Global (via require("Test.GlobalSuite") in Global.lua).
-- Uses *production* XW_cmd and MoveData to lock golden barrel-roll endpoints.

local lu       = require("Test.luaunit_tts")
local MoveData = require("Game.Mechanic.Movement.MoveData")

local GOLDEN   = require("Test.Game.Mechanic.fixtures.barrel_roll_expected")

-- minimal dot-call-safe ship carrying Size (what DecodeInfo expects)
local function newShip(base)
    local s = { _vars = { Data = { Size = base or "small" } } }
    s.getTable = function(k) return s._vars[k] end
    return s
end

-- JUnit-style helper: expected first, actual second
local function assertPoseAlmostEquals(expected, actual, tolPos, tolYaw, label)
    lu.assertAlmostEquals(expected.x, actual[1], tolPos, (label or "") .. " x")
    lu.assertAlmostEquals(expected.z, actual[3], tolPos, (label or "") .. " z")
    lu.assertAlmostEquals(expected.yaw, actual[4], tolYaw, (label or "") .. " yaw")
end

TestGlobalXWCmdBarrelRoll_Golden = {}

function TestGlobalXWCmdBarrelRoll_Golden:setUp()
    -- We run inside Global, so XW_cmd and MoveData are already in scope.
    lu.assertNotNil(XW_cmd, "XW_cmd not found on Global.")
    lu.assertNotNil(MoveData, "MoveData not found.")
    -- Ensure LUT is populated (Global usually does this; assert if not)
    lu.assertNotNil(MoveData.LUT and MoveData.LUT.Data, "MoveData.LUT.Data not loaded.")
end

-- tolerances: tighten after first pass if you like
local TOL_POS = 0.75 -- table units
local TOL_YAW = 1.0  -- degrees

-- Build one LuaUnit test per command so failures show the cmd in the test name.
local function addCmdTest(idx, row)
    local cmd                              = row.cmd
    local base                             = row.base or "small"
    local want                             = row.expect
    local name                             = ("test_%03d_%s_%s"):format(idx, base, cmd):gsub("[^%w_]", "_")

    TestGlobalXWCmdBarrelRoll_Golden[name] = function()
        local ship = newShip(base)

        -- 1) Ensure production regex recognizes the command as an action move
        lu.assertEquals("actionMove", XW_cmd.CheckCommand(cmd), "Cmd not recognized: " .. cmd)

        -- 2) Decode via production MoveData
        local info = MoveData.DecodeInfo(cmd, ship)
        lu.assertNotNil(info, "DecodeInfo returned nil for " .. cmd)
        lu.assertEquals(base, info.size, "size mismatch for " .. cmd)

        -- 3) Sample endpoint (no ship movement)
        local pose = MoveData.LUT.ConstructData(info, MoveData.partMax)

        -- 4) Compare to golden
        assertPoseAlmostEquals(want, pose, TOL_POS, TOL_YAW, cmd)
    end
end

for i, row in ipairs(GOLDEN) do
    addCmdTest(i, row) -- create one test method per row
end

return TestGlobalXWCmdBarrelRoll_Golden
