-- tts_output.lua
local M = require('Test.luaunit')

TTSOutput = { __class__ = 'TTSOutput' }

function TTSOutput.new(runner)
    local t = {
        runner = runner,
        result = runner.result,
        verbosity = runner.verbosity or M.VERBOSITY_DEFAULT,
        totalTests = runner.result.selectedCount,
        completedTests = 0,
        squareIds = {},
        hostObject = runner.hostObject
    }
    return setmetatable(t, { __index = TTSOutput })
end

-- Utility function to recursively find an element by its ID
local function findElementById(elements, id)
    for _, element in ipairs(elements or {}) do
        if element.attributes and element.attributes.id == id then
            return element
        end
        if element.children then
            local found = findElementById(element.children, id)
            if found then
                return found
            end
        end
    end
    return nil
end

function TTSOutput:startSuite()
    if not self.hostObject then
        printToAll("No host object in startSuite", { 1, 0, 0 })
        return
    end

    -- Get the current UI structure
    local uiTable = self.hostObject.UI.getXmlTable()
    if not uiTable or #uiTable == 0 then
        printToAll("Failed to get UI table", { 1, 0, 0 })
        return
    end

    function onClick(player, value, id)
        local testName = self.hostObject.UI.getAttribute(id, "tooltip")
        local statusColor = self.hostObject.UI.getAttribute(id, "color")

        printToAll(testName, Color.fromHex(statusColor))
    end

    -- Build panels for the grid
    local panels = {}
    for i = 1, self.totalTests do
        local id = "TestSquare" .. i
        self.squareIds[i] = id
        table.insert(panels, {
            tag = "Panel",
            attributes = {
                id = id,
                tooltip = "",
                color = "#F0F0F0",
                onClick = "onClick",
            }
        })
    end

    -- Find the TestGrid element dynamically
    local testGrid = findElementById(uiTable, "TestGrid")
    if not testGrid then
        printToAll("TestGrid not found!", { 1, 0, 0 })
        return
    end

    -- Replace TestGrid's children with the new panels
    testGrid.children = panels

    -- Set the updated UI
    self.hostObject.UI.setXmlTable(uiTable)
    printToAll("Starting suite with " .. self.totalTests .. " tests", { 0, 1, 0 })
end

function TTSOutput:startClass(className)
    if self.verbosity > M.VERBOSITY_LOW then
        printToAll("Starting class: " .. className, { 1, 1, 0 })
    end
end

function TTSOutput:startTest(testName)
    if self.verbosity > M.VERBOSITY_DEFAULT then
        printToAll("Starting test: " .. testName, { 1, 1, 0 })
    end
end

function TTSOutput:updateStatus(node)
    -- No-op: updates handled in endTest()
end

function TTSOutput:endTest(node)
    self.completedTests = self.completedTests + 1
    local index = self.completedTests
    if not self.hostObject then
        printToAll("No host object in endTest", { 1, 0, 0 })
        return
    end

    local squareId = self.squareIds[index]
    local tooltip = node.testName .. " (" .. node.status:lower() .. ")"
    local color = "#FF00FF" -- magenta: unknown

    if node:isSuccess() then
        color = "#00FF00" -- green
    elseif node:isFailure() then
        color = "#FF0000" -- red
    elseif node:isError() then
        color = "#FF0000" -- red
    elseif node:isSkipped() then
        color = "#FFFF00" -- yellow
    end

    -- Update square panel
    Wait.frames(function()
        self.hostObject.UI.setAttribute(squareId, "color", color)
        self.hostObject.UI.setAttribute(squareId, "tooltip", tooltip)
    end, 2)
end

function TTSOutput:endClass()
    if self.verbosity > M.VERBOSITY_LOW then
        printToAll("Ending class", { 1, 1, 0 })
    end
end

function TTSOutput:endSuite()
    printToAll(M.LuaUnit.statusLine(self.result), { 1, 1, 0 })
end

M.LuaUnit.outputType = TTSOutput

return M
