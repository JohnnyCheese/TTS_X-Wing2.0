local ObjectContainer = {}
ObjectContainer.__index = ObjectContainer

function ObjectContainer:new(objects)
    return setmetatable({ objects = objects or {} }, ObjectContainer)
end

function ObjectContainer:add(object)
    table.insert(self.objects, object)
end

function ObjectContainer:remove(object)
    for i, obj in ipairs(self.objects) do
        if obj == object then
            table.remove(self.objects, i)
            return
        end
    end
end

function ObjectContainer:getObjects()
    return self.objects
end

function ObjectContainer:filter(predicate)
    local filtered = {}
    for _, obj in ipairs(self.objects) do
        if predicate(obj) then
            table.insert(filtered, obj)
        end
    end
    return ObjectContainer:new(filtered)
end

function ObjectContainer:all(predicate)
    for _, obj in ipairs(self.objects) do
        if not predicate(obj) then
            return false
        end
    end
    return true
end

function ObjectContainer:allAtRest()
    return self:all(function(obj)
        return not obj.isSmoothMoving() and obj.resting and not obj.spawning
    end)
end

function ObjectContainer:move(offset)
    for _, obj in ipairs(self.objects) do
        local newPosition = obj.getPosition() + offset
        obj.setPositionSmooth(newPosition)
    end
end

function ObjectContainer:fromCast(castParams, filterFunc)
    assert(type(castParams) == "table", "castParams must be a table.")
    filterFunc = filterFunc or function() return true end

    local castResult = Physics.cast(castParams)
    local objects = {}
    for _, hit in ipairs(castResult) do
        local obj = hit.hit_object
        if filterFunc(obj) then
            table.insert(objects, obj)
        end
    end
    return ObjectContainer:new(objects)
end

function ObjectContainer:forEach(callback)
    for _, obj in ipairs(self.objects or {}) do
        callback(obj)
    end
end

function ObjectContainer:count()
    return #self.objects
end

-- Metamethod to automatically use tostring in string concatenation
function ObjectContainer:__tostring()
    local objectNames = {}
    for _, obj in ipairs(self.objects) do
        table.insert(objectNames, obj.getName and obj:getName() or tostring(obj))
    end
    return "ObjectContainer: [" .. table.concat(objectNames, ", ") .. "]"
end

-- Enable string concatenation with ObjectContainer
function ObjectContainer:__concat(other)
    return tostring(self) .. tostring(other)
end

return ObjectContainer
