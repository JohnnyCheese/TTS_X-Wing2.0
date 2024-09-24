require("TTS_lib.Util.Table")
local SFLayout = require("TTS_xwing.src.Game.StarForge.StarForgeLayout")

local StarForgeDeduper = {
    allObjects = {},
    namedObjects = {},
    unNamedObjects = {},

    -- Add an object to the manager
    addObject = function(self, bag, object)
        local entry = {
            guid = object.guid,
            name = object.name,
            bagGUID = bag.getGUID(),
        }

        if entry.name and entry.name ~= "" then
            if self.namedObjects[entry.name] == nil then
                self.namedObjects[entry.name] = {}
            end
            table.insert(self.namedObjects[entry.name], entry)
        else
            printToAll("Another nameless object.")
            if not self.unNamedObjects[entry.guid] then
                self.unNamedObjects[entry.guid] = {}
            end
            table.insert(self.unNamedObjects[entry.guid], entry)
        end

        self.allObjects[entry.guid] = entry
    end,
    getDups = function(self)
        local dups = {}
        printToAll("looking for dups")
        for name, entries in pairs(self.namedObjects) do
            if #entries > 1 then
                printToAll(name .. " has duplicates", Color.Orange)
                dups[name] = entries
            end
        end
        return dups
    end
}

local scanInfiniteBag = function(infiniteBag)
    StarForgeDeduper.takeObject(infiniteBag, "", function(object)
        StarForgeDeduper:addObject(infiniteBag, object)
        infiniteBag.putObject(object)
    end)
end

local scanMixedBag = function(mixedBag)
    local items = mixedBag.getObjects()

    for _, item in ipairs(items) do
        StarForgeDeduper:addObject(mixedBag, item)
    end
end

StarForgeDeduper.takeObject = function(Bag, guid, callback)
    local guid = guid or ""
    local product = Bag.takeObject({
        position = SFLayout:nextPosition(),
        smooth = false,
        guid = guid,
        callback_function = function(object)
            if callback ~= nil then
                callback(object)
            end
        end
    })
end

StarForgeDeduper.ScanAllBags = function()
    print("Scan All Bags")
    local everything = getObjects()
    for _, object in ipairs(everything) do
        if object.type == "Infinite" then
            scanInfiniteBag(object)
        elseif object.type == "Bag" then
            scanMixedBag(object)
        end
    end
    print("Scan All Bags Done")
end

StarForgeDeduper.LayoutDuplicates = function()
    printToAll("Layout Duplicates")
    SFLayout:reset()
    printToAll("Layout reset")
    local duplicates = StarForgeDeduper:getDups()
    printToAll("we have " .. tostring(#duplicates) .. " duplicates")
    for name, entries in pairs(duplicates) do
        for index, dup in ipairs(entries) do
            local bag = getObjectFromGUID(dup.bagGUID)

            StarForgeDeduper.takeObject(bag, dup.guid)
        end
    end
    printToAll("Layout Duplicates Done")
end

return StarForgeDeduper
