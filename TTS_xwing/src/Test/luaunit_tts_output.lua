-- luaunit_tts_output.lua
-- TTSOutput: dual-mode output plugin (UI grid + chat) with symbolic colors

local M = require("Test.luaunit")

TTSOutput = {
    __class__ = "TTSOutput",
    chat = false,            -- default: chat logging off
    log = false,             -- default: console log logging off
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
    t.colors = TTSOutput.colors
    t.subOutputters = {}
    if TTSOutput.chat then
        table.insert(t.subOutputters, ChatOutput.new(runner))
    end
    if runner.hostObject ~= nil then
        table.insert(t.subOutputters, GridOutput.new(runner))
    end

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

----- ChatOutput: subclass of TextOutput for TTS chat window output
ChatOutput = {
    __class__ = "ChatOutput"
}
setmetatable(ChatOutput, { __index = M.TextOutput })

function ChatOutput.new(runner)
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
    line = line or ""
    self.buffer = self.buffer or ""
    printToAll(self.buffer .. line, self:color())
    self.buffer = ""
end

function ChatOutput:color()
    local status = self.result.currentNode and self.result.currentNode.status or "INFO"
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
    t.squareIds = {}
    t.testOutputs = {}
    return setmetatable(t, { __index = GridOutput })
end

function GridOutput:startSuite()
    local uiTable = self.hostObject.UI.getXmlTable()
    if not uiTable or #uiTable == 0 then
        printToAll(self.__class__ .. ": Failed to get UI table", Color.fromHex(self.colors.ERROR))
        return
    end

    function onClick(player, value, id)
        local testResult = M.prettystr(self.testOutputs[id])
        local colorHex = self.hostObject.UI.getAttribute(id, "color")
        printToAll(testResult, Color.fromHex(colorHex))
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

    local id = "TestSquare" .. node.number
    self.testOutputs[id] = node

    local squareId = self.squareIds[completedTests]
    self.hostObject.UI.setAttribute(squareId, "color", colorHex)
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
