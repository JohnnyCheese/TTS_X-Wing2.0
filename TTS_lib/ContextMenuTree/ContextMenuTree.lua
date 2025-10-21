-- ContextMenuTree.lua
local MenuChoice = {}
MenuChoice.__index = MenuChoice

function MenuChoice.menu(label)
    return setmetatable({ label = label or "", children = {}, action = nil, parent = nil }, MenuChoice)
end

function MenuChoice:submenu(label)
    local menu = MenuChoice.menu("[i]" .. label .. "[/i]")
    menu.parent = self
    table.insert(self.children, menu)
    return menu
end

function MenuChoice:choice(label, action)
    local leaf = setmetatable({ label = label, action = action, children = nil, parent = self }, MenuChoice)
    table.insert(self.children, leaf)
    return self
end

function MenuChoice:root()
    local m = self
    while m and m.parent do m = m.parent end
    return m
end

local Cursor = {}
Cursor.__index = Cursor

function Cursor.new(object, root)
    FWD = { "[b]▸[/b]", "[b]>[/b]", "›", "▶", "»", "→" }
    BCK = { "[b]◂[/b]", "[b]<[/b]", "‹", "◀", "«", "←" }
    return setmetatable({
        object   = object,
        current  = root,
        submenu  = FWD[2],
        backMark = BCK[2],
        backText = "[i]Back[/i]" -- or "Go Back"
    }, Cursor)
end

function Cursor:show()
    local obj = self.object
    obj.clearContextMenu()

    for _, child in ipairs(self.current.children or {}) do
        if child.children and #child.children > 0 then
            obj.addContextMenuItem(child.label .. " " .. self.submenu, function(color)
                self.current = child
                self:show()
            end, false)
        else
            obj.addContextMenuItem(child.label, function(color)
                if child.action then child.action(color, obj, self) end
            end, false)
        end
    end

    if self.current.parent then
        obj.addContextMenuItem(self.backMark .. " " .. self.backText, function(color)
            self.current = self.current.parent
            self:show()
        end, false)
    end
end

function Cursor:showRoot()
    self.current = self.current:root()
    self:show()
end

return {
    Menu = MenuChoice,
    Cursor = Cursor
}
