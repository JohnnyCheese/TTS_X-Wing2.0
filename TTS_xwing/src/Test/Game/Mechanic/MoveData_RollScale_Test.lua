local lu = require("Test.luaunit_tts")
local MoveData = require("Game.Mechanic.Movement.MoveData")

require("Game.Mechanic.Movement.MoveLUT")
MoveData.LUT.Data = MoveData.LUT.Data or ParseLUT()


local function ship() return { getTable = function() return { Size = "small" } end } end
local function disp(cmd)
    local info = MoveData.DecodeInfo(cmd, ship())
    return MoveData.LUT.ConstructData(info, MoveData.partMax) -- {x,0,z,rot}
end

TestMoveDataRollScale = {}

-- Center offset: Z ~ 0; each extra template adds ~half of baseline center lateral.
function TestMoveDataRollScale:test_center_offset_increments_are_half_baseline()
    local r1 = disp("rr2")     -- speed-1, right, center
    local r2 = disp("r2r2")    -- speed-2, right, center
    local r3 = disp("r3r2")    -- speed-3, right, center

    local L1 = math.abs(r1[1]) -- baseline lateral (base + 1 template)
    local eps = 1e-4

    -- Z remains ~0 for center
    lu.assertAlmostEquals(0, r1[3], eps)
    lu.assertAlmostEquals(0, r2[3], eps)
    lu.assertAlmostEquals(0, r3[3], eps)

    -- Each extra template ≈ + L1/2
    lu.assertAlmostEquals((r2[1] - r1[1]), 0.5 * L1, 1e-3)
    lu.assertAlmostEquals((r3[1] - r2[1]), 0.5 * L1, 1e-3)

    -- Overall: r3 ≈ r1 + L1 (i.e., ~2× baseline), matching the expected magnitude
    lu.assertAlmostEquals((r3[1] - r1[1]), 1.0 * L1, 1e-3)
end

-- Forward/back offsets: keep Z from LUT; X increments are same as center
function TestMoveDataRollScale:test_forward_and_backward_keep_z_add_half_baseline_per_step()
    local f1 = disp("rr1")
    local f3 = disp("r3r1")
    local b1 = disp("rr3")
    local b2 = disp("r2r3")

    local L1 = math.abs(disp("rr2")[1])
    local eps = 1e-4

    -- Z preserved
    lu.assertAlmostEquals(f3[3], f1[3], eps)
    lu.assertAlmostEquals(b2[3], b1[3], eps)

    -- X increments: +L1/2 per extra template
    lu.assertAlmostEquals((b2[1] - b1[1]), 0.5 * L1, 1e-3) -- from speed-1 -> speed-2
    lu.assertAlmostEquals((f3[1] - f1[1]), 1.0 * L1, 1e-3) -- from speed-1 -> speed-3 (two steps)
end

return TestMoveDataRollScale
