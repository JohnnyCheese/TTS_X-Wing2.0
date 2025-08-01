-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_lib
--
-- Framework for binding functions to scripting key combination press and/or release easily
-- Description and usage in README.md in this lib folder in repository
-- ~~~~~~

if not package.loaded['Hotkey'] then
    Hotkey = {}
    package.loaded['Hotkey'] = Hotkey

    -- Register the press and call any press functions
    Hotkey.onScriptingButtonDown = function(index, playerColor)
        if playerColor ~= 'Grey' then
            Hotkey.PressButton(index, playerColor)
            if Hotkey.map[Hotkey.stateTable[playerColor] .. 'D'] then
                for _, handler in pairs(Hotkey.map[Hotkey.stateTable[playerColor] .. 'D']) do
                    handler(playerColor, 'down', index)
                end
            end
        end
    end

    -- Call any release functions and then register release
    Hotkey.onScriptingButtonUp = function(index, playerColor)
        if playerColor ~= 'Grey' then
            if Hotkey.map[Hotkey.stateTable[playerColor] .. 'U'] then
                for _, handler in pairs(Hotkey.map[Hotkey.stateTable[playerColor] .. 'U']) do
                    handler(playerColor, 'up', index)
                end
            end
            Hotkey.ReleaseButton(index, playerColor)
        end
    end

    -- Hook into event functions, use EventSub if present
    local EventSub = require("TTS_Lib.EventSub.EventSub")

    -- Now just register the handlers without checking if EventSub is loaded
    EventSub.Register('onScriptingButtonDown', function(...)
        Hotkey.onScriptingButtonDown(table.unpack({ ... }))
    end)

    EventSub.Register('onScriptingButtonUp', function(...)
        Hotkey.onScriptingButtonUp(table.unpack({ ... }))
    end)

    -- Amount of available buttons
    Hotkey.keyCount = 10
    -- Create a string representing press combination for easy comparision
    Hotkey.PressString = function(combination)
        local out = ''
        for k = 1, Hotkey.keyCount do
            out = out .. '-'
        end
        if combination then
            for _, index in pairs(combination) do
                out = out:sub(1, index - 1) .. '+' .. out:sub(index + 1)
            end
        end
        return out
    end

    -- Main table containing info on player keypresses
    Hotkey.stateTable = {
        ['White'] = Hotkey.PressString(),
        ['Brown'] = Hotkey.PressString(),
        ['Red'] = Hotkey.PressString(),
        ['Orange'] = Hotkey.PressString(),
        ['Yellow'] = Hotkey.PressString(),
        ['Green'] = Hotkey.PressString(),
        ['Teal'] = Hotkey.PressString(),
        ['Blue'] = Hotkey.PressString(),
        ['Pink'] = Hotkey.PressString(),
        ['Purple'] = Hotkey.PressString(),
        ['Black'] = Hotkey.PressString()
    }

    -- Map of combination strings to a table of handler functions
    Hotkey.map = {}

    -- Add a handler function for a combination
    Hotkey.Bind = function(combination, handler, direction)
        assert(type(combination) == 'table', 'Hotkey.Bind: combination not a table!')
        assert(type(handler) == 'function', 'Hotkey.Bind: handler not a function!')
        direction = direction or 'down'
        local pressString = Hotkey.PressString(combination)
        if direction == 'up' or direction == 'any' then
            if not Hotkey.map[pressString .. 'U'] then
                Hotkey.map[pressString .. 'U'] = {}
            end
            table.insert(Hotkey.map[pressString .. 'U'], handler)
        end
        if direction == 'down' or direction == 'any' then
            if not Hotkey.map[pressString .. 'D'] then
                Hotkey.map[pressString .. 'D'] = {}
            end
            table.insert(Hotkey.map[pressString .. 'D'], handler)
        end
    end

    -- Register button press in state tables
    Hotkey.PressButton = function(index, playerColor)
        if Hotkey.stateTable then
            Hotkey.stateTable[playerColor] = Hotkey.stateTable[playerColor]:sub(1, index - 1) ..
                '+' .. Hotkey.stateTable[playerColor]:sub(index + 1, -1)
        end
    end
    -- Register button release in state tables
    Hotkey.ReleaseButton = function(index, playerColor)
        if Hotkey.stateTable then
            Hotkey.stateTable[playerColor] = Hotkey.stateTable[playerColor]:sub(1, index - 1) ..
                '-' .. Hotkey.stateTable[playerColor]:sub(index + 1, -1)
        end
    end
end
