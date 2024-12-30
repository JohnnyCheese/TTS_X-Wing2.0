local CastGroupPlugin = {}

function CastGroupPlugin.castGroup(seq, castParams, filterFunc)
    assert(type(castParams) == "table", "castParams must be a table.")
    filterFunc = filterFunc or function() return true end -- Default to no-op filter

    local function performCast()
        local castResult = Physics.cast(castParams)
        local objects = {}
        for _, hit in ipairs(castResult) do
            local obj = hit.hit_object
            if filterFunc(obj) then
                table.insert(objects, obj)
            end
        end
        return objects
    end

    seq.context.castObjects = performCast()
    seq:next()
end

return CastGroupPlugin
