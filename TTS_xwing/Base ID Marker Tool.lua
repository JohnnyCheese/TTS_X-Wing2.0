

	local AttatchTemplateButton = {['function_owner'] = self, ['click_function'] = 'AttatchTemplate', ['label'] = 'Attatch', ['position'] = {0.0, 0.3, 0.3}, ['rotation'] =  {0, 0, 0}, ['width'] = 200, ['height'] = 80, ['font_size'] = 50}
    self.createButton(AttatchTemplateButton)
	
function AttatchTemplate()
	local spos = self.getPosition()
        local nearest = nil
        local minDist = 2.89 -- 80mm
        for k,ship in pairs(getAllObjects()) do
            if ship.tag == 'Figurine' and ship.name ~= '' then
                local pos = ship.getPosition()
                local dist = math.sqrt(math.pow((spos[1]-pos[1]),2) + math.pow((spos[3]-pos[3]),2))
                if dist < minDist then
                    nearest = ship
                    minDist = dist
                end
            end
        end
local obj = nil
local shipGUID = nil
obj = nearest
shipGUID = obj.getGUID()
obj.addAttachment(self)
self.clearButtons()
end

-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- Arc indicator snap script
-- ~~~~~~

-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'arcIndicator'

-- Should it snap on the next collision
snap = true

-- When colliding with a ship, set position to its center and rotation to nearest 90deg point
-- Wait until resting after every snap
function onCollisionEnter(collision_info)
    local body = collision_info.collision_object
    if (not loaded) or (not snap) or (not body) or body.tag ~= 'Figurine' then return end
    local relRot = self.getRotation()[2] - body.getRotation()[2]
    local tRot = math.round(relRot/90)*90 + body.getRotation()[2]
    local tPos = body.getPosition()
    self.setPositionSmooth({tPos[1], tPos[2]+0.3, tPos[3]}, false, true)
    self.setRotationSmooth({0, tRot, 0}, false, true)
    snap = false
    startLuaCoroutine(self, 'waitForResting')
end

function onLoad(save_state)
    loaded = true
end

function waitForResting()
    while (not self.resting) or self.isSmoothMoving() do
        coroutine.yield(0)
    end
    snap = true
    return 1
end

-- Round to decPlaces decimal places
-- if decPlaces nil round to nearest integer
function math.round(arg, decPlaces)
    if decPlaces == nil then decPlaces = 0 end

    if decPlaces == 0 then
        frac = arg - math.floor(arg)
        if frac >= 0.5 then
            return math.ceil(arg)
        else
            return math.floor(arg)
        end
    else
        local mult = 10^(decPlaces or 0)
        return math.floor(arg * mult + 0.5) / mult
    end
end
