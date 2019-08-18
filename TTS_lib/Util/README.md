## Misc utilities library
Extends some of the standard libraries functionality.  
Added ``myString.fun(string_arg, ...)`` methods can be called just like the rest from standard library ``myString_arg:fun(...)`` if you prefer.

### Full interface

| Function(args) | Return type | Return description
| --- | --- | --- |
| ``math.clamp (Number var, Number min, Number max)`` | ``Number`` | 1st argument limited with upper and lower bounds (nil = no bound) |
| ``math.sgn (Number)`` | ``Number`` | 1 if arg positive, -1 if arg negative, 0 if arg equal zero |
| ``math.round (Number var, Number decimals)`` | ``Number`` | 1st argument rounded to given number of decimals (default 1) |
| ``table.empty (Table)`` | ``Bool`` | true if table has no values at all, false otherwise |
| ``table.join (Table, Table)`` | ``Table`` | table with joined array parts of arguments (values under number keys) |
| ``table.shallowcopy (Table)`` | ``Table`` | table with all values copied directly from 1st argument |
| ``table.deepcopy (Table)`` | ``Table`` | table with all values copied from original, deeper tables copied recursively inside |
| ``table.size (Table)`` | ``Number`` | size of the table (counting both number and non-number keys) |
| ``table.min (Table, Function)`` | ``Variable``| return table element that returns minimal value passed to the provided function |
| ``table.max (Table, Function)`` | ``Variable``| same as table.min, but one that returns maximum value from provided function |
| ``table.sieve (Table, Function)`` | ``Table, Table`` | 1st table: elements that return true passed to function, 2nd: that return false |
| ``table.process (Table, Function)`` | ``Table`` | with all the elements passed through provided function |
| ``table.print (Table, String)`` | ``nil`` | console output: print the table contents (shallow) prefixed by provided string |
| ``table.find (Table, Variable)`` | ``Variable`` | key under which second argument was found in the table, nil if not found |
| ``myString:beginswith (String)`` | ``Bool`` | true if myString begins with parameter string (no pattern) |
| ``myString:startswith (String)`` | ``Bool`` | same as myString:beginswith(...) |
| ``myString:endswith (String)`` | ``Bool`` | true if myString ends with parameter string (no pattern) |
| ``myString:contains (String)`` | ``Bool`` | true if myString contains parameter string (no pattern) |

### Example usage
```lua
local someTable = {'this', 'is', 'an', 'example', 'table', 'with', 'strings'}

-- Get elements contaning letter 'e'
local wordsWithE, wordsWithoutE = table.sieve(someTable, function(el) return el:contains('e') end)
table.print(wordsWithE)     --> {'example', 'table', 'strings'}
table.print(wordsWithoutE)  --> {'this', 'is', 'an', 'with'}

-- Batch process all items (e.g. capitalization)
local upperWithE = table.process(wordsWithE, function(el) return string.upper(el) end)
table.print(upperWithE)     --> {'EXAMPLE', 'TABLE', 'STRINGS'}

-- Simple find
table.find(upperWithE, 'something') --> nil
table.find(upperWithE, 'STRINGS')   --> 3

```
