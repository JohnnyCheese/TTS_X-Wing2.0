local lu          = require("Test.luaunit_tts")
local Snapshotter = require("Test.Game.Mechanic.fixtures.MovementSnapshot")
local MoveData    = require("Game.Mechanic.Movement.MoveData")

-- This is not a Test!
-- * it's a SnapShot generator to create a GOLDEN master type of file for movement commands
-- * this expects that the commands verified manually, so the snapshot of their results is GOLDEN
-- * it is run by the LuaUnit-TTS framework, and should be run in Global.lua scope for acces to XW_cmd
-- * set this to true to generated output
PRINT_SNAPSHOT    = false

FakeTest          = {}

function FakeTest:setUp()
    lu.assertNotNil(XW_cmd, "XW_cmd not found on Global.")
    lu.assertNotNil(MoveData and MoveData.LUT and MoveData.LUT.Data, "MoveData LUT not loaded.")
end

function FakeTest:test_print_small_goldens_opt_in()
    if not _G.PRINT_SNAPSHOT then
        lu.assertTrue(true) -- no-op unless you opt in
        return
    end

    Snapshotter.print_snapshot_block("barrel_roll_expected.lua (small)", cmds, "small")
    lu.assertTrue(true)
end

cmds = {
    -- Straight Barrel Rolls Right
    "rr1", "rr2", "rr3",
    "r1r1", "r1r2", "r1r3",
    "r2r1", "r2r2", "r2r3",
    "r3r1", "r3r2", "r3r3",

    -- Straight Barrel Rolls Left
    "rl1", "rl2", "rl3",
    "r1l1", "r1l2", "r1l3",
    "r2l1", "r2l2", "r2l3",
    "r3l1", "r3l2", "r3l3",

    -- Banked (Viper) Barrel Rolls Right Forward
    "vrf1", "vrf2", "vrf3",
    "v1rf1", "v1rf2", "v1rf3",
    "v2rf1", "v2rf2", "v2rf3",
    "v3rf1", "v3rf2", "v3rf3",

    -- Banked (Viper) Barrel Rolls Right Backward
    "vrb1", "vrb2", "vrb3",
    "v1rb1", "v1rb2", "v1rb3",
    "v2rb1", "v2rb2", "v2rb3",
    "v3rb1", "v3rb2", "v3rb3",

    -- Banked (Viper) Barrel Rolls Left Forward
    "vlf1", "vlf2", "vlf3",
    "v1lf1", "v1lf2", "v1lf3",
    "v2lf1", "v2lf2", "v2lf3",
    "v3lf1", "v3lf2", "v3lf3",

    -- Banked (Viper) Barrel Rolls Left Backward
    "vlb1", "vlb2", "vlb3",
    "v1lb1", "v1lb2", "v1lb3",
    "v2lb1", "v2lb2", "v2lb3",
    "v3lb1", "v3lb2", "v3lb3",

    -- Turn (Viper) Barrel Rolls Right Forward
    -- "vtrf1",
    "vtrf2",
    -- "vtrf3",

    -- Turn (Viper) Barrel Rolls Right Backward
    -- "vtrb1",
    "vtrb2",
    -- "vtrb3",

    -- Turn (Viper) Barrel Rolls Left Forward
    -- "vtlf1",
    "vtlf2",
    -- "vtlf3",

    -- Turn (Viper) Barrel Rolls Left Backward
    -- "vtlb1",
    "vtlb2",
    -- "vtlb3",
}

return FakeTest
