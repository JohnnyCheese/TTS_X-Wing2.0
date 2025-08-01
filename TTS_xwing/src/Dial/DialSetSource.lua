
local talSegPos = {1, 0, 4}
local koiPos = {{2, 0, 4}, {2, 0, 5}, {-2, 0, 4}, {-2, 0, 5}}
local koiCount = 1
function decodeDesc(desc)
    dir = nil
    speed = nil
    type = nil
    if desc:sub(-1, -1) == 's' then
        type = 'seg'
        speed = tonumber(desc:sub(-2, -2))
        dir = desc:sub(-3, -3)
    elseif desc:sub(-1, -1) == 't' then
        type = 'tal'
        speed = tonumber(desc:sub(-2, -2))
        dir = desc:sub(-3, -3)
    elseif desc:sub(-1,-1) == 'r' then
        type = desc:sub(1, 1)
        if desc:sub(2,2) == 'r' then
            dir = 'r'
        elseif desc:sub(2,2) == 'e' or desc:sub(2,2) == 'l' then
            dir = 'l'
        end
        speed = 0
    elseif desc:sub(1, 1) == 'k' then
        type = 'koi'
        speed = tonumber(desc:sub(2, 2))
        dir = 's'
    elseif desc:sub(1, 1) == 's' then
        type = 's'
        speed = tonumber(desc:sub(2, 2))
        dir = 's'
    else
        type = desc:sub(1, 1)
        dir = desc:sub(2, 2)
        speed = tonumber(desc:sub(3, 3))
    end

    out = {0, 0, speed}

    if type == 'seg' or type == 'tal' then
        out = {talSegPos[1], talSegPos[2], talSegPos[3]}
    elseif type == 'koi' then
        out = koiPos[koiCount]
        koiCount = koiCount+1
    else
        if type == 'b' then
            out[1] = 1
        elseif type == 't' then
            out[1] = 2
        end
    end

    if dir == 'e' or dir == 'l' then
        out[1] = -1*out[1]
    end

    return out
end

function moveSpeed(desc)
    local speed = nil
    if desc:sub(-1, -1) == 's' then
        speed = tonumber(desc:sub(-2, -2))
    elseif desc:sub(-1, -1) == 't' then
        speed = tonumber(desc:sub(-2, -2))
    elseif desc:sub(-1,-1) == 'r' then
        speed = 0
    elseif desc:sub(1, 1) == 'k' then
        speed = tonumber(desc:sub(2, 2))
    elseif desc:sub(1, 1) == 's' then
        speed = tonumber(desc:sub(2, 2))
    else
        speed = tonumber(desc:sub(3, 3))
    end
    if speed == nil then print(desc) end
    return speed
end

function offset(table1, table2)
    table2 = table2 or {0, 0, 0}
    return {table1[1]+table2[1], table1[2]+table2[2], table1[3]+table2[3]}
end

function scale(table, value)
    value = value or 1
    return {table[1]*value, table[2]*value, table[3]*value}
end

function localPos(pos)
    refOffset = self.getPosition()
    refRot = math.rad(-1*self.getRotation()[2])
    local posRot = {pos[3]*math.sin(refRot)-pos[1]*math.cos(refRot), pos[2], -1*pos[1]*math.sin(refRot) - pos[3]*math.cos(refRot)}
    return {posRot[1]+refOffset[1], refOffset[2], posRot[3]+refOffset[3]}
end


-- FUNCTION FOR DIAL ASSIGNMENT UPON LAYOUT
function assignCallback(obj, params)
    table.insert(spawnedDials, obj)
    if #spawnedDials == dialCount then
        if params.ship ~= nil then
            Global.call('DialAPI_AssignSet', {set=spawnedDials, ship=params.ship})
        end
        if params.callbackObj ~= nil then
            params.callbackObj.call(params.callbackFun, params.callbackParams)
        end
    end
end

-- LAY OUT DIALS, CALL ASSIGN IF NECCESARY, DESTROY SELF
function init(arg)
    dialCount = #self.getObjects()-2
    spawnedDials = {}
    local callbackTable = arg or {}
    local dialSpacing = (2/0.625)*(self.getScale()[1])
    local stackDials = self.getObjects()
    local minSpeed = 5
    local maxSpeed = 0
    for k,dial in pairs(stackDials) do
        if dial.description ~= 'spec' then
            local dialSpeed = moveSpeed(dial.description)
            if dialSpeed < minSpeed then
                minSpeed = dialSpeed
            end
            if dialSpeed > maxSpeed then
                maxSpeed = dialSpeed
            end
        end
    end
    local posOffset = {0, 0.1, -1*0.5*(maxSpeed-minSpeed) - minSpeed}
    ---[[
    for k, dial in pairs(stackDials) do
        if dial['description'] ~= 'spec' then
            local dialPos = decodeDesc(dial['description'])
            dialPos = offset(dialPos, posOffset)
            dialPos = scale(dialPos, dialSpacing)
            dialPos = localPos(dialPos)
            local dialRot = {0, self.getRotation()[2], 0}
            newDial = self.takeObject({ position=dialPos, rotation=dialRot, guid=dial['guid'],
                                        callback='assignCallback', callback_owner=self, params={ship=callbackTable.ship,
                                        cb=callbackTable.callbackFun, cbArgs=callbackTable.callbackParams, cbObj=callbackTable.callbackObj}})
            newDial.setPosition(dialPos)
            newDial.setRotation(dialRot)
            newDial.setLuaScript(dialLuaScript)
            local Description = newDial.getDescription()
            newDial = {}
            newDial.Desc = Description
        end
    end
    self.destruct()
    return spawnedDials
    --]]
    --[[
    function LayoutCor()
        for k, dial in pairs(stackDials) do
            if dial['description'] ~= 'spec' then
                local dialPos = decodeDesc(dial['description'])
                dialPos = offset(dialPos, posOffset)
                dialPos = scale(dialPos, dialSpacing)
                dialPos = localPos(dialPos)
                local dialRot = {0, self.getRotation()[2], 0}
                newDial = self.takeObject({ position=dialPos, rotation=dialRot, guid=dial['guid'],
                                            callback='assignCallback', callback_owner=self, params={ship=callbackTable.ship,
                                            cb=callbackTable.callbackFun, cbArgs=callbackTable.callbackParams, cbObj=callbackTable.callbackObj}})
                newDial.setLuaScript(dialLuaScript)
                coroutine.yield(0)
            end
        end
        self.destruct()
        return 1
    end
    startLuaCoroutine(self, 'LayoutCor')
    --]]
end

function onLoad()
    if self.getName() == 'Dial Set source' then
        self.setPosition({0, -3, -7.5})
        self.setRotation({0, 0, 0})
        self.lock()
        self.tooltip = false
        self.interactable = false

    end
    dialLuaScript = Global.getVar('dialLuaScript')
end