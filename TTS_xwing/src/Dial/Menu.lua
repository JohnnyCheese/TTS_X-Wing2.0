local obj = self

local M = {}

local toggleItems = {}

function M.addToggleItem(name, text, func, noToggle)
    local i = {
        name = name,
        text = text,
        func = func,
        noToggle = noToggle
    }

    table.insert(toggleItems, i)
end

function M.update()
    obj.clearContextMenu()

    for _, v in ipairs(toggleItems) do
        local text = ""
        local value = _G[v.name] or false
        if v.noToggle then
            text = v.text
        elseif value then
            text = "Disable " .. v.text
        else
            text = "Enable " .. v.text
        end

        obj.addContextMenuItem(text, function() v.func(not value) end)
    end
end

return M
