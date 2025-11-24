local M = {}

local MoveData = require("Game.Mechanic.Movement.MoveData")

local function newShip(base)
    local s = { _vars = { Data = { Size = base or "small" } } }
    function s.getTable(k) return s._vars[k] end

    return s
end

local function endpointPose(info)
    local p = MoveData.LUT.ConstructData(info, MoveData.partMax)
    return { x = p[1], z = p[3], yaw = p[4] }
end

local function num(n) return string.format("%.3f", n) end

-- Build a paste-ready Lua block in one string (no multi-print fragments).
function M.snapshot_block(cmds, base)
    assert(_G.XW_cmd and XW_cmd.CheckCommand, "XW_cmd not available.")
    assert(MoveData and MoveData.DecodeInfo, "MoveData.DecodeInfo not available.")

    local ship = newShip(base or "small")
    table.sort(cmds, function(a, b) return tostring(a) < tostring(b) end)

    local rows = {}
    for _, cmd in ipairs(cmds) do
        assert(XW_cmd.CheckCommand(cmd) == "actionMove", "Not an actionMove: " .. cmd)
        local info = MoveData.DecodeInfo(cmd, ship)
        assert(info, "DecodeInfo nil: " .. cmd)
        local pose = endpointPose(info)
        rows[#rows + 1] = string.format(
            '    { cmd = %q, base = %q, expect = { x = %s, z = %s, yaw = %s } },',
            cmd, ship._vars.Data.Size, num(pose.x), num(pose.z), num(pose.yaw)
        )
    end
    return "return {\n" .. table.concat(rows, "\n") .. "\n}"
end

-- Print exactly once, with clear markers (helps Console++ capture reliably).
function M.print_snapshot_block(label, cmds, base)
    local block = M.snapshot_block(cmds, base)
    local header = label or "barrel_roll_expected.lua snippet"
    print("\n-- BEGIN " .. header .. "\n" .. block .. "\n-- END " .. header .. "\n")
end

return M
