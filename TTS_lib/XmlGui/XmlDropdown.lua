--- @class XmlDropdown
--- A utility class for managing Tabletop Simulator XML UI Dropdown elements.
--- Maintains a shared UI table per uiOwner, similar to a Java static variable.
--- Usage example:
--- ```lua
--- local dropdown = XmlDropdown.new(self, "myDropdown")
--- dropdown:setOptions({{name="Red", value=Color(1,0,0)}})
--- dropdown:apply() -- Updates shared UI table
--- ```
XmlDropdown = {}
XmlDropdown.__index = XmlDropdown

--- Shared UI tables, keyed by uiOwner (e.g., self or Global)
XmlDropdown._sharedUiTables = {}

--- Creates a new XmlDropdown instance.
--- @param uiOwner table The object with the UI property (e.g., self or Global).
--- @param dropdownId string The ID of the dropdown element to manage.
--- @param uiTable table|nil Optional raw XML table (overrides shared table if provided).
--- @return XmlDropdown The new XmlDropdown instance.
--- @error If uiOwner lacks UI property and uiTable is invalid, or if dropdownId is not a string.
function XmlDropdown.new(uiOwner, dropdownId, uiTable)
    if not uiOwner or not uiOwner.UI then
        if not uiTable or type(uiTable) ~= "table" then
            error("XmlDropdown.new: `uiOwner` must have a UI property or `uiTable` must be a valid XML table", 2)
        end
    end
    if not dropdownId or type(dropdownId) ~= "string" then
        error("XmlDropdown.new: `dropdownId` must be a non-empty string", 2)
    end

    local self = setmetatable({}, XmlDropdown)
    self.uiOwner = uiOwner
    -- Use shared uiTable if uiOwner is provided and no override uiTable is given
    if uiOwner and not uiTable then
        if not XmlDropdown._sharedUiTables[uiOwner] then
            XmlDropdown._sharedUiTables[uiOwner] = uiOwner.UI.getXmlTable()
            if not XmlDropdown._sharedUiTables[uiOwner] then
                printToAll("XmlDropdown.new: Failed to fetch UI table for " .. tostring(uiOwner))
            end
        end
        self.uiTable = XmlDropdown._sharedUiTables[uiOwner]
    else
        self.uiTable = uiTable -- Fallback to provided table
    end
    self.dropdownId = dropdownId
    self.dropdown = XmlDropdown.findElementById(self.uiTable, dropdownId)
    self.options = {}

    if not self.dropdown then
        printToAll("XmlDropdown Error: Dropdown ID '" .. dropdownId .. "' not found in UI table!")
    else
        self:syncOptions()
    end

    return self
end

--- Recursively finds an element in the XML table by its ID.
--- @param xmlTable table The XML table to search.
--- @param id string The ID to find.
--- @return table|nil The found element, or nil if not found.
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

--- Syncs the internal options table with the current dropdown children.
function XmlDropdown:syncOptions()
    self.options = {}
    if self.dropdown and self.dropdown.children then
        for _, option in ipairs(self.dropdown.children) do
            if option.tag == "Option" then
                self.options[option.value] = option.attributes and (option.attributes.value or option.value) or
                option.value
            end
        end
    end
end

--- Clears all options from the dropdown.
function XmlDropdown:clearOptions()
    if self.dropdown then
        self.dropdown.children = {}
        self.options = {}
    end
end

--- Sets multiple options, replacing existing ones.
--- @param options table Array of options: { "name" } or { {name="name", value=val} }.
--- @param default string|nil Optional name of the option to mark as selected.
function XmlDropdown:setOptions(options, default)
    if not self.dropdown then return end
    if not options or type(options) ~= "table" then
        printToAll("XmlDropdown.setOptions: `options` must be a table")
        return
    end

    self:clearOptions()
    for i, option in ipairs(options) do
        if type(option) == "table" then
            self:addOption(option.name, option.value, option.name == default)
        elseif type(option) == "string" then
            self:addOption(option, option, option == default)
        else
            printToAll("XmlDropdown.setOptions: Skipping invalid option at index " .. i)
        end
    end
end

--- Adds a single option to the dropdown.
--- @param name string The display name of the option.
--- @param value any The value associated with the option (defaults to name if nil).
--- @param selected boolean|nil If true, marks this option as selected.
--- @param overwrite boolean|nil If true, overwrites an existing option with the same name.
function XmlDropdown:addOption(name, value, selected, overwrite)
    if not self.dropdown then return end
    if not name then
        printToAll("XmlDropdown.addOption: `name` is required")
        return
    end

    value = value or name
    if self.options[name] and not overwrite then
        return
    end

    local optionElement = {
        tag = "Option",
        attributes = { value = tostring(value) },
        value = tostring(name)
    }
    if selected then
        optionElement.attributes.selected = "true"
    end
    table.insert(self.dropdown.children, optionElement)
    self.options[name] = value
end

--- Gets the current options as a table.
--- @return table A table mapping option names to their values.
function XmlDropdown:getOptions()
    return self.options
end

--- Gets the value associated with a specific option name.
--- @param name string The name of the option.
--- @return any|nil The value, or nil if not found.
function XmlDropdown:getValue(name)
    return self.options[name]
end

--- Gets the currently selected option name from the UI.
--- @return string|nil The selected option name, or nil if unavailable.
function XmlDropdown:getSelected()
    if not self.uiOwner or not self.uiOwner.UI then return nil end
    local currentText = self.uiOwner.UI.getAttribute(self.dropdownId, "text")
    return currentText or next(self.options)
end

--- Sets the selected option by name.
--- @param name string The name of the option to select.
function XmlDropdown:setSelected(name)
    if not self.uiOwner or not self.uiOwner.UI then
        printToAll("XmlDropdown.setSelected: No valid `uiOwner` set")
        return
    end
    if self.options[name] then
        self.uiOwner.UI.setAttribute(self.dropdownId, "text", name)
    else
        printToAll("XmlDropdown.setSelected: Option '" .. tostring(name) .. "' not found")
    end
end

--- Applies the modified shared UI table to the UI.
function XmlDropdown:apply()
    if not self.uiOwner or not self.uiOwner.UI then
        printToAll("XmlDropdown.apply: No valid `uiOwner` - must have UI property")
        return
    end
    self.uiOwner.UI.setXmlTable(self.uiTable)
    printToAll("Applied shared UI table for " .. self.dropdownId) -- Debug
end

return XmlDropdown
