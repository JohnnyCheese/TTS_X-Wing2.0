--BagHandler = {}

--function BagHandler:new(bag)
--    assert(bag, "BagHandler requires a bag object")
--    local o = {
--        originalBag = bag,
--    }
--    setmetatable(o, self)
--    self.__index = self
--    return o
--end
--
--function BagHandler:takeItem(criteria, options)
--    local clonedBag = self.originalBag.clone({
--        position = self.originalBag.getPosition() + Vector(0, 2, 0),
--    })
--    Wait.condition(
--        function()
--            self:processClonedBag(clonedBag, criteria, options)
--        end,
--        function()
--            return clonedBag.resting
--        end
--    )
--end
--
--function BagHandler:processClonedBag(clonedBag, criteria, options)
--    -- Find the item in the cloned bag
--    local item
--    if type(criteria) == "string" and #criteria == 6 then
--        item = self:findByGUID(clonedBag, criteria)
--    elseif type(criteria) == "string" then
--        item = self:findByName(clonedBag, criteria)
--    elseif type(criteria) == "function" then
--        local matches = self:findByFilter(clonedBag, criteria)
--        if #matches > 0 then
--            item = matches[1]
--        end
--    else
--        error("Invalid criteria type. Must be GUID, name, or filter function.")
--    end
--
--    if not item then
--        printToAll("No matching item found in the bag.", {1, 0, 0})
--        self:cleanUpClonedBag(clonedBag)
--        return
--    end
--
--    -- Take the object from the cloned bag
--    clonedBag.takeObject({
--        guid = item.guid,
--        position = options.position or (clonedBag.getPosition() + Vector(0, 2, 0)),
--        rotation = options.rotation or nil,
--        smooth = options.smooth or false,
--        callback_function = function(obj)
--            -- Call the client-provided callback
--            if options.callback_function then
--                options.callback_function(obj)
--            end
--
--            -- Clean up the cloned bag after use
--            self:cleanUpClonedBag(clonedBag)
--        end,
--    })
--end
--
--function BagHandler:cleanUpClonedBag(clonedBag)
--    clonedBag.destruct()
--end
--
---- Find item by GUID in the bag
--function BagHandler:findByGUID(bag, guid)
--    for _, item in ipairs(bag.getObjects()) do
--        if item.guid == guid then
--            return item
--        end
--    end
--    return nil
--end
--
---- Find item by name in the bag
--function BagHandler:findByName(bag, name)
--    for _, item in ipairs(bag.getObjects()) do
--        if item.name == name then
--            return item
--        end
--    end
--    return nil
--end
--
---- Find items matching a filter function
--function BagHandler:findByFilter(bag, filterFunc)
--    local matches = {}
--    for _, item in ipairs(bag.getObjects()) do
--        if filterFunc(item) then
--            table.insert(matches, item)
--        end
--    end
--    return matches
--end
--
--BagHandler = {}
--
--function BagHandler:new(bag_guid)
--    local self = setmetatable({}, BagHandler)
--    self.bag_guid = bag_guid
--    self.bag = getObjectFromGUID(bag_guid)
--    self.__index = self
--    if not self.bag then
--        error("Bag with GUID " .. tostring(bag_guid) .. " not found.")
--    end
--    return self
--end
--
--function BagHandler:takeItemByGUID(item_guid, callback)
--    -- Clone the bag to safely retrieve the item
--    local clonedBag = self.bag.clone()
--    clonedBag.setPosition({ x = 0, y = 10, z = 0 }) -- Move it away to avoid interference
--
--    local item = nil
--
--    -- Attempt to retrieve the item
--    Wait.condition(
--        function()
--            item = clonedBag.takeObject({
--                guid = item_guid,
--                callback_function = function(obj)
--                    if callback then
--                        callback(obj)
--                    end
--                end
--            })
--            clonedBag.destruct()
--        end,
--        function()
--            return clonedBag.resting
--        end
--    )
--
--    return item
--end
--
--function BagHandler:takeItemByName(item_name, callback)
--    -- Clone the bag to safely retrieve the item
--    local clonedBag = self.bag.clone()
--    clonedBag.setPosition({ x = 0, y = 10, z = 0 }) -- Move it away to avoid interference
--
--    local item = nil
--
--    -- Search for the item by name
--    Wait.condition(
--        function()
--            for _, objData in ipairs(clonedBag.getObjects()) do
--                if objData.name == item_name then
--                    item = clonedBag.takeObject({
--                        guid = objData.guid,
--                        callback_function = function(obj)
--                            if callback then
--                                callback(obj)
--                            end
--                        end
--                    })
--                    break
--                end
--            end
--            clonedBag.destruct()
--        end,
--        function()
--            return clonedBag.resting
--        end
--    )
--
--    return item
--end
--
--function BagHandler:takeItemByFilter(filter_function, callback)
--    -- Clone the bag to safely retrieve the item
--    local clonedBag = self.bag.clone()
--    clonedBag.setPosition({ x = 0, y = 10, z = 0 }) -- Move it away to avoid interference
--
--    local item = nil
--
--    -- Search for the item using the filter function
--    Wait.condition(
--        function()
--            for _, objData in ipairs(clonedBag.getObjects()) do
--                if filter_function(objData) then
--                    item = clonedBag.takeObject({
--                        guid = objData.guid,
--                        callback_function = function(obj)
--                            if callback then
--                                callback(obj)
--                            end
--                        end
--                    })
--                    break
--                end
--            end
--            clonedBag.destruct()
--        end,
--        function()
--            return clonedBag.resting
--        end
--    )
--
--    return item
--end

BagHandler = {}

function BagHandler:new(bag_guid)
    local self = { bag_guid = bag_guid }
    setmetatable(self, { __index = BagHandler })

    self.bag = getObjectFromGUID(bag_guid)
    if not self.bag then
        error("Bag with GUID " .. tostring(bag_guid) .. " not found.")
    else
        printToAll("Found bag: " .. tostring(self.bag.getName()), Color.Pink)
    end

    return self
end

-- Private method: Generalized item retrieval with a criterion function
function BagHandler:_findAndTakeItem(criterion, parameters)
    local clonedBag = self.bag.clone({ position = { x = -38, y = 3, z = -21 } })

    local item = nil

    Wait.condition(
        function()
            for _, objData in ipairs(clonedBag.getObjects()) do
                if criterion(objData) then
                    parameters.guid = objData.guid
                    item = clonedBag.takeObject(parameters)
                    break
                end
            end
            clonedBag.destruct()
        end,
        function()
            return clonedBag.resting
        end
    )

    return item
end

-- Take an item by GUID
function BagHandler:takeItemByGUID(item_guid, parameters)
    return self:_findAndTakeItem(
        function(objData) return objData.guid == item_guid end, parameters
    )
end

-- Take an item by name
function BagHandler:takeItemByName(item_name, parameters)
    return self:_findAndTakeItem(
        function(objData) return objData.name == item_name end, parameters
    )
end

-- Take an item by custom filter
function BagHandler:takeItemByFilter(filter_function, parameters)
    return self:_findAndTakeItem(filter_function, parameters)
end

return BagHandler
