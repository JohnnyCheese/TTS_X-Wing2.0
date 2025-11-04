--------
-- MOVEMENT DATA MODULE
-- Stores and processes data about moves
-- NOT aware of any ship position, operation solely on relative movements
-- Used for feeding data about a move to a higher level movement module
-- Exclusively uses millimeters and degrees for values, needs external conversion

local EventSub = require("TTS_Lib.EventSub.EventSub")
local Vect = require("TTS_lib.Vector.Vector")

local Dim = require("Dim")

MoveData = {}

-- Lookup table for most of the moves
-- Generated using Matlab, source: https://github.com/tjakubo2/xwing_traj
-- Stored on another object to reduce clutter, passed on load
MoveData.LUT = {}
MoveData.onLoad = function()
    for _, obj in pairs(getAllObjects()) do
        if obj.getName() == 'MoveLUT' then
            MoveData.LUT.Parse(obj)
        end
    end
end
EventSub.Register('onLoad', MoveData.onLoad)
MoveData.LUT.Parse = function(object)
    MoveData.LUT.Data = object.call('ParseLUT', {})
end

-- Max part value for partial moves
-- Part equal to this is a full move
-- Value is largely irrelevant since part can be a fraction (any kind of number really)
MoveData.partMax = 1000

-- Construct data from a lookup table entry
-- Move info provided from MoveData.DecodeInfo
-- Return format: {xPos_offset, yPos_offset, zPos_offset, yRot_offset}
-- Linear interpolation between points in lookup table
--
-- Only returns data for RIGHT direction move (if applies)
-- Doesn't take any segnor, talon versions etc into considerations
-- Above things are considered MODIFIERS with functions to apply them defined further
MoveData.LUT.ConstructData = function(moveInfo, part)
    if part == nil then
        part = MoveData.partMax
    end
    if moveInfo.speed == 0 and moveInfo.type == 'straight' then
        return { 0, 0, 0, 0 }
    end
    part = math.clamp(part, 0, MoveData.partMax)
    local LUTtable = MoveData.LUT.Data[moveInfo.size .. 'Base'][moveInfo.type][moveInfo.speed]
    local LUTindex = (part / MoveData.partMax) * LUTtable.dataNum
    if LUTindex < 1 then LUTindex = 1 end
    -- Interpolation between two nearest indexes
    local aProp = LUTindex - math.floor(LUTindex)
    local bProp = 1 - aProp
    local outPos = Vect.Sum(Vect.Scale(LUTtable.posXZ[math.floor(LUTindex)], bProp),
        Vect.Scale(LUTtable.posXZ[math.ceil(LUTindex)], aProp))
    local outRot = (LUTtable.rotY[math.floor(LUTindex)] * bProp) + (LUTtable.rotY[math.ceil(LUTindex)] * aProp)

    local outData = { outPos[1], 0, outPos[2], outRot }

    -- Barrel Roll: longer template increases lateral only.
    -- Forward/back alignment (offset 1/2/3) remains as per LUT.
    if moveInfo.type == 'roll' and moveInfo.rollSpeed and moveInfo.rollSpeed > 1 then
        -- Measure baseline lateral for a center roll at speed-1 (same base size).
        local baseInfo = {
            type      = 'roll',
            dir       = 'right', -- positive lateral
            size      = moveInfo.size,
            speed     = 2,       -- center offset
            traits    = { full = true, part = false },
            rollSpeed = 1        -- canonical baseline
        }
        local baseData = MoveData.LUT.ConstructData(baseInfo, MoveData.partMax)
        local baselineLateral = math.abs(baseData[1])
        local perTemplate = 0.5 * baselineLateral

        outData[1] = outData[1] + (moveInfo.rollSpeed - 1) * perTemplate
    end

    return outData
end

-- Get true move length from LUT data *IN MILLIMETERS*
-- True as in trajectory length, not distance between start and end
-- (stored in LUT to reduce load here)
MoveData.MoveLength = function(moveInfo)
    if moveInfo.traits.part == false then
        return nil
    elseif moveInfo.speed == 0 then
        return 0
    else
        return MoveData.LUT.Data[moveInfo.size .. 'Base'][moveInfo.type][moveInfo.speed].length
    end
end

-- Convert an entry from milimeters to in-game units
MoveData.ConvertDataToIGU = function(entry)
    return { Dim.Convert_mm_igu(entry[1]), Dim.Convert_mm_igu(entry[2]), Dim.Convert_mm_igu(entry[3]), entry[4] }
end

-- Change an entry to a left-heading version
MoveData.LeftVariant = function(entry)
    return { -1 * entry[1], entry[2], entry[3], -1 * entry[4] }
end

-- Change an entry to be k-turn like (+180deg rot at the end)
MoveData.TurnAroundVariant = function(entry)
    return { entry[1], entry[2], entry[3], entry[4] + 180 }
end

-- Change an entry to be talon-roll like (+90deg INWARD rot at the end)
MoveData.TurnInwardVariant = function(entry)
    local dir = 0
    if entry[1] > 0 then
        dir = 90
    elseif entry[1] < 0 then
        dir = -90
    end
    return { entry[1], entry[2], entry[3], entry[4] + dir }
end

-- Change an entry to be reverse type
MoveData.ReverseVariant = function(entry)
    return { entry[1], entry[2], -1 * entry[3], -1 * entry[4] }
end

-- Rotate an entry by given degrees
-- Helps define rolls as straights rotated 90deg sideways etc
MoveData.RotateEntry = function(entry, angDeg)
    local rotEntry = Vect.RotateDeg(entry, angDeg)
    return { rotEntry[1], rotEntry[2], rotEntry[3], entry[4] + angDeg }
end

-- Apply move modifiers that happen even if move is partial
MoveData.ApplyBasicModifiers = function(entry, info)
    local out = table.shallowcopy(entry)
    if (info.type == 'turnSlip' or info.type == 'bankSlip') then
        if info.dir == 'right' then
            out = MoveData.LeftVariant(out)
        end
    elseif info.dir == 'left' then
        out = MoveData.LeftVariant(out)
    end
    if info.extra == 'reverse' then
        out = MoveData.ReverseVariant(out)
    end
    return out
end

-- Apply move modifiers that only happen if move is performed fully
MoveData.ApplyFinalModifiers = function(entry, info)
    local out = table.shallowcopy(entry)
    if info.extra == 'talon' then
        out = MoveData.TurnInwardVariant(out)
    elseif info.extra == 'koiogran' or info.extra == 'segnor' then
        out = MoveData.TurnAroundVariant(out)
    end
    return out
end


-- Decode a move command into table with type, direction, speed etc info
-- TODO make a lookup table?
MoveData.DecodeInfo = function(move_code, ship)
    local info = {
        -- [option1] [option2] ... [optionN]  // [errorOption]
        type = 'invalid', -- [straight] [bank] [turn] [roll] [viper] [cloak] [echo] [bankSlip] [ turnSlip]//  [invalid]
        speed = nil,      -- [1] [2] [3] [4] [5]  //  [nil]
        dir = nil,        -- [left] [right] [nil]
        extra = nil,      -- [koiogran] [segnor] [talon] [reverse] [straight] [forward] [backward] [nil]
        traits =
        {
            full = false, -- [true] [false] if this move can be attempted as a full move
            part = false  -- [true] [false] if this move can be attempted as a partial move
        },
        size = nil,       -- [small] [large]  //  [nil]
        note = nil,       -- [string] eg. 'banked xxx'       //  [nil]
        collNote = nil,   -- [string] eg. 'tried to do xxx'  //  [nil]
        code = move_code  -- [string] eg. 'be2'              //  [nil]
    }
    if ship ~= nil then
        info.size = ship.getTable("Data").Size or 'small'
    else
        info.size = 'small'
    end
    -- Straights and koiograns, regular stuff
    if move_code:sub(1, 1) == 's' or move_code:sub(1, 1) == 'k' then
        info.type = 'straight'
        info.speed = tonumber(move_code:sub(2, 2))
        info.traits.full = true
        info.traits.part = true
        if move_code:sub(1, 1) == 'k' then
            info.extra = 'koiogran'
            info.note = 'koiogran turned ' .. info.speed
            info.collNote = 'tried to koiogran turn ' .. info.speed
        elseif move_code:sub(-1, -1) == 'r' then
            info.extra = 'reverse'
            info.note = 'flew reverse ' .. info.speed
            info.collNote = 'tried to fly reverse ' .. info.speed
        elseif move_code:sub(-1, -1) == 'b' then
            info.traits.part = false
            local boostSpd = ''
            if info.speed > 1 then
                boostSpd = ' ' .. info.speed
            end
            info.note = 'boosted straight' .. boostSpd
            info.collNote = 'tried to boost straight' .. boostSpd
        else
            info.note = 'flew straight ' .. info.speed
            info.collNote = 'tried to fly straight ' .. info.speed
        end
        if info.speed == 0 then
            info.traits.part = false
            if info.extra == 'koiogran' then
                info.note = 'turned around'
            else
                info.note = 'is stationary'
            end
        end
        -- Banks, regular stuff
    elseif move_code:sub(1, 1) == 'a' then
        info.type = 'adjust'
        info.speed = tonumber(move_code:sub(2, 2))
        info.traits.full = true
        info.traits.part = false
        if info.speed == 1 then
            info.note = 'adjusted forward'
            info.collNote = 'tried to adjust forward'
        else
            info.note = 'adjusted backward'
            info.collNote = 'tried to adjust backward'
        end
    elseif move_code:sub(1, 1) == 'b' then
        info.type = 'bank'
        info.dir = 'right'
        info.speed = tonumber(move_code:sub(3, 3))
        info.traits.full = true
        info.traits.part = true
        if move_code:sub(2, 2) == 'l' or move_code:sub(2, 2) == 'e' then
            info.dir = 'left'
        end
        if move_code:sub(-1, -1) == 's' then
            info.extra = 'segnor'
            info.note = 'segnor looped ' .. info.dir .. ' ' .. info.speed
            info.collNote = 'tried to segnor loop ' .. info.dir .. ' ' .. info.speed
        elseif move_code:sub(-1, -1) == 't' then
            info.extra = 'talon'
            info.note = 'talon rolled (bank template) ' .. info.dir .. ' ' .. info.speed
            info.collNote = 'tried to talon roll ' .. info.dir .. ' ' .. info.speed
        elseif move_code:sub(-1, -1) == 'r' then
            info.extra = 'reverse'
            info.note = 'flew reverse bank ' .. info.dir .. ' ' .. info.speed
            info.collNote = 'tried to fly reverse bank ' .. info.dir .. ' ' .. info.speed
        elseif move_code:sub(-1, -1) == 'z' then
            info.type = 'bankSlip'
            info.extra = 'bankSlip'
            info.note = 'sliped bank ' .. info.dir .. ' ' .. info.speed
            info.collNote = 'tried to slip bank ' .. info.dir .. ' ' .. info.speed
        elseif move_code:sub(-1, -1) == 'b' then
            info.traits.part = false
            local boostSpd = ''
            if info.speed > 1 then
                boostSpd = ' ' .. info.speed
            end
            info.note = 'boosted ' .. info.dir .. boostSpd
            info.collNote = 'tried to boost ' .. info.dir .. boostSpd
        else
            info.note = 'banked ' .. info.dir .. ' ' .. info.speed
            info.collNote = 'tried to bank ' .. info.dir .. ' ' .. info.speed
        end
        -- Turns, regular stuff
    elseif move_code:sub(1, 1) == 't' then
        if info.size == 'huge' then
            info.note = "tried to turn, but huge ships can't do that"
            info.collNote = "tried to turn, but huge ships can't do that"
            return info
        end
        info.type = 'turn'
        info.dir = 'right'
        info.speed = tonumber(move_code:sub(3, 3))
        info.traits.full = true
        info.traits.part = true
        if move_code:sub(2, 2) == 'l' or move_code:sub(2, 2) == 'e' then
            info.dir = 'left'
        end
        if move_code:sub(-1, -1) == 't' then
            info.type = 'talon'
            info.note = 'talon rolled ' .. info.dir .. ' ' .. info.speed
            info.collNote = 'tried to talon roll ' .. info.dir .. ' ' .. info.speed
            if move_code:sub(-2, -2) == 'f' then
                info.type = 'talonF'
                info.note = 'talon rolled ' .. info.dir .. ' ' .. info.speed .. 'adjusting Forward'
                info.collNote = 'tried to talon roll ' .. info.dir .. ' ' .. info.speed .. 'adjusting Forward'
            elseif move_code:sub(-2, -2) == 'b' then
                info.type = 'talonB'
                info.note = 'talon rolled ' .. info.dir .. ' ' .. info.speed .. 'adjusting Backward'
                info.collNote = 'tried to talon roll ' .. info.dir .. ' ' .. info.speed .. 'adjusting Backward'
            end
        elseif move_code:sub(-1, -1) == 's' then
            info.extra = 'segnor'
            info.note = 'segnor looped (turn template) ' .. info.dir .. ' ' .. info.speed
            info.collNote = 'tried to segnor loop (turn template) ' .. info.dir .. ' ' .. info.speed
        elseif move_code:sub(-1, -1) == 'r' then
            info.extra = 'reverse'
            info.note = 'flew reverse turn ' .. info.dir .. ' ' .. info.speed
            info.collNote = 'tried to fly reverse turn ' .. info.dir .. ' ' .. info.speed
        elseif move_code:sub(-1, -1) == 'z' then
            info.type = 'turnSlip'
            info.extra = 'turnSlip'
            info.note = 'sliped turn ' .. info.dir .. ' ' .. info.speed
            info.collNote = 'tried to slip turn ' .. info.dir .. ' ' .. info.speed
        elseif move_code:sub(-1, -1) == 'b' then
            info.traits.part = false
            local boostSpd = ''
            if info.speed > 1 then
                boostSpd = ' ' .. info.speed
            end
            info.note = 'boosted (turn template) ' .. info.dir .. boostSpd
            info.collNote = 'tried to boost (turn template) ' .. info.dir .. boostSpd
        else
            info.note = 'turned ' .. info.dir .. ' ' .. info.speed
            info.collNote = 'tried to turn ' .. info.dir .. ' ' .. info.speed
        end
        if tonumber(move_code:sub(3, 3)) == 4 then
            info.traits.part = false
            info.note = 'Pivoted ' .. info.dir
            info.collNote = 'tried pivoting ' .. info.dir
        end
    elseif move_code:sub(1, 1) == 'r' then
        -- Unified barrel-roll grammar:
        --   r[123]?[rle][123]?
        --   - optional prefix digit = template length (1..3) → roll | roll2 | roll3
        --   - [r|l|e]             = direction (right|left|left-edge≡left)
        --   - optional suffix     = end-offset (1=fwd, 2=center [default], 3=back)
        --
        -- Backward-compatible examples:
        --   rl      → roll , dir=left,  offset=center(2)
        --   rr2     → roll , dir=right, offset=2
        --   r2l3    → roll2, dir=left,  offset=3
        --   r3r1    → roll3, dir=right, offset=1
        local pre, dirChar, off = move_code:match("^r(%d?)([rle])(%d?)$")
        if not dirChar then
            -- Not our pattern; let caller treat it as unknown.
            return nil
        end

        local tmpl = tonumber(pre) or 1
        if tmpl == 1 then
            info.type = 'roll'
        elseif tmpl == 2 then
            info.type = 'roll2'
        else
            info.type = 'roll3' -- clamp 3+
        end

        -- 'e' historically used as “edge” and treated as left for direction flip
        if dirChar == 'r' then
            info.dir = 'right'
        else
            info.dir = 'left'
        end

        info.speed = tonumber(off) or 2 -- end-offset default: center
        info.traits.full, info.traits.part = true, false

        -- User-facing notes (unchanged semantics)
        if info.speed == 1 then
            info.note     = 'barrel rolled ' .. info.dir .. ' forward'
            info.collNote = 'tried barrel rolling ' .. info.dir .. ' forward'
        elseif info.speed == 2 then
            info.note     = 'barrel rolled ' .. info.dir .. ' straight'
            info.collNote = 'tried barrel rolling ' .. info.dir .. ' straight'
        else
            info.note     = 'barrel rolled ' .. info.dir .. ' backward'
            info.collNote = 'tried barrel rolling ' .. info.dir .. ' backward'
        end
    elseif move_code:sub(1, 2) == 'vt' then
        info.type = 'viperTurn'
        info.dir = 'right'
        if move_code:sub(3, 3) == 'l' or move_code:sub(3, 3) == 'e' then
            info.dir = 'left'
        end
        info.speed = tonumber(move_code:sub(-1, -1))
        info.traits.full = true
        info.traits.part = false
        if move_code:sub(4, 4) == 'f' then
            info.type = 'viperTurnF'
            info.extra = 'forward'
        else
            info.type = 'viperTurnB'
            info.extra = 'backward'
        end
        if tonumber(move_code:sub(-1, -1)) == 1 then
            info.note = 'barrel rolled using turn template ' .. info.dir .. ' ' .. info.extra .. ' adjusting forward'
            info.collNote = 'tried barrel rolling using turn template ' .. info.dir .. ' ' .. info.extra
        elseif tonumber(move_code:sub(-1, -1)) == 2 then
            info.note = 'barrel rolled using turn template ' .. info.dir .. ' ' .. info.extra .. ' adjusting straight'
            info.collNote = 'tried barrel rolling using turn template ' .. info.dir .. ' ' .. info.extra
        elseif tonumber(move_code:sub(-1, -1)) == 3 then
            info.note = 'barrel rolled using turn template ' .. info.dir .. ' ' .. info.extra .. ' adjusting backward'
            info.collNote = 'tried barrel rolling using turn template ' .. info.dir .. ' ' .. info.extra
        end
        -- New Viper roll
    elseif move_code:sub(1, 1) == 'v' then
        info.type = 'viper'
        info.dir = 'right'
        if move_code:sub(2, 2) == 'l' or move_code:sub(2, 2) == 'e' then
            info.dir = 'left'
        end
        info.speed = tonumber(move_code:sub(-1, -1))
        info.traits.full = true
        info.traits.part = false
        if move_code:sub(3, 3) == 'f' then
            info.type = 'viperF'
            info.extra = 'forward'
        else
            info.type = 'viperB'
            info.extra = 'backward'
        end
        if tonumber(move_code:sub(-1, -1)) == 1 then
            info.note = 'barrel rolled using bank template ' .. info.dir .. ' ' .. info.extra .. ' adjusting forward'
            info.collNote = 'tried barrel rolling using bank template ' .. info.dir .. ' ' .. info.extra
        elseif tonumber(move_code:sub(-1, -1)) == 2 then
            info.note = 'barrel rolled using bank template ' .. info.dir .. ' ' .. info.extra .. ' adjusting straight'
            info.collNote = 'tried barrel rolling using bank template ' .. info.dir .. ' ' .. info.extra
        elseif tonumber(move_code:sub(-1, -1)) == 3 then
            info.note = 'barrel rolled using bank template ' .. info.dir .. ' ' .. info.extra .. ' adjusting backward'
            info.collNote = 'tried barrel rolling using bank template ' .. info.dir .. ' ' .. info.extra
        end
        -- New Decloak
    elseif move_code:sub(1, 1) == 'c' then
        info.type = 'deCloak'
        info.dir = 'right'
        if move_code:sub(2, 2) == 'l' or move_code:sub(2, 2) == 'e' then
            info.dir = 'left'
        end
        info.speed = tonumber(move_code:sub(-1, -1))
        info.traits.full = true
        info.traits.part = false
        if tonumber(move_code:sub(-1, -1)) == 1 then
            info.note = 'decloaked ' .. info.dir .. ' forward'
            info.collNote = 'tried decloaking ' .. info.dir .. ' forward'
        elseif tonumber(move_code:sub(-1, -1)) == 2 then
            info.note = 'decloaked ' .. info.dir .. ' straight'
            info.collNote = 'tried decloaking ' .. info.dir .. ' straight'
        elseif tonumber(move_code:sub(-1, -1)) == 3 then
            info.note = 'decloaked ' .. info.dir .. ' backward'
            info.collNote = 'tried decloaking ' .. info.dir .. ' backward'
        end
        if move_code:sub(2, 2) == 's' then
            info.type = 'straight'
            if info.size == "small" then
                info.speed = 2
            else
                info.speed = 1
            end
            info.dir = nil
            info.note = 'decloaked forward'
            info.collNote = 'tried decloacking forward'
        end
        --New Echo
    elseif move_code:sub(1, 1) == 'e' then
        info.type = 'Echo'
        info.dir = 'right'
        if move_code:sub(2, 2) == 'l' or move_code:sub(2, 2) == 'e' then
            info.dir = 'left'
        end
        info.speed = tonumber(move_code:sub(4, 4))
        info.traits.full = true
        info.traits.part = false
        if move_code:sub(3, 3) == 'f' then
            info.type = 'echoF'
            info.extra = 'forward'
        elseif move_code:sub(3, 3) == 'b' then
            info.type = 'echoB'
            info.extra = 'backward'
        end
        if tonumber(move_code:sub(4, 4)) == 1 then
            info.note = 'decloacked ' .. info.dir .. ' ' .. info.extra .. ' adjusting forward'
            info.collNote = 'tried decloacking ' .. info.dir .. ' ' .. info.extra
        elseif tonumber(move_code:sub(4, 4)) == 2 then
            info.note = 'decloacked ' .. info.dir .. ' ' .. info.extra .. ' adjusting straight'
            info.collNote = 'tried decloacking ' .. info.dir .. ' ' .. info.extra
        elseif tonumber(move_code:sub(4, 4)) == 3 then
            info.note = 'decloacked ' .. info.dir .. ' ' .. info.extra .. ' adjusting backward'
            info.collNote = 'tried decloacking ' .. info.dir .. ' ' .. info.extra
        end
        if move_code:sub(2, 2) == 's' then
            info.type = 'bank'
            info.speed = 2
            info.note = 'decloaked banking right'
            info.collNote = 'tried decloacking banking right'
            if move_code:sub(3, 3) == 'l' or move_code:sub(3, 3) == 'e' then
                info.dir = 'left'
                info.note = 'decloaked banking left'
                info.collNote = 'tried decloacking banking left'
            end
        end
        -- Barrel rolls and decloaks, spaghetti
    elseif move_code:sub(1, 2) == 'ch' or move_code:sub(1, 2) == 'vr' then
        -- Echo's fucking bullshit which goes against ALL the standards
        -- StarViper handled the same
        info.type = 'echo'
        if move_code:sub(1, 2) == 'vr' then
            info.type = 'viper'
        end
        info.dir = 'right'
        info.extra = 'forward'
        if move_code:sub(4, 4) == 'b' then
            info.extra = 'backward'
        end
        if move_code:sub(3, 3) == 'l' or move_code:sub(3, 3) == 'e' then
            -- Ones going right/left
            info.dir = 'left'
        elseif move_code:sub(3, 3) == 's' then
            -- Ones going forward
            info = MoveData.DecodeInfo('b' .. move_code:sub(4, 4) .. '2', ship)
            info.traits.part = false
            info.code = move_code
        end
        if move_code:sub(1, 2) == 'ch' then
            -- Echo dedscriptions
            if info.type == 'echo' then
                info.note = 'dechocloaked ' .. info.dir .. ' ' .. info.extra
                info.collNote = 'tried to dechocloak ' .. info.dir .. ' ' .. info.extra
            else
                info.note = 'dechocloaked forward ' .. info.dir
                info.collNote = 'tried to dechocloak forward ' .. info.dir
            end
        else
            -- SV descriptions
            info.note = 'bank rolled ' .. info.dir .. ' ' .. info.extra
            info.collNote = 'tried to bank roll ' .. info.dir .. ' ' .. info.extra
        end
        -- Special 2nd adjust move
        if move_code == 'chadj' or move_code == 'vradj' then
            info.extra = 'adjust'
        end
    elseif move_code:sub(1, 1) == 'x' or move_code:sub(1, 1) == 'c' then
        -- Rolls
        info.type = 'roll'
        info.dir = 'right'
        info.speed = 1
        if move_code:sub(2, 2) == 'l' or move_code:sub(2, 2) == 'e' then
            info.dir = 'left'
        end
        info.note = 'barrel rolled'
        info.collNote = 'tried to barrel roll'
        -- Decloaks
        -- Straigh decloak is treated as a roll before, now just return straight 2 data
        if move_code:sub(2, 2) == 's' then
            info.type = 'straight'
            info.speed = 2
            info.traits.full = true
            info.note = 'decloaked forward'
            info.collNote = 'tried to decloak forward'
            info.dir = nil
            -- Side decloak is a barrel roll, but with 2 speed
        elseif move_code:sub(1, 1) == 'c' then
            info.note = 'decloaked'
            info.collNote = 'tried to decloak'
            info.speed = 2
        end

        -- Forward/backward modifiers
        if info.type ~= 'straight' then
            if move_code:sub(-1, -1) == 'f' then
                info.extra = 'forward'
                info.note = info.note .. ' forward ' .. info.dir
                info.collNote = info.collNote .. ' forward ' .. info.dir
            elseif move_code:sub(-1, -1) == 'b' then
                info.extra = 'backward'
                info.note = info.note .. ' backward ' .. info.dir
                info.collNote = info.collNote .. ' forward ' .. info.dir
            else
                info.note = info.note .. ' ' .. info.dir
                info.collNote = info.collNote .. ' ' .. info.dir
            end
        end
    end
    return info
end

-- Get the offset data for a full move
-- Return format: {xPos_offset, yPos_offset, zPos_offset, yRot_offset}
MoveData.DecodeFullMove = function(move_code, ship)
    local data = {}
    local info = MoveData.DecodeInfo(move_code, ship)
    if info.type == 'invalid' then
        print('MoveData.DecodeFullMove: invalid move type')
        return { 0, 0, 0, 0 }
    else
        data = MoveData.DecodePartMove(move_code, ship, MoveData.partMax)
    end
    data = MoveData.ApplyFinalModifiers(data, info)
    return data
end

-- Get the offset data for a partial move
-- Return format: {xPos_offset, yPos_offset, zPos_offset, yRot_offset}
MoveData.DecodePartMove = function(move_code, ship, part)
    local data = {}
    local info = MoveData.DecodeInfo(move_code, ship)
    part = math.clamp(part, 0, MoveData.partMax)
    if info.type == 'invalid' then
        print('MoveData.DecodePartMove: invalid move type')
        return { 0, 0, 0, 0 }
    end
    data = MoveData.LUT.ConstructData(info, part)
    data = MoveData.ApplyBasicModifiers(data, info)
    return data
end

-- END MOVEMENT DATA MODULE
--------

return MoveData
