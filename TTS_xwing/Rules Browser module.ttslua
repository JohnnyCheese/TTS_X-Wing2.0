-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: https://github.com/tjakubo2/TTS_xwing
-- ~~~~~~


-- Templating module
-- May be an overkill but it works
TempModule = {}
TempModule.objects = {}
    TempModule.objects['Rules & FAQ Bag']='empty'
    TempModule.objects['L2P & Tutorial Bag']='empty'
    TempModule.objects['[b]BOOKS USAGE[/b]']='empty'
    TempModule.objects['Table help and wiki browser bag']='empty'





-- Templates children table
-- Key: templateName, Value: {obj1, obj2, ... , objN}
TempModule.children = {}

-- Find template objects on the table
-- Name: "TEMPLATE{tempName}"
-- tempName is one of the TempModule.objects keys
TempModule.Init = function()
    for k,obj in pairs(getAllObjects()) do
        if TempModule.IsTemplate(obj) then
            local tName = TempModule.GetTrueName(obj)
            if TempModule.objects[tName] == 'empty' then
                TempModule.objects[tName] = obj
            elseif TempModule.objects[tName] ~= nil then
                print('WARNING: Double template \'' .. tName .. '\'' .. '!')
            end
        end
    end
    for k,entry in pairs(TempModule.objects) do
        if entry == 'empty' then
            print('WARNING: Template \'' .. k .. '\'' .. ' not found!')
            TempModule.objects[k] = nil
        end
    end
end

-- Check if object has template type name, return true/false
TempModule.IsTemplate = function(obj)
    if obj.getName():find('TEMPLATE{') and obj.getName():sub(-1,-1) == '}' then
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
        for k,child in pairs(TempModule.children[tName]) do
            if child ~= nil then
                child.destruct()
            end
        end
        TempModule.children[tName] = nil
    end
end

-- Destroy all children from all templates
TempModule.DeleteAllChildren = function()
    for tName,t in pairs(TempModule.children) do
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
    for k,cObj in pairs(TempModule.children[tName]) do
        if obj == cObj then return end
    end
    obj.setVar('tempChild', true)
    table.insert(TempModule.children[tName], obj)
end

-- Remove this object from child tables if it is in any
TempModule.MakeOrphan = function(obj)
    for k,cTable in pairs(TempModule.children) do
        local filtered = {}
        for k2, cObj in pairs(cTable) do
            if cObj ~= obj then table.insert(filtered, cObj) end
        end
        TempModule.children[k] = filtered
    end
    obj.setVar('tempChild', false)
end
-- Shorthand
local TM = TempModule

-- Add an object as a child if it enters associated scripting zone
function onObjectLeaveScriptingZone(zone, leave_object)
    local rulesZone = getObjectFromGUID('3822de')
    if zone == rulesZone then
        TempModule.MakeOrphan(leave_object)
    end
end

-- Remove an object afrom any child tables if it leaves associated scripting zone
function onObjectEnterScriptingZone(zone, enter_object)
    local rulesZone = getObjectFromGUID('3822de')
    if zone == rulesZone then
        TempModule.AddChildren('Arbitrary', enter_object)
    end
end

-- Remove an object afrom any child tables if it dies (so there are no 'nil' holes in tables)
function onObjectDestroyed(dying_object)
    if dying_object.getVar('tempChild') == true then
        TempModule.MakeOrphan(dying_object)
    end
end

-- Tray buttons
RBM_buttons = {}
RBM_buttons.none = {
    click_function = 'RBM_clickNone',
    function_owner = self,
    label = 'None',
    position = {-15, 0, 1.5},
    rotation = {0, 180, 0},
    width = 2100,
    height = 400,
    font_size = 300
                    }
RBM_buttons.rules = {
    click_function = 'RBM_clickRules',
    function_owner = self,
    label = 'Rules & FAQ',
    position = {-15, 0, 0.5},
    rotation = {0, 180, 0},
    width = 2100,
    height = 400,
    font_size = 300
                    }
RBM_buttons.learn2play = {
    click_function = 'RBM_clickL2P',
    function_owner = self,
    label = 'Learn to Play',
    position = {-15, 0, -0.5},
    rotation = {0, 180, 0},
    width = 2100,
    height = 400,
    font_size = 300
                    }
RBM_buttons.modHelp = {
    click_function = 'RBM_clickModHelp',
    function_owner = self,
    label = 'Table help',
    position = {-15, 0, -1.5},
    rotation = {0, 180, 0},
    width = 2100,
    height = 400,
    font_size = 300
                    }

-- Sum of two vectors (of any size)
function Vect_Sum(vec1, vec2)
    local out = {}
    local k = 1
    while vec1[k] ~= nil and vec2[k] ~= nil do
        out[k] = vec1[k]+vec2[k]
        k = k+1
    end
    return out
end

-- Click functions for spawning things, taking other from bags, adding them as children
--   setting positions, rotations ....  boring

function RBM_clickNone()
    TM.DeleteAllChildren()
end
function RBM_clickRules()
    TM.DeleteAllChildren()
    local sPos = self.getPosition()
    local usageNote = TM.Instantiate('[b]BOOKS USAGE[/b]', Vect_Sum(sPos, {3, 0.5, -13}), {1, 1, 1}, {0, 90, 0})
    usageNote.setLuaScript('')
    usageNote.interactable = true
    usageNote.unlock()
    local RFAQ_bag = TM.Instantiate('Rules & FAQ Bag', Vect_Sum(sPos, {0, -5, 0}))
    RFAQ_bag.lock()
    local items = RFAQ_bag.getObjects()
    for k,info in pairs(items) do
        local params = {guid=info.guid, rotation={0, -90, 0}}
        local newObj = RFAQ_bag.takeObject(params)
        if newObj.getName() == 'FAQ' then
            newObj.setPosition(Vect_Sum(sPos, {0, 0.5, -2}))
        elseif newObj.getName() == 'Rules Reference Index' then
            newObj.setPosition(Vect_Sum(sPos, {0, 0.5, 20}))
        elseif newObj.getName() == 'Reference Cards' then
            newObj.setPosition(Vect_Sum(sPos, {-3, 0.5, -13}))
            newObj.setRotation({0, 0, 0})
        else
            newObj.setPosition(Vect_Sum(sPos, {0, 0.5, 11}))
        end
        TM.AddChildren('Rules & FAQ Bag', newObj)
    end
end
function RBM_clickL2P()
    TM.DeleteAllChildren()
    local sPos = self.getPosition()
    local usageNote = TM.Instantiate('[b]BOOKS USAGE[/b]', Vect_Sum(sPos, {0, 0.5, -13}), {1, 1, 1}, {0, 90, 0})
    usageNote.setLuaScript('')
    usageNote.interactable = true
    usageNote.unlock()
    local L2PTut_bag = TM.Instantiate('L2P & Tutorial Bag', Vect_Sum(sPos, {0, -5, 0}))
    L2PTut_bag.lock()
    local items = L2PTut_bag.getObjects()
    for k,info in pairs(items) do
        local params = {guid=info.guid, rotation={0, -90, 0}}
        local newObj = L2PTut_bag.takeObject(params)
        if newObj.getName() == 'Tutorial Video' then
            newObj.setPosition(Vect_Sum(sPos, {0, 0.5, 0}))
        elseif newObj.getName() == 'Learn to Play Booklet' then
            newObj.setPosition(Vect_Sum(sPos, {0, 0.5, 15}))
        end
        TM.AddChildren('L2P & Tutorial Bag', newObj)
    end
end
function RBM_clickModHelp()
    TM.DeleteAllChildren()
    local sPos = self.getPosition()
    local Help_bag = TM.Instantiate('Table help and wiki browser bag', Vect_Sum(sPos, {0, -5, 0}))
    Help_bag.lock()
    local items = Help_bag.getObjects()
    for k,info in pairs(items) do
        local params = {guid=info.guid, rotation={0, 90, 0}}
        local newObj = Help_bag.takeObject(params)
        if newObj.getName() == 'Wiki browser' then
            newObj.setPosition(Vect_Sum(sPos, {0, 0.5, -6}))
            newObj.setRotationSmooth({0, -90, 0})
        elseif newObj.getName() == '[b]Table help[/b]' then
            newObj.setPosition(Vect_Sum(sPos, {0, 0.5, 15}))
        end
        TM.AddChildren('Table help and wiki browser bag', newObj)
    end
end

-- Tray positioning
function onLoad(save_state)
    self.setScale({1.5, 0.5, 1.5})
    self.setPosition({65, 0, 0})
    self.setRotation({0, 90, 0})
    self.lock()
    self.interactable = false
    TempModule.Init()
    self.createButton(RBM_buttons.none)
    self.createButton(RBM_buttons.rules)
    self.createButton(RBM_buttons.learn2play)
    self.createButton(RBM_buttons.modHelp)
end