local menu   = require("Dial.Menu")
local button = require("Dial.Button")
local proxy  = require("Dial.Proxy")
local Dim = require("Dim")

-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- Token for easy barrel rolls with StarViper Mk.II title
-- ~~~~~~


-- Scripted token properties
__XW_Token = false
__XW_TokenIdle = true
__XW_TokenType = 'helper:Dial'

self.addTag("Flippable")

-- Ref to assigned ship if there is one
assignedShip = nil
playerColor = nil
playerTeam = nil
teamVisibility = ""
openPanel = nil
openButton = nil
openColor = "#555555"
closedColor = "#222222"
setMan = nil
prevMan = nil
manButtonId = nil

clickMode = true
proxyMode = true
finished_setup = true

timeoutDuration = 5

clickTimer = nil

arcCommands = {
    Range1 = "r1",
    Range2 = "r2",
    Range3 = "r3",
    FrontArc = "f",
    LeftArc = "sl",
    RightArc = "sr",
    RearArc = "b",
    BullseyeArc = "bull",
    FullFrontArc = "ff",
    FullBackArc = "fb",
    FixedArc = "f"
}

arcToCmnd = {
    front = "f",
    left = "sl",
    back = "b",
    right = "sr",
    frontback = "frontback",
    leftright = "leftright",
    fullfront = "ff",
    fullback = "fb",
    bull = "bull",
}

mountToId = {
    main = "1",
    front = "1",
    rear = "2"
}

-- Save self state
function onSave()
    if assignedShip ~= nil then
        local state = {
            assignedShipGUID = assignedShip.getGUID(),
            owningPlayer = playerColor,
            owningPlayerTeam = playerTeam,
            clickMode = clickMode,
            proxyMode = proxyMode,
            timeoutDuration = timeoutDuration
        }
        return JSON.encode(state)
    end
end

firstSet = false
setSinceTemplatePlaced = false -- True if the user has set a movement since the movement template was last placed on the table
templatePlaced = false         -- True if the movement template is currently on the table (as far as we can tell based on just dial button clicks, anyway)

exOptions = {}
exOptSelected = false
exOptValue = {}
exOptButtons = { "ExOpt1", "ExOpt2", "ExOpt3", "ExOpt4", "ExOpt5", "ExOpt6", "ExOpt7", "ExOpt8", "ExOpt9", "ExOpt10",
    "ExOpt11", "ExOpt12", "ExOpt13" }


-- Restore self state
function onLoad(savedData)
    --self.UI.setCustomAssets(assetTable)
    clearDial()
    if savedData ~= nil and savedData ~= "" then
        state = JSON.decode(savedData)
        clickMode = state.clickMode
        proxyMode = state.proxyMode
        playerColor = state.owningPlayer
        playerTeam = state.playerTeam
        local savedShipGuid = state.assignedShipGUID
        assignedShip = nil

        local dial = self
        if savedShipGuid then
            Wait.frames(
                function()
                    local savedShip = getObjectFromGUID(savedShipGuid)
                    if savedShip then
                        dial.call("assignShip", { ship = savedShip })
                    end
                end, 1)
        end
    end

    toggleClickMode(clickMode)
    menu.addToggleItem("clickMode", "click mode", toggleClickMode)
    menu.addToggleItem("proxyMode", "proxy mode", toggleProxyMode)
    menu.addToggleItem(nil, "Reset dial", resetDial, true)
    menu.update()
end

function clearOpenPanel()
    if openPanel ~= nil then
        self.UI.hide(openPanel)
        self.UI.setAttribute(openButton, "color", closedColor)
        self.UI.setAttribute(openButton, "textColor", "#FFFFFF")
    end
    openPanel = nil
    openButton = nil
end

function clearDial()
    self.UI.hide('TalonPanel') -- Talon has to come before CenterFU which it is inside -- hide doesn't work when the parent is already hidden (could also use active=false instead)
    self.UI.hide("ExecutionOptionsPanel")
    self.UI.hide("CenterFD")
    self.UI.hide('CenterFU')
    self.UI.hide('Setup')
    self.UI.hide("ManWin")
    self.UI.hide('arcPanel')
    self.UI.hide('relocPanel')
    self.UI.hide('tokenPanel')
    self.UI.hide("setManPeekPanel")
    winStat = false
    clearOpenPanel()
end

function onFlip()
    local face_down = not self.is_face_down
    redraw(face_down)
end

function redraw(face_down)
    if assignedShip ~= nil then
        if not face_down then
            clearDial()
            self.UI.setAttribute("Main", "rotation", "0 0 0")
            if finished_setup then
                self.UI.show("CenterFD")
            else
                self.UI.show('Setup')
            end
            button.setAttributeFacing("Setup", "Down")
            button.setAttributeFacing("proxyPanel", "Down")
        else
            clearDial()
            manSetting()
            if finished_setup then
                self.UI.show("CenterFU")
            else
                self.UI.show('Setup')
            end
            button.setAttributeFacing("Setup", "Up")
            button.setAttributeFacing("proxyPanel", "Up")
        end
    end
end

function getManeuverIcons(maneuver)
    if maneuver:sub(1, 1) == 'w' then
        manColor = "White"
    elseif maneuver:sub(1, 1) == 'b' then
        manColor = "Blue"
    elseif maneuver:sub(1, 1) == 'r' then
        manColor = "Red"
    elseif maneuver:sub(1, 1) == 'p' then
        manColor = "Purple"
    end

    if maneuver:sub(-1, -1) == 't' then
        manType = "Talon"
    elseif maneuver:sub(-1, -1) == 's' then
        if maneuver:sub(2, 2) == 't' then
            manType = "TurnSloop"
        else
            manType = "Sloop"
        end
    elseif maneuver:sub(-1, -1) == 'z' then
        if maneuver:sub(2, 2) == 't' then
            manType = "TurnSlip"
        else
            manType = "BankSlip"
        end
    elseif maneuver:sub(-1, -1) == 'r' then
        if maneuver:sub(2, 2) == 'b' then
            manType = "ReverseBank"
        else
            manType = "ReverseStraight"
        end
    elseif maneuver:sub(2, 2) == 't' then
        manType = "Turn"
    elseif maneuver:sub(2, 2) == 'b' then
        manType = "Bank"
    elseif maneuver:sub(2, 2) == 's' then
        manType = "Straight"
    elseif maneuver:sub(2, 2) == 'k' then
        manType = 'K'
    end

    local Char = maneuver:find("%d")
    manSpeed = maneuver:sub(Char, Char)

    if maneuver:sub(3, 3) == 'l' then
        manBear = "L"
    elseif maneuver:sub(3, 3) == 'r' then
        manBear = "R"
    else
        manBear = ""
    end
    if manSpeed == "0" and manType == "Straight" then
        manType = 'Stall'
    end

    return { speed = "Speed" .. manSpeed, type = manColor .. manType .. manBear }
end

function manSelect(p, option, id)
    if spectReturn(p) == true or option == false then
        return
    end
    firstSet = true
    self.UI.setAttribute("ManBtnGroup", "allowSwitchOff", "false")
    manButtonId = id
    curMan = string.lower(id)
    icons = getManeuverIcons(curMan)
    speedIcon = icons.speed
    typeIcon = icons.type
    setMan = curMan:sub(2)
    befAft = '_B'
end

function manSetting()
    if setStat == true then
        self.UI.setAttribute("TypeIcon", "image", typeIcon)
        self.UI.setAttribute("SpeedIcon", "image", speedIcon)
        self.UI.setAttribute("TypeIcon", "active", "true")
        self.UI.setAttribute("SpeedIcon", "active", "true")
        self.UI.setAttribute("MoveBtn", "active", "true")
        self.UI.setAttribute("MoveBtn", "textColor", "#FFFFFF")
        self.UI.setAttribute("UndoBtn", "active", "false")
        self.UI.setAttribute("Templ", "active", "true")
        self.UI.setAttribute("Templ", "textColor", "#222222") -- Make the text same color as the background since goal is to only have the type / speed icons showing anyway
    else
        self.UI.setAttribute("TypeIcon", "active", "false")
        self.UI.setAttribute("SpeedIcon", "active", "false")
        self.UI.setAttribute("MoveBtn", "active", "false")
        self.UI.setAttribute("UndoBtn", "active", "false")
        self.UI.setAttribute("Templ", "textColor", "#FFFFFF")

        -- Hide the template button when there isn't a maneuver set, since it's confusing and undefined in some cases what template should be shown then
        if not templatePlaced then
            self.UI.setAttribute("Templ", "active", "false")
        end
    end
    if firstSet == false then
        self.UI.setAttribute("TypeIcon", "active", "false")
        self.UI.setAttribute("SpeedIcon", "active", "false")
        self.UI.setAttribute("MoveBtn", "active", "false")
        self.UI.setAttribute("UndoBtn", "active", "false")
        self.UI.setAttribute("Templ", "textColor", "#FFFFFF")

        -- Hide the template button when there isn't a maneuver set, since it's confusing and undefined in some cases what template should be shown then
        if not templatePlaced then
            self.UI.setAttribute("Templ", "active", "false")
        end
    end

    -- Remove template if a new maneuver has been set since it was shown, since it could be confusing to still show the old template (and to show the new one you would have to click the button twice, which would be confusing)
    if setSinceTemplatePlaced and templatePlaced then
        deleteTemplate()
    end
end

function Undo(p)
    if spectReturn(p) == true then
        return
    end
    assignedShip.setDescription("q")
    befAft = '_B'
    self.UI.setAttribute("UndoBtn", "active", "false")
    if setStat then
        return
    elseif prevMan:sub(-1, -1) ~= 't' or proxyMode then
        setMan = prevMan
        setStat = prevMan ~= ""
        if setStat then
            self.UI.setAttribute("MoveBtn", "active", "true")
            self.UI.setAttribute("MoveBtn", "textColor", "#FFFFFF")
            self.UI.setAttribute("TypeIcon", "active", "true")
            self.UI.setAttribute("SpeedIcon", "active", "true")
            self.UI.setAttribute("Templ", "active", "true")
        end
    else
        setMan = prevMan
        setStat = true
        self.UI.show("TalonPanel")
    end
end

function allignShip(P)
    if spectReturn(P) == true then
        return
    end
    rot = assignedShip.getRotation()
    modint, modfrac = math.modf(rot.y / 45)
    if modfrac < 0.5 then
        rot.y = modint * 45
    else
        rot.y = (modint + 1) * 45
    end
    assignedShip.setRotation(rot)
end

function placeShip(P)
    if spectReturn(P) == true then
        return
    end
    finished_setup = true
    assignedShip.setVar("finished_setup", true)
    assignedShip.call("initContextMenu")
    assignedShip.setLock(true)
    redraw(self.is_face_down)
end

setupRotations = {
    Rot1DegLBut = -1,
    Rot5DegLBut = -5,
    Rot225DegLBut = -22.5,
    Rot1DegRBut = 1,
    Rot5DegRBut = 5,
    Rot225DegRBut = 22.5,
}

function setupRot(P, option, id)
    if (option ~= '-1') or (spectReturn(P) == true) then
        return
    end
    local rot = assignedShip.getRotation()
    rot.y = rot.y + (setupRotations[id] or 0)
    assignedShip.setLock(true)
    assignedShip.setRotation(rot)
end

setupShifts = {
    AdjustFBut = vector(0, 0, -0.05),
    AdjustBBut = vector(0, 0, 0.05),
    AdjustLBut = vector(0.05, 0, 0),
    AdjustRBut = vector(-0.05, 0, 0),
}

function setupShift(P, option, id)
    if (option ~= '-1') or (spectReturn(P) == true) then
        return
    end
    pos = assignedShip.positionToWorld(setupShifts[id] or vector(0, 0, 0))
    assignedShip.setLock(true)
    assignedShip.setPosition(pos)
end

function performMove(P)
    if spectReturn(P) == true then
        return
    end
    if setMan ~= nil and setMan ~= "" then
        self.UI.setAttribute("MoveBtn", "active", "false")
        -- Check alternate execution options
        --print("curMan:" .. curMan)
        if exOptions[curMan] ~= nil and exOptSelected == false then
            setupAlternateExecutionPanel(P, exOptions[curMan])
        elseif setMan:sub(-1, -1) == 't' then
            if proxyMode then
                proxy_settings = {
                    ship_guid   = assignedShip.getGUID(),
                    move_code   = setMan,
                    offsets     = { front = 'ft', center = 't', back = 'bt' },
                    button_func = button.setProxyState,
                }
                proxy.spawn(proxy_settings)
                clearOpenPanel()
                exOptSelected = false
                setDial(P)
            else
                self.UI.show("TalonPanel")
                return
            end
        else
            self.UI.setAttribute("UndoBtn", "active", "true")
            self.UI.setAttribute("UndoBtn", "textColor", "#FFFFFF")
            assignedShip.setDescription(setMan)
            exOptSelected = false
            befAft = '_A'
            setDial(P)
        end
        prevMan = setMan
        setMan = nil
        Global.call("API_SetDial", { dial = self, set = false })
        self.UI.setAttribute(manButtonId, "isOn", "false")
    end
end

function setupAlternateExecutionPanel(P, executionOptions)
    self.UI.setAttribute("TypeIcon", "active", "false")
    self.UI.setAttribute("SpeedIcon", "active", "false")
    self.UI.setAttribute("Templ", "active", "false")
    self.UI.setAttribute("undoFU", "active", "false")
    self.UI.show("ExecutionOptionsPanel")
    for _, button in pairs(exOptButtons) do
        self.UI.setAttribute(button .. 'But', "active", "false")
    end
    for i, option in pairs(executionOptions) do
        self.UI.setAttribute(exOptButtons[i] .. "But", "active", "true")
        exOptValue[exOptButtons[i] .. 'But'] = option
        local icons = getManeuverIcons(option)
        self.UI.setAttribute(exOptButtons[i] .. "TypeIcon", "image", icons.type)
        self.UI.setAttribute(exOptButtons[i] .. "SpeedIcon", "image", icons.speed)
    end
end

function selectExecuteOption(P, option, id)
    if spectReturn(P) == true then
        return
    end
    self.UI.hide("ExecutionOptionsPanel")
    exOptSelected = true
    setMan = exOptValue[id]:sub(2)
    local icons = getManeuverIcons(exOptValue[id])
    self.UI.setAttribute("TypeIcon", "active", "true")
    self.UI.setAttribute("SpeedIcon", "active", "true")
    self.UI.setAttribute("Templ", "active", "true")
    self.UI.setAttribute("Templ", "textColor", "#222222")
    self.UI.setAttribute("undoFU", "active", "true")
    self.UI.setAttribute("undoFU", "textColor", "#FFFFFF")
    self.UI.setAttribute("TypeIcon", "image", icons.type)
    self.UI.setAttribute("SpeedIcon", "image", icons.speed)
    performMove(P)
end

function performTalon(P, option, id)
    if spectReturn(P) == true then
        return
    end

    self.UI.hide("TalonPanel")
    self.UI.setAttribute("UndoBtn", "active", "true")
    self.UI.setAttribute("UndoBtn", "textColor", "#FFFFFF")
    if id == "TalonMidBtn" then
        assignedShip.setDescription(setMan)
    elseif id == "TalonReaBtn" then
        talonMove = setMan:sub(1, 3) .. "b" .. setMan:sub(-1, -1)
        assignedShip.setDescription(talonMove)
    elseif id == "TalonForBtn" then
        talonMove = setMan:sub(1, 3) .. "f" .. setMan:sub(-1, -1)
        assignedShip.setDescription(talonMove)
    end
    exOptSelected = false
    befAft = '_A'
    setDial(P)
    prevMan = setMan
    setMan = nil
    Global.call("API_SetDial", { dial = self, set = false })
    self.UI.setAttribute(manButtonId, "isOn", "false")
end

function onPickUp(player_color)
    if assignedShip == nil then
        pColor = self.held_by_color
    end
end

-- Assign a ship to the dial
function assignShip(args)
    self.UI.setAttribute("CenterFD", "active", "true")
    self.UI.setAttribute("CenterFU", "active", "true")
    self.UI.setAttribute("arcPanel", "active", "true")
    self.UI.setAttribute("tokenPanel", "active", "true")
    self.UI.setAttribute("proxyPanel", "active", "true")
    self.UI.hide("proxyPanel")
    self.UI.setAttribute("relocPanel", "active", "true")
    self.UI.setAttribute("setManPeekPanel", "active", "true")
    assignedShip = args.ship
    Name = assignedShip.getName()
    self.setName(Name)
    finished_setup = assignedShip.getVar("finished_setup") or false
    --self.UI.setAttribute("DialName", Name)
    self.UI.setValue("Name", Name)
    self.UI.setValue("SetupName", Name)
    shipData = assignedShip.getTable("Data")
    if shipData.arcs and shipData.arcs.fixed then
        self.UI.setAttribute("FixedArc", "active", "true")
        arcCommands['FixedArc'] = "a"
    else
        self.UI.setAttribute("FixedArc", "active", "false")
    end
    if shipData.arcs and shipData.arcs.turret then
        local buttonname = "TurretArc"
        for mount, turret in pairs(shipData.arcs.turret) do
            local id = mountToId[mount]
            local command_id = id
            if mount == "main" then
                command_id = ""
            end
            self.UI.setAttribute("TurretArc" .. id, "active", "true")
            self.UI.setAttribute("TurretArc" .. id .. "Panel", "active", "true")
            if turret.type[1] == "doubleturret" then
                self.UI.setAttribute("TurretArc" .. id .. "Icon", "image", "DoubleTurretArc")
                arcCommands["RotateLeft" .. id] = "rot" .. command_id
                self.UI.setAttribute("RotateLeft" .. id, "active", "true")
            else
                arcCommands["RotateLeft" .. id] = "rotl" .. command_id
                self.UI.setAttribute("RotateLeft" .. id, "active", "true")
                arcCommands["RotateRight" .. id] = "rotr" .. command_id
                self.UI.setAttribute("RotateRight" .. id, "active", "true")
            end
            arcCommands["TurretArc" .. id] = "turret" .. command_id
        end
    end

    exOptions = shipData.executeOptions or {}
    self.UI.setAttribute("BackGround", "image", tostring(shipData['Faction']) .. "BG")
    for _, v in pairs(shipData['moveSet']) do
        self.UI.setAttribute(string.upper(v), "active", "true")
    end
    setMan = ""
    prevMan = ""
    local repos = false
    for _, v in pairs(shipData['actSet']) do
        if v == 'F' then
            self.UI.setAttribute('FocusBtn', 'active', 'true')
        elseif v == 'TL' then
            self.UI.setAttribute("TargetLockBtn", 'active', 'true')
        elseif v == 'E' then
            self.UI.setAttribute("EvadeBtn", 'active', 'true')
        elseif v == 'R' then
            self.UI.setAttribute("ReinforceBtn", 'active', 'true')
        elseif v == 'C' then
            self.UI.setAttribute("CalculateBtn", 'active', 'true')
        elseif v == 'CL' then
            self.UI.setAttribute("CloakBtn", 'active', 'true')
        elseif v == 'BR' then
            repos = true
            button.setBarrelRollState(proxyMode, true)
        elseif v == 'B' then
            repos = true
            self.UI.setAttribute("BoostFD", "active", "true")
            self.UI.setAttribute("BoostSBtn", "active", "true")
            self.UI.setAttribute("BoostRBtn", "active", "true")
            self.UI.setAttribute("BoostLBtn", "active", "true")
        elseif v == 'Ail' then
            repos = true
            self.UI.setAttribute("AileronFD", "active", "true")
            self.UI.setAttribute("AilSBtn", "active", "true")
            self.UI.setAttribute("AilRBtn", "active", "true")
            self.UI.setAttribute("AilLBtn", "active", "true")
        elseif v == 'Piv' then
            repos = true
            self.UI.setAttribute("PivotFD", "active", "true")
            self.UI.setAttribute("PivKBtn", "active", "true")
            self.UI.setAttribute("PivRBtn", "active", "true")
            self.UI.setAttribute("PivLBtn", "active", "true")
        elseif v == 'Dare' then
            repos = true
            self.UI.setAttribute("BoostFD", "active", "true")
            self.UI.setAttribute("BoostFD", "preferredWidth", "330")
            self.UI.setAttribute("Boost2FD", "preferredWidth", "330")
            self.UI.setAttribute("BoostLTBtn", "active", "true")
            self.UI.setAttribute("BoostRTBtn", "active", "true")
            self.UI.setAttribute("BoostLT2Btn", "active", "true")
            self.UI.setAttribute("BoostRT2Btn", "active", "true")
        elseif v == '2B' then
            repos = true
            self.UI.setAttribute("Boost2FD", "active", "true")
            self.UI.setAttribute("BoostS2Btn", "active", "true")
            self.UI.setAttribute("BoostL2Btn", "active", "true")
            self.UI.setAttribute("BoostR2Btn", "active", "true")
        elseif v == '2BR' then
            repos = true
            button.setBarrelRoll2State(proxyMode, true)
        elseif v == 'VR' then
            repos = true
            button.setViperBarrelRollState(proxyMode, true)
        elseif v == 'TR' then
            repos = true
            button.setTurnBarrelRollState(proxyMode, true)
        elseif v == "Nantex" then
            repos = true
            self.UI.setAttribute("BoostFD", "active", "true")
            self.UI.setAttribute("BoostSBtn", "active", "true")
            button.setBarrelRollState(proxyMode, true)
        end
    end

    if repos == false then
        self.UI.setAttribute("RelocMenu", "active", "false")
        self.UI.setAttribute("RelocMenuFU", "active", "false")
    end

    Global.call("API_AssignDial", { dial = self, ship = assignedShip, player = pColor })
    redraw(self.is_face_down)
end

-- Assign on drop near a small base ship
function onDropped()
    if assignedShip == nil then
        local spos = self.getPosition()
        local nearest = nil
        local minDist = Dim.Convert_mm_igu(80)
        for _, ship in pairs(getAllObjects()) do
            if ship.tag == 'Figurine' and ship.name ~= '' then
                local pos = ship.getPosition()
                local dist = math.sqrt(math.pow((spos[1] - pos[1]), 2) + math.pow((spos[3] - pos[3]), 2))
                if dist < minDist then
                    nearest = ship
                    minDist = dist
                end
            end
        end
        if nearest ~= nil then
            if pColor == "White" then
                printToAll("Please, pick a color before assigning dials")
            else
                assignedShip = nearest
                playerColor = pColor

                playerTeam = nil
                teamVisibility = ""
                for _, player in pairs(Player.getPlayers()) do
                    if player.color == playerColor then
                        if player.team ~= "None" then
                            playerTeam = player.team
                            teamVisibility = "|" .. playerTeam
                        end
                    end
                end

                nearest.setVar('owningPlayer', pColor)
                printToAll('Dial assigned to to ' .. nearest.getName(), { 0.3, 0.3, 1 })
                --printToAll('Controlled by the '.. playerColor .. ' player')
                --if playerTeam then
                --printToAll('Of the '.. tostring(playerTeam) .. ' team')
                --end

                --sprintToAll('')
                self.setRotation(nearest.getRotation())
                assignShip({ ship = nearest })
            end
        end
    end
end

-- functions called when buttons are pressed
function genericAction(a, b, c, d)
    print(a)
    print(b)
    print(c)
    print(d)
end

function focusTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Focus', playerColor, { remove = id ~= '-1' } })
end

function evadeTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Evade', playerColor, { remove = id ~= '-1' } })
end

function tlTok(p, id)
    if spectReturn(p) == true then
        return
    end
    if id == '-1' then
        Global.call('proxyPerformAction', { assignedShip, 'Target Lock', playerColor })
    end
end

function tractorTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Tractor', playerColor, { remove = id ~= '-1' } })
end

function jamTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Jam', playerColor, { remove = id ~= '-1' } })
end

function disarmTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Disarm', playerColor, { remove = id ~= '-1' } })
end

function cloakTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Cloak', playerColor, { remove = id ~= '-1' } })
end

function calcTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Calculate', playerColor, { remove = id ~= '-1' } })
end

function reinforceTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Reinforce', playerColor, { remove = id ~= '-1' } })
end

function stressTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Stress', playerColor, { remove = id ~= '-1' } })
end

function strainTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Strain', playerColor, { remove = id ~= '-1' } })
end

function depleteTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Deplete', playerColor, { remove = id ~= '-1' } })
end

function ionTok(p, id)
    if spectReturn(p) == true then
        return
    end
    Global.call('proxyPerformAction', { assignedShip, 'Ion', playerColor, { remove = id ~= '-1' } })
end

reposCommands = {
    BoostSBtn = "s1b",
    BoostLBtn = "bl1b",
    BoostRBtn = "br1b",
    BoostLTBtn = "tl1b",
    BoostRTBtn = "tr1b",
    BoostS2Btn = "s2b",
    BoostL2Btn = "bl2b",
    BoostR2Btn = "br2b",
    BoostLT2Btn = "tl2b",
    BoostRT2Btn = "tr2b",
    AilLBtn = "bl1",
    AilSBtn = "s1",
    AilRBtn = "br1",
    BarrelLFBtn = "rl1",
    BarrelLBtn = "rl2",
    BarrelLBBtn = "rl3",
    BarrelRFBtn = "rr1",
    BarrelRBtn = "rr2",
    BarrelRBBtn = "rr3",

    BarrelLF2Btn = "cl1",
    BarrelL2Btn = "cl2",
    BarrelLB2Btn = "cl3",
    BarrelRF2Btn = "cr1",
    BarrelR2Btn = "cr2",
    BarrelRB2Btn = "cr3",

    BarrelVLUBtn = "vlf2",
    BarrelVLDBtn = "vlb2",
    BarrelVRUBtn = "vrf2",
    BarrelVRDBtn = "vrb2",

    BarrelVTLUBtn = "vtlf2",
    BarrelVTLDBtn = "vtlb2",
    BarrelVTRUBtn = "vtrf2",
    BarrelVTRDBtn = "vtrb2",

}

function Repos(P, option, id)
    if (option ~= '-1') or (spectReturn(P) == true) then
        return
    end

    local move_code = reposCommands[id] or ""
    if proxyMode and proxy.isProxyable(move_code) then
        proxy_settings = {
            ship_guid   = assignedShip.getGUID(),
            move_code   = move_code,
            offsets     = { front = '1', center = '2', back = '3' },
            cancellable = not setStat,
            button_func = button.setProxyState,
        }
        proxy.spawn(proxy_settings)
        clearOpenPanel()
    else
        assignedShip.setDescription(move_code)
    end
end

function CancelProxy(player, option, id)
    proxy.cancel(assignedShip.getGUID())
end

function Arc(P, option, id)
    if spectReturn(P) then
        return
    end
    includeFriendlies = ""
    if (option ~= '-1') then
        includeFriendlies = "a"
    end
    assignedShip.setDescription((arcCommands[id] or "") .. includeFriendlies)
end

function pivK(p)
    if spectReturn(p) == true then
        return
    end
    assignedShip.setDescription('k0')
end

function pivR(p)
    if spectReturn(p) == true then
        return
    end
    assignedShip.setDescription('tr4')
end

function pivL(p)
    if spectReturn(p) == true then
        return
    end
    assignedShip.setDescription('tl4')
end

function Window(p)
    if winStat == nil then
        winStat = false
    end
    if spectReturn(p) == false then
        if winStat == false then
            winStat = true
            self.UI.show("ManWin")
            self.UI.setAttribute("ManWin", "visibility", playerColor .. teamVisibility .. "|Black")
            self.UI.setAttribute("ManBtnGroup", "active", "true")
            clearOpenPanel()
        else
            winStat = false
            self.UI.setAttribute("ManBtnGroup", "active", "false")
            self.UI.hide('ManWin')
        end
    end
end

function spectReturn(p)
    if p.color == 'Black' then
        return false
    elseif p.color == playerColor then
        return false
    elseif p.team == playerTeam then
        return false
    else
        return true
    end
end

function showSetMan(p)
    if spectReturn(p) == true then
        return
    end
    self.UI.show("setManPeekPanel")
    self.UI.setAttribute("setManPeekPanel", "visibility", playerColor .. teamVisibility)
    self.UI.setAttribute("setManTypeIcon", "image", typeIcon)
    self.UI.setAttribute("setManSpeedIcon", "image", speedIcon)
    self.UI.setAttribute("setManTypeIcon", "active", "true")
    self.UI.setAttribute("setManSpeedIcon", "active", "true")
    self.UI.setAttribute("setManPeekPanel", "position", "-100 -150 -50")
    self.UI.setAttribute("setManPeekPanel", "rotation", "180 180 0")
end

function hideSetMan(p)
    if spectReturn(p) == true then
        return
    end
    self.UI.hide("setManPeekPanel")
end

click_functions = {
    ArcMenu = {
        show = function() showArcMFD() end,
        hide = function() hideArcM() end
    },
    ArcMenuFU = {
        show = function() showArcMFU() end,
        hide = function() hideArcM() end
    },
    RelocMenu = {
        show = function() showRelocMFD() end,
        hide = function() hideRelocM() end
    },
    RelocMenuFU = {
        show = function() showRelocMFU() end,
        hide = function() hideRelocM() end
    },
    TokenMenu = {
        show = function() showTokMFD() end,
        hide = function() hideTokM() end
    },
    TokenMenuFU = {
        show = function() showTokMFU() end,
        hide = function() hideTokM() end
    },
}

hover_functions = {
    ArcMenu = function()
        stopClickTimer()
        showArcMFD()
    end,
    ArcMenuFU = function()
        showArcMFU()
        stopClickTimer()
    end,
    arcPanel = function()
        restartClickTimer()
    end,
    RelocMenu = function()
        showRelocMFD()
        stopClickTimer()
    end,
    RelocMenuFU = function()
        showRelocMFU()
        stopClickTimer()
    end,
    relocPanel = function()
        restartClickTimer()
    end,
    TokenMenu = function()
        showTokMFD()
        stopClickTimer()
    end,
    TokenMenuFU = function()
        showTokMFU()
        stopClickTimer()
    end,
    tokenPanel = function()
        restartClickTimer()
    end,
}

function toggleClickMode(enable)
    clickMode = enable

    self.UI.setAttribute("arcPanel", "raycastTarget", not clickMode)
    self.UI.setAttribute("tokenPanel", "raycastTarget", not clickMode)
    self.UI.setAttribute("relocPanel", "raycastTarget", not clickMode)
    if clickMode then
        timeoutDuration = 20
    else
        timeoutDuration = 2
    end

    menu.update()
end

function toggleProxyMode(enable)
    proxyMode = enable

    button.setBarrelRollState(proxyMode)
    button.setBarrelRoll2State(proxyMode)
    button.setViperBarrelRollState(proxyMode)
    button.setTurnBarrelRollState(proxyMode)
    menu.update()
end

function resetDial(enable)
    self.setName("Unassigned Dial")
    playerColor = nil
    playerTeam = nil
    finished_setup = false
    self.UI.setAttribute("setBtnFD", "active", "false")
    self.UI.setAttribute("setManPeekPanel", "active", "false")
    self.UI.setAttribute("moveWindow", "active", "true")
    self.UI.setAttribute("moveWindow", "textColor", "#FFFFFF")
    if manButtonId then
        self.UI.setAttribute(manButtonId, "isOn", "false")
    end
    Global.call("API_AssignDial", { dial = self, ship = nil })
    setStat = false
    setMan = nil
    prevMan = ""
    self.UI.setValue("Name", "")
    self.UI.setValue("SetupName", "")
    clearDial()
    assignedShip = nil
    self.script_state = nil
end

function stopClickTimer()
    if clickTimer then
        Wait.stop(clickTimer)
    end
end

function restartClickTimer()
    stopClickTimer()
    clickTimer = Wait.time(clickTimeout, timeoutDuration)
end

function clickTimeout()
    if openButton then
        click_functions[openButton].hide()
    end
    clickTimer = nil
end

function menuClick(p, option, id)
    if winStat or (not clickMode) or proxy.isActive() or spectReturn(p) == true then
        return
    end
    if openButton == id then
        click_functions[id].hide(p)
        stopClickTimer()
    else
        click_functions[id].show(p)
        restartClickTimer()
    end
end

function menuHover(p, option, id)
    if winStat or clickMode or proxy.isActive() or spectReturn(p) == true then
        return
    end
    hover_functions[id]()
end

function showTokMFD()
    self.UI.show("tokenPanel")
    self.UI.setAttribute("TokenMenu", "color", openColor)
    clearOpenPanel()
    openPanel = "tokenPanel"
    openButton = "TokenMenu"
    self.UI.setAttribute("tokenPanel", "position", "-360 -165 -25")
    self.UI.setAttribute("tokenPanel", "rotation", "180 180 0")
end

function showTokMFU()
    self.UI.show("tokenPanel")
    self.UI.setAttribute("TokenMenuFU", "color", openColor)
    clearOpenPanel()
    openPanel = "tokenPanel"
    openButton = "TokenMenuFU"
    self.UI.setAttribute("tokenPanel", "position", "360 -165 1")
    self.UI.setAttribute("tokenPanel", "rotation", "180 0 0")
end

function hideTokM()
    if openPanel == "tokenPanel" then
        self.UI.hide(openPanel)
        self.UI.setAttribute(openButton, "color", closedColor)
        self.UI.setAttribute(openButton, "textColor", "#FFFFFF")
        openPanel = nil
        openButton = nil
    end
end

function showArcMFD()
    self.UI.show("arcPanel")
    self.UI.setAttribute("ArcMenu", "color", openColor)
    clearOpenPanel()
    openPanel = "arcPanel"
    openButton = "ArcMenu"

    self.UI.setAttribute("arcPanel", "position", "340 -150 -25")
    self.UI.setAttribute("arcPanel", "rotation", "180 180 0")
end

function showArcMFU()
    self.UI.show("arcPanel")
    self.UI.setAttribute("ArcMenuFu", "color", openColor)
    clearOpenPanel()
    openPanel = "arcPanel"
    openButton = "ArcMenuFU"

    self.UI.setAttribute("arcPanel", "position", "-340 -150 1")
    self.UI.setAttribute("arcPanel", "rotation", "180 0 0")
end

function hideArcM()
    if openPanel == "arcPanel" then
        self.UI.hide(openPanel)
        self.UI.setAttribute(openButton, "color", closedColor)
        self.UI.setAttribute(openButton, "textColor", "#FFFFFF")
        openPanel = nil
        openButton = nil
    end
end

function showRelocMFD()
    self.UI.show("relocPanel")
    self.UI.setAttribute("RelocMenu", "color", openColor)
    clearOpenPanel()
    openPanel = "relocPanel"
    openButton = "RelocMenu"

    self.UI.setAttribute("relocPanel", "position", "0 -215 -25")
    self.UI.setAttribute("relocPanel", "rotation", "180 180 0")
end

function showRelocMFU()
    self.UI.show("relocPanel")
    self.UI.setAttribute("RelocMenuFu", "color", openColor)
    clearOpenPanel()
    openPanel = "relocPanel"
    openButton = "RelocMenuFU"

    self.UI.setAttribute("relocPanel", "position", "0 -215 1")
    self.UI.setAttribute("relocPanel", "rotation", "180 0 0")
end

function hideRelocM()
    if openPanel == "relocPanel" then
        self.UI.hide(openPanel)
        self.UI.setAttribute(openButton, "color", closedColor)
        self.UI.setAttribute(openButton, "textColor", "#FFFFFF")
        openPanel = nil
        openButton = nil
    end
end

function nextMan(P, opt, id)
    if spectReturn(P) == true then
        return
    end
    local dir = 1
    if id == "prevManBut" then
        dir = -1
    end
    for k, v in pairs(shipData.moveSet) do
        if v == curMan then
            local newman = k + dir
            if newman == 0 then
                newman = #shipData.moveSet
            elseif newman > #shipData.moveSet then
                newman = 1
            end
            manSelect(P, opt, shipData.moveSet[newman])
            self.UI.setAttribute(string.upper(curMan), "isOn", "true")
            return
        end
    end
    manSelect(P, opt, shipData.moveSet[1])
    self.UI.setAttribute(string.upper(curMan), "isOn", "true")
end

function setDial(P)
    if spectReturn(P) == false then
        if setMan and setMan ~= '' then
            if setStat == nil then
                setStat = false
            end

            if setStat == false then
                self.UI.setAttribute("setBtnFD", "color", playerColor)
                self.UI.setAttribute("setBtnFD", "active", "true")
                self.UI.setAttribute("setBtnFD", "textColor", "#FFFFFF")
                if (P.color == "Yellow") then
                    -- White text on yellow button is pretty hard to read, so for the Yellow player change the text to black instead
                    self.UI.setAttribute("setBtnFD", "textColor", "#000000")
                end
                self.UI.setAttribute("moveWindow", "active", "false")
                setStat = true
                setSinceTemplatePlaced = true
                printToAll(P.color .. " player has set the maneuver for " .. assignedShip.getName(), P.color)
                Global.call("API_SetDial", { dial = self, set = true })
                if winStat == true then
                    Window(P)
                end
            else
                --TODO: Now that the set dial and unset dial buttons are 2 different buttons, this file's code would probably be more readable with this function split in to setDial() and unsetDial()
                self.UI.setAttribute("setBtnFD", "active", "false")
                self.UI.setAttribute("setManPeekPanel", "active", "false")
                self.UI.setAttribute("moveWindow", "active", "true")
                self.UI.setAttribute("moveWindow", "textColor", "#FFFFFF")
                Global.call("API_SetDial", { dial = self, set = false })
                setStat = false
            end
        else
            print("Pick a maneuver before setting the dial")
        end
    end
end

function spawnTemplate(p)
    if spectReturn(p) == true then
        return
    end
    templMan = setMan or prevMan
    if templMan and templMan ~= '' then
        setSinceTemplatePlaced = false
        templatePlaced = not templatePlaced

        -- if a maneuver is not visible on dial, template button is only here to allow removal, and after that it can be hidden again
        if self.UI.getAttribute("SpeedIcon", "active") == "false" then
            self.UI.setAttribute("Templ", "active", "false")
        end

        Table = { [1] = assignedShip, [2] = 'spawnMoveTemplate:' .. templMan .. befAft, [3] = playerColor }
        Global.call("proxyPerformAction", Table)
    end
end

function deleteTemplate()
    templatePlaced = false
    Table = { [1] = assignedShip, [2] = 'deleteMoveTemplate', [3] = playerColor }
    Global.call("proxyPerformAction", Table)
end
