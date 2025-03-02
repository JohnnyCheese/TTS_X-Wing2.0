require("TTS_lib.Util.Table")
--- @class XmlDropdown
--- A utility class for managing Tabletop Simulator XML UI Dropdown elements.
--- Maintains a shared UI table per uiOwner, similar to a Java static variable.
--- Changes are queued and applied atomically via apply(), updating only the specified dropdown.
--- Usage example:
--- ```lua
--- local dropdown = XmlDropdown.new(self, "myDropdown")
--- dropdown:setOptions({{name="Red", value=Color(1,0,0)}})
--- dropdown:apply() -- Updates only the dropdown in the UI’s XML
--- ```
XmlDropdown = {}
XmlDropdown.__index = XmlDropdown

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
    self.uiTable = uiTable or uiOwner.UI.getXmlTable()
    self.dropdownId = dropdownId
    self.dropdown = XmlDropdown.findElementById(self.uiTable, dropdownId)
    self.options = {}
    self.pendingOptions = nil  -- Queue for new options
    self.pendingSelected = nil -- Queue for new selection

    if not self.dropdown then
        print("XmlDropdown Error: Dropdown ID '" .. dropdownId .. "' not found in UI table!")
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

--- Clears all options from the dropdown, queuing the change for apply().
function XmlDropdown:clearOptions()
    if self.dropdown then
        self.dropdown.children = {}
        self.options = {}
        self.pendingOptions = {}
        self.pendingSelected = nil
    end
end

--- Sets multiple options, replacing existing ones, and queues the change for apply().
--- @param options table Array of options: { "name" } or { {name="name", value=val} }.
--- @param default string|nil Optional name of the option to mark as selected.
function XmlDropdown:setOptions(options, default)
    if not self.dropdown then return end
    if not options or type(options) ~= "table" then
        print("XmlDropdown.setOptions: `options` must be a table")
        return
    end

    self.pendingOptions = {}
    self.pendingSelected = default
    for i, option in ipairs(options) do
        if type(option) == "table" then
            self:addOption(option.name, option.value, option.name == default)
        elseif type(option) == "string" then
            self:addOption(option, nil, option == default)
        else
            print("XmlDropdown.setOptions: Skipping invalid option at index " .. i)
        end
    end
end

--- Adds a single option to the dropdown, queuing the change for apply().
--- @param name string The display name of the option.
--- @param value any The value associated with the option (defaults to name if nil).
--- @param selected boolean|nil If true, marks this option as selected.
--- @param overwrite boolean|nil If true, overwrites an existing option with the same name.
function XmlDropdown:addOption(name, value, selected, overwrite)
    if not self.dropdown then return end
    if not name then
        print("XmlDropdown.addOption: `name` is required")
        return
    end

    value = value or name
    if self.options[name] and not overwrite then
        return
    end

    if not self.pendingOptions then self.pendingOptions = {} end
    self.pendingOptions[name] = value
    if selected then
        self.pendingSelected = name
    end
end

--- Gets the current options as a table (from pending or actual state).
--- @return table A table mapping option names to their values.
function XmlDropdown:getOptions()
    return self.pendingOptions or self.options
end

--- Gets the value associated with a specific option name (from pending or actual state).
--- @param name string The name of the option.
--- @return any|nil The value, or nil if not found.
function XmlDropdown:getValue(name)
    local options = self.pendingOptions or self.options
    return options and options[name]
end

--- Gets the currently selected option name from the UI or queued state.
--- @return string|nil The selected option name, or nil if unavailable.
function XmlDropdown:getSelected()
    if self.pendingSelected then
        return self.pendingSelected
    end
    if not self.uiOwner or not self.uiOwner.UI then return nil end
    local currentText = self.uiOwner.UI.getAttribute(self.dropdownId, "text")
    return currentText or (self.options and next(self.options))
end

--- Sets the selected option by name, queuing the change for apply().
--- @param name string The name of the option to select.
function XmlDropdown:setSelected(name)
    if not self.uiOwner or not self.uiOwner.UI then
        print("XmlDropdown.setSelected: No valid `uiOwner` set")
        return
    end
    if (self.pendingOptions or self.options)[name] then
        self.pendingSelected = name
    end
end

--- Applies all queued changes (options and selection) to the dropdown, updating only the dropdown in the UI’s XML.
function XmlDropdown:apply()
    if not self.uiOwner or not self.uiOwner.UI then
        print("XmlDropdown.apply: No valid `uiOwner` - must have UI property")
        return
    end

    -- Fetch the current UI XML table
    local currentUiTable = self.uiOwner.UI.getXmlTable()
    if not currentUiTable then
        print("XmlDropdown.apply: Failed to fetch current UI table")
        return
    end

    -- Find and update the dropdown in the current UI table
    local dropdownElement = XmlDropdown.findElementById(currentUiTable, self.dropdownId)
    if not dropdownElement then
        print("XmlDropdown.apply: Dropdown ID '" .. self.dropdownId .. "' not found in current UI")
        return
    end

    -- Apply pending options if any
    if self.pendingOptions then
        local newChildren = {}
        for name, value in pairs(self.pendingOptions) do
            local option = {
                tag = "Option",
                attributes = { value = tostring(value) },
                value = tostring(name)
            }
            if name == self.pendingSelected then
                option.attributes.selected = "true"
            end
            table.insert(newChildren, option)
        end
        dropdownElement.children = newChildren
        self.options = table.shallowcopy(self.pendingOptions) -- Use shallowcopy from Util.Table
        self.pendingOptions = nil
    end

    -- Apply pending selection if any
    if self.pendingSelected then
        local index = 0
        for i, name in ipairs(self.options) do
            if name == self.pendingSelected then
                index = i - 1 -- Convert to 0-based for potential future use (if needed)
                break
            end
        end
        if index >= 0 then
            self.selected = self.pendingSelected
            self.uiOwner.UI.setAttribute(self.dropdownId, "text", self.selected) -- Set text for selection
        end
        self.pendingSelected = nil
    end

    -- Apply the updated UI table, preserving the rest of the UI
    self.uiOwner.UI.setXmlTable(currentUiTable)
end

return XmlDropdown
