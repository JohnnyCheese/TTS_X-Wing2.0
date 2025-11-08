-- Golden endpoint poses for commands that were verified manually.
-- Expand at will. For each row:
--   cmd  = the exact command string
--   base = "small" | "medium" | "large"
--   expect = { x = <number>, z = <number>, yaw = <degrees> }  -- relative to start

-- barrel_roll_expected.lua (small)
return {
    -- Straight Barrel Rolls Right
    { cmd = "rr1",    base = "small", expect = { x = 80.000, z = 10.000, yaw = 0.000 } },
    { cmd = "rr2",    base = "small", expect = { x = 80.000, z = 0.000, yaw = 0.000 } },
    { cmd = "rr3",    base = "small", expect = { x = 80.000, z = -10.000, yaw = 0.000 } },

    { cmd = "r1r1",   base = "small", expect = { x = 80.000, z = 10.000, yaw = 0.000 } },
    { cmd = "r1r2",   base = "small", expect = { x = 80.000, z = 0.000, yaw = 0.000 } },
    { cmd = "r1r3",   base = "small", expect = { x = 80.000, z = -10.000, yaw = 0.000 } },

    { cmd = "r2r1",   base = "small", expect = { x = 120.000, z = 10.000, yaw = 0.000 } },
    { cmd = "r2r2",   base = "small", expect = { x = 120.000, z = 0.000, yaw = 0.000 } },
    { cmd = "r2r3",   base = "small", expect = { x = 120.000, z = -10.000, yaw = 0.000 } },

    { cmd = "r3r1",   base = "small", expect = { x = 160.000, z = 10.000, yaw = 0.000 } },
    { cmd = "r3r2",   base = "small", expect = { x = 160.000, z = 0.000, yaw = 0.000 } },
    { cmd = "r3r3",   base = "small", expect = { x = 160.000, z = -10.000, yaw = 0.000 } },

    -- Straight Barrel Rolls Left
    { cmd = "rl1",    base = "small", expect = { x = 80.000, z = 10.000, yaw = 0.000 } },
    { cmd = "rl2",    base = "small", expect = { x = 80.000, z = 0.000, yaw = 0.000 } },
    { cmd = "rl3",    base = "small", expect = { x = 80.000, z = -10.000, yaw = 0.000 } },

    { cmd = "r1l1",   base = "small", expect = { x = 80.000, z = 10.000, yaw = 0.000 } },
    { cmd = "r1l2",   base = "small", expect = { x = 80.000, z = 0.000, yaw = 0.000 } },
    { cmd = "r1l3",   base = "small", expect = { x = 80.000, z = -10.000, yaw = 0.000 } },

    { cmd = "r2l1",   base = "small", expect = { x = 120.000, z = 10.000, yaw = 0.000 } },
    { cmd = "r2l2",   base = "small", expect = { x = 120.000, z = 0.000, yaw = 0.000 } },
    { cmd = "r2l3",   base = "small", expect = { x = 120.000, z = -10.000, yaw = 0.000 } },

    { cmd = "r3l1",   base = "small", expect = { x = 160.000, z = 10.000, yaw = 0.000 } },
    { cmd = "r3l2",   base = "small", expect = { x = 160.000, z = 0.000, yaw = 0.000 } },
    { cmd = "r3l3",   base = "small", expect = { x = 160.000, z = -10.000, yaw = 0.000 } },

    -- Banked (Viper) Barrel Rolls Right Forward
    { cmd = "vrf1",   base = "small", expect = { x = 83.640, z = 44.645, yaw = -45.000 } },
    { cmd = "vrf2",   base = "small", expect = { x = 90.711, z = 37.574, yaw = -45.000 } },
    { cmd = "vrf3",   base = "small", expect = { x = 97.782, z = 30.503, yaw = -45.000 } },

    { cmd = "v1rf1",  base = "small", expect = { x = 83.640, z = 44.645, yaw = -45.000 } },
    { cmd = "v1rf2",  base = "small", expect = { x = 90.711, z = 37.574, yaw = -45.000 } },
    { cmd = "v1rf3",  base = "small", expect = { x = 97.782, z = 30.503, yaw = -45.000 } },

    { cmd = "v2rf1",  base = "small", expect = { x = 118.995, z = 59.289, yaw = -45.000 } },
    { cmd = "v2rf2",  base = "small", expect = { x = 126.066, z = 52.218, yaw = -45.000 } },
    { cmd = "v2rf3",  base = "small", expect = { x = 133.137, z = 45.147, yaw = -45.000 } },

    { cmd = "v3rf1",  base = "small", expect = { x = 154.350, z = 73.934, yaw = -45.000 } },
    { cmd = "v3rf2",  base = "small", expect = { x = 161.421, z = 66.863, yaw = -45.000 } },
    { cmd = "v3rf3",  base = "small", expect = { x = 168.492, z = 59.792, yaw = -45.000 } },

    -- Banked (Viper) Barrel Rolls Right Backward
    { cmd = "vrb1",   base = "small", expect = { x = 97.782, z = -30.503, yaw = 45.000 } },
    { cmd = "vrb2",   base = "small", expect = { x = 90.711, z = -37.574, yaw = 45.000 } },
    { cmd = "vrb3",   base = "small", expect = { x = 83.640, z = -44.645, yaw = 45.000 } },

    { cmd = "v1rb1",  base = "small", expect = { x = 97.782, z = -30.503, yaw = 45.000 } },
    { cmd = "v1rb2",  base = "small", expect = { x = 90.711, z = -37.574, yaw = 45.000 } },
    { cmd = "v1rb3",  base = "small", expect = { x = 83.640, z = -44.645, yaw = 45.000 } },

    { cmd = "v2rb1",  base = "small", expect = { x = 133.137, z = -45.147, yaw = 45.000 } },
    { cmd = "v2rb2",  base = "small", expect = { x = 126.066, z = -52.218, yaw = 45.000 } },
    { cmd = "v2rb3",  base = "small", expect = { x = 118.995, z = -59.289, yaw = 45.000 } },

    { cmd = "v3rb1",  base = "small", expect = { x = 168.492, z = -59.792, yaw = 45.000 } },
    { cmd = "v3rb2",  base = "small", expect = { x = 161.421, z = -66.863, yaw = 45.000 } },
    { cmd = "v3rb3",  base = "small", expect = { x = 154.350, z = -73.934, yaw = 45.000 } },

    -- Banked (Viper) Barrel Rolls Left Forward
    { cmd = "vlf1",   base = "small", expect = { x = 83.640, z = 44.645, yaw = -45.000 } },
    { cmd = "vlf2",   base = "small", expect = { x = 90.711, z = 37.574, yaw = -45.000 } },
    { cmd = "vlf3",   base = "small", expect = { x = 97.782, z = 30.503, yaw = -45.000 } },

    { cmd = "v1lf1",  base = "small", expect = { x = 83.640, z = 44.645, yaw = -45.000 } },
    { cmd = "v1lf2",  base = "small", expect = { x = 90.711, z = 37.574, yaw = -45.000 } },
    { cmd = "v1lf3",  base = "small", expect = { x = 97.782, z = 30.503, yaw = -45.000 } },

    { cmd = "v2lf1",  base = "small", expect = { x = 118.995, z = 59.289, yaw = -45.000 } },
    { cmd = "v2lf2",  base = "small", expect = { x = 126.066, z = 52.218, yaw = -45.000 } },
    { cmd = "v2lf3",  base = "small", expect = { x = 133.137, z = 45.147, yaw = -45.000 } },

    { cmd = "v3lf1",  base = "small", expect = { x = 154.350, z = 73.934, yaw = -45.000 } },
    { cmd = "v3lf2",  base = "small", expect = { x = 161.421, z = 66.863, yaw = -45.000 } },
    { cmd = "v3lf3",  base = "small", expect = { x = 168.492, z = 59.792, yaw = -45.000 } },

    -- Banked (Viper) Barrel Rolls Left Backward
    { cmd = "vlb1",   base = "small", expect = { x = 97.782, z = -30.503, yaw = 45.000 } },
    { cmd = "vlb2",   base = "small", expect = { x = 90.711, z = -37.574, yaw = 45.000 } },
    { cmd = "vlb3",   base = "small", expect = { x = 83.640, z = -44.645, yaw = 45.000 } },

    { cmd = "v1lb1",  base = "small", expect = { x = 97.782, z = -30.503, yaw = 45.000 } },
    { cmd = "v1lb2",  base = "small", expect = { x = 90.711, z = -37.574, yaw = 45.000 } },
    { cmd = "v1lb3",  base = "small", expect = { x = 83.640, z = -44.645, yaw = 45.000 } },

    { cmd = "v2lb1",  base = "small", expect = { x = 133.137, z = -45.147, yaw = 45.000 } },
    { cmd = "v2lb2",  base = "small", expect = { x = 126.066, z = -52.218, yaw = 45.000 } },
    { cmd = "v2lb3",  base = "small", expect = { x = 118.995, z = -59.289, yaw = 45.000 } },

    { cmd = "v3lb1",  base = "small", expect = { x = 168.492, z = -59.792, yaw = 45.000 } },
    { cmd = "v3lb2",  base = "small", expect = { x = 161.421, z = -66.863, yaw = 45.000 } },
    { cmd = "v3lb3",  base = "small", expect = { x = 154.350, z = -73.934, yaw = 45.000 } },

    -- Turn (Viper) Barrel Rolls Right Forward
    { cmd = "vtrf2",  base = "small", expect = { x = 55.000, z = 55.000, yaw = -90.000 } },

    -- Turn (Viper) Barrel Rolls Right Backward
    { cmd = "vtrb2",  base = "small", expect = { x = 55.000, z = -55.000, yaw = 90.000 } },

    -- Turn (Viper) Barrel Rolls Left Forward
    { cmd = "vtlf2",  base = "small", expect = { x = 55.000, z = 55.000, yaw = -90.000 } },

    -- Turn (Viper) Barrel Rolls Left Backward
    { cmd = "vtlb2",  base = "small", expect = { x = 55.000, z = -55.000, yaw = 90.000 } },

}
