-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_lib
--
-- Package for easy object "type" definitions and searching nearby things
-- Description and usage in README.md in this lib folder in repository
-- ~~~~~~

local Vect = require("TTS_Lib.Vector.Vector")
local ObjType = {
    types = {}
}

-- Add a type definition
ObjType.AddType = function(typeName, fcn)
    ObjType.types[typeName] = fcn
end
ObjType.AddType('any', function() return true end)

-- Return true if object matches type
ObjType.IsOfType = function(obj, typeName)
    if not typeName or not ObjType.types[typeName] then
        error('ObjType.IsOfType: queried type \'' .. typeName .. '\' not defined')
    end
    return ObjType.types[typeName](obj)
end
-- Return a table of all type this object matches
ObjType.GetTypes = function(obj)
    local types = {}
    for type, typeFcn in pairs(ObjType.types) do
        if typeFcn(obj) then
            types[type] = true
        end
    end
    return types
end

-- Cast a regular sphere and return hit objects
ObjType.SphereCast = function(center, distance)
    local hits = Physics.cast({
        origin = Vect.Sum(center, { 0, -1.1 * distance, 0 }),
        direction = { 0, distance / 500, 0 },
        type = 2,
        size = { distance * 2, distance * 2, distance * 2 },
        debug = false
    })
    local nearData = {}
    for k, hitData in pairs(hits) do
        table.insert(nearData, hitData.hit_object)
        --table.insert(nearData, {obj = hitData.hit_object, dist=Vect.Distance(hitData.point, center)})
    end
    return nearData
end
-- Cast a box of given size and orientation and return hit objects
ObjType.BoxCast = function(center, orientation, size)
    local hits = Physics.cast({
        origin = Vect.Sum(center, { 0, -1.1 * size[2], 0 }),
        direction = { 0, size[2] / 200, 0 },
        type = 3,
        size = size,
        orientation = orientation,
        debug = false
    })
    local nearData = {}
    for k, hitData in pairs(hits) do
        table.insert(nearData, hitData.hit_object)
        --table.insert(nearData, {obj = hitData.hit_object, dist=Vect.Distance(hitData.point, center)})
    end
    return nearData
end

-- Get the object matching provided type, nearest to position/object in some radius
-- Args:
--      centerPosObj    <- Center position (vector) or object
--      maxDist         <- Max distance to check in
--      objType         <- Required type of the nearest object
--      excl            <- Table of objects excluded from search
-- Return: nearestObject, distance
ObjType.GetNearestOfType = function(centerPosObj, maxDist, objType, excl)
    local centerPos = centerPosObj
    if type(centerPosObj) == 'userdata' then
        excl[centerPosObj] = true
        centerPos = centerPosObj.getPosition()
    end
    local nearOfType = ObjType.GetNearOfType(centerPos, objType, maxDist, excl)
    return table.min(nearOfType, function(obj) return Vect.Distance(cenerPos, obj) end)
end

-- Get all objects in given radius matching given type
-- Args identical like in ObjType.GetNearestOfType
-- Return: table of objects
ObjType.GetNearOfType = function(centerPosObj, maxDist, objType, excl)
    excl = excl or {}
    for k, v in ipairs(excl) do
        excl[v] = true
        excl[k] = nil
    end
    maxDist = maxDist or 100
    assert(type(objType) == 'string', 'Obj.GetNearOfType: search type not provided')
    local centerPos = centerPosObj
    if type(centerPosObj) == 'userdata' then
        excl[centerPosObj] = true
        centerPos = centerPosObj.getPosition()
    end
    local nearData = ObjType.SphereCast(centerPos, maxDist)
    nearData = table.sieve(nearData, function(obj) return (not excl[obj] and ObjType.IsOfType(obj, objType)) end)
    return nearData
end

-- Get the all objects inside a box matching given type
-- Args:
--      centerPosObj    <- Center position (vector) or object
--      orient          <- Box orientation (vector)
--      size            <- Box size (vector)
--      objType         <- Required type of the nearest object
--      excl            <- Table of objects excluded from search
-- Return: table of objects
ObjType.GetBoxOfType = function(centerPosObj, orient, size, objType, excl)
    excl = excl or {}
    for k, v in ipairs(excl) do
        excl[v] = true
        excl[k] = nil
    end
    assert(type(objType) == 'string', 'Obj.GetNearOfType: search type not provided')
    local centerPos = centerPosObj
    if type(centerPosObj) == 'userdata' then
        excl[centerPosObj] = true
        centerPos = centerPosObj.getPosition()
    end
    local boxData = ObjType.BoxCast(centerPos, orient, size)
    boxData = table.sieve(boxData, function(obj) return (not excl[obj] and ObjType.IsOfType(obj, objType)) end)
    return boxData
end

return ObjType
