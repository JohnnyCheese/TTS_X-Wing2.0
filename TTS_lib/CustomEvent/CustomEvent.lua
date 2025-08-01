function name()
    if self then return self.getName() else return 'Global' end
end

if not package.loaded['CustomEvent'] then
    -- Require EventSub so we can hook into onLoad
    local ES = require("TTS_Lib.EventSub.EventSub")

    CustomEvent = {}
    package.loaded['CustomEvent'] = CustomEvent

    -- Event queues for before onLoad (Global doesn't exist yet then)
    EventSub.subQueue = {}
    EventSub.triggerQueue = {}
    -- Process queued events
    EventSub.PushQueued = function()
        __temp = function()
            local subQueue = EventSub.subQueue
            EventSub.subQueue = nil
            for k, args in ipairs(subQueue) do
                CustomEvent.Subscribe(table.unpack(args))
            end
            -- To ensure subs come before triggers, wait a few frames
            local wait = 3
            for k = 1, 10 do
                coroutine.yield(0)
            end
            local triggerQueue = EventSub.triggerQueue
            EventSub.triggerQueue = nil
            for k, args in ipairs(triggerQueue) do
                CustomEvent.TriggerEvent(table.unpack(args))
            end
            __temp = nil
            return 1
        end
        startLuaCoroutine(self, '__temp')
    end
    ES.Register('onLoad', EventSub.PushQueued)

    CustomEvent.eventFcns = {}
    CustomEvent.Subscribe = function(eventName, handler)
        if EventSub.subQueue then
            table.insert(EventSub.subQueue, { eventName, handler })
            return
        end
        if not CustomEvent.eventFcns[eventName] then
            CustomEvent.eventFcns[eventName] = {}
            if self then
                Global.call('__CustomEventDispatch', { call = 'subscribe', arg = { eventName = eventName, user = self } })
            end
        end
        table.insert(CustomEvent.eventFcns[eventName], handler)
    end

    CustomEvent.HandleEvent = function(eventName, argTable)
        argTable = argTable or {}
        if CustomEvent.eventFcns[eventName] then
            for k, handler in pairs(CustomEvent.eventFcns[eventName]) do
                handler(table.unpack(argTable))
            end
        end
    end
    CustomEvent.TriggerEvent = function(eventName, argTable)
        if EventSub.triggerQueue then
            table.insert(EventSub.triggerQueue, { eventName, argTable })
            return
        end
        Global.call('__CustomEventDispatch', { call = 'trigger', arg = { argTable = argTable, eventName = eventName } })
    end
    CustomEvent.Trigger = {}
    setmetatable(CustomEvent.Trigger, {
        __index = function(t, k)
            return function(...) CustomEvent.TriggerEvent(k, { ... }) end
        end,
        __call = function(t, ...)
            local args = { ... }
            CustomEvent.TriggerEvent(args[1], args[2])
        end
    })

    __CustomEventDispatch = function(info)
        if info.call == 'trigger' then
            CustomEvent.HandleEvent(info.arg.eventName, info.arg.argTable)
        end
    end

    if not self then
        CustomEvent.subs = {}
        local RegularDispatch = __CustomEventDispatch
        __CustomEventDispatch = function(info)
            RegularDispatch(info)
            if info.call == 'subscribe' then
                if not CustomEvent.subs[info.arg.eventName] then
                    CustomEvent.subs[info.arg.eventName] = {}
                end
                table.insert(CustomEvent.subs[info.arg.eventName], info.arg.user)
            elseif info.call == 'trigger' then
                if CustomEvent.subs[info.arg.eventName] then
                    for _, sub in pairs(CustomEvent.subs[info.arg.eventName]) do
                        sub.call('__CustomEventDispatch',
                            { call = 'trigger', arg = { eventName = info.arg.eventName, argTable = info.arg.argTable } })
                    end
                end
            end
        end
    end
end
