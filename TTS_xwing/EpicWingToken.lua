
-- ~~~~~~
-- Script by CrazyVulcan
-- Based on work by dzikakulka
-- Issues, history at: TBD
--
-- Epic Wing gizmo token v0.1 test canadate. 
-- ~~~~~~

-- Scripted token properties
__XW_Token = true
__XW_TokenIdle = false
__XW_TokenType = 'helper:epicWing'

-- Ref to assigned ship if there is one
-- Ships in this wings GUID
local shipGUID_WL = nil
local shipGUID_LF = nil
local shipGUID_RF = nil
local shipGUID_BS = nil
local shipGUID_LS = nil
local shipGUID_RS = nil
local shipActive_WL = false
local shipActive_LF = false
local shipActive_RF = false
local shipActive_BS = false
local shipActive_LS = false
local shipActive_RS = false
local s1 = 0.73
local ship = nil
nameUnassigned = 'Epic Wing Token'
nameAssigned = '\'s Wing'
local wingName = ''
local index = 0
local posName = ''
local toolOpen = false
local pos1 = nil
local pos2 = nil
local pos3 = nil
local pos4 = nil
local pos5 = nil
function onLoad()
	nameAssigned = self.getName()
	SpawnFirstButtons()
end

function SpawnFirstButtons()
	if nameAssigned == 'Epic Wing Token' then
    self.clearButtons()
	local nameWingButton = {['function_owner'] = self , ['click_function'] = 'nameWingButton', ['label'] = 'Click to Start', ['position'] = {0, 0.25, 0}, ['rotation'] =  {0, 0, 0}, ['width'] = 700, ['height'] = 200, ['font_size'] = 100}
    self.createButton(nameWingButton)
	else
	SpawnLastButtons()
	end
	
end

function onDrop()
	if toolOpen == true then
		AddWingmate()
	end
end



function SpawnLastButtons()
    self.clearButtons()
    local ResetButton = {['function_owner'] = self , ['click_function'] = 'selfReset', ['label'] = 'Reset', ['position'] = {0, 0.25, 0.8}, ['rotation'] =  {0, 0, 0}, ['width'] = 700, ['height'] = 200, ['font_size'] = 100}
    self.createButton(ResetButton)
	local formWingButton = {['function_owner'] = self , ['click_function'] = 'SetWing', ['label'] = 'Form Wing', ['position'] = {0, 0.25, 0}, ['rotation'] =  {0, 0, 0}, ['width'] = 700, ['height'] = 200, ['font_size'] = 100}
    self.createButton(formWingButton)
	toolOpen = true
	wingName = self.getName()
end


-- Unassign the ship
function selfReset()

	local selfParams = self.getCustomObject()
	selfParams.diffuse = "http://cloud-3.steamusercontent.com/ugc/772864005379607458/65B8F0711DA05AE27B198979B0A4BE951284FD4E/"
	self.setCustomObject(selfParams)
    shipGUID_WL = nil
	shipGUID_LF = nil
	shipGUID_RF = nil
	shipGUID_BS = nil
	shipGUID_LS = nil
	shipGUID_RS = nil
	local shipActive_WL = false
	local shipActive_LF = false
	local shipActive_RF = false
	local shipActive_BS = false
	local shipActive_LS = false
	local shipActive_RS = false
	local pos1 = nil
	local pos2 = nil
	local pos3 = nil
	local pos4 = nil
	local pos5 = nil
	index = 0
    self.clearButtons()
    self.setName(nameUnassigned)
	nameAssigned = nameUnassigned
	self.call('SpawnFirstButtons')
	local newSelf = self.reload()
end


--asign ships to wing Place token on the ship and press the Left Wing Button
-- Assign on drop near a small base ship
-- Add a wingmate to the wing
function AddWingmate ()
	--find which posistion to fill next
        if index == 0 then 
		PosName = ' Leader'
		shipActive_WL = true
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
        if nearest ~= nil then
            printToAll('Epic wing token assigned to ' .. nearest.getName())
            SpawnFirstButtons()
            shipGUID_WL = nearest

			ThisShipsGUID = shipGUID_WL.getGUID()
        end
		shipGUID_WL = getObjectFromGUID(ThisShipsGUID)
--		shipGUID_WL.setName(wingName .. ' Leader: ' .. nearest.getName())
		shipActive_WL = true
    end

	

	if index == 1 then 
		posName = ' One'
		shipActive_LF = true
	elseif index == 2 then
		shipActive_RF = true
		posName = ' Two'
	elseif index == 3 then
		shipActive_LS = true
		posName = ' Three'
	elseif index == 4 then
		shipActive_BS = true
		posName = ' Four'
	elseif index == 5 then 
		shipActive_RS = true
		posName = ' Five'
	end
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
        if nearest ~= nil then
            printToAll(wingName .. ' ' .. posName .. ': assigned to ' .. nearest.getName())
            SpawnFirstButtons()
            ship = nearest
			ThisShipsGUID = ship.getGUID()
        end
	ship = getObjectFromGUID(ThisShipsGUID)
--	ship.setName(wingName .. index)
	if index == 0 then shipGUID_WL = ship end
	if index == 1 then shipGUID_LF = ship end
	if index == 2 then shipGUID_RF = ship end	
	if index == 3 then shipGUID_LS = ship end	
	if index == 4 then shipGUID_BS = ship end
	if index == 5 then shipGUID_RS = ship end
	index = index + 1
	if index == 7 then index = 6 end
end



-------------------------------------------
----Flavor Script for Nameing Squadrons----

function nameWingButton()
	self.clearButtons()
		
	local SetRedSquadron = {['function_owner'] = self, ['click_function'] = 'SetRedSquadron', ['label'] = 'Red Squadron', ['position'] = {-2.5, 0.25, 1}, ['rotation'] =  {0, 0, 0}, ['width'] = 900, ['height'] = 200, ['font_size'] = 100}
    self.createButton(SetRedSquadron)
	local SetGoldSquadron = {['function_owner'] = self, ['click_function'] = 'SetGoldSquadron', ['label'] = 'Gold Squadron', ['position'] = {-2.5, 0.25, 0}, ['rotation'] =  {0, 0, 0}, ['width'] = 900, ['height'] = 200, ['font_size'] = 100}
    self.createButton(SetGoldSquadron)
	local SetBlueSquadron = {['function_owner'] = self, ['click_function'] = 'SetBlueSquadron', ['label'] = 'Blue Squadron', ['position'] = {-2.5, 0.25, -1}, ['rotation'] =  {0, 0, 0}, ['width'] = 900, ['height'] = 200, ['font_size'] = 100}
    self.createButton(SetBlueSquadron)
	local SetGreenSquadron = {['function_owner'] = self, ['click_function'] = 'SetGreenSquadron', ['label'] = 'Green Squadron', ['position'] = {2.5, 0.25, 1}, ['rotation'] =  {0, 0, 0}, ['width'] = 900, ['height'] = 200, ['font_size'] = 100}
    self.createButton(SetGreenSquadron)
	local SetBlackSquadron = {['function_owner'] = self, ['click_function'] = 'SetBlackSquadron', ['label'] = 'Black Squadron', ['position'] = {2.5, 0.25, 0}, ['rotation'] =  {0, 0, 0}, ['width'] = 900, ['height'] = 200, ['font_size'] = 100}
    self.createButton(SetBlackSquadron)
	local SetWhiteSquadron = {['function_owner'] = self, ['click_function'] = 'SetWhiteSquadron', ['label'] = 'White Squadron', ['position'] = {2.5, 0.25, -1}, ['rotation'] =  {0, 0, 0}, ['width'] = 900, ['height'] = 200, ['font_size'] = 100}
    self.createButton(SetWhiteSquadron)

end


function SetRedSquadron()
	wingName = 'Red'
	self.setName(wingName)
	local selfParams = self.getCustomObject()
	selfParams.diffuse = "https://i.imgur.com/KZZPnhX.png"
	self.setCustomObject(selfParams)
	local newSelf = self.reload()
	self.call('SpawnLastButtons')
end
function SetGoldSquadron()
	wingName = 'Gold'
	self.setName(wingName)
	local selfParams = self.getCustomObject()
	selfParams.diffuse = "https://i.imgur.com/XjBrVrA.png"
	self.setCustomObject(selfParams)
	local newSelf = self.reload()
	self.call('SpawnLastButtons')
end
function SetBlueSquadron()
	wingName = 'Blue'
	self.setName(wingName)
	local selfParams = self.getCustomObject()
	selfParams.diffuse = "https://i.imgur.com/ykWvj3L.png"
	self.setCustomObject(selfParams)
	self.call('SpawnLastButtons')
	local newSelf = self.reload()
	
end
function SetGreenSquadron()
	wingName = 'Green'
	self.setName(wingName)
	local selfParams = self.getCustomObject()
	selfParams.diffuse = "https://i.imgur.com/2TsnvPM.png"
	self.setCustomObject(selfParams)
	self.call('SpawnLastButtons')
	local newSelf = self.reload()
	
end

function SetBlackSquadron()
	wingName = 'Black'
	self.setName(wingName)
	local selfParams = self.getCustomObject()
	selfParams.diffuse = "https://i.imgur.com/4ByFkvW.png"
	self.setCustomObject(selfParams)
	self.call('SpawnLastButtons')
	local newSelf = self.reload()
	
end

function SetWhiteSquadron()
	wingName = 'White'
	self.setName(wingName)
	local selfParams = self.getCustomObject()
	selfParams.diffuse = "https://i.imgur.com/u5IKfG5.png"
	self.setCustomObject(selfParams)
	local newSelf = self.reload()
	self.call('SpawnLastButtons')

end

-----------------------------------
local ships = {shipGUID_WL, shipGUID_LF, shipGUID_RF, shipGUID_BS, shipGUID_LS, shipGUID_RS}
function SetWing()
	self.clearButtons()
		if index == 2 then print('A Wing needsd to have at least 3 ships to form') end
		if index >= 3 then 
		pos1 = shipGUID_LF
		pos2 = shipGUID_RF
		WingMateLand() 
		end
		if index == 4 then 
			pos1 = shipGUID_LF
			pos2 = shipGUID_RF
			pos4 = shipGUID_LS
			WingMateLand()
		end
		if index == 5 then
			pos1 = shipGUID_LF
			pos2 = shipGUID_RF
			pos3 = shipGUID_LS
			pos5 = shipGUID_BS
			WingMateLand()
		end
		if index == 6 then
		pos1 = shipGUID_LF
		pos2 = shipGUID_RF
		pos3 = shipGUID_LS
		pos4 = shipGUID_BS
		pos5 = shipGUID_RS
		end

	local formWingButton = {['function_owner'] = self , ['click_function'] = 'WingMateLand', ['label'] = 'Form Wing', ['position'] = {0, 0.25, 0}, ['rotation'] =  {0, 0, 0}, ['width'] = 700, ['height'] = 200, ['font_size'] = 100}
    self.createButton(formWingButton)
	toolOpen = false
end



function WingMateLand()
print(index)
	if index == 3 then
		if shipActive_LF == true then landLF() end
		if shipActive_RF == true then Wait.frames(landRF, 10) end
	end	

	if index == 4 then
		if shipActive_LF == true then landLF() end
		if shipActive_RF == true then Wait.frames(landRF, 10) end
		if shipActive_LS == true then Wait.frames(landBS, 20) end
	end

	if index == 5 then
		if shipActive_LF == true then landLF() end
		if shipActive_RF == true then Wait.frames(landRF, 10) end
		if shipActive_LS == true then Wait.frames(landLS, 20) end
		if shipActive_BS == true then Wait.frames(landRS, 30) end
	end

	if index == 6 then
		if shipActive_LF == true then landLF() end
		if shipActive_RF == true then Wait.frames(landRF, 10) end
		if shipActive_BS == true then Wait.frames(landBS, 20) end
		if shipActive_LS == true then Wait.frames(landLS, 30) end
		if shipActive_RS == true then Wait.frames(landRS, 40) end
	end
end


function landLF()
shipGUID_LF.clearButtons()
local WL_POS = shipGUID_WL.getPosition()
local WL_ROT = shipGUID_WL.getRotation()
	posZ= math.sin(math.rad(WL_ROT.y))*(s1*3)
	posX= math.cos(math.rad(WL_ROT.y))*(s1*3)
	desiredpos = {WL_POS.x+posX,WL_POS.y,WL_POS.z-posZ}
	desiredrot = {WL_ROT.x, WL_ROT.y, WL_ROT.z}

local success = Global.call("epicMoveWingmate",{pos1,desiredpos, desiredrot})
	if not success then
		print('Right Flank needs to break off')-- Break from wing, and mark for movement after all other wing members have been moved
		shipActive_LF = false
		rejoinButton()
	end
	return true
end

function landRF()
shipGUID_RF.clearButtons()
local WL_POS = shipGUID_WL.getPosition()
local WL_ROT = shipGUID_WL.getRotation()
	posZ= math.sin(math.rad(WL_ROT.y))*(s1*3)
	posX= math.cos(math.rad(WL_ROT.y))*(s1*3)
	desiredpos = {WL_POS.x-posX,WL_POS.y,WL_POS.z+posZ}
	desiredrot = {WL_ROT.x, WL_ROT.y, WL_ROT.z}

local success = Global.call("epicMoveWingmate",{pos2,desiredpos, desiredrot})
	if not success then
		print('Right Flank needs to break off')-- Break from wing, and mark for movement after all other wing members have been moved
		shipActive_RF = false
		rejoinButton()
	end
	return true
end

function landLS()
shipGUID_LS.clearButtons()
local WL_POS = shipGUID_WL.getPosition()
local WL_ROT = shipGUID_WL.getRotation()
	posZ= math.sin(math.rad(WL_ROT.y))*(s1*3)
	posX= math.cos(math.rad(WL_ROT.y))*(s1*3)
	posA = {x=WL_POS.x+posX, y=WL_POS.y, z=WL_POS.z-posZ}
	desiredrot = {WL_ROT.x, WL_ROT.y, WL_ROT.z}
	posZ= math.sin(math.rad(WL_ROT.y+90))*(s1*3)
	posX= math.cos(math.rad(WL_ROT.y+90))*(s1*3)
	desiredpos = {posA.x-posX, posA.y, posA.z+posZ}
	checkPos3()

end

function checkPos3()
local success = Global.call("epicMoveWingmate",{pos3,desiredpos, desiredrot})
	if not success then
		print('Left Support needs to break off')-- Break from wing, and mark for movement after all other wing members have been moved		
		shipActive_LS = false
		rejoinButton()
	end
	return true
end

function landBS()
local WL_POS = shipGUID_WL.getPosition()
local WL_ROT = shipGUID_WL.getRotation()
	posZ= math.sin(math.rad(WL_ROT.y+90))*(s1*3)
	posX= math.cos(math.rad(WL_ROT.y+90))*(s1*3)
	desiredpos = {WL_POS.x-posX,WL_POS.y,WL_POS.z+posZ}
	desiredrot = {WL_ROT.x, WL_ROT.y, WL_ROT.z}
checkPos4()
end

function checkPos4()
local success = Global.call("epicMoveWingmate",{pos4,desiredpos, desiredrot})
	if not success then
		print('Back Support needs to break off')-- Break from wing, and mark for movement after all other wing members have been moved
	end
		return true
end


function landRS()
local WL_POS = shipGUID_WL.getPosition()
local WL_ROT = shipGUID_WL.getRotation()
	posZ= math.sin(math.rad(WL_ROT.y))*(s1*3)
	posX= math.cos(math.rad(WL_ROT.y))*(s1*3)
	posA = {x=WL_POS.x-posX, y=WL_POS.y, z=WL_POS.z+posZ}
	desiredrot = {WL_ROT.x, WL_ROT.y, WL_ROT.z}
	posZ= math.sin(math.rad(WL_ROT.y+90))*(s1*3)
	posX= math.cos(math.rad(WL_ROT.y+90))*(s1*3)
	desiredpos = {posA.x-posX, posA.y, posA.z+posZ}
	checkPos5()
end
function checkPos5()
local success = Global.call("epicMoveWingmate",{pos5,desiredpos, desiredrot})
	if not success then
		print('Right Support needs to break off')-- Break from wing, and mark for movement after all other wing members have been moved
		shipActive_RS = false
		rejoinButton()
	end
	return true
end	

local failedShip = nil
function _fallOut()

local rejoinButton = {['function_owner'] = failedShip, ['click_function'] = 'rejoin', ['label'] = 'Reform', ['position'] = {0, 0.25, -0.75}, ['rotation'] =  {0, 0, 0}, ['width'] = 200, ['height'] = 150, ['font_size'] = 100}
--find who needs to be removed from the roster.
	if failedShip == shipGUID_LF then 
	shipActive_LF = false 
	shipGUID_LF.createButton(rejoinButton)
	end
	if failedShip == shipGUID_RF then 
	shipActive_RF = false 
	shipGUID_RF.createButton(rejoinButton)
	end
	if failedShip == shipGUID_BS then 
	shipActive_BS = false 
	shipGUID_BS.createButton(rejoinButton)
	end
	if failedShip == shipGUID_LS then 
	shipActive_LS = false 
	shipGUID_LS.createButton(rejoinButton)
	end
	if failedShip == shipGUID_RS then 
	shipActive_RS = false 
	shipGUID_RS.createButton(rejoinButton)
	end
end

function rejoin()
	if self.getGUID() == shipGUID_LF then 
		shipActive_LF = true 
		landLF()
	end
	if self.getGUID() == shipGUID_RF then 
		shipActive_RF = true 
		landRF()
	end
	if self.getGUID() == shipGUID_BS then 
		shipActive_BS = true 
		landBS()
	end
	if self.getGUID() == shipGUID_LS then 
		shipActive_LS = true 
		landLS()
	end
	if self.getGUID() == shipGUID_RS then 
		shipActive_RS = true 
		landRS()
	end
end