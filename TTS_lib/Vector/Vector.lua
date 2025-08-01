-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_lib
--
-- Library for all vector-related operations
-- Description and usage in README.md in this lib folder in repository
-- ~~~~~~

-- TODO: Many of these now have TTS equivalents.
-- TODO: e.g. Vector.__add(vec1, vec2)

local Vect = {}

require("TTS_Lib.Util.Math")

-- Sum of two vectors (of any size)
Vect.Sum = function(vec1, vec2)
    assert(type(vec1) == 'table', 'Vect.Sum: arg#1 not a table!')
    assert(type(vec2) == 'table', 'Vect.Sum: arg#2 not a table!')
    local out = {}
    local k = 1
    while vec1[k] ~= nil and vec2[k] ~= nil do
        out[k] = vec1[k] + vec2[k]
        k = k + 1
    end
    return out
end

-- Inverse of a vector
Vect.Inverse = function(vector)
    assert(type(vector) == 'table', 'Vect.Inverse: arg#1 not a table!')
    local out = {}
    local k = 1
    while vector[k] ~= nil do
        out[k] = 1 / vector[k]
        k = k + 1
    end
    return out
end

-- Multiply each element of a vector by a factor
Vect.Scale = function(vector, factor)
    assert(type(vector) == 'table', 'Vect.Scale: arg#1 not a table!')
    assert(type(factor) == 'number', 'Vect.Scale: arg#2 not a number!')
    local out = {}
    local k = 1
    while vector[k] ~= nil do
        out[k] = vector[k] * factor
        k = k + 1
    end
    return out
end

-- Multiply each element of a vector by an element from factor vector
-- (element-wise vector multiplication)
Vect.ScaleEach = function(vector, factorVec)
    assert(type(vector) == 'table', 'Vect.ScaleEach: arg#1 not a table!')
    assert(type(factorVec) == 'table', 'Vect.ScaleEach: arg#2 not a table!')
    local out = {}
    local k = 1
    while vector[k] ~= nil and factorVec[k] ~= nil do
        out[k] = vector[k] * factorVec[k]
        k = k + 1
    end
    return out
end


-- Length of  vector on X-Z plane (ignoring height)
Vect.Length = function(vector)
    assert(type(vector) == 'table', 'Vect.Length: arg#1 not a table!')
    return math.sqrt(vector[1] * vector[1] + vector[3] * vector[3])
end

-- Rotation of a 3D vector over its second element axis, arg in radians
-- Elements past 3rd are copied
Vect.RotateRad = function(vector, radRotation)
    assert(type(vector) == 'table', 'Vect.RotateRad: arg#1 not a table!')
    assert(type(radRotation) == 'number', 'Vect.RotateRad: arg#2 not a number!')
    local newX = math.cos(radRotation) * vector[1] + math.sin(radRotation) * vector[3]
    local newZ = math.sin(radRotation) * vector[1] * -1 + math.cos(radRotation) * vector[3]
    local out = { newX, vector[2], newZ }
    local k = 4
    while vector[k] ~= nil do
        table.insert(out, vector[k])
        k = k + 1
    end
    return out
end

-- Distance between two points
-- Points as vectors or objects (their positions)
Vect.Distance = function(pos1, pos2)
    assert(type(pos1) == 'table' or type(pos1) == 'userdata', 'Vect.Distance: arg#1 not a table/object!')
    assert(type(pos2) == 'table' or type(pos2) == 'userdata', 'Vect.Distance: arg#2 not a table/object!')
    if type(pos1) == 'userdata' then
        pos1 = pos1.getPosition()
    end
    if type(pos2) == 'userdata' then
        pos2 = pos2.getPosition()
    end
    return Vect.Length(Vect.Between(pos1, pos2))
end

-- Print vector elements
Vect.Print = function(vec, name)
    assert(type(vec) == 'table', 'Vect.Print: arg#1 not a table!')
    local out = '['
    if name then
        out = name .. ' => ' .. out
    end
    local k = 1
    while vec[k] ~= nil do
        out = out .. math.round(vec[k], 3) .. ' : '
        k = k + 1
    end
    out = out:sub(1, -3) .. ']'
    print(out)
end

-- Dot product
Vect.DotProd = function(vec1, vec2)
    assert(type(vec1) == 'table', 'Vect.DotProd: arg#1 not a table!')
    assert(type(vec2) == 'table', 'Vect.DotProd: arg#2 not a table!')
    local sum = 0
    local k = 1
    while vec1[k] ~= nil and vec2[k] ~= nil do
        sum = sum + vec1[k] * vec2[k]
        k = k + 1
    end
    return sum
end

-- Element-by-element comparison
-- Fails if length uneven
Vect.Compare = function(vec1, vec2)
    assert(type(vec1) == 'table', 'Vect.Compare: arg#1 not a table!')
    assert(type(vec2) == 'table', 'Vect.Compare: arg#2 not a table!')
    if #vec1 ~= #vec2 then
        return false
    end
    local k = 1
    while vec1[k] ~= nil and vec2[k] ~= nil do
        if vec1[k] ~= vec2[k] then
            return false
        end
        k = k + 1
    end
    return true
end

-- Euclidean norm
Vect.Norm = function(vec)
    local selfDot = Vect.DotProd(vec, vec)
    return math.sqrt(selfDot)
end

-- Convert a vector to unit vector in the same direction
-- Return zero vector for zero vector
Vect.ToUnit = function(vec)
    if Vect.Norm(vec) == 0 then
        return vec
    end
    return Vect.Scale(vec, 1 / Vect.Norm(vec))
end

-- Angle between vectors in radians
-- If second argument not provided, calculate typical angle (from [1, 0, 0, ...] )
Vect.Angle = function(vec1, vec2)
    if vec2 == nil then
        vec2 = { 1 }
        for k = 2, #vec1, 1 do
            table.insert(vec2, 0)
        end
    end
    return math.acos(Vect.DotProd(vec1, vec2) / (Vect.Norm(vec1) * Vect.Norm(vec2)))
end

-- Angle between vectors in radians, in plane
-- If second argument not provided, calculate typical angle (from [1, 0, 0, ...] )
Vect.Angle2D = function(vec1, vec2)
    if vec2 == nil then
        vec2 = { 1 }
        for k = 2, #vec1, 1 do
            table.insert(vec2, 0)
        end
    end
    return (math.atan2(vec2[3], vec2[1]) - math.atan2(vec1[3], vec1[1]))
end

-- Same as Vect.Angle but in degrees
Vect.AngleDeg = function(vec1, vec2)
    return math.deg(Vect.Angle(vec1, vec2))
end

-- Same as Vect.Angle2D but in degrees
Vect.AngleDeg2D = function(vec1, vec2)
    return math.deg(Vect.Angle2D(vec1, vec2))
end

-- Vector pointing from one position to another
Vect.Between = function(fromVec, toVec)
    return Vect.Sum(toVec, Vect.Scale(fromVec, -1))
end

-- Vector pointing between two points
Vect.Middle = function(p1, p2)
    return Vect.Sum(p1, Vect.Scale(Vect.Between(p1, p2), 0.5))
end

-- Subtract vector from another
Vect.Sub = function(vec1, vec2)
    return Vect.Sum(vec1, Vect.Scale(vec2, -1))
end

-- Opposite of a vector
Vect.Opposite = function(vector)
    return Vect.Scale(vector, -1)
end

-- Rotation of a 3D vector over its second element axis, arg in degrees
-- Elements past 3rd are copied
Vect.RotateDeg = function(vector, degRotation)
    local radRotation = math.rad(degRotation)
    return Vect.RotateRad(vector, radRotation)
end

-- Scale the vector to have set length
-- Negative "length" - opposite of set length
Vect.SetLength = function(vector, len)
    return Vect.Scale(vector, len / Vect.Length(vector))
end

return Vect
