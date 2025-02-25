XmlDropdown = {}
XmlDropdown.__index = XmlDropdown

-- Constructor: Takes an XML Table and a Dropdown ID
function XmlDropdown.new(uiTable, dropdownId)
    local self = setmetatable({}, XmlDropdown)
    self.uiTable = uiTable
    self.dropdownId = dropdownId
    self.dropdown = XmlDropdown.findElementById(self.uiTable, self.dropdownId)
    self.optionsTable = {} -- Stores options as { name = value }

    if not self.dropdown then
        printToAll("XmlDropdown Error: Dropdown ID '" .. self.dropdownId .. "' not found!")
    else
        self:syncOptionsTable()
    end

    return self
end

-- Recursively finds an element in the XML table by ID
function XmlDropdown.findElementById(xmlTable, id)
    for _, element in ipairs(xmlTable) do
        if element.attributes and element.attributes.id == id then
            return element
        end
        if element.children then
            local result = XmlDropdown.findElementById(element.children, id)
            if result then return result end
        end
    end
    return nil
end

-- Syncs self.optionsTable with the current dropdown options
function XmlDropdown:syncOptionsTable()
    self.optionsTable = {} -- Reset
    if self.dropdown and self.dropdown.children then
        for _, option in ipairs(self.dropdown.children) do
            self.optionsTable[option.value] = option.attributes.value or option.value
        end
    end
end

-- Clears all options from the dropdown
function XmlDropdown:clearOptions()
    if self.dropdown then
        self.dropdown.children = {}  -- Remove all children (options)
        self.optionsTable = {} -- Clear tracking table
    end
end

-- Sets multiple options in the dropdown, replacing existing ones
function XmlDropdown:setOptions(options)
    if self.dropdown then
        self:clearOptions()  -- Remove old options
        for _, option in ipairs(options) do
            if type(option) == "table" then
                self:addOption(option.name, option.value)
            else
                self:addOption(option, option) -- Default name == value
            end
        end
    end
end

-- Adds a single option to the dropdown
function XmlDropdown:addOption(name, value)
    if self.dropdown and not self.optionsTable[name] then
        local optionElement = { tag = "Option", attributes = { value = value }, value = name }
        table.insert(self.dropdown.children, optionElement)
        self.optionsTable[name] = value -- Track it
    end
end

-- Retrieves the current options table
function XmlDropdown:getOptionsTable()
    return self.optionsTable
end

-- Retrieves value by name
function XmlDropdown:getValue(name)
    return self.optionsTable[name]
end

-- 🚀 Corrected `apply()` method: Requires `uiOwner` (Global or object)
function XmlDropdown:apply(uiOwner)
    if uiOwner and uiOwner.UI then
        uiOwner.UI.setXmlTable(self.uiTable)
    else
        printToAll("XmlDropdown Error: Invalid `uiOwner` passed to `apply()`!")
    end
end

return XmlDropdown
