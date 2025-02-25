-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- All cross-script-callable functions
-- ~~~~~~

-- "API" functions, to be working in TTS:
-- Must take one and only one argument, of table type
-- Must return one and only one value
-- Cannot receive/return function or thread type values
-- Have to be called after callee loads (its onLoad triggers)


-- Perform a move using a standard move command
-- Argument: { code = moveCode, ship = shipReference, ignoreCollisions = [true/false] }
-- Return: TRUE if move completed, FALSE if overlap prevented ship from moving
-- Return:                         FALSE if invalid (non-move) command or ship not ready
function API_PerformMove(argTable)
    local type = XW_cmd.CheckCommand(argTable.code)
    if (type ~= 'move' and type ~= 'actionMove') or not XW_cmd.isReady(argTable.ship) then
        return false
    end
    return MoveModule.PerformMove(argTable.code, argTable.ship, argTable.ignoreCollisions)
end

function API_Relocate(argTable)
    Relocator:execute(argTable.ship, argTable.moveType)
end

-- Queue tokens near a ship for movement
-- To be called immediately before changing position of a ship
-- Argument: { ship = shipRef, finPos = { pos = finalPosition, rot = finalRotation} }
-- finPos field may be nil (no position set after wait then)
function API_QueueShipTokensMove(argTable)
    -- Set the ship busy if it's not to try prevent double ready later
    if XW_cmd.isReady(argTable.ship) then
        XW_cmd.SetBusy(argTable.ship)
    end
    local lockFun = nil
    if argTable.noLock == true then
        lockFun = function(ship)
            ship.unlock()
        end
    end
    TokenModule.QueueShipTokensMove(argTable.ship)
    MoveModule.WaitForResting(argTable.ship, argTable.finPos, lockFun)
end

-- Indicate dropping of a bomb token from outside Global
-- Argument: { token = droppedTokenRef }
-- Return: true if token snapped, false otherwise
function API_BombTokenDrop(argTable)
    return BombModule.OnTokenDrop(argTable.token)
end

function API_MineDrop(argTable)
    BombModule.CheckMineDroppedOverlapping(argTable.mine, argTable.ship)
end

function API_IsShipType(argTable)
    return ObjType.IsOfType(argTable.ship, 'ship')
end

function API_AssignToken(argTable)
    TokenModule.AssignToken(argTable.token, argTable.ship)
end

function API_RemoveTokenOnFlip(argTable)
    TokenModule.removeOnFlip(argTable.object, argTable.player)
end

function API_GetPlayerConfig(argTable)
    return ConfigManager.GetConfig(argTable.player_color, argTable.param_name)
end

function API_GetGlobalConfig(argTable)
    return ConfigManager.GetConfig("global", argTable.param_name)
end

function API_SetPlayerConfig(argTable)
    return ConfigManager.SetConfig(argTable.player_color, argTable.param_name, argTable.value)
end

function API_SetGlobalConfig(argTable)
    return ConfigManager.SetConfig("global", argTable.param_name, argTable.value)
end

function API_SpawnTemplate(args)
    return DialModule.SpawnTemplate(args.ship, args.dialCode)
end

function API_FindNearestShip(args)
    return FindNearestShip(args.object, args.max_distance, args.filter_function)
end

function API_GetClosestPointToShip(argTable)
    local size = argTable.ship.getTable('Data').Size or "small"
    local segments = ArcCheck.GetOwnArcLineSegments(argTable.ship, ArcCheck.arc_line_segments[size].full.segments)

    local closestRange = 100000
    local closestDistance = nil
    for _, segment in pairs(segments) do
        distance = ArcCheck.GetDistanceBetweenLineSegmentAndPoint(segment, argTable.point, false)
        --print("Dist: " .. tostring(distance.length))
        if distance.length < closestRange then
            closestRange = distance.length
            closestDistance = distance
        end
    end
    return closestDistance
end

function API_AssignDial(argTable)
    DialManagerModule.assignDial(argTable.dial, argTable.ship, argTable.player)
end

function API_SetDial(argTable)
    if argTable.set then
        DialManagerModule.setDial(argTable.dial)
    else
        DialManagerModule.unSetDial(argTable.dial)
    end
end

function API_IsAllDialsSet(argTable)
    return DialManagerModule.isAllDialsSet(argTable.player)
end

function API_ClearPosition(argTable)
    TokenModule.ClearPosition(argTable.pos, argTable.reach, argTable.ship)
end

function API_GetTokenSize()
    return TokenModule.tokenSize
end

function API_SetTokenSize(argTable)
    TokenModule.tokenSize = argTable.size
end

function API_StreamAnnounce(argTable)
    StreamManagerModule.Announce(argTable.text, argTable.player)
end

function API_ToggleAnnouncement(argTable)
    StreamManagerModule.Announce(argTable.text, argTable.player)
end

function API_XWcmd_isReady(argTable)
    local ship = argTable.ship

    return ship.resting and ship.getDescription() == "" and XW_cmd.isReady(ship)
end

--------
-- OBJECT SPECIFIC VARIABLES
-- These variables are set per object and have some specific meaning
-- Some may be linked to another so caution must be kept when modifying

-- objectType : varName         - val / val2 ... / valN     <- meaning
-- ship : 'hasDials'            - true / (false/nil)        <- Has assigned set of dials (ONLY informative) / Not
-- ship : 'slideOngoing'        - true / (false/nil)        <- Is in process of manually adjusting slide / Not
-- ship : 'cmdBusy'             - true / (false/nil)        <- Is currently processing some command / Not
-- ship : 'missingModelWarned'  - true / (false/nil)        <- Printed a warning that model is unrecognized (once) / Not yet
-- dial : 'slideOngoing'        - true / (false/nil)        <- Its ship in process of manually adjusting slide / Not
-- dial : 'assignedShip'        - shipRef / nil             <- Object reference to its owner / No owner
-- token : 'idle'               - false / (true/nil)        <- This token should be ignored when moving tokens / Not

--------
