-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- X-Wing related measurements for TTS
-- ~~~~~~

local Dim = {}

-- adjusted length = 40mm = 1.4536igu
-- 1mm = 0.03634igu
Dim.mm_igu_ratio = 0.03637

-- 40mm = 1.445igu
-- (s1 length / small base size)

-- 1mm = 0.036125igu
--mm_igu_ratio = 0.036125

-- Millimeter dimensions of ship bases
Dim.mm_smallBase = 40
Dim.mm_mediumBase = 60
Dim.mm_largeBase = 80

Dim.mm_baseSize = {
    small = 40,
    medium = 60,
    large = 80,
    huge = 80,
    smallBase = 40,
    mediumBase = 60,
    largeBase = 80,
    hugeBase = 80,
    objective = 36,
}

----------------------------------------
-- Standard X-Wing Maneuver Templates --
----------------------------------------

Dim.XWingTemplates = {
    straight = { 40, 80, 120, 160, 200 }, -- Speed to millimeters
    turn = { 35, 62.5, 90 },              -- Turn Middle Radius (mm)
    bank = { 80, 130, 180 },              -- Bank Middle Radius (mm)
}

-- Millimeter dimensions for cards
Dim.mm_upgrade_width = 41
Dim.mm_upgrade_height = 63
Dim.mm_pilot_width = 63.5
Dim.mm_pilot_height = 88

Dim.mm_ship_scale = vector(0.629, 0.629, 0.629)

Dim.mm_cardSize = {
    upgrade = { width = 41, height = 63 },
    pilot = { width = 63.5, height = 88 }
}

-- Millimeter dimension for dial cards
Dim.mm_dialSize = 54

-- Convert argument from MILLIMETERS to IN-GAME UNITS
function Dim.Convert_mm_igu(millimeters)
    return millimeters * Dim.mm_igu_ratio
end

-- Convert argument from IN-GAME UNITS to MILLIMETERS
function Dim.Convert_igu_mm(in_game_units)
    return in_game_units / Dim.mm_igu_ratio
end

return Dim
