-- TODO: dispose of properly - this file was in the repo but unused.
-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: https://github.com/tjakubo2/TTS_xwing
-- ~~~~~~
local Vect = require("TTS_lib.Vector.Vector")

TempModule = {}
TempModule.objects = {}
TempModule.objects['[b]INSTRUCTIONS[/b]'] = 'empty'
TempModule.objects['[b]ITEM BROWSER INSTRUCTIONS[/b]'] = 'empty'
TempModule.objects['Example squad to paste'] = 'empty'
TempModule.objects['Spawner Bags'] = 'empty'
TempModule.objects['Upgrade Collection'] = 'empty'
TempModule.objects['Ship Models Collection'] = 'empty'
TempModule.objects['Pilot Cards Collection'] = 'empty'
TempModule.objects['Dials & Refcards Collection'] = 'empty'
TempModule.objects['[b]WARNING[/b]'] = 'empty'
TempModule.children = {}



-- Templates children table
-- Key: templateName, Value: {obj1, obj2, ... , objN}
TempModule.children = {}

-- Find template objects on the table
-- Name: "TEMPLATE{tempName}"
-- tempName is one of the TempModule.objects keys
TempModule.Init = function()
    for _, obj in pairs(getAllObjects()) do
        if TempModule.IsTemplate(obj) then
            local tName = TempModule.GetTrueName(obj)
            if TempModule.objects[tName] == 'empty' then
                TempModule.objects[tName] = obj
            elseif TempModule.objects[tName] ~= nil then
                print('WARNING: Double template \'' .. tName .. '\'' .. '!')
            end
        end
    end
    for k, entry in pairs(TempModule.objects) do
        if entry == 'empty' then
            print('WARNING: Template \'' .. k .. '\'' .. ' not found!')
            TempModule.objects[k] = nil
        end
    end
end

-- Check if object has template type name, return true/false
TempModule.IsTemplate = function(obj)
    if obj.getName():find('TEMPLATE{') and obj.getName():sub(-1, -1) == '}' then
        return true
    else
        return false
    end
end

-- Omit the "TEMPLATE{}" part from objects name
TempModule.GetTrueName = function(obj)
    return obj.getName():sub(10, -2)
end

-- Clone the template object with given parameters
-- Add it to the template children table
TempModule.Instantiate = function(tName, pos, scale, rot)
    if TempModule.objects[tName] == nil then
        print('WARNING: Template \'' .. k .. '\'' .. ' does no exist! (Instantiate)')
        return
    end
    local template = TempModule.objects[tName]
    local newObj = template.clone({})
    newObj.setName(TempModule.GetTrueName(template))
    if pos ~= nil then newObj.setPosition(pos) end
    if scale ~= nil then newObj.setScale(scale) end
    if rot ~= nil then newObj.setRotation(rot) end
    TempModule.AddChildren(tName, newObj)
    return newObj
end

-- Destroy all children of some template
TempModule.DeleteTempChildren = function(tName)
    if TempModule.children[tName] ~= nil then
        for _, child in pairs(TempModule.children[tName]) do
            if child ~= nil then
                child.destruct()
            end
        end
        TempModule.children[tName] = nil
    end
end

-- Destroy all children from all templates
TempModule.DeleteAllChildren = function()
    for tName, _ in pairs(TempModule.children) do
        TempModule.DeleteTempChildren(tName)
    end
end

-- Add an object as a child of a template
-- Asserts if it is already a child
TempModule.AddChildren = function(tName, obj)
    if obj.getVar('tempChild') == true or obj.getName():find('module') ~= nil then return end
    if tName == nil then
        tName = 'Arbitrary'
    end
    if TempModule.children[tName] == nil then
        TempModule.children[tName] = {}
    end
    for _, cObj in pairs(TempModule.children[tName]) do
        if obj == cObj then return end
    end
    obj.setVar('tempChild', true)
    table.insert(TempModule.children[tName], obj)
end

-- Remove this object from child tables if it is in any
TempModule.MakeOrphan = function(obj)
    local orphaned = false
    for k, cTable in pairs(TempModule.children) do
        local filtered = {}
        for _, cObj in pairs(cTable) do
            if cObj ~= obj then
                table.insert(filtered, cObj)
            else
                orphaned = true
            end
        end
        TempModule.children[k] = filtered
    end
    if orphaned then
        obj.setVar('tempChild', false)
    end
end
-- Shorthand
local TM = TempModule

-- Add an object as a child if it enters associated scripting zone
function onObjectLeaveScriptingZone(zone, leave_object)
    local builderZone = getObjectFromGUID('e3fc04')
    if zone == builderZone then
        TempModule.MakeOrphan(leave_object)
    end
end

function onObjectEnterScriptingZone(zone, enter_object)
    --[[
    local builderZone = getObjectFromGUID('e3fc04')
    if zone == builderZone then
        TempModule.AddChildren('Arbitrary', leave_object)
    end
    ]]
    --
end

-- Remove an object from any child tables if it dies (so there are no 'nil' holes in tables)
function onObjectDestroyed(dying_object)
    if dying_object.getVar('tempChild') == true then
        TempModule.MakeOrphan(dying_object)
    end
end

-- Tray buttons
SBM_buttons = {}
SBM_buttons.none = {
    click_function = 'SBM_clickNone',
    function_owner = self,
    label = 'None',
    position = { -15, 0, 1 },
    rotation = { 0, 180, 0 },
    width = 2100,
    height = 400,
    font_size = 300
}
SBM_buttons.builder = {
    click_function = 'SBM_clickBuilder',
    function_owner = self,
    label = 'Squad Builder',
    position = { -15, 0, 0 },
    rotation = { 0, 180, 0 },
    width = 2100,
    height = 400,
    font_size = 300
}
SBM_buttons.itemSpawner = {
    click_function = 'SBM_clickItemBrowser',
    function_owner = self,
    label = 'Item Browser',
    position = { -15, 0, -1 },
    rotation = { 0, 180, 0 },
    width = 2100,
    height = 400,
    font_size = 300
}
SBM_buttons.collection = {
    click_function = 'SBM_clickCollection',
    function_owner = self,
    label = 'Collection',
    position = { -15, 0, -2 },
    rotation = { 0, 180, 0 },
    width = 2100,
    height = 400,
    font_size = 300
}

-- Click functions for spawning things, taking other from bags, adding them as children
--   setting positions, rotations ....  boring

function SBM_clickNone()
    TM.DeleteAllChildren()
end

function SBM_clickBuilder()
    TM.DeleteAllChildren()
    local sPos = self.getPosition()
    local spawnerBag = TM.Instantiate('Spawner Bags', Vect.Sum(sPos, { 0, -5, 0 }), { 1, 1, 1 }, { 0, 90, 0 })
    spawnerBag.lock()
    local bags = spawnerBag.getObjects()
    local bagsOffset = {}
    bagsOffset['Upgrades Bag'] = { -11, 0.5, 0 }
    bagsOffset['Accesories Bag'] = { -13.5, 0.5, 0 }
    bagsOffset['Ship Models Bag'] = { -11, 0.5, 2.5 }
    bagsOffset['Pilot Cards Bag'] = { -11, 0.5, -2.5 }
    local bagRefs = {}
    for _, oTable in pairs(bags) do
        local newBag = spawnerBag.takeObject({ guid = oTable.guid, position = Vect.Sum(sPos, bagsOffset[oTable.name]) })
        bagRefs[newBag.getName()] = newBag
        newBag.setRotation({ 0, 90, 0 })
        newBag.setPosition(Vect.Sum(sPos, bagsOffset[oTable.name]))
        newBag.lock()
        TempModule.AddChildren('Upgrades Bag', newBag)
    end
    --bagRefs['Upgrades Bag'].call('API_linkBag', {bagRefs['Accesories Bag'], 'Accesories Bag'})
    --bagRefs['Upgrades Bag'].call('API_linkBag', {bagRefs['Ship Models Bag'], 'Ship Models Bag'})
    --bagRefs['Upgrades Bag'].call('API_linkBag', {bagRefs['Pilot Cards Bag'], 'Pilot Cards Bag'})
    local iNote = TM.Instantiate('[b]INSTRUCTIONS[/b]', Vect.Sum(sPos, { -17, 0.5, 22 }), { 1.5, 1.5, 1.5 },
        { 0, -90, 0 })
    iNote.setLuaScript('')
    local eNote = TM.Instantiate('Example squad to paste', Vect.Sum(sPos, { -10, 0.5, 22 }), { 1.5, 1.5, 1.5 },
        { 0, -90, 0 })
    eNote.setLuaScript('')

    iNote.interactable = true
    iNote.unlock()
    eNote.interactable = true
    eNote.unlock()
end

function API_AddChild(objTable)
    local obj = objTable[1]
    local temp = objTable[2]
    TempModule.AddChildren(temp, obj)
end

function builderFinish()
    TM.DeleteTempChildren('Upgrades Bag')
end

function SBM_clickItemBrowser()
    TM.DeleteAllChildren()
    local sPos = self.getPosition()
    local spawnerBag = TM.Instantiate('Spawner Bags', Vect.Sum(sPos, { 0, -5, 0 }), { 1, 1, 1 }, { 0, 90, 0 })
    spawnerBag.lock()
    local bags = spawnerBag.getObjects()
    local bagsOffset = {}
    bagsOffset['Upgrades Bag'] = { -11, 0.5, 0 }
    bagsOffset['Accesories Bag'] = { -13.5, 0.5, 0 }
    bagsOffset['Ship Models Bag'] = { -11, 0.5, 2.5 }
    bagsOffset['Pilot Cards Bag'] = { -11, 0.5, -2.5 }
    local bagRefs = {}
    for _, oTable in pairs(bags) do
        local newBag = spawnerBag.takeObject({ guid = oTable.guid, position = Vect.Sum(sPos, bagsOffset[oTable.name]) })
        if oTable.name == 'Upgrades Bag' then
            newBag.setDescription('itemBrowserMode')
        end
        bagRefs[newBag.getName()] = newBag
        newBag.setRotation({ 0, 90, 0 })
        newBag.setPosition(Vect.Sum(sPos, bagsOffset[oTable.name]))
        newBag.lock()
        TempModule.AddChildren('Upgrades Bag', newBag)
    end
    local iNote = TM.Instantiate('[b]ITEM BROWSER INSTRUCTIONS[/b]', Vect.Sum(sPos, { 1, 0.5, 11 }), { 1.8, 1.8, 1.8 },
        { 0, -90, 0 })
    iNote.setLuaScript('')
    iNote.interactable = true
    iNote.unlock()
end

function SBM_clickCollection()
    TM.DeleteAllChildren()
    --13,22
    local sPos = self.getPosition()
    local DR_bag = TM.Instantiate('Dials & Refcards Collection', Vect.Sum(sPos, { 0, -2, 0 }))
    DR_bag.lock()
    DR_bag.tooltip = false
    local items = DR_bag.getObjects()
    local DR_sPos = Vect.Sum(sPos, { -11, 0.5, 25 })
    for _, info in pairs(items) do
        local newObj = DR_bag.takeObject({ guid = info.guid })
        newObj.setPosition(DR_sPos)
        DR_sPos = Vect.Sum(DR_sPos, { -2, 0, 0 })
        TempModule.AddChildren('Dials & Refcards Collection', newObj)
    end
    --TM.DeleteTempChildren('Dials & Refcards Collection')
    local UC_bag = TM.Instantiate('Upgrade Collection', Vect.Sum(sPos, { 0, -3, 0 }))
    UC_bag.lock()
    UC_bag.tooltip = false
    items = UC_bag.getObjects()
    local UC_sPos = Vect.Sum(sPos, { -13, 0.5, 22 })
    for _, info in pairs(items) do
        local newObj = UC_bag.takeObject({ guid = info.guid, rotation = { 180, -90, 0 } })
        newObj.setPosition(UC_sPos)
        UC_sPos = Vect.Sum(UC_sPos, { 0, 0, -2 })
        TempModule.AddChildren('Upgrade Collection', newObj)
    end
    --TM.DeleteTempChildren('Upgrade Collection')
    local SM_bag = TM.Instantiate('Ship Models Collection', Vect.Sum(sPos, { 0, -4, 0 }))
    SM_bag.lock()
    SM_bag.tooltip = false
    items = SM_bag.getObjects()
    local SM_sPos = { UC_sPos[1] + 2, UC_sPos[2] + 0.5, UC_sPos[3] - 1 }
    for _, info in pairs(items) do
        local newObj = SM_bag.takeObject({ guid = info.guid })
        newObj.setPosition(SM_sPos)
        SM_sPos = Vect.Sum(SM_sPos, { -2, 0, 0 })
        TempModule.AddChildren('Ship Models Collection', newObj)
    end
    --TM.DeleteTempChildren('Ship Models Collection')
    local PC_bag = TM.Instantiate('Pilot Cards Collection', Vect.Sum(sPos, { 0, -5, 0 }))
    PC_bag.lock()
    PC_bag.tooltip = false
    items = PC_bag.getObjects()
    local PC_sPos = { SM_sPos[1] + 4, SM_sPos[2] + 0.5, SM_sPos[3] - 3 }
    for _, info in pairs(items) do
        local newObj = PC_bag.takeObject({ guid = info.guid, rotation = { 180, -90, 0 } })
        newObj.setPosition(PC_sPos)
        PC_sPos = Vect.Sum(PC_sPos, { 0, 0, -3 })
        TempModule.AddChildren('Pilot Cards Collection', newObj)
    end
    --TM.DeleteTempChildren('Pilot Cards Collection')
    local warnNote = TM.Instantiate('[b]WARNING[/b]', Vect.Sum(PC_sPos, { 0, 0, -3 }), { 1.25, 1.25, 1.25 },
        { 0, 180, 0 })
    warnNote.setLuaScript('')
    warnNote.interactable = true
    warnNote.unlock()
end

-- Prevent destroying text field template
-- (can be accidentally done through "Delete all 3d text" button)
function onObjectDestroyed(obj)
    if obj.TextTool ~= nil and obj.getValue() == 'TEMPLATE{Text Field}' then
        obj.clone({ position = obj.getPosition() })
    end
end

-- Tray positioning
function onLoad(save_state)
    self.setScale({ 1.5, 0.5, 1.5 })
    self.setPosition({ -65, 0, 0 })
    self.setRotation({ 0, -90, 0 })
    self.lock()
    self.interactable = false
    TempModule.Init()
    self.createButton(SBM_buttons.none)
    self.createButton(SBM_buttons.builder)
    self.createButton(SBM_buttons.itemSpawner)
    self.createButton(SBM_buttons.collection)
end
