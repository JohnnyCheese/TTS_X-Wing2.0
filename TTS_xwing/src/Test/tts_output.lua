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
    printToAll("TTSOutput: Creating with " .. t.totalTests .. " tests, hostObject: " .. tostring(t.hostObject),
        { 1, 1, 0 })
    return setmetatable(t, { __index = TTSOutput })
end

function TTSOutput:startSuite()
    if not self.hostObject then
        printToAll("TTO: No host object in startSuite", { 1, 0, 0 })
        return
    end

    -- Get the current UI structure
    local uiTable = self.hostObject.UI.getXmlTable()
    if not uiTable or #uiTable == 0 then
        printToAll("TTO: Failed to get UI table", { 1, 0, 0 })
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

    printToAll("TTO: Created " .. #panels .. " panels", { .2, .2, 1 })

    -- Update the TestGrid within the full UI structure
    for _, element in ipairs(uiTable) do
        if element.attributes and element.attributes.id == "TestStatus" then
            for _, child in ipairs(element.children or {}) do
                if child.tag == "VerticalLayout" then
                    for i, subChild in ipairs(child.children or {}) do
                        if subChild.attributes and subChild.attributes.id == "TestGrid" then
                            child.children[i].children = panels -- Replace TestGrid's children
                            break
                        end
                    end
                end
            end
        end
    end

    -- Set the updated UI
    self.hostObject.UI.setXmlTable(uiTable)
    printToAll("TTO: Starting suite with " .. self.totalTests .. " tests", { 0, 1, 0 })
end

function TTSOutput:startClass(className)
    if self.verbosity > M.VERBOSITY_LOW then
        printToAll("TTO: Starting class: " .. className, { 1, 1, 0 })
    end
end

function TTSOutput:startTest(testName)
    if self.verbosity > M.VERBOSITY_DEFAULT then
        printToAll("TTO: Starting test: " .. testName, { 1, 1, 0 })
    end
end

function TTSOutput:updateStatus(node)
    local index = self.completedTests + 1
    if not self.hostObject then
        printToAll("TTO: No host object in updateStatus", { 1, 0, 0 })
        return
    end
    if node:isSkipped() then
        self.hostObject.UI.setAttribute(self.squareIds[index], "color", "#FFFF00")
    elseif node:isFailure() then
        self.hostObject.UI.setAttribute(self.squareIds[index], "color", "#FF0000")
    elseif node:isError() then
        self.hostObject.UI.setAttribute(self.squareIds[index], "color", "#FF0000")
    else
        self.hostObject.UI.setAttribute(self.squareIds[index], "color", "#00FF00")
    end
end

function TTSOutput:endTest(node)
    self.completedTests = self.completedTests + 1
    local index = self.completedTests
    if not self.hostObject then
        printToAll("TTO: No host object in endTest", { 1, 0, 0 })
        return
    end
    local testName = node.testName .. ": " .. node.status:lower()
    if node:isSuccess() then
        self.hostObject.UI.setAttribute(self.squareIds[index], "color", "#00FF00")
    elseif not (node:isFailure() or node:isError() or node:isSkipped()) then
        self.hostObject.UI.setAttribute(self.squareIds[index], "color", "#FF0000")
    end
    self.hostObject.UI.setAttribute(self.squareIds[index], "tooltip", testName)
end

function TTSOutput:endClass()
    if self.verbosity > M.VERBOSITY_LOW then
        printToAll("TTO: Ending class", { 1, 1, 0 })
    end
end

function TTSOutput:endSuite()
    printToAll("TTO: Test suite completed", { 0, 0, 1 })
    printToAll(M.LuaUnit.statusLine(self.result), { 1, 1, 0 })
end

M.LuaUnit.outputType = TTSOutput

return M
