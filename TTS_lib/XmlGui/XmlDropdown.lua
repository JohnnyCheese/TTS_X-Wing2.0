require("TTS_lib.Util.Table")

--- @class XmlDropdown
--- A utility class for managing Tabletop Simulator XML UI Dropdown elements.
--- Changes are queued and applied atomically via apply(), updating only the specified dropdown.
--- Usage example:
--- ```lua
--- local dropdown = XmlDropdown.new(self, "myDropdown")
--- dropdown:setOptions({"Red", "Blue"})
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
    local uiTable = uiOwner.UI.getXmlTable()
    self.dropdownId = dropdownId
    self.dropdown = XmlDropdown.findElementById(uiTable, dropdownId)
    self.options = {}
    self.pendingOptions = nil
    self.pendingSelected = nil

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
                self.options[option.value] = option.value
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
--- @param options table Array of option strings or tables with {option="text", selected=boolean}.
--- @param default string|nil Optional option text to mark as selected.
function XmlDropdown:setOptions(options, default)
    if not self.dropdown then return end
    if not options or type(options) ~= "table" then
        print("XmlDropdown.setOptions: `options` must be a table")
        return
    end
    self.pendingOptions = {}
    self.pendingSelected = default
    for i, opt in ipairs(options) do
        if type(opt) == "string" then
            self:addOption(opt, opt == default)
        elseif type(opt) == "table" and opt.option then
            self:addOption(opt.option, opt.option == default)
        else
            print("XmlDropdown.setOptions: Skipping invalid option at index " .. i)
        end
    end
end

--- Adds a single option to the dropdown, queuing the change for apply().
--- @param option string The display text of the option.
--- @param selected boolean|nil If true, marks this option as selected.
function XmlDropdown:addOption(option, selected)
    if not self.dropdown then return end
    if not option then
        print("XmlDropdown.addOption: `option` is required")
        return
    end
    if not self.pendingOptions then self.pendingOptions = {} end
    self.pendingOptions[option] = option
    if selected then
        self.pendingSelected = option
    end
end

--- Gets the current options as a table (from pending or actual state).
--- @return table A table mapping option texts to themselves.
function XmlDropdown:getOptions()
    return self.pendingOptions or self.options
end

--- Gets the value associated with a specific option text (same as the text).
--- @param option string The text of the option.
--- @return string|nil The option text, or nil if not found.
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
    local currentUiTable = self.uiOwner.UI.getXmlTable()
    if not currentUiTable then
        print("XmlDropdown.apply: Failed to fetch current UI table")
        return
    end
    local dropdownElement = XmlDropdown.findElementById(currentUiTable, self.dropdownId)
    if not dropdownElement then
        print("XmlDropdown.apply: Dropdown ID '" .. self.dropdownId .. "' not found in current UI")
        return
    end

    if self.pendingOptions then
        local newChildren = {}
        for option, _ in pairs(self.pendingOptions) do
            local optElement = {
                tag = "Option",
                value = tostring(option)
            }
            if option == self.pendingSelected then
                optElement.attributes = { selected = "true" }
            end
            table.insert(newChildren, optElement)
        end
        dropdownElement.children = newChildren
        self.options = table.shallowcopy(self.pendingOptions)
        self.pendingOptions = nil
    end

    if self.pendingSelected then
        if self.options[self.pendingSelected] then
            self.selected = self.pendingSelected
            self.uiOwner.UI.setAttribute(self.dropdownId, "text", self.selected)
        end
        self.pendingSelected = nil
    end

    self.uiOwner.UI.setXmlTable(currentUiTable)
end

return XmlDropdown
