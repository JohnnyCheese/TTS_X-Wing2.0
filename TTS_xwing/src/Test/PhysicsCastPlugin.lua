---@class PhysicsCastPlugin
---A plugin for performing physics-based casting and filtering using ObjectContainer.
---Integrates with the Sequence framework to allow casting operations within sequences.
local PhysicsCastPlugin = {}
local ObjectContainer = require("Test.ObjectContainer")

-- Define a static empty ObjectContainer instance
local Empty = ObjectContainer:new({})

--- Performs a physics cast and filters the results.
--- Results are stored in `seq.result` as an ObjectContainer.
--- @param seq Sequence: The current sequence instance.
--- @param castParams table: Parameters for the Physics.cast operation.
--- @param filterFunc? function: A filter function to determine which objects to include (optional).
function PhysicsCastPlugin.cast(seq, castParams, filterFunc)
    assert(type(castParams) == "table", "castParams must be a table.")
    filterFunc = filterFunc or function() return true end -- Default no-op filter

    -- Use ObjectContainer for casting and fallback to the static empty instance
    seq.result = ObjectContainer:fromCast(castParams, filterFunc) or Empty
    seq:next() -- Advance the sequence
end

return PhysicsCastPlugin
