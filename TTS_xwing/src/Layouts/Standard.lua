local Vect = require("TTS_Lib.Vector.Vector")

local standard = {}
do
    standard.name       = 'Standard'
    standard.tableImage = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/table.jpg'
    standard.elements   = {
        ['Damage Decks']            = { pos = { 1.89, 1.06, -0.06 }, rot = { 0.00, 45.01, 0.00 }, scale = { 1.00, 0.95, 1.00 } },
        ['Huge Ship Damage Decks']  = { pos = { 2.49, 1.00, -1.95 }, rot = { 0.00, 45.01, 0.00 }, scale = { 0.44, 0.42, 0.44 } },
        ['Tractor Beam']            = { pos = { -1.36, 1.06, -12.2 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['Reinforce']               = { pos = { 1.36, 1.06, -9.56 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['Calculate']               = { pos = { -1.28, 1.06, -9.53 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['Ion']                     = { pos = { -1.40, 1.07, 8.12 }, rot = { 0.00, 180.03, 0.00 }, scale = { 1.08, 1.08, 1.08 } },
        ['Stress']                  = { pos = { -1.39, 1.07, 10.20 }, rot = { 0.00, 180.00, 0.00 }, scale = { 1.08, 1.08, 1.08 } },
        ['Deplete']                 = { pos = { 1.45, 1.07, 5.87 }, rot = { 0.00, 180.00, 0.00 }, scale = { 1.08, 1.08, 1.08 } },
        ['Strain']                  = { pos = { 1.43, 1.07, 10.16 }, rot = { 0.00, 180.00, 0.00 }, scale = { 1.08, 1.08, 1.08 } },
        ['Evade']                   = { pos = { 1.40, 1.06, -7.02 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['X-Wing Attack Die']       = { pos = { 0.00, 1.08, -1.67 }, rot = { 0.00, 90.00, 90.00 }, scale = { 3.00, 3.00, 3.00 } },
        ['X-Wing Defense Die']      = { pos = { 0.00, 1.08, 1.53 }, rot = { 90.00, 90.00, 0.00 }, scale = { 3.00, 3.00, 3.00 } },
        ['Attack Dice changer']     = { pos = { 0.03, 1.01, -1.72 }, rot = { 0.00, 315.55, 0.00 }, scale = { 2.50, 0.10, 2.50 } },
        ['Defence Dice changer']    = { pos = { -0.03, 1.01, 1.49 }, rot = { 0.00, 137.13, 0.00 }, scale = { 2.50, 0.10, 2.50 } },
        ['Target Locks']            = { pos = { -1.93, 1.06, -0.06 }, rot = { 0.00, 180.00, 180.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['Focus']                   = { pos = { -1.32, 1.06, -7.07 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['Shield']                  = { pos = { 1.46, 1.06, 3.81 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['Energy']                  = { pos = { 2.91, 1.01, 1.60 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.38, 0.38, 0.38 } },
        ['Force']                   = { pos = { -1.44, 1.06, 6.01 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['Charge']                  = { pos = { -1.45, 1.06, 3.81 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['Critical Hit']            = { pos = { 1.43, 1.07, 8.12 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.84, 1.08, 0.84 } },
        ['Cloak']                   = { pos = { 1.36, 1.07, -4.37 }, rot = { 0.00, 270.00, 0.00 }, scale = { 1.00, 1.00, 1.00 } },
        ['Fuse']                    = { pos = { -1.31, 1.05, -4.36 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.93, 0.93, 0.93 } },
        ['Disarm']                  = { pos = { 1.34, 1.06, -12.2 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['Jam']                     = { pos = { 0, 1.06, -14.66 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.95, 0.95, 0.95 } },
        ['All mines tokens']        = { pos = { 1.36, 0.96, 12.54 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.30, 0.92, 0.30 } },
        ['Bomb drop tokens']        = { pos = { 0.02, 1.05, 14.70 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.93, 1.19, 0.93 } },
        ['All bomb tokens']         = { pos = { -1.35, 0.96, 12.53 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.57, 0.83, 0.57 } },
        ['Remotes']                 = { pos = { -2.39, 1.06, 15.55 }, rot = { 0.00, 270.00, 0.00 }, scale = { 0.95, 1.71, 0.95 } },
        ['Spare parts']             = { pos = { 2.35, 1.03, 15.59 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.80, 1.42, 0.80 } },

        ['Board Edge L']            = { pos = { -37.33, 0.80, 0.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.5, 0.5, 16.75 }, int = false },
        ['Board Edge R']            = { pos = { -3.71, 0.80, 0.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.5, 0.5, 16.75 }, int = false },
        ['Board Edge T']            = { pos = { -20.50, 0.80, 16.81 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.5, 0.5, 16.50 }, int = false },
        ['Board Edge B']            = { pos = { -20.50, 0.8, -16.81 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.5, 0.5, 16.50 }, int = false },

        ['1 Straight Templates']    = { pos = { -40.30, 0.96, -2.25 }, rot = { 0.00, 180.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['2 Straight Templates']    = { pos = { -41.90, 0.96, -3.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['3 Straight Templates']    = { pos = { -40.30, 0.96, 0.80 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['4 Straight Templates']    = { pos = { -41.90, 0.96, 1.50 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['5 Straight Templates']    = { pos = { -41.10, 0.96, 0.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['1 Bank Templates']        = { pos = { -40.00, 1.05, -7.50 }, rot = { 0.00, 270.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['2 Bank Templates']        = { pos = { -40.62, 1.05, -8.50 }, rot = { 0.00, 270.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['3 Bank Templates']        = { pos = { -41.25, 1.05, -9.50 }, rot = { 0.00, 270.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['1 Turn Templates']        = { pos = { -39.70, 0.96, 7.50 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['2 Turn Templates']        = { pos = { -40.20, 1.00, 8.50 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['3 Turn Templates']        = { pos = { -40.70, 0.96, 9.50 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['Core Set Asteroids']      = { pos = { -46.10, 0.99, -7.09 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.70, 0.53, 0.70 } },
        ['TFA Set Asteroids']       = { pos = { -45.97, 0.97, -4.02 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.38, 1.65, 0.38 } },
        ['Debris Fields']           = { pos = { -46.24, -0.27, -0.32 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.50, 1.90, 0.50 } },
        ['Gas Clouds']              = { pos = { -46.23, 0.96, 4.25 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.64, 1.14, 0.64 } },
        ['POM Set Obstacles']       = { pos = { -46.21, 0.97, 8.74 }, rot = { 0.00, 0.00, 0.00 }, scale = { 2.42, 1.14, 2.42 } },
        ['Range 1 Rulers']          = { pos = { -43.50, 1.00, -4.10 }, rot = { 0.00, 270.00, 0.00 }, scale = { 0.63, 0.63, 0.63 } },
        ['Range 1-2 Rulers']        = { pos = { -43.50, 1.00, 2.40 }, rot = { 0.00, 270.00, 180.00 }, scale = { 0.63, 0.63, 0.63 } },
        ['Range 1-3 Rulers']        = { pos = { -42.70, 1.00, 0.00 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.63, 0.63, 0.63 } },
        ['First player coin']       = { pos = { -2.52, 0.96, -15.59 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.40, 0.86, 0.40 }, lock = false },
        ['Game Console']            = { pos = { -38.22, 1.61, 0.00 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.65, 0.65, 0.65 } },
        ['1 Straight Templates 2']  = { pos = { 38.00, 0.97, 2.25 }, rot = { 0.00, 180.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['2 Straight Templates 2']  = { pos = { 40.00, 0.97, -3.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['3 Straight Templates 2']  = { pos = { 38.00, 0.97, -0.80 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['4 Straight Templates 2']  = { pos = { 40.00, 0.97, 1.50 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['5 Straight Templates 2']  = { pos = { 39.00, 0.97, 0.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['1 Bank Templates 2']      = { pos = { 39.50, 1.06, -7.50 }, rot = { 0.00, 225.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['2 Bank Templates 2']      = { pos = { 40.12, 1.06, -8.50 }, rot = { 0.00, 225.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['3 Bank Templates 2']      = { pos = { 40.75, 1.06, -9.50 }, rot = { 0.00, 225.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['1 Turn Templates 2']      = { pos = { 39.20, 0.96, 7.50 }, rot = { 0.00, 90.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['2 Turn Templates 2']      = { pos = { 39.70, 0.98, 8.50 }, rot = { 0.00, 90.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['3 Turn Templates 2']      = { pos = { 40.20, 0.97, 9.50 }, rot = { 0.00, 90.00, 0.00 }, scale = { 3.63, 3.63, 3.63 } },
        ['Core Set Asteroids 2']    = { pos = { 46.10, 0.99, -7.09 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.70, 0.53, 0.70 } },
        ['TFA Set Asteroids 2']     = { pos = { 45.97, 0.97, -4.02 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.38, 1.65, 0.38 } },
        ['Debris Fields 2']         = { pos = { 46.24, -0.27, -0.32 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.50, 1.90, 0.50 } },
        ['Gas Clouds 2']            = { pos = { 46.23, 0.96, 4.25 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.64, 1.14, 0.64 } },
        ['POM Set Obstacles 2']     = { pos = { 46.21, 0.97, 8.74 }, rot = { 0.00, 0.00, 0.00 }, scale = { 2.42, 1.14, 2.42 } },

        ['Range 1 Rulers 2']        = { pos = { 42.00, 1.00, 4.10 }, rot = { 0.00, 270.00, 180.00 }, scale = { 0.63, 0.63, 0.63 } },
        ['Range 1-2 Rulers 2']      = { pos = { 42.00, 1.00, -2.40 }, rot = { 0.00, 270.01, 0.00 }, scale = { 0.63, 0.63, 0.63 } },
        ['Range 1-3 Rulers 2']      = { pos = { 41.00, 1.00, 0.00 }, rot = { 0.00, 270.00, 180.00 }, scale = { 0.63, 0.63, 0.63 } },
        ['First player coin 2']     = { pos = { 2.52, 0.96, -15.59 }, rot = { 0.00, 270.00, 180.00 }, scale = { 0.40, 0.86, 0.40 }, lock = false },
        ['Board Edge L 2']          = { pos = { 37.07, 0.8, 0.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.5, 0.5, 16.75 }, int = false },
        ['Board Edge R 2']          = { pos = { 3.96, 0.8, 0.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.5, 0.5, 16.75 }, int = false },
        ['Board Edge T 2']          = { pos = { 20.50, 0.8, 16.55 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.5, 0.5, 16.50 }, int = false },
        ['Board Edge B 2']          = { pos = { 20.50, 0.8, -16.55 }, rot = { 0.00, 90.00, 0.00 }, scale = { 0.5, 0.5, 16.50 }, int = false },

        ['Deck Holder 1']           = { pos = { -40.00, 0.90, -15.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.65, 0.65, 0.65 } },
        ['Deck Holder 2']           = { pos = { -40.00, 0.90, 15.00 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.65, 0.65, 0.65 } },
        ['Deck Holder 3']           = { pos = { 40.00, 0.90, 15.00 }, rot = { 0.00, 180.00, 0.00 }, scale = { 0.65, 0.65, 0.65 } },
        ['Deck Holder 4']           = { pos = { 40.00, 0.90, -15.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 0.65, 0.65, 0.65 } },


    }
    local assignOffset  = { -5, 1, 2 }
    local zonePos       = { 22.5, 2.5, -32 }
    local zoneScale     = { 44.9, 4, 12 }
    local stuffCenter   = { 27, 0, -18.5 }
    local stuffSize     = { 54, 1, 37 }
    local function left(data)
        return Vect.ScaleEach(data, { -1, 1, 1 })
    end
    local function opposite(data)
        return Vect.ScaleEach(data, { 1, 1, -1 })
    end
    standard.hands = {
        ['Red']    = { pos = { -22.50, 5.00, -40.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 5.00, 5.00, 1.00 } },
        ['Blue']   = { pos = { -22.50, 5.00, 40.00 }, rot = { 0.00, 180.00, 0.00 }, scale = { 5.00, 5.00, 1.00 } },
        ['Orange'] = { pos = { 22.50, 5.00, 40.00 }, rot = { 0.00, 180.00, 0.00 }, scale = { 5.00, 5.00, 1.00 } },
        ['Purple'] = { pos = { 22.50, 5.00, -40.00 }, rot = { 0.00, 0.00, 0.00 }, scale = { 5.00, 5.00, 1.00 } },
        ['Teal']   = { pos = { -50.00, 5.00, -15.00 }, rot = { 0.00, 90.28, 0.00 }, scale = { 5.00, 5.00, 1.00 } },
        ['Green']  = { pos = { -52.00, 5.00, 0.00 }, rot = { 0.00, 90.00, 0.00 }, scale = { 5.01, 5.00, 1.00 } },
        ['Yellow'] = { pos = { -50.00, 5.00, 15.00 }, rot = { 0.00, 90.00, 0.00 }, scale = { 5.01, 5.00, 1.00 } },
        ['Brown']  = { pos = { 50.00, 5.00, 15.00 }, rot = { 0.00, 270.00, 0.00 }, scale = { 5.01, 5.00, 1.00 } },
        ['Pink']   = { pos = { 52.00, 5.00, 0.00 }, rot = { 0.00, 270.00, 0.00 }, scale = { 5.01, 5.00, 1.00 } },
        ['White']  = { pos = { 50.00, 5.00, -15.00 }, rot = { 0.00, 270.00, 0.00 }, scale = { 5.01, 5.00, 1.00 } },
    }
    standard.mats = {
        ['Red-Blue'] = { pos = { -20.5142, 1, 0.00 }, rot = { 0.00, 180.00, 0.00 }, scale = { 1.655, 1.2, 1.655 }, int = false },
        ['Purple-Orange'] = { pos = { 20.5142, 1, 0.00 }, rot = { 0.00, 180.00, 0.00 }, scale = { 1.27, 1.2, 1.27 }, int = false },
    }
    function StandardCallMat(matName, callFcn)
        local mat = Layout.GetMats()[standard.name][matName]
        mat.call(callFcn)
    end

    function StandardChangeMatGR()
        StandardCallMat('Red-Blue', 'NextImage')
    end

    function StandardChangeMatTB()
        StandardCallMat('Purple-Orange', 'NextImage')
    end

    function StandardChangeMatGRPrev()
        StandardCallMat('Red-Blue', 'PrevImage')
    end

    function StandardChangeMatTBPrev()
        StandardCallMat('Purple-Orange', 'PrevImage')
    end

    function StandardToggleRulersGR()
        StandardCallMat('Red-Blue', 'ToggleRulers')
    end

    function StandardToggleRulersTB()
        StandardCallMat('Purple-Orange', 'ToggleRulers')
    end

    function EpicLayout()
        Layout.Switch(2)
    end

    local bWidth = 2200
    local bHeight = 500
    local bFontSize = 230
    standard.controls = {
        {
            position = { 50.5, 1, 2.5 },
            rotation = { 0, 90, 0 },
            click_function = 'StandardChangeMatGR',
            label = 'NEXT PLAYMAT'
        },
        {
            position = { 50.5, 1, -2.5 },
            rotation = { 0, 90, 0 },
            click_function = 'StandardChangeMatGRPrev',
            label = 'PREV PLAYMAT'
        },
        {
            position = { -50.5, 1, -2.5 },
            rotation = { 0, -90, 0 },
            click_function = 'StandardChangeMatTB',
            label = 'NEXT PLAYMAT'
        },
        {
            position = { -50.5, 1, 2.5 },
            rotation = { 0, -90, 0 },
            click_function = 'StandardChangeMatTBPrev',
            label = 'PREV PLAYMAT'
        },
        {
            position = { 49, 1, 0 },
            rotation = { 0, 90, 0 },
            click_function = 'StandardToggleRulersGR',
            label = 'TOGGLE RULERS'
        },
        {
            position = { -49, 1, 0 },
            rotation = { 0, -90, 0 },
            click_function = 'StandardToggleRulersTB',
            label = 'TOGGLE RULERS'
        },
        {
            position = { 52, 1, 0 },
            rotation = { 0, 90, 0 },
            click_function = 'EpicLayout',
            label = 'EPIC LAYOUT'
        },
        {
            position = { 80, 1, -35 },
            rotation = { 0, 180, 0 },
            click_function = 'HotacLayout',
            label = 'HOTAC MODE'
        },
    }
    for _, button in ipairs(standard.controls) do
        button.width = bWidth
        button.height = bHeight
        button.font_size = bFontSize
        button.function_owner = self
    end
end

return standard
