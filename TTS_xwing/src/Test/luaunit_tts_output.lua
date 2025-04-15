-- luaunit_tts_output.lua
-- TTSOutput: dual-mode output plugin (UI grid + chat) with symbolic colors

local M = require("Test.luaunit")

TTSOutput = {
    __class__ = "TTSOutput",
    chat = false,            -- default: chat logging off
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
setmetatable(TTSOutput, { __index = M.genericOutput })

function TTSOutput.new(runner)
    local t = M.genericOutput.new(runner)
    t.hostObject = runner.hostObject
    t.chat = TTSOutput.chat
    t.colors = TTSOutput.colors
    t.subOutputters = {}
    if t.chat then
        table.insert(t.subOutputters, ChatOutput.new(runner))
    end
    table.insert(t.subOutputters, GridOutput.new(runner))
    return setmetatable(t, { __index = TTSOutput })
end

-- Delegate LuaUnit methods to sub-outputters
for _, method in ipairs({
    "startSuite", "startClass", "startTest", "updateStatus", "endTest", "endClass", "endSuite"
}) do
    TTSOutput[method] = function(self, ...)
        for _, outputter in ipairs(self.subOutputters) do
            if outputter[method] then
                outputter[method](outputter, ...)
            end
        end
    end
end

function TTSOutput:endSuite()
    local r = self.result
    local color

    if r.failureCount == 0 and r.errorCount == 0 and r.successCount > 0 then
        color = self.colors.SUCCESS
    else
        local counts = {
            FAIL  = r.failureCount or 0,
            ERROR = r.errorCount or 0,
            SKIP  = r.skipCount or 0
        }

        local maxKey, maxValue = "FAIL", -1
        for key, value in pairs(counts) do
            if value > maxValue then
                maxKey, maxValue = key, value
            end
        end

        color = self.colors[maxKey] or self.colors.FINISH
    end

    self:printAtLevel(M.VERBOSITY_LOW, M.LuaUnit.statusLine(r), color)
    if color == self.colors.SUCCESS then
        self:printAtLevel(M.VERBOSITY_LOW, "Ok", self.colors.SUCCESS)
    end
end

function TTSOutput:printAtLevel(level, msg, color)
    if not self.chat then return end
    if self.verbosity >= level then
        printToAll(msg, Color.fromHex(color))
    end
end

----- ChatOutput: subclass of TextOoutput for TTS chat output
ChatOutput = {
    __class__ = "ChatOutput"
}
setmetatable(ChatOutput, { __index = M.TextOutput })

function ChatOutput.new(runner)
    printToAll("ChatOutput new: " .. M.prettystr(TTSOutput), Color.Blue)
    local t = M.TextOutput.new(runner)
    t.colors = TTSOutput.colors
    t.buffer = "" -- Initialize buffer for partial outputs
    return setmetatable(t, { __index = ChatOutput })
end

function ChatOutput:emit(...)
    for _, arg in ipairs({ ... }) do
        self.buffer = self.buffer .. tostring(arg)
    end
    if self.buffer:find("\n") then
        local lines = {}
        for line in self.buffer:gmatch("[^\n]+") do
            table.insert(lines, line)
        end
        self.buffer = self.buffer:match("\n(.*)$") or ""
        for _, line in ipairs(lines) do
            printToAll(line, self:color())
        end
    end
end

function ChatOutput:emitLine(line)
    if self.buffer ~= "" then
        printToAll(self.buffer, self:color())
        self.buffer = ""
    end
    printToAll(line, self:color())
end

function ChatOutput:color()
    local status = self.result.currentNode and self.result.currentNode.status or "UNKNOWN"
    return Color.fromHex(self.colors[status] or self.colors.NEUTRAL)
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

-------------------------------------------
-- GridOutput: Grid-based UI output for TTS
-------------------------------------------
GridOutput = {
    __class__ = "GridOutput"
}
setmetatable(GridOutput, { __index = M.genericOutput })

function GridOutput.new(runner)
    local t = M.genericOutput.new(runner)
    t.hostObject = runner.hostObject
    t.colors = TTSOutput.colors
    t.squareIds = {}  -- Map index to squareId
    t.testOutputs = {}  -- Map testName to tooltip
    return setmetatable(t, { __index = GridOutput })
end

function GridOutput:startSuite()
    if not self.hostObject then return end

    local uiTable = self.hostObject.UI.getXmlTable()
    if not uiTable or #uiTable == 0 then
        printToAll(self.__class__ .. ": Failed to get UI table", Color.fromHex(self.colors.ERROR))
        return
    end

    function onClick(player, value, id)
        local tooltip = self.hostObject.UI.getAttribute(id, "tooltip")
        local colorHex = self.hostObject.UI.getAttribute(id, "color")
        printToAll(tooltip, Color.fromHex(colorHex))
    end

    local panels = {}
    local totalTests = self.runner.result.selectedCount
    for i = 1, totalTests do
        local id = "TestSquare" .. i
        self.squareIds[i] = id
        table.insert(panels, {
            tag = "Panel",
            attributes = {
                id = id,
                tooltip = "",
                color = self.colors.NEUTRAL,
                onClick = "onClick"
            }
        })
    end

    local testGrid = findElementById(uiTable, "TestGrid")
    if not testGrid then
        printToAll(self.__class__ .. ": TestGrid not found", Color.fromHex(self.colors.ERROR))
        return
    end
    testGrid.children = panels
    self.hostObject.UI.setXmlTable(uiTable)
    coroutine.yield(0)
end

function GridOutput:endTest(node)
    local completedTests = node.number
    local status = node.status or "UNKNOWN"
    local colorHex = self.colors[status] or self.colors.UNKNOWN
    local tooltip = node.testName .. " (" .. status:lower() .. ")"

    -- Store tooltip for potential future use
    self.testOutputs[node.testName] = tooltip

    if not self.hostObject then return end
    local squareId = self.squareIds[completedTests]
    self.hostObject.UI.setAttribute(squareId, "color", colorHex)
    self.hostObject.UI.setAttribute(squareId, "tooltip", tooltip)
    if self.runner.result.selectedCount > 100 then
        local percent = 1 - (completedTests / self.runner.result.selectedCount)
        self.hostObject.UI.setAttribute("TestScroll", "verticalNormalizedPosition", tostring(percent))
    end
    if completedTests % 10 == 0 then
        coroutine.yield(0)
    end
end

function GridOutput:totalTests()
    return self.runner.result.selectedCount
end

return { TTSOutput = TTSOutput }
