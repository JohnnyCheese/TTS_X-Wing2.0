require("TTS_lib.Util.Table")
--- @class XmlDropdown
--- A utility class for managing Tabletop Simulator XML UI Dropdown elements.
--- Maintains a shared UI table per uiOwner, similar to a Java static variable.
--- Changes are queued and applied atomically via apply(), updating only the specified dropdown.
--- Usage example:
--- ```lua
--- local dropdown = XmlDropdown.new(self, "myDropdown")
--- dropdown:setOptions({{option="Red", value=Color(1,0,0)}})
--- dropdown:apply() -- Updates only the dropdown in the UI’s XML
--- ```
XmlDropdown = {}
XmlDropdown.__index = XmlDropdown

--- Creates a new XmlDropdown instance.
--- @param uiOwner table The object with the UI property (e.g., self or Global).
--- @param dropdownId string The ID of the dropdown element to manage.
--- @return XmlDropdown The new XmlDropdown instance.
--- @error If uiOwner is nil, lacks UI property, or dropdownId is invalid.
function XmlDropdown.new(uiOwner, dropdownId)
    if not uiOwner or not uiOwner.UI then
        error("XmlDropdown.new: `uiOwner` must be a non-nil object with a UI property", 2)
    end
    if not dropdownId or type(dropdownId) ~= "string" then
        error("XmlDropdown.new: `dropdownId` must be a non-empty string", 2)
    end

    local self = setmetatable({}, XmlDropdown)
    self.uiOwner = uiOwner
    self.uiTable = uiOwner.UI.getXmlTable()
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
--- @param options table Array of options: { "option" } or { {option="option", value=val} }.
--- @param default string|nil Optional option to mark as selected.
function XmlDropdown:setOptions(options, default)
    if not self.dropdown then return end
    if not options or type(options) ~= "table" then
        print("XmlDropdown.setOptions: `options` must be a table")
        return
    end

    self.pendingOptions = {}
    self.pendingSelected = default
    for i, opt in ipairs(options) do
        if type(opt) == "table" then
            self:addOption(opt.option, opt.value, opt.option == default)
        elseif type(opt) == "string" then
            self:addOption(opt, nil, opt == default)
        else
            print("XmlDropdown.setOptions: Skipping invalid option at index " .. i)
        end
    end
end

--- Adds a single option to the dropdown, queuing the change for apply().
--- @param option string The display text of the option.
--- @param value any The value associated with the option (defaults to option if nil).
--- @param selected boolean|nil If true, marks this option as selected.
--- @param overwrite boolean|nil If true, overwrites an existing option with the same text.
function XmlDropdown:addOption(option, value, selected, overwrite)
    if not self.dropdown then return end
    if not option then
        print("XmlDropdown.addOption: `option` is required")
        return
    end

    value = value or option
    if self.options[option] and not overwrite then
        return
    end

    if not self.pendingOptions then self.pendingOptions = {} end
    self.pendingOptions[option] = value
    if selected then
        self.pendingSelected = option
    end
end

--- Gets the current options as a table (from pending or actual state).
--- @return table A table mapping option texts to their values.
function XmlDropdown:getOptions()
    return self.pendingOptions or self.options
end

--- Gets the value associated with a specific option text (from pending or actual state).
--- @param option string The text of the option.
--- @return any|nil The value, or nil if not found.
function XmlDropdown:getValue(option)
    local options = self.pendingOptions or self.options
    return options and options[option]
end

--- Gets the currently selected option text from the UI or queued state.
--- @return string|nil The selected option text, or nil if unavailable.
function XmlDropdown:getSelected()
    if self.pendingSelected then
        return self.pendingSelected
    end
    local currentText = self.uiOwner.UI.getAttribute(self.dropdownId, "text")
    return currentText or (self.options and next(self.options))
end

--- Sets the selected option by text, queuing the change for apply().
--- @param option string The text of the option to select.
function XmlDropdown:setSelected(option)
    if (self.pendingOptions or self.options)[option] then
        self.pendingSelected = option
    end
end

--- Applies all queued changes (options and selection) to the dropdown, updating only the dropdown in the UI’s XML.
function XmlDropdown:apply()
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
        for option, value in pairs(self.pendingOptions) do
            local optElement = {
                tag = "Option",
                attributes = { value = tostring(value) },
                value = tostring(option)
            }
            if option == self.pendingSelected then
                optElement.attributes.selected = "true"
            end
            table.insert(newChildren, optElement)
        end
        dropdownElement.children = newChildren
        self.options = table.shallowcopy(self.pendingOptions) -- Use shallowcopy from Util.Table
        self.pendingOptions = nil
    end

    -- Apply pending selection if any
    if self.pendingSelected then
        local index = 0
        for i, option in ipairs(self.options) do
            if option == self.pendingSelected then
                index = i - 1 -- Convert to 0-based for potential future use
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
