local CastGroupPlugin = {}
local ObjectContainer = require("Test.ObjectContainer")

function CastGroupPlugin.castGroup(seq, castParams, filterFunc)
    assert(type(castParams) == "table", "castParams must be a table.")
    filterFunc = filterFunc or function() return true end -- Default no-op filter

    -- Use ObjectContainer for casting and filtering
    seq.result = ObjectContainer:fromCast(castParams, filterFunc)
    seq:next() -- Advance the sequence
end

return CastGroupPlugin
