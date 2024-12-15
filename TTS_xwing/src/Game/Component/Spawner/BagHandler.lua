BagHandler = {}

function BagHandler:new(bag_guid)
    local self = { bag_guid = bag_guid }
    setmetatable(self, { __index = BagHandler })

    self.bag = getObjectFromGUID(bag_guid)
    if not self.bag then
        error("Bag with GUID " .. tostring(bag_guid) .. " not found.")
    end

    return self
end

-- Private method: Generalized item retrieval with a criterion function
function BagHandler:_findAndTakeItem(criterion, parameters)
    local clonedBag = self.bag.clone({ position = { x = -38, y = 3, z = -21 } })

    local item = nil

    for _, objData in ipairs(clonedBag.getObjects()) do
        if criterion(objData) then
            parameters.guid = objData.guid
            item = clonedBag.takeObject(parameters)
            break
        end
    end
    clonedBag.destruct()

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
