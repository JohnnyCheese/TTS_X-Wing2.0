-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_lib
--
-- Simple framework for adding many subscribers of default events (onLoad, update, onChat etc)
-- Description and usage in README.md in this lib folder in repository
-- ~~~~~~

local EventSub = {
    subs = {}
}

-- Table mapping event names to table of handler functions

-- Initialize subscriber table for given event function, save current one if exists
EventSub.AddEvent = function(eventName)
    EventSub.subs[eventName] = {}
    if type(_G[eventName]) == 'function' then
        table.insert(EventSub.subs[eventName], _G[eventName])
    end
    -- Set the global event function to call each handler pasing its parameters
    _G[eventName] = function(...)
        for _, handler in ipairs(EventSub.subs[eventName]) do
            handler(table.unpack({ ... }))
        end
    end
end
-- Method for adding subscribers
EventSub.Register = function(eventName, handler)
    assert(type(eventName) == 'string', 'EventSub.Register: Provided event name not a string!')
    assert(type(handler) == 'function', 'EventSub.Register: Provided handler not a function!')
    if not EventSub.subs[eventName] then
        EventSub.AddEvent(eventName)
    end
    table.insert(EventSub.subs[eventName], handler)
end

return EventSub
