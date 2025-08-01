-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- Auto naming for reinforce token
-- ~~~~~~

-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'reinforce'

-- Is a direction clear?
function clearDir(dir)
    local clear = true
    local rayHits = checkRay(dir)
    for k, hitTable in pairs(rayHits) do
        if not ignoreHit(hitTable.hit_object) then
            clear = false
            break
        end
    end
    return clear
end

-- Which cast hits should be ignored
function ignoreHit(obj)
    return ((obj.tag == 'Figurine') or (obj.tag == 'Chip') or (obj == self))
end

-- Check for hits in a direction
function checkRay(dir)
    local localDir = self.positionToWorld({ 0, dir, 0 })
    local sPos = self.getPosition()
    local rayDir = { localDir[1] - sPos[1], localDir[2] - sPos[2], localDir[3] - sPos[3] }
    return Physics.cast({ origin = self.getPosition(), direction = rayDir, type = 1 })
end

-- Name self based on which side is faceup
function onCollisionEnter()
    if clearDir(1) then
        self.setName('Reinforce (aft)')
    end
    if clearDir(-1) then
        self.setName('Reinforce (fore)')
    end
end
