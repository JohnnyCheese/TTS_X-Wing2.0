## Event subscription handling library
Provides a very simple and lightweight framework to give scripts access to default events (onLoad, onChat, update etc.) without having one take the control away from other.  
In simple words, assign as many "handlers" to any default event at any time - in one line.  
Any parameters present in the event function will be passed to registered handler unchanged.  
Assigned handlers are permanent, other modules can add their own without any interference at will.  

*Warning:* Redefining event functions after this library is included *will silently break the module* (for redefined event that is).

**Access table:** ``EventSub``, ``event_sub``

### Example usage
```lua
-- Function I want to work onLoad
function myOnLoadFunction(save_state)
    -- doing awesome stuff here
end

-- Tell the event handler to call my function when onLoad triggers
EventSub.Register('onLoad', myOnLoadFunction)

-- Now other functions can also utilize onLoad without interfering
EventSub.Register('onLoad', function() print('Finally loaded!') end)

-- Use this version if you're creating a module yourself and want it to be more versatile
if package.loaded['EventSub'] then
    EventSub.Register('onLoad', myOnLoadFunction)
else
    assert(onLoad == nil, 'Trying to redefine default event, probably will break something!')
    function onLoad(save_state)
        myOnLoadFunction(save_state)
    end
end
```

### Full interface
``Register(String eventName, Function handler)``  
**Effect:** Call ``handler`` whenever event named ``eventName`` happens, passing its arguments if it comes with any.
**Return:** nil
