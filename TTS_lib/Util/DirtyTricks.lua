require("TTS_Lib.Util.Table")

local DirtyTricks = {}

function DirtyTricks.exportGlobals(moduleTable, prefix)
    prefix = prefix or ""
    if table.empty(moduleTable) then return end
    for key, value in pairs(moduleTable) do
        local globalKey = prefix .. key
        if type(value) == "table" and not getmetatable(value) then
            -- Only recursively handle plain tables
            DirtyTricks.exportGlobals(value, globalKey .. ".")
        else
            -- Directly assign other types (including tables with metatables)
            _G[globalKey] = value
        end
    end
end

return DirtyTricks
