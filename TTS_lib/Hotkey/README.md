## Library for binding function to buttons combination presses
This library allows you to define scripting button combination (of one or more) and tell it to call your functions when those combinations are pressed and/or released.  
Keep in mind you still have to set scripting buttons yourself in configuration first - scripts can't access that.
Button combinations are tables with button indexes (numbers, 1-10). Order of pressing a combination doesn't matter (you can make it matter on your end easily).
Multiple functions can be bound to the same combination, they are never replaced (can be used safely from many modules).
Hotkey presses are ignored for spectators.

*Warning:* This library utilizes default scripting button events. If you redefine them between code inclusion and ``Hotkey.Bind`` call, it will silently break. Don't do this or use the EventSub library for sane event hook management.

**Access table:** ``Hotkey``

### Example usage
```lua
-- Define a button combination: 1st, 3rd and 9th scripting buttons
local myCombination = {1, 3, 9}

-- Define our handler function for combination press/release
function myHandler(playerColor, direction, lastPressIndex)
    print('Combination was triggered by player ' .. playerColor)
    if direction == 'up' then
        print('Combination was just pressed')
    else
        print('Combination was just released')
    end
    print('Button number ' .. lastPressIndex .. ' was pressed last in the combination')
end

-- Bind the handler to combination, make it trigger on both press and release (3rd argument)
Hotkey.Bind(myCombination, myHandler, 'any')
-- If we wanted to trigger myHandler only on PRESS, set 3rd argument to 'down' or omit it ('down' is deafult)
-- If we wanted to trigger myHandler only on RELEASE, set 3rd argument to 'up'

-- Print 'Hello World' when player releases 5th scripting button
Hotkey.Bind({5}, function() print('Hello World') end, 'up')
```

### Interface
```lua
Hotkey.Bind(Table combination, Function handler, String direction)
```  
**Effect:** ``handler`` is called every time ``combination`` of scripting keys registers in ``direction`` direction.  
**Argument ``combination``:** Table of scripting button indices, e.g. ``{1, 10}`` for 1st and 10th buttons combination, ``{8}`` for just 8th button press/release.  
**Argument ``handler``:** Reference to function called when combination registers. Called with player color (1st arg, ``'Red'``/``'Green'`` etc), registered direction (2nd arg, ``'up'`` fore release, ``'down'`` for press), and index of the last button pressed from the combination (3rd arg, a number).  
**Argument ``direction``:** String, ``'down'`` to bind to combination press, ``'down'`` to bind to combination release, ``'any'`` to both. If omitted, defaults to ``'down'``.  
**Return:** nil
