-- ~~~~~~
-- Script by joeshmoe554
--
-- Based on the dial script logic by dzikakulka
-- ~~~~~~


-- Scripted token properties
__XW_Token = false
__XW_TokenIdle = true
__XW_TokenType = 'helper:ManueverCard'

-- Ref to assigned ship if there is one
assignedShip = nil
frontImage = "http://nnxwing.com/Content/TTS/ManeuverCard/ManeuverCardFront.png"
backImage = "http://nnxwing.com/Content/TTS/ManeuverCard/ManeuverCardBack.png"
maneuversVisible = false
dataPadId = "a4dbbf"

-- Restore self state
function onLoad(savedData)
    clearDial()
end

function clearOpenPanel()
    if openpanel ~= nil then
        self.UI.hide(openpanel)
        self.UI.setAttribute(openbutton, "color", closedcolor)
        self.UI.setAttribute(openbutton, "textColor", "#FFFFFF")
    end
    openpanel = nil
    openbutton = nil
end

function clearDial()
    ShowManeuvers(false)
    winStat = false
    clearOpenPanel()

    -- Reset the card.
    local cardData = self.getCustomObject()
    cardData.face = frontImage
    self.setCustomObject(cardData)
end

-- Assign a ship to the dial
function assignShip(ship)
    assignedShip = ship
    shipData = assignedShip.getTable("Data")

    --self.UI.setValue("Name",Name)
    --self.UI.setValue("SetupName",Name)
    self.UI.setAttribute("BackGround", "image", tostring(shipData['Faction']).."BG")
    for k,v in pairs(shipData['moveSet']) do
        self.UI.setAttribute(string.upper(v), "active", "true")
    end

    ShowManeuvers(true)

    local dataPad = getObjectFromGUID(dataPadId)
    local shipDB = dataPad.getTable("masterShipDB")
    Name = shipDB[shipData.shipId].name
    self.setName(Name)

    local pilotDB = dataPad.getTable("masterPilotDB")
    local cardImage = backImage
    for key,pilot in pairs(pilotDB) do
        if pilot.ship_type == shipData.shipId and pilot.Faction == shipData['Faction'] then
            cardImage = "https://raw.githubusercontent.com/eirikmun/x-wing2.0-project-goldenrod/2.5/src/images/En/pilots/" .. pilot.XWS .. ".png"
            break
        end
    end

    local cardData = self.getCustomObject()
    cardData.face = cardImage
    self.setCustomObject(cardData)
end

-- Assign on drop near a small base ship
function onDropped()
    if assignedShip == nil then
        local nearest = Global.call("API_FindNearestShip", { object = self, max_distance = 90 })
        if nearest ~= nil then
            assignedShip = nearest
            assignShip(nearest)
        else
            ShowManeuvers(false)
        end
    end
end

function ShowManeuvers(show)
    if maneuversVisible ~= show then
        if show then
            self.UI.show("ManWin")
            self.UI.hide("NotSet")
        else
            self.UI.hide("ManWin")
            self.UI.show("NotSet")
        end
        maneuversVisible = show
    end
end

function DisplayTable(arg)
    output = ""
    for key, value in pairs(arg) do
        output = output .. "\n" .. key .. ": ";
        if type(value) == "table" then
            output = output .. DisplayTable(value)
        elseif type(value) == 'boolean' then
            if value then
                output = output .. "true"
            else
                output = output .. "false"
            end
        else
            output = output .. value
        end
    end

    return output
end
