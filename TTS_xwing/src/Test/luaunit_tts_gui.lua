-- luaunit_tts_gui.lua
-- TTS LuaUnit with visual test output grid
local lu = require("Test.luaunit_tts")

TTSOutput = { __class__ = "TTSOutput" }

function TTSOutput.new(runner)
    local t = {
        runner = runner,
        result = runner.result,
        verbosity = runner.verbosity or lu.VERBOSITY_DEFAULT,
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

    local testGrid = findElementById(uiTable, "TestGrid")
    if not testGrid then
        printToAll("TestGrid not found!", { 1, 0, 0 })
        return
    end

    testGrid.children = panels

    -- Set the updated UI
    self.hostObject.UI.setXmlTable(uiTable)
    printToAll("Starting suite with " .. self.totalTests .. " tests", { 0, 1, 0 })
end

function TTSOutput:startClass(className)
    if self.verbosity > lu.VERBOSITY_LOW then
        printToAll("Starting class: " .. className, { 1, 1, 0 })
    end
end

function TTSOutput:startTest(testName)
    if self.verbosity > lu.VERBOSITY_DEFAULT then
        printToAll("Starting test: " .. testName, { 1, 1, 0 })
    end
end

function TTSOutput:updateStatus(node) end -- No-op

function TTSOutput:endTest(node)
    self.completedTests = self.completedTests + 1
    local squareId = self.squareIds[self.completedTests]
    local tooltip = node.testName .. " (" .. node.status:lower() .. ")"
    local color = "#FF00FF"

    if node:isSuccess() then color = "#00FF00"
    elseif node:isFailure() or node:isError() then color = "#FF0000"
    elseif node:isSkipped() then color = "#FFFF00" end

    Wait.frames(function()
        self.hostObject.UI.setAttribute(squareId, "color", color)
        self.hostObject.UI.setAttribute(squareId, "tooltip", tooltip)
    end, 2)
end

function TTSOutput:endClass()
    if self.verbosity > lu.VERBOSITY_LOW then
        printToAll("Ending class", { 1, 1, 0 })
    end
end

function TTSOutput:endSuite()
    printToAll(lu.LuaUnit.statusLine(self.result), { 1, 1, 0 })
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Attach output plugin
lu.LuaUnit.outputType = TTSOutput

-- Optionally expose plugin class for customization
return setmetatable(lu, {
    __index = { TTSOutput = TTSOutput }
})
