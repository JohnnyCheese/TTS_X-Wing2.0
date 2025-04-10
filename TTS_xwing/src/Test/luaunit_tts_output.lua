-- luaunit_tts_output.lua
-- TTSOutput: dual-mode output plugin (UI grid + chat) with symbolic colors

local M = require("Test.luaunit")

TTSOutput = {
    __class__ = "TTSOutput",
    printText = false,       -- default: chat logging off
    colors = {
        SUCCESS = "#00FF00", -- green
        FAIL    = "#FF0000", -- bright red
        ERROR   = "#CC0000", -- red (distinct from FAIL, can override)
        SKIP    = "#FFFF00", -- yellow
        UNKNOWN = "#FF00FF", -- magenta
        START   = "#FFFF99", -- light yellow
        INFO    = "#9999FF", -- soft blue
        FINISH  = "#FFFF99", -- matches START by default, intended for final summary line
        NEUTRAL = "#FFFFFF", -- white
    }
}

function TTSOutput.new(runner)
    local t = {
        runner = runner,
        result = runner.result,
        verbosity = runner.verbosity or M.VERBOSITY_DEFAULT,
        totalTests = runner.result.selectedCount,
        completedTests = 0,
        squareIds = {},
        hostObject = runner.hostObject,
        printText = TTSOutput.printText,
        colors = TTSOutput.colors,
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
    if not self.hostObject then return end

    -- Get the current UI structure
    local uiTable = self.hostObject.UI.getXmlTable()
    if not uiTable or #uiTable == 0 then
        printToAll("TTSOutput: Failed to get UI table", Color.fromHex(self.colors.FAIL))
        return
    end

    function onClick(player, value, id)
        local testName = self.hostObject.UI.getAttribute(id, "tooltip")
        local colorHex = self.hostObject.UI.getAttribute(id, "color")
        printToAll(testName, Color.fromHex(colorHex))
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
                color = self.colors.NEUTRAL,
                onClick = "onClick",
            }
        })
    end

    local testGrid = findElementById(uiTable, "TestGrid")
    if not testGrid then
        printToAll("TTSOutput: TestGrid not found", Color.fromHex(self.colors.FAIL))
        return
    end

    testGrid.children = panels
    self.hostObject.UI.setXmlTable(uiTable)
end

function TTSOutput:endTest(node)
    self.completedTests = self.completedTests + 1

    local status = node.status or "UNKNOWN"
    local colorHex = self.colors[status] or self.colors.UNKNOWN
    local tooltip = node.testName .. " (" .. status:lower() .. ")"

    if self.hostObject then
        local squareId = self.squareIds[self.completedTests]
        Wait.frames(function()
            self.hostObject.UI.setAttribute(squareId, "color", colorHex)
            self.hostObject.UI.setAttribute(squareId, "tooltip", tooltip)
        end, 2)
    end

    if self.printText then
        printToAll(tooltip, Color.fromHex(colorHex))
    end
end

function TTSOutput:startClass(name)
    if self.verbosity > M.VERBOSITY_LOW and self.printText then
        printToAll("Start class: " .. name, Color.fromHex(self.colors.START))
    end
end

function TTSOutput:startTest(name)
    if self.verbosity > M.VERBOSITY_DEFAULT and self.printText then
        printToAll("Start test: " .. name, Color.fromHex(self.colors.INFO))
    end
end

function TTSOutput:endClass()
    if self.verbosity > M.VERBOSITY_LOW and self.printText then
        printToAll("End class", Color.fromHex(self.colors.INFO))
    end
end

function TTSOutput:endSuite()
    printToAll(M.LuaUnit.statusLine(self.result), Color.fromHex(self.colors.FINISH))
end

function TTSOutput:updateStatus() end

return { TTSOutput = TTSOutput }
