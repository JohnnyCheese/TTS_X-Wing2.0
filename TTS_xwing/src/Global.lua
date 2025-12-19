-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: https://github.com/tjakubo2/TTS_xwing
--
-- Based on a work of: Flolania, Hera Vertigo
-- ~~~~~~

-- ~~~~~~
-- Code contributions
--  - Characted width data: Indimeco
--  - https://github.com/Indimeco/Tabletop-Simulator-Misc
-- ~~~~~~

-- Should the code execute print functions or skip them?
-- This should be set to false on every release
print_debug = false
cast_debug = false

bagGuids = {
    ['Accessories'] = '53ad3d', -- Accessories 81 items
    ['DiceBag']     = 'f0e7b9', -- Dice Bag 10 items
    ['ExtraAssets'] = 'a3690e', -- Extra Assets 19 items
    ['Fuse']        = '568727', -- Fuse Bag Infinite
    ['Obstacles']   = '203cb8', -- ObstacleBag 31 items
}

CompositeBase_GUID = '8c3322'
Straight_1_Bag_GUID = '637ad7'

TTS_print = print
function print(...)
    if print_debug == true then
        TTS_print(table.unpack({ ... }))
    end
end

function getSelectingPlayers(obj)
    local selectingPlayers = {}
    for _, p in ipairs(Player.getPlayers() or {}) do
        for _, o in ipairs(p.getSelectedObjects() or {}) do
            if o == obj then
                table.insert(selectingPlayers, p)
                break
            end
        end
    end
    return selectingPlayers
end

require("vscode/console")

function submerge(object, originalPos)
    if originalPos.y < 0 then
        object.setPosition(originalPos)
        object.setLock(true)
    end
end

function surface(object)
    local originalPos = object.getPosition()
    if originalPos.y < 0 then
        local sPos = originalPos:copy()
        sPos.y = -sPos.y
        object.setPosition(sPos)
        object.setLock(true)
    end
    return originalPos
end

function showMe(arg)
    local guid = type(arg) == "table" and arg[1] or arg
    local object = getObjectFromGUID(guid)
    if object == nil then
        print("Object not found.")
        return
    end
    local origPos = surface(object)
    local origColor = object.getColorTint()
    -- Highlight the object by changing its color tint
    object.setColorTint({ r = 1, g = 0, b = 0 }) -- Set to red for visibility

    -- Move the camera to focus on the object
    -- Adjusting the parameters might be necessary based on your specific use case
    local position = object.getPosition()
    position.y = position.y + 5 -- Raise the camera slightly above the object
    for _, player in ipairs(Player.getPlayers()) do
        player.lookAt({
            position = position,
            pitch = 60,   -- Angle of the camera looking down at the object
            distance = 10 -- Distance from the object (adjust as needed)
        })
    end

    -- Optionally, reset the color after a delay
    Wait.time(function()
        object.setColorTint(origColor) -- Reset to white or original color
        submerge(object, origPos)
    end, 5)                            -- Delay in seconds before the color reset happens
end

-- Standard libraries extentions
require("TTS_Lib.Util.Math")
require("TTS_Lib.Util.Table")
require("TTS_Lib.Util.String")

-- Vector manipulation
local Vect = require("TTS_Lib.Vector.Vector")

-- Standard event handling
local EventSub = require("TTS_Lib.EventSub.EventSub")

-- Object type abstraction
ObjType = require("TTS_Lib.ObjType.ObjType")

-- Save/load management
local SaveManager = require("TTS_Lib.SaveManager.SaveManager")

-- Component sizes, unit conversion methods
local Dim = require("Dim")

-- AI behaviour sets
local BehaviourDB = require("Game.HotAC.AI.BehaviourDB")

-- Dice control and dice_statistics
local DiceControlModule = require("Game.Component.Dice.DiceControl")

-- Arc checks
ArcCheck = require("Game.Mechanic.ArcCheck")
ArcCheck.Initialize()
CheckArc = ArcCheck.CheckArc

-- Ship proxy
local ShipProxyModule = require("Ship.ShipProxy")

-- Ship verification
local ShipVerification = require("Ship.ShipVerification")

-- ContextGui
local ContextGui = require("Player.ContextGui")

-- ConfigManager
local ConfigManager = require("Player.ConfigManager")

HotkeyModule = require("Player.HotkeyManager")
PlayerEventModule = require("Player.PlayerActionModule")
DialManagerModule = require("Dial.DialManager")
ShipProximityHider = require("Ship.ShipProximityHider")
StreamManagerModule = require("Player.StreamManager")
--StreamManagerModule.SetUI(self)
--StreamManagerModule.AddPresentation("Purple", "left")
--StreamManagerModule.AddPresentation("Blue", "right")

local GlobalGuiControl = require("Player.GlobalGuiControl")
local MoveData = require("Game.Mechanic.Movement.MoveData")
local AnnModule = require("Player.Announcements")
Maneuver = require("Game.Mechanic.Movement.Maneuver")
Relocator = Maneuver:new()

-- Modules API, must be loaded last
require("API")

function onSave()
    return SaveManager.onSave()
end

--------
-- MISC FUNCTIONS

-- Dumbest TTS issue ever workaround
function TTS_Serialize(pos)
    return { pos[1], pos[2], pos[3] }
end

ObjType.AddType('ship', function(obj)
    return (obj ~= nil) and (((obj.tag == 'Figurine') and (obj.getVar('__XW_Ship') == true)) or obj.hasTag('Ship'))
end)
ObjType.AddType('token', function(obj)
    return (obj.tag == 'Chip' or obj.tag == 'Coin' or (obj.getVar('__XW_Token') and obj.getVar('__XW_TokenIdle')))
end)
ObjType.AddType('assignable_token', function(obj)
    return (obj.getVar('__XW_Token') and obj.getVar('__XW_TokenIdle')) or obj.hasTag('Assignable')
end)
ObjType.AddType('dial', function(obj)
    return (obj.tag == 'Card' and XW_cmd.CheckCommand(obj.getDescription()) == 'move')
end)


-- Dud function for info buttons and not yet written sections where Lua complains about no code
function dummy()
    return
end

-- END MISC FUNCTIONS
--------


--------
-- COMMAND HANDLING MODULE
-- Sanitizes input (more like ignores anything not explicitly allowed)
-- Allows other modules to add available commands and passes their execution where they belong

XW_cmd = {}
XW_cmd.commandLUT = {}

-- Table of valid commands: their patterns and general types
XW_cmd.ValidCommands = {}

-- Add given regen expression as a valid command for processing
XW_cmd.AddCommand = function(cmdRegex, type)
    -- When adding available commands, assert beggining and end of string automatically
    if cmdRegex:sub(1, 1) ~= '^' then
        cmdRegex = '^' .. cmdRegex
    end
    if cmdRegex:sub(-1, -1) ~= '$' then
        cmdRegex = cmdRegex .. '$'
    end
    table.insert(XW_cmd.ValidCommands, { string.lower(cmdRegex), type })
end

-- Check if command is registered as valid
-- If it is return its type identifier, if not return nil
XW_cmd.CheckCommand = function(cmd)
    -- Trim whitespaces
    cmd = string.lower(cmd:match("^%s*(.-)%s*$"))
    local type = nil
    if XW_cmd.commandLUT[cmd] then
        return XW_cmd.commandLUT[cmd]
    end
    -- Resolve command type
    for k, pat in pairs(XW_cmd.ValidCommands) do
        if cmd:match(pat[1]) ~= nil then
            type = pat[2]
            break
        end
    end
    XW_cmd.commandLUT[cmd] = type
    return type
end

-- (special function)
-- Purge all save data (everything that goes to onSave)
XW_cmd.AddCommand('purgeSave', 'special')
XW_cmd.PurgeSave = function()
    MoveModule.moveHistory = {}
end

-- (special function)
-- Print ship hitory
XW_cmd.AddCommand('hist', 'special')
XW_cmd.ShowHist = function(ship)
    MoveModule.PrintHistory(ship)
end

-- (special function)
-- Check for typical issues with a ship
XW_cmd.AddCommand('diag', 'special')
XW_cmd.Diagnose = function(ship)
    -- Check and unlock XW_cmd lock if it's on
    local issueFound = false
    if ObjType.IsOfType(ship, 'ship') ~= true then
        return
    end
    if XW_cmd.isReady(ship) ~= true then
        XW_cmd.SetReady(ship)
        printToAll(ship.getName() .. '\'s deadlock resolved', { 0.1, 0.1, 1 })
        issueFound = true
    end
    -- Delete lingering buttons
    if ship.getButtons() ~= nil then
        ship.clearButtons()
        printToAll(ship.getName() .. '\'s lingering buttons deleted', { 0.1, 0.1, 1 })
        issueFound = true
    end
    -- If ship has unrecognized model and said that before, remind
    if ship.getVar('missingModelWarned') == true then
        printToAll(
            'I hope you do remember that I told you about ' ..
            ship.getName() .. '\'s model being unrecognized when it was first moved/used', { 0.1, 0.1, 1 })
        issueFound = true
    end
    -- No issues found
    if issueFound ~= true then
        printToAll(ship.getName() .. ' looks OK', { 0.1, 1, 0.1 })
    end
end

-- Process provided command on a provided object
-- Return true if command has been executed/started
-- Return false if object cannot process commands right now or command was invalid
XW_cmd.Process = function(obj, cmd)
    -- Trim whitespaces
    cmd = cmd:match("^%s*(.-)%s*$")

    -- Resolve command type
    local type = XW_cmd.CheckCommand(cmd)

    -- Process special commands without taking lock into consideration
    if type == nil then
        return false
    elseif type == 'special' then
        if cmd == 'diag' then
            XW_cmd.Diagnose(obj)
        elseif cmd == 'purgeSave' then
            XW_cmd.PurgeSave()
        elseif cmd == 'hist' then
            XW_cmd.ShowHist(obj)
        end
    end

    -- Return if not ready, else process
    if XW_cmd.isReady(obj) ~= true then
        return false
    end

    if type == 'demoMove' then
        MoveModule.DemoMove(cmd:sub(3, -1), obj)
    elseif type == 'move' or type == 'actionMove' then
        local info = MoveData.DecodeInfo(cmd, obj)
        MoveModule.PerformMove(cmd, obj)
    elseif type == 'historyHandle' then
        if cmd == 'q' or cmd == 'undo' then
            MoveModule.UndoMove(obj)
        elseif cmd == 'z' or cmd == 'redo' then
            MoveModule.RedoMove(obj)
        elseif cmd == 'keep' then
            MoveModule.SaveStateToHistory(obj, false)
        elseif cmd:sub(1, 8) == 'restore#' then
            local keyNum = tonumber(cmd:sub(9, -1))
            MoveModule.Restore(obj, keyNum)
        end
    elseif type == 'dialHandle' then
        if cmd == 'sd' then
            DialModule.SaveNearby(obj)
        elseif cmd == 'rd' then
            DialModule.RemoveSet(obj)
        end
    elseif type == 'rulerHandle' then
        RulerModule.ToggleRuler(obj, string.upper(cmd))
    elseif type == 'action' then
        DialModule.PerformAction(obj, cmd)
    elseif type == 'bombDrop' then
        BombModule.ToggleDrop(obj, cmd)
    elseif type == 'StrikeAI' then
        AIModule.EnableStrikeAI(obj, cmd)
    elseif type == 'AI' then
        AIModule.EnableAI(obj, cmd)
    elseif type == 'rotate' then
        DialModule.RotateArc(obj, cmd)
    elseif type == 'turretarc' then
        DialModule.TurretArc(obj, cmd)
    elseif type == 'fixedarc' then
        DialModule.FixedArc(obj, cmd)
    elseif type == 'renameShip' then
        if obj.getVar('SetName') then
            obj.call('SetName', { name = cmd:match("name%s*(.*)") })
        end
    elseif type == 'changeInitiative' then
        if obj.getVar('SetInitiative') then
            obj.call('SetInitiative', { init = cmd:sub(5, -1) })
        end
    end
    obj.setDescription('')
    return true
end

-- Is object not processing some commands right now?
XW_cmd.isReady = function(obj)
    return (obj.getVar('cmdBusy') ~= true)
end

-- Flag the object as processing commands to ignore any in the meantime
XW_cmd.SetBusy = function(obj)
    if XW_cmd.isReady(obj) ~= true then
        print('Nested process on ' .. obj.getName())
    end
    obj.setVar('cmdBusy', true)
end

-- Flag the object as ready to process next command
XW_cmd.SetReady = function(obj)
    if XW_cmd.isReady(obj) == true then
        print('Double ready on ' .. obj.getName())
    end
    obj.setVar('cmdBusy', false)
end

--------
-- MOVEMENT DATA MODULE
-- Stores and processes data about moves
-- NOT aware of any ship position, operation solely on relative movements
-- Used for feeding data about a move to a higher level movement module
-- Exclusively uses milimeters and degrees for values, needs external conversion

-- Possible commands supported by this module
XW_cmd.AddCommand('[sk][012345][r]?', 'move')    -- Straights/Koiograns + stationary moves
XW_cmd.AddCommand('b[rle][0123][strz]?', 'move') -- Banks + segnor and reverse versions
XW_cmd.AddCommand('t[rle][01234][srfbtz]?[t]?', 'move')

XW_cmd.AddCommand('r[123]?[rle][123]?', 'actionMove')   --New Roll Done
XW_cmd.AddCommand('v[123]?[rle][fb][123]?',  'actionMove')
XW_cmd.AddCommand('vt[rle][fb][123]?', 'actionMove')
XW_cmd.AddCommand('c[srle][123]?', 'actionMove')        --New Cloak side
XW_cmd.AddCommand('e[srle][fbrle][123]?', 'actionMove') --New Echo Cloack


XW_cmd.AddCommand('x[rle][fb]?', 'actionMove')  -- Barrel rolls
XW_cmd.AddCommand('s[12345]b', 'actionMove')    -- Boost straights
XW_cmd.AddCommand('b[rle][123]b', 'actionMove') -- Boost banks
XW_cmd.AddCommand('t[rle][123]b', 'actionMove') -- Boost turns
XW_cmd.AddCommand('a[12]', 'actionMove')        -- Adjusts

--XW_cmd.AddCommand('c[srle]', 'actionMove')      -- Decloaks side middle + straight
--XW_cmd.AddCommand('c[rle][fb]', 'actionMove')   -- Decloaks side forward + backward
--XW_cmd.AddCommand('ch[rle][fb]', 'actionMove')  -- Echo's bullshit
--XW_cmd.AddCommand('chs[rle]', 'actionMove')     -- Echo's bullshit, part 2
--XW_cmd.AddCommand('vr[rle][fb]', 'actionMove')  -- StarViper Mk.II rolls

XW_cmd.AddCommand('name[ *]*[-a-zA-Z" %d]*', 'renameShip')
XW_cmd.AddCommand('init[ ]?[01234567]', 'changeInitiative')

-- AI Module:
debug_AI = false
AIModule = {}

-- 2000mm is the length between opposite corners of an epic table.
AIModule.max_distance = 2000

-- Information about the most recently executed maneuver by an AI ship. This is
-- stored just before we move the ship, and it used when the ship comes to rest
-- and the callback is fired. Yes, this is a bit of a hack, and yes, I'd love to
-- do it a better way.
AIModule.current_move = {}
AIModule.current_move.in_progress = false
AIModule.current_move.Reset = function()
    AIModule.current_move.take_action = false
    AIModule.current_move.move_code = nil
    AIModule.current_move.collision = false
    AIModule.current_move.difficulty = nil
    AIModule.current_move.obstacle = false
    AIModule.current_move.stress_count = 0
    AIModule.current_move.is_ionised = false
    AIModule.current_move.target = nil
    AIModule.current_move.probes = {}
    AIModule.current_move.action_stack = {}
    AIModule.current_move.actions = {}
end
AIModule.current_move.Reset()



-- Possible commands supported by the AI module
XW_cmd.AddCommand('ai', 'AI')                    -- Enables the AI on the selected ship
XW_cmd.AddCommand('[sS]trike[ ]*.*', 'StrikeAI') -- List of Strike AI Targets

-- Description function to add the AI functions to a ship
AIModule.EnableAI = function(ship, command)
    if not ship.getVar('isAi') then
        ship.setVar('isAi', true)
        ship.AddContextMenuItem("AI move and action",
            function(argument)
                Global.call("PerformAIManeuver", { ['ship'] = ship, ['take_action'] = true })
            end, false)
        ship.AddContextMenuItem("AI move only",
            function(argument)
                Global.call("PerformAIManeuver", { ['ship'] = ship, ['take_action'] = false })
            end, false)
    end
end

-- This function is intended to parse a comma-separated list of targets'
-- name or guid and update the ship's Strike Targets table to store those strings.
AIModule.EnableStrikeAI = function(ship, cmd)
    --  cmd = "strike guid1,guid2,name3,name4"
    AIModule.EnableAI(ship, 'AI')
    local pattern = '[sS]trike[ ]*(.*)' -- Captures the list after 'strike '

    local targetsString = cmd:match(pattern)
    if targetsString then
        local targets = {}
        for arg in targetsString:gmatch("([^,]+)") do
            -- Split by comma
            local target = arg:trim()
            if target ~= "" then
                table.insert(targets, target)
            end
        end

        -- Check if any valid targets were added
        if #targets > 0 then
            ship.setTable('StrikeTargets', targets)
            printToAll(tostring(ship.getName()) .. " has Strike Target list: " .. table.concat(targets, ", "),
                Color.Yellow)
        else
            printToAll(tostring(ship.getName()) .. " has no Strike Targets, reverting to Attack AI.", Color.Yellow)
            ship.setTable('StrikeTargets', nil)
        end
    else
        printToAll("Invalid format or no targets specified.", Color.Yellow)
        ship.setTable('StrikeTargets', nil)
    end
end

-- Sanity check, make sure that all the moves for this ship are actually
-- possible. It won't fix every issue but it'll find most typos. This is not
-- called except when debugging.
AIModule.ValidateMoveTables = function(ship)
    local ship_id = ship.getTable('Data')['shipId']
    local behaviour = BehaviourDB.GetRuleSet().GetShipBehaviour(ship)

    for arc, range_tables in pairs(behaviour.move_table) do
        for range, move_table in pairs(range_tables) do
            for roll, move_code in pairs(move_table) do
                if AIModule.GetMoveDifficulty(ship, move_code) == nil then
                    print("Couldn't find maneuver " ..
                        move_code ..
                        " from ship " ..
                        tostring(ship_id) ..
                        "'s move table. Arc: " .. arc .. ", range: " .. range .. ", roll: " .. tostring(roll))
                end
            end
        end
    end
end

--[[ AI target selection

Target selection is the simplest of the AI submodules. It consists of a set of
functions for different selection types, each of which takes the querying ship
and returns a target ship. There are also some helper methods for filtering
targets by various metrics.
]]

-- Target selection functions. These take a ship, and return a target ship
AIModule.TargetSelectionFunctions = {}
AIModule.TargetSelectionFunctions.ClosestInArc = function(ship)
    local targets = AIModule.GetSortedTargetsInArc(ship)

    -- Get the first ship as it's already been sorted by distance
    for i, target in pairs(targets) do
        return target.ship
    end

    return nil
end

AIModule.TargetSelectionFunctions.Closest = function(ship)
    local potential_targets = ArcCheck.GetPotentialTargets(ship, AIModule.max_distance)

    local closest_distance = nil
    local closest_target = nil
    for i, target in pairs(potential_targets) do
        local distance = Vect.Length(ship.getPosition() - target.GetPosition())
        if closest_distance == nil or distance < closest_distance then
            closest_distance = distance
            closest_target = target
        end
    end

    return closest_target
end

AIModule.TargetSelectionFunctions.LockedInRange = function(ship)
    local potential_targets = AIModule.GetSortedTargetsInArc(ship, 'all')
    potential_targets = table.sieve(potential_targets, AIModule.FilterInRange)

    local closest_distance = nil
    local closest_target = nil
    for i, target in pairs(potential_targets) do
        -- Is this ship locked by us?
        if AIModule.HasTargetLockOnShip(ship, target.ship) then
            local distance = Vect.Length(ship.getPosition() - target.ship.GetPosition())
            if closest_distance == nil or distance < closest_distance then
                closest_distance = distance
                closest_target = target.ship
            end
        end
    end

    return closest_target
end

AIModule.TargetSelectionFunctions.ClosestInArcLowerInitiative = function(ship)
    local initiative = ship.getTable('Data')['initiative']
    local targets = AIModule.GetSortedTargetsInArc(ship)

    -- Get the first ship with a lower initiative as it's already been sorted by
    -- distance.
    for i, target in pairs(targets) do
        if (target.ship.getTable('Data')['initiative'] < initiative) then
            return target.ship
        end
    end

    return nil
end

-- Only choose ships that are in arc and between ranges 1-3
AIModule.FilterInArc = function(el)
    if el.in_arc == false then
        return false
    end

    return true;
end

-- Only choose ships that are between range one and three
AIModule.FilterInRange = function(el)
    if el.closest.range < 1 or el.closest.range > 3 then
        return false
    end

    return true;
end

-- Assumed to have been filtered first
AIModule.SortTargetsByAIDesirability = function(e1, e2)
    if e1.closest ~= nil and e2.closest ~= nil then
        if e1.closest.length < e2.closest.length then
            return true
        elseif e1.closest.length > e2.closest.length then
            return false
        end
    end

    return e1.ship.getGUID() > e2.ship.getGUID()
end

AIModule.GetSortedTargetsInArc = function(ship, arc)
    local targets = ArcCheck.GetTargetsInRelationToArc(ship, arc or 'front')
    targets = table.sieve(targets, AIModule.FilterInArc)
    targets = table.sieve(targets, AIModule.FilterInRange)
    table.sort(targets, AIModule.SortTargetsByAIDesirability)
    return targets
end

AIModule.HasTargetLockOnShip = function(locking_ship, locked_ship)
    local lock_tokens = locked_ship.call("GetTokens", { type = "targetLock" })
    for j, token in pairs(lock_tokens or {}) do
        if token.GetName() == locking_ship.GetName() then
            -- TODO: this really should be guid
            return true
        end
    end

    return false
end

AIModule.IsStrikeTarget = function(ship, target_ship)
    if (ship == nil or target_ship == nil) then
        return false;
    end

    -- Only Strike AI ships have Strike Targets defined
    local strikeTargets = ship.getTable('StrikeTargets') or {}

    local targetName = target_ship.getName():trim()
    local targetGUID = target_ship.getGUID():trim()

    -- Check if the target is in the list of strike targets by name or GUID
    for _, nameOrGUID in ipairs(strikeTargets) do
        if nameOrGUID == targetName or nameOrGUID == targetGUID then
            return true -- Found the designated strike target
        end
    end

    return false -- No match found
end

AIModule.IsStrikeShip = function(ship)
    local strikeTargets = ship.getTable('StrikeTargets')
    local isStrikeAI = strikeTargets ~= nil and next(strikeTargets) ~= nil
    return isStrikeAI
end

-- This function checks if a target lock action should be skipped based on Strike AI
AIModule.SkipTargetLock = function(locking_ship, target_ship)
    -- Only Strike AI ships have Strike Targets defined
    local isStrikeAI = AIModule.IsStrikeShip(locking_ship)

    -- Check whether the target is in the ship's list of designated strike targets
    local isStrikeAITarget = AIModule.IsStrikeTarget(locking_ship, target_ship)

    -- Skip target lock as it's not a designated strike target
    return isStrikeAI and not isStrikeAITarget
end

AIModule.TargetForStrikeAI = function(ship)
    local isStrikeAI = AIModule.IsStrikeShip(ship)
    if not isStrikeAI then
        -- only Strike AI ships run this targeting logic
        print("This is not a Strike AI Ship. Abort special targeting.")
        return nil
    end
    print("This is a Strike AI Ship. Using Strike targeting.")

    local strikeTargetNames = ship.getTable('StrikeTargets') or {}

    if #strikeTargetNames == 0 then
        print("No Strike targets defined for " .. ship.getName())
        return nil
    end

    -- Get potential_targets as a table with: distance, arc, and ship.
    local potential_targets = ArcCheck.GetTargetsInRelationToArc(ship, "all", nil, 9, true)

    -- Extract from potential targets only those listed as Strike Targets
    local strike_targets = {}
    for _, target in ipairs(potential_targets) do
        if (AIModule.IsStrikeTarget(ship, target.ship)) then
            -- Give preference to an already locked target
            if (AIModule.HasTargetLockOnShip(ship, target.ship)) then
                return target.ship
            end
            table.insert(strike_targets, target)
        end
    end

    -- Sort the Strike Targets by distance to the Strike AI ship
    table.sort(strike_targets, AIModule.SortTargetsByAIDesirability)

    -- Return the closest Strike Target, if any
    if #strike_targets > 0 then
        local strike_target = strike_targets[1].ship
        printToAll(tostring(ship.getName()) .. " found Strike AI target: '" .. tostring(strike_target.getName()) .. "'",
            Color.Yellow)
        return strike_target
    end
    return nil
end


--[[ AI maneuver selection

The maneuver selection is the main submodule of the AI, as well as the one that
ties most of the others together. It is home to one of the entry points,
"PerformAIManever". The main function, AIModule.PerformManeuver, uses the
target selection functions to pick a target, then plots a maneuver based on
the move tables in BehaviourDB.ttslua. It also cover stress, ion, and obstacle
avoidance.

Worth noting is that due to having to wait for ships to finish moving, part of
the functionality of AIModule.PerformManeuver had to be split out to a callback
function, AIModule.ManeuverPostShipRest. This handles everything after the
maneuver is executed, including calling the action submodule.

It also includes various helper functions for searching through and transforming
manveuvers.
]]
function PerformAIManeuver(args)
    local ship = args.ship
    local take_action = args.take_action

    AIModule.PerformManeuver(ship, take_action)
end

AIModule.PerformManeuver = function(ship, take_action)
    if AIModule.current_move.in_progress then
        printToAll("Can't perform AI maneuver while another ship is moving.", color(1.0, 1.0, 0.2, 0.9))
        return
    end

    --AIModule.ValidateMoveTables(ship)
    AIModule.current_move.Reset()
    AIModule.current_move.stress_count = TokenModule.GetShipTokenCount(ship, "Stress")
    AIModule.current_move.take_action = take_action
    local stress = AIModule.current_move.stress_count > 0

    local rule_set = BehaviourDB.GetRuleSet()

    local ship_id = ship.getTable('Data')['shipId']
    local ship_behaviour = rule_set.GetShipBehaviour(ship)

    if ship_behaviour ~= nil then
        printToAll('Performing AI routine for ' .. ship.GetName(), color(1.0, 1.0, 0.2, 0.9))
        local move_code = nil

        -- Find this ship's target.
        local target_ship = AIModule.TargetForStrikeAI(ship)
        if (target_ship == nil) then
            for _, target_selection_function in ipairs(ship_behaviour.target_selection) do
                target_ship = AIModule.TargetSelectionFunctions[target_selection_function](ship)
                if target_ship ~= nil then
                    break
                end
            end
        end
        AIModule.current_move.target = target_ship

        -- Check if we're ionised.
        local is_ionised = AIModule.IsIonised(ship)
        AIModule.current_move.is_ionised = is_ionised

        if target_ship == nil then
            -- TODO: This is undefined behaviour, and highly unlikely to happen.
            -- Should it default to a 2 straight?
            printToAll('Failed to find target')
        elseif is_ionised == true then
            move_code = 's1'
            printToAll('Ionised, skipping movement selection')
        else
            -- Find out the arc that the target is in.
            local target_arc = nil
            local arc_parts = nil

            local ship_size = ship.getTable("Data").Size or 'small'
            if rule_set.usesBullseyeArc then
                -- First do a check to see if the ship is in our bullseye.
                -- Move the bullseye position ahead because it's in the middle of
                -- range ruler rather than one end. Could this be moved into the
                -- GetBullseyeTargets function?
                local bullseye_position = vector(ArcCheck.bullseye_data.pos[ship_size][1],
                    ArcCheck.bullseye_data.pos[ship_size][2],
                    ArcCheck.bullseye_data.pos[ship_size][3] + Dim.Convert_mm_igu(AIModule.max_distance / 2) -
                    (ArcCheck.bullseye_data.size[3] / 2))
                local bullseye_targets = ArcCheck.GetBullseyeTargets(ship, bullseye_position, AIModule.max_distance)
                for i, bullseye_target in pairs(bullseye_targets) do
                    if bullseye_target == target_ship then
                        target_arc = 'bullseye'
                        arc_parts = { 'front' }
                        break
                    end
                end
            end

            if target_arc == nil then
                -- We have our target ship. Now we do some vector maths to get
                -- the angle pointing from our ship to the target ship.
                local ship_facing = Vect.RotateDeg({ 0, 0, -1 }, ship.GetRotation().y)
                local ship_to_target = target_ship.GetPosition() - ship.getPosition()
                local angle_to_target = Vect.AngleDeg(ship_facing, ship_to_target)

                -- angleToTarget is normalised between 0 and 180, to work out if
                -- if it's pointing to our left or our right we need to get the
                -- dot product of the shipToTarget vector and the tangent to our
                -- facing.
                local ship_facing_tangent = { ship_facing[3], 0, -ship_facing[1] }
                local tangent_dot_product = Vect.DotProd(ship_to_target, ship_facing_tangent)
                if tangent_dot_product < 0 then
                    angle_to_target = angle_to_target * -1
                end

                arc_result = rule_set.degreesToArc(angle_to_target)
                target_arc = arc_result.target_arc
                arc_parts = arc_result.arc_parts
            end

            -- Find the range bracket - one of closing, fleeing, distant, or
            -- stress.
            local range_bracket = nil
            if stress then
                range_bracket = 'stress'
                printToAll(' Selected target: ' ..
                    target_ship.getName() .. ', in the ' .. target_arc .. ' arc, while stressed.')
            else
                local target_range = nil
                -- Find the range, if we haven't got it already.
                -- TODO: If a ship is at range 0, then treat it as range 1 and
                -- behind our ship. (pg 19, "Touching")
                if target_range == nil then
                    -- TODO: Wrap up this code in a re-useable function
                    local own_line_segments = {}
                    for i, arc in ipairs(arc_parts) do
                        local segments = ArcCheck.GetOwnArcLineSegments(ship,
                            ArcCheck.arc_line_segments[ship_size][arc]["segments"])
                        for k, segment in ipairs(segments) do
                            table.insert(own_line_segments, segment)
                        end
                    end

                    local target_line_segments = {}
                    for i, arc in ipairs(arc_parts) do
                        local segments = ArcCheck.GetTargetLineSegmentsInArc(ship, target_ship,
                            ArcCheck.arc_line_segments[ship_size][arc]["degrees"])
                        for k, segment in ipairs(segments) do
                            table.insert(target_line_segments, segment)
                        end
                    end

                    if #target_line_segments ~= 0 then
                        local closest = nil
                        closest, _ = ArcCheck.GetDistanceBetweenLineSegments(own_line_segments, target_line_segments)
                        target_range = closest.range
                    end
                end

                -- If we're at range 2, then we need to check if the target is
                -- moving towards us (closing) or moving away from us (fleeing)
                target_closing = nil
                closing_text = '.'
                if target_range == 2 then
                    local target_ship_facing = Vect.RotateDeg({ 0, 0, -1 }, target_ship.GetRotation().y)
                    local target_to_ship = ship.getPosition() - target_ship.GetPosition()
                    local angle_to_ship = Vect.AngleDeg(target_ship_facing, target_to_ship)

                    if (angle_to_ship < 90) then
                        target_closing = true
                        closing_text = ' and closing.'
                    else
                        target_closing = false
                        closing_text = ' and fleeing.'
                    end
                end

                printToAll(' Selected target: ' ..
                    target_ship.getName() ..
                    ', in the ' .. target_arc .. ' arc at range ' .. tostring(target_range) .. closing_text)

                -- Get the move for our situation.
                -- Convert our target's range and facing into a range bracket.
                range_bracket = 'distant'
                if (target_range <= 1 or (target_range == 2 and target_closing == true)) then
                    range_bracket = 'near'
                elseif (target_range == 3 or (target_range == 2 and target_closing == false)) then
                    range_bracket = 'far'
                end
            end

            -- Check if we need to flip the facing and the final move.
            local flip_move = ship_behaviour.move_table[target_arc] == nil
            if (flip_move) then
                target_arc = rule_set.flipArc(target_arc)
            end

            -- Roll the d6, and keep substracting 1 until we find a move.
            local d6_roll = math.random(6)
            while move_code == nil and d6_roll > 0 do
                move_code = ship_behaviour.move_table[target_arc][range_bracket][d6_roll]
                d6_roll = d6_roll - 1
            end

            -- If we had to flip the arc, then also flip the resulting move.
            if (flip_move) then
                if string.find(move_code, 'l') then
                    move_code = string.gsub(move_code, 'l', 'r')
                elseif string.find(move_code, 'r') then
                    move_code = string.gsub(move_code, 'r', 'l')
                end
            end
        end

        AIModule.current_move.move_code = move_code

        if move_code ~= nil then
            -- Check for collisions.
            local move_info = MoveData.DecodeInfo(move_code, ship)
            local probe_data = MoveModule.MoveProbe.TryFullMove(move_info, ship, MoveModule.GetFullMove)
            AIModule.current_move.collision = probe_data.collObj ~= nil
            if probe_data.collObs ~= nil then
                printToAll(' Tried ' .. move_code .. ', hit an obstacle')
                AIModule.current_move.obstacle = true
                -- We've hit an obstacle! If we aren't ionised then We'll try to
                -- swerve.
                if is_ionised == false then
                    -- We pick up to two maneuvers that are the closest to our
                    -- current maneuver, and possible for our ship and stress
                    -- level. Whichever of these will get us closer to our
                    -- target is the one that we try. If that move avoids an
                    -- obstacle, then we choose it instead, otherwise we stick
                    -- with our original maneuver.
                    -- TODO: deal with reverse moves
                    local potential_swerve_moves = {}

                    local selected_swerve_move_code = nil
                    local non_colliding_move_codes = {}
                    if improved_ai then
                        selected_move_through_manouvre = nil
                        if move_info.type == 'straight' then
                            potential_swerve_moves = { 'bl' .. swerve_speed, 'br' .. swerve_speed }
                        elseif move_info.type == 'bank' then
                            potential_swerve_moves = { 't' .. string.sub(move_info.dir, 1, 1) .. swerve_speed, 's' ..
                            swerve_speed }
                        elseif move_info.type == 'turn' then
                            potential_swerve_moves = { 'b' .. string.sub(move_info.dir, 1, 1) .. swerve_speed }
                        end
                        local valid_moves = AIModule.TrySwerveOptions(ship, potential_swerve_moves, stress == false)

                        for _, valid_move in pairs(valid_moves) do
                            local swerve_probe_data = MoveModule.MoveProbe.TryFullMove(valid_move, ship,
                                MoveModule.GetFullMove)
                            if swerve_probe_data.collObs == nil then
                                table.insert(non_colliding_move_codes, swerve_move_info)
                            elseif swerve_probe_data then
                            end
                        end
                    else
                        local swerve_speed = tostring(math.max(1, math.min(3, move_info.speed)))
                        if move_info.type == 'straight' then
                            potential_swerve_moves = { 'bl' .. swerve_speed, 'br' .. swerve_speed }
                        elseif move_info.type == 'bank' then
                            potential_swerve_moves = { 't' .. string.sub(move_info.dir, 1, 1) .. swerve_speed, 's' ..
                            swerve_speed }
                        elseif move_info.type == 'turn' then
                            potential_swerve_moves = { 'b' .. string.sub(move_info.dir, 1, 1) .. swerve_speed }
                        end

                        local swerve_moves = {}
                        for _, potential_swerve_move_code in ipairs(potential_swerve_moves) do
                            -- If we can't do this move, then get the closest move that
                            -- we can do and try that instead. This may be multiple
                            -- moves, for example if a two-bank is impossible then we
                            -- may be able to try a one-bank and a three-bank. They're
                            -- both the same distance from the original so we'll try
                            -- both.
                            local nearest_move_codes = AIModule.GetNearestMoves(ship, potential_swerve_move_code,
                                stress == false)
                            for _, nearest_move_code in ipairs(nearest_move_codes) do
                                table.insert(swerve_moves, nearest_move_code)
                            end
                        end

                        -- Loop through all of the possible swerve moves, and find out
                        -- which one will get us the closest to our target. This is the
                        -- maneuver that we'll try again with.
                        local closest_swerve_move_code = nil
                        local closest_swerve_distance = nil
                        for _, swerve_move_code in ipairs(swerve_moves) do
                            local post_swerve = MoveModule.GetFullMove(swerve_move_code, ship)
                            local post_swerve_position = Vector(post_swerve.pos[1], post_swerve.pos[2],
                                post_swerve.pos[3])
                            local distance = Vect.Length(post_swerve_position - target_ship.GetPosition())
                            if closest_swerve_distance == nil or distance < closest_swerve_distance then
                                closest_swerve_distance = distance
                                selected_swerve_move_code = swerve_move_code
                            end
                        end
                    end

                    if selected_swerve_move_code ~= nil then
                        local swerve_move_info = MoveData.DecodeInfo(selected_swerve_move_code, ship)
                        local swerve_probe_data = MoveModule.MoveProbe.TryFullMove(swerve_move_info, ship,
                            MoveModule.GetFullMove)
                        if swerve_probe_data.collObs == nil then
                            move_code = selected_swerve_move_code
                            print(' Tried ' .. selected_swerve_move_code .. ', avoids the obstacle.')
                            AIModule.current_move.obstacle = false
                            AIModule.current_move.collision = swerve_probe_data.collObj ~= nil
                        else
                            print(' Tried ' .. selected_swerve_move_code .. ', still hits an obstacle.')

                            local obstacle_name = swerve_probe_data.collObs.getName()
                            if obstacle_name:find('Asteroid') then
                                -- Asteroid: Suffer 1 Hit damage and roll one attack die. On a Hit/Crit suffer 1 Hit damage
                                AIModule.current_move.obstacle = 'asteroid'
                                printToAll(
                                    ship.GetName() ..
                                    ' has collided with an Asteroid. Suffer 1 Hit damage and roll an attack die, suffer 1 additional Hit damage if a Hit or Critical is rolled.',
                                    color(1.0, 1.0, 0.2, 0.9))
                            elseif obstacle_name:find('Debris') then
                                -- Debris cloud: Take 1 Stress (happens in ManeuverPostShipRest), and roll one attack die. On a Hit suffer 1 Hit damage, on a Crit suffer 1 Crit damage
                                AIModule.current_move.obstacle = 'debris_field'
                                printToAll(
                                    ship.GetName() ..
                                    ' has collided with a Debris Field. Roll an attack die and suffer 1 Hit damage if a Hit is rolled or 1 Critical damage if a Critical is rolled.',
                                    color(1.0, 1.0, 0.2, 0.9))
                            elseif obstacle_name:find('Gas Cloud') then
                                -- Gas cloud: Break All Locks, gain 1 Strain (happens in ManeuverPostShipRest), and roll one attack die. On a Hit gain 1 Ion. On a Crit gain 3 Ion
                                AIModule.current_move.obstacle = 'gas_cloud'
                                printToAll(
                                    ship.GetName() ..
                                    ' has collided with a Gas Cloud. Break all Locks and roll an attack die, gain 1 Ion if a Hit is rolled or 3 Ions if a Critical is rolled.',
                                    color(1.0, 1.0, 0.2, 0.9))
                            elseif obstacle_name:find('Loose Cargo') then
                                -- Loose Cargo: Take 1 Strain (happens in ManeuverPostShipRest), and roll one attack die. On a Hit/Crit take 1 Stress
                                AIModule.current_move.obstacle = 'Loose Cargo'
                                printToAll(
                                    ship.GetName() ..
                                    ' has collided with a Loose Cargo. Roll an attack die and gain 1 Stress if if a Hit or Critical is rolled.',
                                    color(1.0, 1.0, 0.2, 0.9))
                            elseif obstacle_name:find('Spare') then
                                -- Spare Parts: Take 1 Strain (happens in ManeuverPostShipRest), and roll one attack die. On a Hit/Crit take 1 Stress
                                AIModule.current_move.obstacle = 'Spare'
                                printToAll(
                                    ship.GetName() ..
                                    ' has collided with Spare Parts. Roll an attack die and gain 1 Stress if if a Hit or Critical is rolled.',
                                    color(1.0, 1.0, 0.2, 0.9))
                            elseif obstacle_name:find('Chaff') then
                                -- Electro-chaff Cloud: Break All Locks, gain 1 Jam, and roll one attack die. On a Hit/Crit gain 1 Stress
                                AIModule.current_move.obstacle = 'chaff_cloud'
                                printToAll(
                                    ship.GetName() ..
                                    ' has collided with an Electro-chaff Cloud. Break all Locks, gain 1 Jam token, and roll an attack die. Gain 1 Stress if a Hit or Critical is rolled.',
                                    color(1.0, 1.0, 0.2, 0.9))
                            elseif obstacle_name:find('Blaze') then
                                -- Blaze: Roll one attack die. On a Hit/Crit suffer 1 Hit damage, on a Focus it gains 1 Stress token
                                AIModule.current_move.obstacle = 'Blaze'
                                printToAll(
                                    ship.GetName() ..
                                    ' has collided with a Blaze. Roll an attack die, suffer 1 Hit damage if a Hit or Critical is rolled, or gain 1 Stress if a Focus is rolled.',
                                    color(1.0, 1.0, 0.2, 0.9))
                            end
                        end
                    end
                end
            end

            -- TODO: Check for edge of table collision

            AIModule.current_move.difficulty = 'b'

            -- If we are ionised, then our move is always blue and we remove
            -- all of our ion tokens. Otherwise, we check for our difficulty.
            if is_ionised then
                while TokenModule.GetShipTokenCount(ship, 'Ion') > 0 do
                    -- BUG: This fails to identify the ion token stack if the
                    -- ship has exactly two stress tokens. If this occurs, the
                    -- ship also leaves behind the single remaining stress
                    -- token. I've done a bit of debugging and it appears that
                    -- when a token stack has "takeObject" called on it, it
                    -- changes from a 'chip' type to a 'generic' type. This
                    -- means that it isn't picked up by ObjType.GetNearOfType.
                    -- This does correct itself if the tokens are moved around
                    -- manually, so I assume that this is just a one-frame
                    -- occurence that wouldn't matter if the AI wasn't doing
                    -- everything at the same time. Potential fix: set
                    -- '__XW_Token' on the token afterwards?
                    DialModule.PerformAction(ship, 'Ion', ship.getVar('owningPlayer'), { ['remove'] = true })
                end
            else
                AIModule.current_move.difficulty = AIModule.GetMoveDifficulty(ship, move_code)
                if AIModule.current_move.difficulty == nil and ship_behaviour.special_move_difficulties then
                    -- Check for special moves that aren't part of the moveSet (config enabled manouvres)
                    AIModule.current_move.difficulty = ship_behaviour.special_move_difficulties[move_code] or 'w'
                end
            end
            -- Remove tokens _before_ the move - if we wait till afterwards then
            -- the tokens haven't caught up with the ship and the token module
            -- doesn't count them.
            if AIModule.current_move.difficulty == 'b' then
                if stress then
                    DialModule.PerformAction(ship, 'Stress', ship.getVar('owningPlayer'), { ['remove'] = true })
                    AIModule.current_move.stress_count = AIModule.current_move.stress_count - 1
                end
                if TokenModule.GetShipTokenCount(ship, 'Strain') > 0 then
                    DialModule.PerformAction(ship, 'Strain', ship.getVar('owningPlayer'), { ['remove'] = true })
                end
                if TokenModule.GetShipTokenCount(ship, 'Deplete') > 0 then
                    DialModule.PerformAction(ship, 'Deplete', ship.getVar('owningPlayer'), { ['remove'] = true })
                end
            end

            AIModule.current_move.in_progress = true
            if MoveModule.PerformMove(move_code, ship, false, AIModule.ManeuverPostShipRest, true) == false then
                -- If the PerformMove function retured false, then the ship
                -- could not move at all. In this case the post-rest callback
                -- won't be fired, so we'll call it ourselves. Also, just in
                -- case, set the collision flag.
                AIModule.current_move.collision = true
                AIModule.ManeuverPostShipRest(ship)
            end
        end
    else
        printToAll('No AI routine found for ship ID ' .. tostring(ship_id), color(1.0, 1.0, 0.2, 0.9))
    end
end

AIModule.ManeuverPostShipRest = function(ship)
    local action_selected = false;

    if AIModule.current_move.obstacle == 'debris_field' then
        DialModule.PerformAction(ship, 'Stress', ship.getVar("owningPlayer"))
    elseif AIModule.current_move.obstacle == 'gas_cloud' or AIModule.current_move.obstacle == 'Loose Cargo' or AIModule.current_move.obstacle == 'Spare' then
        DialModule.PerformAction(ship, 'Strain', ship.getVar("owningPlayer"))
    end

    if AIModule.current_move.difficulty == 'r' then
        DialModule.PerformAction(ship, 'Stress', ship.getVar("owningPlayer"))
    elseif AIModule.current_move.take_action == true and AIModule.current_move.stress_count == 0 and AIModule.current_move.collision == false and AIModule.current_move.obstacle == false then
        if AIModule.current_move.is_ionised then
            -- Ionised ships can only perform a focus action, if possible.
            for _, action in pairs(ship.getTable('Data')['actSet']) do
                if action == 'F' then
                    table.insert(AIModule.current_move.action_stack, 'focus')
                    action_selected = true
                    break
                end
            end
        else
            -- Check for Full Throttle and apply it now if appropriate.
            AIModule.ApplySpecialAbility(ship, 'fullThrottle')

            -- Run through the ship's actions and try them in order.
            action_selected = AIModule.SelectAction(ship)
        end
    end

    if action_selected then
        AIModule.ProcessActionStack(ship)
    else
        AIModule.current_move.in_progress = false
    end
end

--[[ AIModule.GetMoveDifficulty
This function takes a ship and a move code and returns the difficulty of the
move.

ship: TTS Object, the ship performing the move
move_code: String, the move code being queried.

returns a string corresponding to the difficulty of the move for the ship:
    'b': blue maneuver, reduces stress
    'w': white manuever, stress neutral
    'r': red maneuver, causes stress
    nil: maneuver is impossible for the given ship
]]
AIModule.GetMoveDifficulty = function(ship, move_code)
    move_set = ship.getTable('Data')['moveSet']
    for _, raw_move_code in ipairs(move_set) do
        local ship_move_difficulty = string.sub(raw_move_code, 1, 1)
        local ship_move_code = string.sub(raw_move_code, 2)

        if ship_move_code == move_code then
            return ship_move_difficulty
        end
    end
    return nil
end

AIModule.TrySwerveOptions = function(ship, move_codes, can_perform_red_maneuvers)
    print("AIModule.TrySwerveOptions: " .. move_codes[1] .. "red?: " .. tostring(can_perform_red_maneuvers))
    move_set = ship.getTable('Data')['moveSet']
    valid_moves = {}
    for _, raw_move_code in ipairs(move_set) do
        local move_difficulty = string.sub(raw_move_code, 1, 1)
        if move_difficulty ~= 'r' or can_perform_red_maneuvers then
            local move_code = string.sub(raw_move_code, 2)
            for _, test_move_code in ipairs(test_move_codes) do
                if test_move_code == move_code then
                    table.insert(valid_moves, move_code)
                end
            end
        end
    end
    return valid_moves
end

--[[ AIModule.GetNearestMoves
This function takes a ship and a move code, and returns the nearest maneuvers
that the ship is capable of. This may be the specified move. "Nearest" is
defined as closest in speed. We won't change the angle of the move. So for
example, if tr1 is passed in we will try tr2 and tr3, but not br1.

ship: TTS Object, the ship whose move set the function will be testing
move_code: String, the move code we want to get the closest maneuver to
can_perform_red_maneuvers: Boolean, if true then we will try red maneuvers,
    if false then we won't.

returns a table of move codes, as strings.
]]
--
AIModule.GetNearestMoves = function(ship, move_code, can_perform_red_maneuvers)
    print("AIModule.GetNearestMoves: " .. tostring(move_code) .. "red?: " .. tostring(can_perform_red_maneuvers))
    move_set = ship.getTable('Data')['moveSet']
    local move_info = MoveData.DecodeInfo(move_code, ship)
    local original_speed = move_info.speed

    -- We're going to loop through all of the ships moves and test for whether
    -- they're possible or not, and each loop we'll increase the speed offset
    -- by one. So 0 first, then -1 and +1, then -2 and +2, ... First we need
    -- to calculate the maximum number of loops we can make.
    local min_speed = 1
    local max_speed = 3
    if move_info.type == 'straight' then
        min_speed = 0
        max_speed = 5
    end
    max_offset = math.max(move_info.speed - min_speed, max_speed - move_info.speed)
    print("max_offset: " .. tostring(max_offset))
    -- Break the move code into sections so we can change the speed easily.
    local speed_position = string.find(move_code, tostring(original_speed))
    local move_pre_speed = string.sub(move_code, 1, speed_position - 1)
    local move_post_speed = string.sub(move_code, speed_position + 1)

    -- Loop through all the moves at the current offset. If we find at least
    -- one possible move, then return it.
    local speed_offset = 0
    while speed_offset <= max_offset do
        -- Prepare a table of 1-2 speeds to try this loop
        local test_speeds = {}
        if speed_offset == 0 then
            table.insert(test_speeds, original_speed)
        else
            for _, direction in ipairs({ 1, -1 }) do
                local test_speed = original_speed + speed_offset * direction
                if test_speed <= max_speed and test_speed >= min_speed then
                    table.insert(test_speeds, test_speed)
                end
            end
        end

        -- Turn the move speeds into move codes
        test_move_codes = {}
        for _, test_speed in ipairs(test_speeds) do
            print("test_speed: " .. move_pre_speed .. tostring(test_speed) .. move_post_speed)
            table.insert(test_move_codes, move_pre_speed .. tostring(test_speed) .. move_post_speed)
        end

        -- Loop through and check if these maneuvers are in our list
        move_replacements = {}
        for _, raw_move_code in ipairs(move_set) do
            local move_difficulty = string.sub(raw_move_code, 1, 1)
            if move_difficulty ~= 'r' or can_perform_red_maneuvers then
                local move_code = string.sub(raw_move_code, 2)
                for _, test_move_code in ipairs(test_move_codes) do
                    if test_move_code == move_code then
                        table.insert(move_replacements, move_code)
                    end
                end
            end
        end

        if #move_replacements ~= 0 then
            return move_replacements
        end

        speed_offset = speed_offset + 1
    end
    return {}
end

AIModule.ApplySpecialAbility = function(ship, ability)
    if AIModule.HasSpecialAbility(ship, ability) then
        if ability == 'fullThrottle' then
            -- Take an evade action if the ship fully executed (ie, no
            -- ship-to-ship collision) a 3-5 maneuver. We're assumed to not be
            -- stressed as this is only called right before actions are
            -- selected.
            if AIModule.current_move.collision == false then
                local move_code = AIModule.current_move.move_code
                if string.find(move_code, '3') or string.find(move_code, '4') or string.find(move_code, '5') then
                    printToAll(string.format('%s used full throttle to evade.', ship.getName()))
                    DialModule.PerformAction(ship, 'Evade', ship.getVar('owningPlayer'))
                    table.insert(AIModule.current_move.actions, 'evade')
                end
            end
        end
    end
end

AIModule.HasSpecialAbility = function(ship, ability)
    local ship_behaviour = BehaviourDB.GetRuleSet().GetShipBehaviour(ship)

    if ship_behaviour.special_rules == nil then
        return false
    end

    for _, ship_ability in pairs(ship_behaviour.special_rules) do
        if ability == ship_ability then
            return true
        end
    end

    return false
end

--[[ AIModule.IsIonised
This function returns whether or not a ship has enough ion tokens to ionise it.

ship: TTS Object, the ship performing the move

returns true if the ship is ionised, false otherwise.
]]
AIModule.IsIonised = function(ship)
    local ion_count = TokenModule.GetShipTokenCount(ship, "Ion")
    local ship_size = ship.getTable('Data').Size or 'small'
    if ship_size == 'small' then
        return ion_count >= 1
    elseif ship_size == 'medium' then
        return ion_count >= 2
    elseif ship_size == 'large' then
        return ion_count >= 3
    else
        return ion_count >= 6
    end

    return false
end

--[[ AI action selection

This submodule is smaller than the maneuver system, but probably more complex.
The main function is AIModule.AttemptAction, which takes an action definition
and checks if it is possible to execute. This involves checking the action's
pre-conditions (if the ship is in the right situation to attempt it), then if
the ship can actually execute the action, and finally checking the action's
post-conditions (if the action met with the desired result).

Where this gets complicated is the use of action probes, which are hypothetical
future positions of the ship. So if a ship makes a boost, then we create a probe
for each type of boost (bl1, s1, br1) and evaluate the post-conditions for each
probe. Where this gets _really_ complicated is when handling ships that can
string together more than one move action, such as the Interceptor's boost
action linking to a barrel roll action. For this we have to "expand" the first
set of probes by the second action - so the probe "bl1" expands into six more
probes: "bl1 > rl1", "bl1 > rl2", "bl1 > rl3", "bl1 > rr1", "bl1 > rr2", and
"bl1 > rr3". These permutations can get quite large (45 in the case of the
Interceptor) so these are cached where possible, but even so they can lead to
long execution times.

Finally, the actions are packed into a stack and processed one-by-one. Just like
the maneuver submodule these have to be dealt with in a callback to wait for the
TTS components to come to a rest.
]]

-- List which actions are expandable actions, and therefore have to be expanded
-- into a list of potential move codes or turret rotations. Any action not
-- listed here is assumed to be possible to made at any time (such as 'focus',
-- 'evade', etc)
AIModule.expandable_actions = {
    ['barrelRoll'] = { 'rl1', 'rr1', 'rl2', 'rr2', 'rl3', 'rr3' },
    ['boost'] = { 'bl1', 's1', 'br1' },
    ['rotateTurret'] = true -- These are calculated at run-time based on the turret type and current rotation.
}

-- Which arcs are adjacent to each arc, used for checking whether a ship is
-- wholly within an arc or not.
AIModule.arc_adjacencies = {
    ['front'] = { 'left', 'right' },
    ['back'] = { 'left', 'right' },
    ['left'] = { 'front', 'back' },
    ['right'] = { 'front', 'back' },
    ['leftRight'] = { 'front', 'back' },
    ['frontBack'] = { 'left', 'right' },
    ['fullfront'] = { 'fullback' },
    ['fullback'] = { 'fullfront' }
}

AIModule.full_action_names = {
    C = 'calculate',
    F = 'focus',
    TL = 'targetLock',
    E = 'evade',
    Rot = 'rotate',
    B = 'boost',
    BR = 'barrelRoll',
    VR = 'barrelRoll',
    RF = 'reinforce',
    RL = 'reload',
    Coord = 'coordinate',
    Jam = 'jam',
}

AIModule.SelectAction = function(ship)
    local ship_behaviour = BehaviourDB.GetRuleSet().GetShipBehaviour(ship)

    for _, action in ipairs(ship_behaviour.action_selection) do
        if AIModule.AttemptAction(ship, AIModule.current_move.target, action) then
            return true
        end
    end

    local ship_id = ship.getTable('Data')['shipId']
    printToAll('No AI actions found for ship ID ' .. tostring(ship_id) .. ', please make actions manually.',
        color(1.0, 1.0, 0.2, 0.9))
end

AIModule.AttemptAction = function(ship, target, action_definition)
    if action_definition.pass_through then
        AIModule.PrintActionDescription(action_definition.description, ship, target)
        return false
    end

    -- Generate a static action probe to start our moves from.
    local initial_probe = AIModule.GetActionProbe(ship)
    -- The list of possible probe moves, if any. Group by the set index.
    local probe_sets = {}
    -- The simple actions that we'll take, grouped by the set index.
    local simple_actions = {}

    -- Check for preconditions
    if AIModule.CheckProbeConditions(ship, target, initial_probe, action_definition.preconditions) == false then
        return false
    end

    -- There are three ways that an action can be defined in the behaviour
    -- database, so look for the shorthands and expand them out to the full
    -- definition if necessary.
    local action_set = action_definition.action
    if type(action_definition.action) == 'string' then
        action_set = { [1] = { [action_definition.action] = { stress = false } } }
    elseif action_definition.action[1] == nil then
        action_set = { [1] = action_definition.action }
    end

    -- Iterate over each item in the action list, attempting each one in turn.
    -- The action could be a move action (barrelRoll or boost) in which case
    -- we need to expand it into all possible moves.
    local action_includes_move_component = false
    for set_index, action_list in ipairs(action_set) do
        probe_sets[set_index] = {}
        simple_actions[set_index] = {}
        local initial_action = true

        for action, arguments in pairs(action_list) do
            -- Check for the stress shorthand in the arguments parameter.
            if type(arguments) ~= 'table' then
                arguments = { stress = arguments }
            end

            if AIModule.expandable_actions[action] ~= nil then
                -- Get or build the list of actions to expand into.
                local expanded_actions = AIModule.expandable_actions[action]
                if type(expanded_actions) == 'table' then
                    action_includes_move_component = true
                else
                    expanded_actions = {}
                    if action == 'rotateTurret' then
                        action_includes_move_component = true
                        local mount = arguments.mount or 'main'
                        local turret_rotation_options = AIModule.GetTurretRotationOptions(ship, mount)
                        for _, rotation in pairs(turret_rotation_options) do
                            table.insert(expanded_actions,
                                {
                                    ['action'] = 'rotateTurret',
                                    ['mount'] = mount,
                                    ['arc'] = rotation,
                                    stress = arguments
                                        .stress
                                })
                        end
                    end
                end

                local action_difficulty = 'w'
                if arguments.stress == true then
                    action_difficulty = 'r'
                end

                -- This action is an expanded action, so expand our current set
                -- of possible action probes further.
                if initial_action == true then
                    probe_sets[set_index] = table.join(probe_sets[set_index],
                        AIModule.ExpandActionProbe(ship, initial_probe, expanded_actions, action_difficulty))
                    initial_action = false
                else
                    new_probes = {}
                    for _, probe in pairs(probe_sets[set_index]) do
                        new_probes = table.join(new_probes,
                            AIModule.ExpandActionProbe(ship, probe, expanded_actions, action_difficulty))
                    end

                    probe_sets[set_index] = table.join(probe_sets[set_index], new_probes)
                end

                -- Set the set index on each probe.
                for _, probe in pairs(probe_sets[set_index]) do
                    probe.set_index = set_index
                end
            else
                -- There's one instance that we skip the action - we don't take
                -- a target lock action if the target is already locked. This is
                -- often handled by the preconditions anyway, but sometimes it's
                -- not so we double-check here. Also, range must be checked by
                -- the postconditions as doing a range check now would be from
                -- the post-maneuver position, not the post-action position.
                local skip_action = false
                if action == 'targetLock' then
                    skip_action = AIModule.HasTargetLockOnShip(ship, target)
                        or AIModule.SkipTargetLock(ship, target)
                end

                if skip_action == false then
                    table.insert(simple_actions[set_index], action)

                    if arguments.stress == true then
                        table.insert(simple_actions[set_index], 'stress')
                    end
                end
            end
        end
    end

    -- We merge together all of the probe sets into one table so we can rank
    -- them and compare them to each other. We need to select a random one, so
    -- we'll randomise the list and pick the first one that passes all the
    -- postconditions. If the list is empty, or if no probe passes the
    -- postconditions, then we can't complete the action and must return false.
    selected_probe = initial_probe

    -- Group all the probe sets together
    local all_possible_probes = {}
    for _, probe_set in pairs(probe_sets) do
        all_possible_probes = table.join(all_possible_probes, probe_set)
    end

    -- Randomise the probes, then sort by difficulty so we avoid stress if
    -- possible. We set the index here as it is used by SortProbesByDifficulty
    -- to guarantee a stable sort.
    all_possible_probes = table.shuffle(all_possible_probes)
    for index, probe in ipairs(all_possible_probes) do
        probe.index = index
    end
    table.sort(all_possible_probes, AIModule.SortProbesByDifficulty)

    -- Iterate over the probes. The first successful one we find we store
    -- in the probe_actions array that gets processed later, and we also record
    -- the set index so we know which set of simple actions to use.
    local probe_actions = {}
    local set_index = 1
    local move_count = 0
    for _, probe in pairs(all_possible_probes) do
        if AIModule.CheckProbeConditions(ship, target, probe, action_definition.postconditions) == true then
            selected_probe = probe
            set_index = probe.set_index

            for _, action in pairs(probe.actions) do
                -- Keep track of how many actual moves we make.
                if action.action == nil then
                    move_count = move_count + 1
                end

                if action ~= 's0' then
                    table.insert(probe_actions, action)
                end
            end

            if probe.difficulty == 'r' then
                table.insert(simple_actions[set_index], 'stress')
            end

            break
        end
    end

    if action_includes_move_component and move_count == 0 then
        return false
    end

    for index = 1, #simple_actions[set_index] do
        table.insert(AIModule.current_move.action_stack,
            simple_actions[set_index][#simple_actions[set_index] + 1 - index])
    end
    for index = 1, #probe_actions do
        table.insert(AIModule.current_move.action_stack, probe_actions[#probe_actions + 1 - index])
    end

    if #AIModule.current_move.action_stack > 0 then
        AIModule.PrintActionDescription(action_definition.description, ship, target, selected_probe)
        return true
    end

    return false
end

-- Processes the queued actions in order, movement first and then simple
-- actions. Will wait for the callback to keep processing actions in the case of
-- a movement action
AIModule.ProcessActionStack = function(ship)
    if AIModule.current_move.in_progress == false then
        return
    end

    while #AIModule.current_move.action_stack > 0 do
        local action = table.remove(AIModule.current_move.action_stack)

        if action.action == 'rotateTurret' then
            ship.call('SetTurretArc', { ['mount'] = action.mount, ['arc'] = action.arc, ['snap'] = false })
        elseif action == 'stress' then
            DialModule.PerformAction(ship, 'Stress', ship.getVar('owningPlayer'))
        elseif action == 'focus' then
            DialModule.PerformAction(ship, 'Focus', ship.getVar('owningPlayer'))
            table.insert(AIModule.current_move.actions, 'focus')
        elseif action == 'calculate' then
            DialModule.PerformAction(ship, 'Calculate', ship.getVar('owningPlayer'))
            table.insert(AIModule.current_move.actions, 'calculate')
        elseif action == 'focuscalculate' then
            local hasFocus = false
            local hasCalc = false
            for _, action in pairs(ship.getTable('Data').actSet) do
                if action == "F" then
                    DialModule.PerformAction(ship, 'Focus', ship.getVar('owningPlayer'))
                    table.insert(AIModule.current_move.actions, 'focus')
                    hasFocus = true
                elseif action == "C" then
                    hasCalc = true
                end
            end
            if hasCalc and not hasFocus then
                DialModule.PerformAction(ship, 'Calculate', ship.getVar('owningPlayer'))
                table.insert(AIModule.current_move.actions, 'calculate')
            end
        elseif action == 'evade' then
            DialModule.PerformAction(ship, 'Evade', ship.getVar('owningPlayer'))
            table.insert(AIModule.current_move.actions, 'evade')
        elseif action == 'targetLock' then
            DialModule.PerformAction(ship, 'Target Lock', ship.getVar('owningPlayer'),
                { ['ship'] = ship, ['target'] = AIModule.current_move.target })
            table.insert(AIModule.current_move.actions, 'targetLock')
        elseif action == 'cloak' then
            DialModule.PerformAction(ship, 'Cloak', ship.getVar('owningPlayer'))
            table.insert(AIModule.current_move.actions, 'cloak')
        elseif action == 'reinforceFore' then
            DialModule.PerformAction(ship, 'Reinforce', ship.getVar('owningPlayer'), { ['flip'] = true })
            table.insert(AIModule.current_move.actions, 'reinforce')
        elseif action == 'reinforceAft' then
            DialModule.PerformAction(ship, 'Reinforce', ship.getVar('owningPlayer'))
            table.insert(AIModule.current_move.actions, 'reinforce')
        elseif action == 'coordinate' then
            printToAll('Please manage the coordinate action manually.', color(1.0, 1.0, 0.2, 0.9))
            table.insert(AIModule.current_move.actions, 'coordinate')
        elseif action == 'jam' then
            target = AIModule.current_move.target
            DialModule.PerformAction(target, 'Jam', target.getVar('owningPlayer'))
            printToAll('Please manage the effects of the jam token manually.', color(1.0, 1.0, 0.2, 0.9))
            table.insert(AIModule.current_move.actions, 'jam')
        elseif action == 'tractor' then
            target = AIModule.current_move.target
            DialModule.PerformAction(target, 'Tractor', target.getVar('owningPlayer'))
            printToAll('Please manage the effects of the tractor token manually.', color(1.0, 1.0, 0.2, 0.9))
            table.insert(AIModule.current_move.actions, 'tractor')
        elseif action == 'tractorSelf' then
            DialModule.PerformAction(ship, 'Tractor', ship.getVar('owningPlayer'))
            table.insert(AIModule.current_move.actions, 'tractor')
        elseif action == 'deplete' then
            DialModule.PerformAction(ship, 'Deplete', ship.getVar('owningPlayer'))
            table.insert(AIModule.current_move.actions, 'deplete')
        elseif action == 'strain' then
            DialModule.PerformAction(ship, 'Strain', ship.getVar('owningPlayer'))
            table.insert(AIModule.current_move.actions, 'strain')
        elseif action == 'disarm' then
            DialModule.PerformAction(ship, 'Disarm', ship.getVar('owningPlayer'))
            table.insert(AIModule.current_move.actions, 'disarm')
        elseif MoveModule.PerformMove(action, ship, false, AIModule.ProcessActionStack) then
            break
        end
    end

    AIModule.current_move.in_progress = #AIModule.current_move.action_stack > 0
end

AIModule.PrintActionDescription = function(description, ship, target, probe)
    local text = description
    local text_parameters = {}
    if type(description) == 'table' then
        text = description.text
        for _, string_id in pairs(description.strings) do
            if string_id == 'ship' then
                table.insert(text_parameters, ship.getName())
            elseif string_id == 'target' then
                table.insert(text_parameters, target.getName())
            else
                -- If it's not 'ship' or 'target', then it's an action target
                -- that is stored in the chain of the selected action probes.
                -- We'll look up the chain until we find it.
                action_target = ''
                current_probe = probe
                while current_probe ~= nil and action_target == '' do
                    if current_probe.action_targets[string_id] ~= nil then
                        action_target = current_probe.action_targets[string_id].getName()
                    end
                    current_probe = current_probe.parent
                end

                table.insert(text_parameters, action_target)
            end
        end
    else
        text_parameters = { ship.getName() }
    end

    printToAll(string.format(text, unpack(text_parameters)))
end

--[[ The action probe system, part of the AI action submodule.

These functions deal the creating action probes, expanding them, sorting them,
and checking conditions on them.
]]
AIModule.CheckProbeConditions = function(ship, target, probe, conditions)
    -- No conditions, then we can't fail.
    if conditions == nil then
        return true
    end

    local probe_result = true

    for condition, parameters in pairs(conditions) do
        local required_result = parameters
        local arguments = nil
        -- Conditions can either point just to the required result, in which
        -- case they have no arguments, or point to a table which contains both
        -- the required result and arguments.
        if type(parameters) == 'table' then
            required_result = parameters.requiredResult
            arguments = parameters.arguments
        end
        local actual_result = AIModule.condition_functions[condition](ship, target, probe, arguments)
        if actual_result ~= required_result then
            probe_result = false
            break
        end
    end

    return probe_result
end

-- This creates the origin action probe and returns it.
AIModule.GetActionProbe = function(ship)
    local move = 's0'

    if AIModule.current_move.probes[move] == nil then
        AIModule.current_move.probes[move] = {}
    end

    if AIModule.current_move.probes[move].possible == nil then
        AIModule.current_move.probes[move].parent = nil
        AIModule.current_move.probes[move].action_targets = {}
        AIModule.current_move.probes[move].actions = { move }
        AIModule.current_move.probes[move].possible = true
        AIModule.current_move.probes[move].difficulty = 'w'
        AIModule.current_move.probes[move].position = ship.getPosition()
        AIModule.current_move.probes[move].rotation = ship.getRotation()
    end

    return AIModule.current_move.probes[move]
end

-- This function takes an existing probe, and appends all possible moves/actions
-- in the action list onto it, returning a list of those that are possible.
AIModule.ExpandActionProbe = function(ship, probe, actions, difficulty)
    local possible_probes = {}

    local probe_name = ''
    for _, previous_action in pairs(probe.actions) do
        if string.len(probe_name) > 0 then
            probe_name = probe_name .. ','
        end
        probe_name = probe_name .. AIModule.GetActionProbeName(previous_action)
    end

    for _, action in pairs(actions) do
        -- First check if this exists. If it does, and it's possible, then just
        -- return it and skip to the next one.
        local new_probe_name = probe_name .. ',' .. AIModule.GetActionProbeName(action)
        new_probe = AIModule.current_move.probes[new_probe_name]
        if new_probe ~= nil then
            if new_probe.possible == true then
                new_probe.difficulty = difficulty
                table.insert(possible_probes, new_probe)
            end
        else
            local new_probe = {
                ['parent'] = probe,
                ['possible'] = false,
                ['actions'] = table.shallowcopy(probe.actions),
                ['action_targets'] = {},
                ['difficulty'] = difficulty,
            }
            table.insert(new_probe.actions, action)

            if action.action == nil then
                -- If the action doesn't contain an 'action' key, then it's a move.
                local move_code = action

                -- Test whether this probe is even possible.
                local original_ship_state = AIModule.GetShipState(ship)
                AIModule.ApplyProbe(ship, probe)

                local move_info = MoveData.DecodeInfo(move_code, ship)
                local probe_data = MoveModule.MoveProbe.TryFullMove(move_info, ship, MoveModule.GetFullMove)
                if probe_data.done and probe_data.collObj == nil and probe_data.collObs == nil then
                    new_probe.possible = true
                    new_probe.position = probe_data.finalPosRot.pos
                    new_probe.rotation = probe_data.finalPosRot.rot
                    table.insert(possible_probes, new_probe)
                end
                AIModule.current_move.probes[new_probe_name] = new_probe

                AIModule.SetShipState(ship, original_ship_state)
            elseif action.action == 'rotateTurret' then
                -- Turret rotations are always possible so we don't need to test
                -- the action.
                new_probe.possible = true
                new_probe.position = probe.position
                new_probe.rotation = probe.rotation
                new_probe.turrets = { [action.mount] = action.arc }
                table.insert(possible_probes, new_probe)

                AIModule.current_move.probes[new_probe_name] = new_probe
            end
        end
    end

    return possible_probes
end

AIModule.GetActionProbeName = function(action)
    if action.action == nil then
        return action
    elseif action.action == 'rotateTurret' then
        return string.format('rotateTurret(%s,%s)', action.mount, action.arc)
    else
        return ''
    end
end

AIModule.SortProbesByDifficulty = function(e1, e2)
    if e1.difficulty == 'b' and e2.difficulty ~= 'b' then
        return true
    elseif e2.difficulty == 'b' and e1.difficulty ~= 'b' then
        return false
    elseif e1.difficulty == 'w' and e2.difficulty == 'r' then
        return true
    elseif e2.difficulty == 'w' and e1.difficulty == 'r' then
        return false
    end

    return e1.index < e2.index
end

AIModule.GetShipState = function(ship)
    local state = { ['position'] = ship.GetPosition(), ['rotation'] = ship.GetRotation(), ['turrets'] = {} }

    local turret_mounts = ship.call('GetAssignedMounts')
    for _, mount in pairs(turret_mounts) do
        state.turrets[mount] = ship.call('GetTurretArc', { ['mount'] = mount })
    end

    return state
end

AIModule.SetShipState = function(ship, state)
    ship.SetPosition(state.position)
    ship.SetRotation(state.rotation)

    --if state.turrets ~= nil then
    --    for mount, arc in pairs(state.turrets) do
    --        ship.call('SetTurretArc', {['mount'] = mount, ['arc'] = arc, ['snap'] = true})
    --    end
    --end
end

AIModule.ApplyProbe = function(ship, probe)
    ship.SetPosition(probe.position)
    ship.SetRotation(probe.rotation)

    --if probe.turrets ~= nil then
    --    for mount, arc in pairs(probe.turrets) do
    --        ship.call('SetTurretArc', {['mount'] = mount, ['arc'] = arc, ['snap'] = true})
    --    end
    --end
end

AIModule.GetTurretRotationOptions = function(ship, mount)
    -- Build up our list of possible rotations.
    local rotation_options = {}
    local turret_type = ship.call('GetTurretType', { ['mount'] = mount })
    if (turret_type[1] == 'singleturret') then
        rotation_options = { 'front', 'right', 'back', 'left' }
    elseif (turret_type[1] == 'doubleturret') then
        rotation_options = { 'frontback', 'leftright' }
    else
        rotation_options = turret_type
    end

    -- Remove our current option arc from the list of options.
    local turret_arc = ship.call('GetTurretArc', { ['mount'] = mount })
    i = 1
    while i <= #rotation_options do
        if rotation_options[i] == current_arc then
            table.remove(rotation_options, i)
        else
            i = i + 1
        end
    end

    return rotation_options
end

AIModule.condition_functions = {}
AIModule.condition_functions.hasShot = function(ship, target, probe, arguments)
    --[[ TODO: This should favour a shot at the target. To do so we might need to
           create a different condition function "hasShotOnTarget" and have it occur
           before the generic hasShot checks.]]
    local min_range = 1
    local max_range = 3
    if arguments ~= nil then
        min_range = arguments.minRange or min_range
        max_range = arguments.maxRange or max_range
    end

    if probe.shot_range == nil then
        probe.shot_range = -1

        local original_position_rotation = AIModule.GetShipState(ship)
        AIModule.ApplyProbe(ship, probe)
        local arcs = ship.call('GetAllArcs')
        if probe.turrets ~= nil then
            arcs = {}
            for mount, arctype in pairs(probe.turrets) do
                for _, arc in pairs(mountDirectionToArcs[arctype]) do
                    table.insert(arcs, arc)
                end
            end
        end
        targets = ArcCheck.GetTargetsInRelationToArc(ship, arcs)
        targets = table.sieve(targets, AIModule.FilterInArc)
        targets = table.sieve(targets, AIModule.FilterInRange)

        for _, target in pairs(targets) do
            if probe.shot_range == -1 or target.closest.range < probe.shot_range then
                probe.shot_range = target.closest.range
            end
        end

        AIModule.SetShipState(ship, original_position_rotation)
    end

    return probe.shot_range ~= -1 and probe.shot_range >= min_range and probe.shot_range <= max_range
end

AIModule.condition_functions.inTargetsArc = function(ship, target, probe, arguments)
    if probe.in_targets_arc == nil then
        local original_position_rotation = AIModule.GetShipState(ship)
        AIModule.ApplyProbe(ship, probe)

        probe.in_targets_arc = false
        local arcs = ship.call('GetAllArcs')
        if probe.turrets ~= nil then
            arcs = {}
            for mount, arctype in pairs(probe.turrets) do
                for _, arc in pairs(mountDirectionToArcs[arctype]) do
                    table.insert(arcs, arc)
                end
            end
        end

        targets = ArcCheck.GetTargetsInRelationToArc(target, arcs, { ship })
        targets = table.sieve(targets, AIModule.FilterInArc)
        targets = table.sieve(targets, AIModule.FilterInRange)
        for _, target_info in pairs(targets) do
            probe.in_targets_arc = true
            break
        end

        AIModule.SetShipState(ship, original_position_rotation)
    end

    return probe.in_targets_arc
end

AIModule.condition_functions.targetMoved = function(ship, target, probe, arguments)
    if probe.target_moved == nil then
        local ship_initiative = ship.getTable('Data')['initiative']
        local target_initiative = target.getTable('Data')['initiative']
        probe.target_moved = ship_initiative >
            target_initiative -- TODO: This assumes that the AI moves first on ties like in HotAC.
    end

    return probe.target_moved
end

AIModule.condition_functions.targetLocked = function(ship, target, probe, arguments)
    if probe.target_locked == nil then
        probe.target_locked = AIModule.HasTargetLockOnShip(ship, target)
    end

    return probe.target_locked
end

AIModule.condition_functions.targetWithinRange = function(ship, target, probe, arguments)
    local min_range = 1
    local max_range = 3
    if arguments ~= nil then
        min_range = arguments.minRange or min_range
        max_range = arguments.maxRange or max_range
    end

    if probe.target_range == nil then
        local targets = ArcCheck.GetTargetsInRelationToArc(ship, 'all', { target })
        for _, target_info in pairs(targets) do
            probe.target_range = target_info.closest.range
            break
        end
    end

    return probe.target_range >= min_range and probe.target_range <= max_range
end

AIModule.condition_functions.evading = function(ship, target, probe, arguments)
    if probe.evading == nil then
        probe.evading = TokenModule.GetShipTokenCount(ship, 'Evade') > 0
    end

    if probe.evading ~= true then
        for _, action in pairs(AIModule.current_move.actions) do
            if action == 'evade' then
                probe.evading = true
                break
            end
        end
    end

    return probe.evading
end

AIModule.condition_functions.hasAction = function(ship, target, probe, arguments)
    if probe.action_set == nil then
        probe.action_set = {}
        for _, action in pairs(ship.getTable('Data').actSet) do
            if AIModule.full_action_names[action] then
                probe.action_set[AIModule.full_action_names[action]] = true
            end
        end
    end
    return probe.action_set[arguments.action]
end

AIModule.condition_functions.inEnemyArc = function(ship, target, probe, arguments)
    local arc = 'all'
    local wholly_within_arc = true
    local min_enemies = 1
    if arguments ~= nil then
        arc = arguments.arc or arc
        wholly_within_arc = arguments.whollyWithinArc or wholly_within_arc
        min_enemies = arguments.enemyCount or min_enemies
    end

    -- This counts the number of enemies whose arc we are within, and who are
    -- within our specified arc. This is mainly used for the reinforce action
    -- and the fullfront/fullback arc.
    local condition_index = arc .. ',' .. tostring(wholly_within_arc)
    if probe.num_enemy_arcs == nil or probe.num_enemy_arcs[condition_index] == nil then
        if probe.num_enemy_arcs == nil then
            probe.num_enemy_arcs = {}
        end
        probe.num_enemy_arcs[condition_index] = 0

        local original_position_rotation = AIModule.GetShipState(ship)
        AIModule.ApplyProbe(ship, probe)

        -- Get all ships within the specified arc.
        enemies_in_arc = ArcCheck.GetTargetsInRelationToArc(ship, arc)
        enemies_in_arc = table.sieve(enemies_in_arc, AIModule.FilterInArc)

        -- If we only want ships that are fully within the arc, then we loop
        -- through all adjacent arcs and remove any ship that appears in both.
        -- So, if we checked the fullfront arc, then we reject all ships that
        -- is also int eh fullback arc.
        if wholly_within_arc and AIModule.arc_adjacencies[arc] ~= nil then
            for _, adjacent_arc in pairs(AIModule.arc_adjacencies[arc]) do
                if #enemies_in_arc > 0 then
                    -- Quick check to avoid unnecessary calls to ArcCheck.GetTargetsInRelationToArc
                    enemies_in_adjacent_arc = ArcCheck.GetTargetsInRelationToArc(ship, adjacent_arc)
                    enemies_in_adjacent_arc = table.sieve(targets, AIModule.FilterInArc)
                    enemies_in_arc = table.sieve(enemies_in_arc,
                        -- Return false if this ship appears in arc_targets.
                        function(el)
                            for _, enemy in pairs(enemies_in_adjacent_arc) do
                                if el.ship == enemy.ship then
                                    return false
                                end
                            end

                            return true
                        end
                    )
                end
            end
        end

        -- Lastly, we iterate over all targets that remain and check if we are
        -- within their arc. For each ship that can fire at us we increment the
        -- number of arcs.
        for _, enemy_ship in pairs(enemies_in_arc) do
            local enemy_arc = ArcCheck.GetTargetsInRelationToArc(enemy_ship.ship, enemy_ship.ship.call('GetAllArcs'),
                { ship })
            enemy_arc = table.sieve(enemy_arc, AIModule.FilterInArc)
            enemy_arc = table.sieve(enemy_arc, AIModule.FilterInRange)
            for _ in pairs(enemy_arc) do
                probe.num_enemy_arcs[condition_index] = probe.num_enemy_arcs[condition_index] + 1
                break
            end
        end

        AIModule.SetShipState(ship, original_position_rotation)
    end

    return probe.num_enemy_arcs[condition_index] >= min_enemies
end

AIModule.condition_functions.hasCoordinateTarget = function(ship, target, probe, arguments)
    if probe.action_targets.coordinate == nil then
        probe.action_targets.coordinate = false

        -- Range two is 200mm, so triple it to 600mm to be sure of not missing
        -- anything once we take bases into account.
        local friendly_ships = ArcCheck.GetShipsWithinRange(ship, 600, false, true)

        local closest_distance = nil
        for _, friendly_ship in pairs(friendly_ships) do
            local distance = ArcCheck.GetDistanceBetweenShips(ship, friendly_ship)
            if distance ~= nil then
                -- Are we are the right range for coordinate?
                if distance.range >= 1 and distance.range <= 2 then
                    -- Is the ship not stressed?
                    if TokenModule.GetShipTokenCount(friendly_ship, "Stress") == 0 then
                        --[[ TODO: appears to be an error with counting stress tokens?
                                Are we closer than the previously closest ship? ]]
                        if closest_distance == nil or closest_distance > distance.length then
                            probe.action_targets.coordinate = friendly_ship
                            closest_distance = distance.length
                        end
                    end
                end
            end
        end
    end

    return probe.action_targets.coordinate ~= false
end

--------
-- MAIN MOVEMENT MODULE
-- Lets us move ships around and handles what comes with moving

MoveModule = {}

-- Convert a typical entry from MoveData functions
-- (this: {xPos_offset, yPos_offset, zPos_offset, yRot_offset} )
-- to a real ship position in world
MoveModule.EntryToPos = function(entry, shipPos)
    local basePos = nil
    local baseRot = nil
    if type(shipPos) == 'userdata' then
        basePos = shipPos.getPosition()
        baseRot = shipPos.getRotation()
    elseif type(shipPos) == 'table' then
        basePos = shipPos.pos
        baseRot = shipPos.rot
    end
    local finalPos = MoveData.ConvertDataToIGU(entry)
    local finalRot = entry[4] + baseRot[2]
    finalPos = Vect.RotateDeg(finalPos, baseRot[2] + 180)
    finalPos = Vect.Sum(basePos, finalPos)
    return { pos = finalPos, rot = { 0, finalRot, 0 } }
end

-- Get the position for a ship if it did a full move
-- Returned position and rotation are ready to feed TTS functions with
MoveModule.GetFullMove = function(move, ship)
    local entry = MoveData.DecodeFullMove(move, ship)
    return MoveModule.EntryToPos(entry, ship)
end

-- Get the position for a ship if it did a part of a move
-- Returned position and rotation are ready to feed TTS functions with
MoveModule.GetPartMove = function(move, ship, part)
    local entry = MoveData.DecodePartMove(move, ship, part)
    return MoveModule.EntryToPos(entry, ship)
end


-- HISTORY HANDLING:
-- Lets us undo, redo and save positions a ship was seen at

-- History table: {ship=shipRef, actKey=keyOfHistoryEntryShipWasLastSeenAt (._.), history=entryList}
-- Entry list: {entry1, entry2, entry3, ...}
-- Entry: {pos=position, rot=rotation, move=moveThatGotShipHere, part=partOfMovePerformed}
MoveModule.moveHistory = {}

-- Hostory-related commads
XW_cmd.AddCommand('[qz]', 'historyHandle')
XW_cmd.AddCommand('undo', 'historyHandle')
XW_cmd.AddCommand('redo', 'historyHandle')
XW_cmd.AddCommand('keep', 'historyHandle')

-- Return history of a ship
MoveModule.GetHistory = function(ship)
    for k, hist in pairs(MoveModule.moveHistory) do
        if hist.ship == ship then
            return hist
        end
    end
    table.insert(MoveModule.moveHistory, { ship = ship, actKey = 0, history = {} })
    return MoveModule.GetHistory(ship)
end

-- Erase all history "forward" from the current state
-- Happens when you undo and then do a move - all positions you undid are lost
MoveModule.ErasePastCurrent = function(ship)
    local histData = MoveModule.GetHistory(ship)
    local k = 1
    while histData.history[histData.actKey + k] ~= nil do
        histData.history[histData.actKey + k] = nil
        k = k + 1
    end
end

-- Print history, just for debug
MoveModule.PrintHistory = function(ship)
    local histData = MoveModule.GetHistory(ship)
    if histData.actKey == 0 then
        print(ship.getName() .. ': NO HISTORY')
    else
        print(ship.getName() .. '\'s HISTORY:')
        local k = 1
        while histData.history[k] ~= nil do
            local entry = histData.history[k]
            local typeStr = ' (' .. entry.finType
            if entry.part ~= nil then
                typeStr = typeStr .. ':' .. entry.part .. ')'
            else
                typeStr = typeStr .. ')'
            end
            if k == histData.actKey then
                print(' >> ' .. entry.move .. typeStr)
            else
                print(' -- ' .. entry.move .. typeStr)
            end
            k = k + 1
        end
        print(' -- -- -- -- ')
    end
end

-- Save <some> ship position to the history
-- Saves on the position after current and deletes any past that
MoveModule.AddHistoryEntry = function(ship, entry)
    local histData = MoveModule.GetHistory(ship)
    histData.actKey = histData.actKey + 1
    histData.history[histData.actKey] = entry
    MoveModule.ErasePastCurrent(ship)
end

-- How much position can be offset to be considered 'same'
MoveModule.undoPosCutoff = Dim.Convert_mm_igu(1)
-- How much rotation can be offset to be considered 'same'
MoveModule.undoRotCutoffDeg = 1

-- Check if the ship is on the curent history position (tolerance above)
MoveModule.IsAtSavedState = function(ship)
    local histData = MoveModule.GetHistory(ship)
    if histData.actKey > 0 then
        local currEntry = histData.history[histData.actKey]
        local dist = Vect.Distance(ship.getPosition(), currEntry.pos)
        local angDiff = math.abs(ship.getRotation()[2] - currEntry.rot[2])
        if math.abs(angDiff) > 180 then
            angDiff = math.abs(angDiff - math.sgn(angDiff) * 360)
        end
        return (dist < MoveModule.undoPosCutoff and angDiff < MoveModule.undoRotCutoffDeg)
    end
    return false
end

-- Save curent ship position to the history
-- Can be quiet when not explicitly called by the user
MoveModule.SaveStateToHistory = function(ship, beQuiet)
    local histData = MoveModule.GetHistory(ship)
    -- Don't add an entry if it's current position/rotation
    if MoveModule.IsAtSavedState(ship) then
        if beQuiet ~= true then
            AnnModule.Announce({ type = 'historyHandle', note = 'already has current position saved' }, 'all', ship)
        end
    else
        local entry = {
            pos = ship.getPosition(),
            rot = ship.getRotation(),
            move = 'position save',
            part = nil,
            finType = 'special'
        }
        MoveModule.AddHistoryEntry(ship, entry)
        if beQuiet ~= true then
            AnnModule.Announce({ type = 'historyHandle', note = 'stored current position' }, 'all', ship)
        end
    end
end

-- Move a ship to a previous state from the history
-- Return true if action was taken
-- Return false if there is no more data
MoveModule.UndoMove = function(ship)
    local histData = MoveModule.GetHistory(ship)
    local announceInfo = { type = 'historyHandle' }
    -- No history
    if histData.actKey == 0 then
        announceInfo.note = 'has no more moves to undo'
    else
        -- There is history
        local currEntry = histData.history[histData.actKey]
        -- current position not matching history
        if not MoveModule.IsAtSavedState(ship) then
            MoveModule.MoveShip(ship, { finPos = { pos = currEntry.pos, rot = currEntry.rot }, noSave = true })
            announceInfo.note = 'moved to the last saved position'
        else
            -- current position matching current histor
            if histData.actKey > 1 then
                local undidMove = currEntry.move
                histData.actKey = histData.actKey - 1
                currEntry = histData.history[histData.actKey]
                MoveModule.MoveShip(ship, { finPos = { pos = currEntry.pos, rot = currEntry.rot }, noSave = true })
                announceInfo.note = 'performed an undo of (' .. undidMove .. ')'
            else
                -- There is no data to go back to
                announceInfo.note = 'has no more moves to undo'
            end
        end
    end
    AnnModule.Announce(announceInfo, 'all', ship)
    return shipMoved
end

-- Move a ship to next state from the history
MoveModule.RedoMove = function(ship)
    local histData = MoveModule.GetHistory(ship)
    local announceInfo = { type = 'historyHandle' }
    -- No history
    if histData.actKey == 0 then
        announceInfo.note = 'has no more moves to redo'
    else
        -- There is history
        if histData.history[histData.actKey + 1] == nil then
            -- No more moves forward
            announceInfo.note = 'has no more moves to redo'
        else
            -- Move forward
            histData.actKey = histData.actKey + 1
            local currEntry = histData.history[histData.actKey]
            MoveModule.MoveShip(ship, { finPos = { pos = currEntry.pos, rot = currEntry.rot }, noSave = true })
            announceInfo.note = 'performed a redo of (' .. currEntry.move .. ')'
        end
    end
    AnnModule.Announce(announceInfo, 'all', ship)
    return shipMoved
end

-- Get the last move code from ship history
-- Always returns an "entry" table, if there's no move, move key is 'none'
MoveModule.GetLastMove = function(ship)
    local histData = MoveModule.GetHistory(ship)
    if histData.actKey < 1 then
        return { move = 'none' }
    else
        return table.shallowcopy(histData.history[histData.actKey])
    end
end

-- Get some old move from ship history (arg in number of moves back)
-- Always returns an "entry" table, if there's no move, move key is 'none'
MoveModule.GetOldMove = function(ship, numMovesBack)
    local histData = MoveModule.GetHistory(ship)
    if histData.actKey - numMovesBack < 1 then
        return { move = 'none' }
    else
        return table.shallowcopy(histData.history[histData.actKey - numMovesBack])
    end
end

-- THING THAT ALLOWS US TOR ESTORE SHIP POSITION AFTER IT WAS DELETED
-- Table of deleted ships last positions
MoveModule.emergencyRestore = {}
-- Pointer at the most recently added restore entry
MoveModule.restoreBufferPointer = 0
-- Max size of the restore entry table
MoveModule.restoreBufferSize = 25
-- Restore command
XW_cmd.AddCommand('restore#[1-9][0-9]?', 'historyHandle')

-- Try to restore some ship position to an entry with given key
MoveModule.Restore = function(ship, key)
    if #MoveModule.emergencyRestore < key or key <= 0 then
        AnnModule.Announce({ type = 'historyHandle', note = 'Restore key (number after the #) invalid' }, 'all')
        return false
    else
        local data = MoveModule.emergencyRestore[key]
        ship.setPosition(data.savedPos.pos)
        ship.setRotation(data.savedPos.rot)
        MoveModule.SaveStateToHistory(ship, true)
        AnnModule.Announce(
            { type = 'historyHandle', note = 'has been restored to position ' .. data.srcName .. ' was last seen at' },
            'all',
            ship)
        return true
    end
end

-- Save some restore data and notify the user of it
MoveModule.AddRestorePoint = function(entry)
    local newKey = MoveModule.restoreBufferPointer + 1
    if newKey > MoveModule.restoreBufferSize then
        newKey = 1
    end
    AnnModule.Announce(
        {
            type = 'historyHandle',
            note = entry.srcName ..
                '\'s ship has been deleted - you can respawn the model and use \'restore#' ..
                newKey .. '\' command to restore its position'
        }, 'all')
    MoveModule.emergencyRestore[newKey] = entry
    MoveModule.restoreBufferPointer = newKey
end

-- Handle destroyed objects
-- Create a restore entry from last set position in history
-- Delete history if present
MoveModule.onObjectDestroyed = function(obj)
    if not ObjType.IsOfType(obj, 'ship') then
        return
    end
    if MoveModule.GetLastMove(obj).move ~= 'none' then
        local lastMove = MoveModule.GetLastMove(obj)
        MoveModule.AddRestorePoint({ srcName = obj.getName(), savedPos = { pos = lastMove.pos, rot = lastMove.rot } })
    end
    for k, hist in pairs(MoveModule.moveHistory) do
        if hist.ship == ship then
            table.remove(MoveModule.moveHistory, k)
            break
        end
    end
end

-- Get the history table with "serialized" positions/rotations
-- I hate this so much
-- Devs, fix your shit, goddamnit
MoveModule.GetSaveData = function()
    local currHistory = {}
    for k, hist in pairs(MoveModule.moveHistory) do
        if hist.history[1] ~= nil then
            local currEntry = MoveModule.GetLastMove(hist.ship)
            currEntry.pos = TTS_Serialize(currEntry.pos)
            currEntry.rot = TTS_Serialize(currEntry.rot)
            table.insert(currHistory, { ship = hist.ship.getGUID(), actKey = 1, history = { currEntry } })
        end
    end
    if currHistory[1] == nil then
        return nil
    else
        return currHistory
    end
end


-- Restore provided table and notify of the results
MoveModule.RestoreSaveData = function(saveTable)
    if saveTable == nil then
        return
    end
    local count = 0
    local missCount = 0
    for k, hist in pairs(saveTable) do
        hist.ship = getObjectFromGUID(hist.ship)
        if hist.ship == nil then
            missCount = missCount + 1
        else
            count = count + 1
            table.insert(MoveModule.moveHistory, hist)
        end
    end
    local info = ' - Restored last position save for ' .. count .. ' ship(s)'
    if missCount > 0 then
        info = info .. ' (' .. missCount .. ' ship model(s) missing)'
    end
    if count > 0 or missCount > 0 then
        return info
    end
end

SaveManager.Register('MoveModule', MoveModule.GetSaveData, MoveModule.RestoreSaveData)

-- Join hit tables t1 .. t5 resulting from Physics.cast call
-- Return a table of unique objects that pass selection function
-- (apaprently cant use '...' arg type when a function is a table field)
-- Arguments:
--      exclObj     <- object excluded from return table (for casts over a ship)
--      SelectFun   <- function taking an object and returning true/false (obj type selection)
--      t1 .. t5    <- hit tables returned from Physics.cast, some can be nil or empty
-- Return:
--      Concatenated table of unique objects from hit tables that also passed selection function
MoveModule.JoinHitTables = function(exclObj, SelectFun, t1, t2, t3, t4, t5)
    local gTable = { [exclObj.getGUID()] = true }
    local out = {}
    local tbls = { a = t1, b = t2, c = t3, d = t4, e = t5 }
    for k, hTable in pairs(tbls) do
        for k2, hit in pairs(hTable) do
            if SelectFun(hit.hit_object) and gTable[hit.hit_object.getGUID()] == nil then
                gTable[hit.hit_object.getGUID()] = true
                table.insert(out, hit.hit_object)
            end
        end
    end
    return out
end

-- Selection function for MoveModule.JoinHitTables - ships only
MoveModule.SelectShips = function(obj)
    return ObjType.IsOfType(obj, 'ship')
end

-- Selection function for MoveModule.JoinHitTables - ships only
MoveModule.SelectRemotes = function(obj)
    return obj.hasTag('TargetableRemote')
end

-- Selection function for MoveModule.JoinHitTables - huge ships only
MoveModule.SelectHugeShips = function(obj)
    return MoveModule.SelectShips(obj) and (obj.getTable('Data').Size == 'huge')
end

-- Selection function for MoveModule.JoinHitTables - huge ships only
MoveModule.SelectShipsAndRemotes = function(obj)
    return MoveModule.SelectShips(obj) or MoveModule.SelectRemotes(obj)
end



-- Selection function for MoveModule.JoinHitTables - obstacles only
MoveModule.SelectObstacles = function(obj)
    local name = obj.getName()
    return obj.hasTag('Obstacle') or
        ((name:find('Asteroid') or name:find('Debris') or name:find('Chute debris') or name:find('Cloud') or name:find('Spare') or name:find('Obstacle')) ~= nil)
end

-- Selection function for MoveModule.JoinHitTables - mine tokens only
MoveModule.SelectMineTokens = function(obj)
    local name = obj.getName()
    return obj.hasTag('Mine') or
        ((name:find('Mine') or name:find('Connor') or name:find('Chute debris') or name:find('Probe') or name:find('Buzz')) ~= nil)
end

-- Selection function for MoveModule.JoinHitTables - mines and obstacles
MoveModule.SelectMinesAndObstacleTokens = function(obj)
    return MoveModule.SelectObstacles(obj) or MoveModule.SelectMineTokens(obj)
end

-- Selection function for MoveModule.JoinHitTables - anything aside from global table object
MoveModule.SelectAny = function(obj)
    return obj.getGUID() ~= nil
end

-- Cast data for checking collisions over a ship type shape
MoveModule.castData = {}
MoveModule.castData.small = {}
MoveModule.castData.small.base = {
    debug = cast_debug,
    direction = { 0, -0.001, 0 },
    type = 3,
    size = { Dim.Convert_mm_igu(40), Dim.Convert_mm_igu(6), Dim.Convert_mm_igu(40) },
    -- + Origin
    -- + Orientation
}
MoveModule.castData.small.nubFR = {
    debug = cast_debug,
    localPos = { -1 * Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), -1 * Dim.Convert_mm_igu(20.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.small.nubFL = {
    debug = cast_debug,
    localPos = { Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), -1 * Dim.Convert_mm_igu(20.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.small.nubBR = {
    debug = cast_debug,
    localPos = { -1 * Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), Dim.Convert_mm_igu(20.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.small.nubBL = {
    debug = cast_debug,
    localPos = { Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), Dim.Convert_mm_igu(20.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}

MoveModule.castData.medium = {}
MoveModule.castData.medium.base = {
    debug = cast_debug,
    direction = { 0, -0.001, 0 },
    type = 3,
    size = { Dim.Convert_mm_igu(60), Dim.Convert_mm_igu(6), Dim.Convert_mm_igu(60) },
    -- + Origin
    -- + Orientation
}
MoveModule.castData.medium.nubFR = {
    debug = cast_debug,
    localPos = { -1 * Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), -1 * Dim.Convert_mm_igu(30.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.medium.nubFL = {
    debug = cast_debug,
    localPos = { Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), -1 * Dim.Convert_mm_igu(30.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.medium.nubBR = {
    debug = cast_debug,
    localPos = { -1 * Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), Dim.Convert_mm_igu(30.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.medium.nubBL = {
    debug = cast_debug,
    localPos = { Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), Dim.Convert_mm_igu(30.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}

MoveModule.castData.large = {}
MoveModule.castData.large.base = {
    debug = cast_debug,
    direction = { 0, -0.001, 0 },
    type = 3,
    size = { Dim.Convert_mm_igu(80), Dim.Convert_mm_igu(6), Dim.Convert_mm_igu(80) },
    -- + Origin
    -- + Orientation
}
MoveModule.castData.large.nubFR = {
    debug = cast_debug,
    localPos = { -1 * Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), -1 * Dim.Convert_mm_igu(40.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.large.nubFL = {
    debug = cast_debug,
    localPos = { Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), -1 * Dim.Convert_mm_igu(40.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.large.nubBR = {
    debug = cast_debug,
    localPos = { -1 * Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), Dim.Convert_mm_igu(40.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.large.nubBL = {
    debug = cast_debug,
    localPos = { Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), Dim.Convert_mm_igu(40.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}

MoveModule.castData.huge = {}
MoveModule.castData.huge.base = {
    debug = cast_debug,
    direction = { 0, -0.001, 0 },
    type = 3,
    size = { Dim.Convert_mm_igu(80), Dim.Convert_mm_igu(6), Dim.Convert_mm_igu(221) },
    -- + Origin
    -- + Orientation
}
MoveModule.castData.huge.nubFR = {
    debug = cast_debug,
    localPos = { -1 * Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), -1 * Dim.Convert_mm_igu(111.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.huge.nubFL = {
    debug = cast_debug,
    localPos = { Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), -1 * Dim.Convert_mm_igu(111.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.huge.nubBR = {
    debug = cast_debug,
    localPos = { -1 * Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), Dim.Convert_mm_igu(111.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}
MoveModule.castData.huge.nubBL = {
    debug = cast_debug,
    localPos = { Dim.Convert_mm_igu(11.38), Dim.Convert_mm_igu(-1.86), Dim.Convert_mm_igu(111.858) },
    direction = { 0, -0.001, 0 },
    type = 2,
    size = { Dim.Convert_mm_igu(3.4), Dim.Convert_mm_igu(8), Dim.Convert_mm_igu(3.4) },
    -- + Origin
}



-- Get cast data for particular ship situation
-- Arguments:
--      ship        <- ship ref (for base size)
--      shipPosRot  <- table with ship check position and rotation ('pos' and 'rot' keys)
--      castType    <- 'base' for base, 'nub[FB][RL]' for one of four nubs
-- Return:
--      Table ready to be fed to Physics.cast
MoveModule.GetCast = function(ship, shipPosRot, castType)
    local baseSize = ship.getTable("Data").Size or 'small'
    local castTable = MoveModule.castData[baseSize][castType]
    --castTable.debug = true
    if castType == 'base' then
        castTable.origin = shipPosRot.pos
        castTable.orientation = shipPosRot.rot
        return castTable
    else
        castTable.origin = Vect.Sum(shipPosRot.pos, Vect.RotateDeg(castTable.localPos, shipPosRot.rot[2]))
        return castTable
    end
end

-- Return all objects that pass selection function and would overlap ship in some situation
-- Arguments:
--      ship        <- ship ref (for base size)
--      shipPosRot  <- table with ship check position and rotation ('pos' and 'rot' keys)
--      SelectFun   <- selection function that returns true/false for an object
-- Return:
--      Concatenated table of all objects that would overlap ship in this situation and pass select function
MoveModule.FullCastCheck = function(ship, shipPosRot, SelectFun)
    return MoveModule.JoinHitTables(
        ship,
        SelectFun,
        Physics.cast(MoveModule.GetCast(ship, shipPosRot, 'base')),
        Physics.cast(MoveModule.GetCast(ship, shipPosRot, 'nubFR')),
        Physics.cast(MoveModule.GetCast(ship, shipPosRot, 'nubFL')),
        Physics.cast(MoveModule.GetCast(ship, shipPosRot, 'nubBR')),
        Physics.cast(MoveModule.GetCast(ship, shipPosRot, 'nubBL'))
    )
end

-- Return all objects that pass selection function and would overlap a template in some situation
-- Arguments:
--      excludeObj   <- Object to exclude from overlapping
--      collList     <- List of already hit objects (from base overlapping)
--      templateData <- table with information on origin, orientation, speed, type and direction
--      SelectFun   <- selection function that returns true/false for an object
-- Return:
--      Concatenated table of all objects that would overlap ship in this situation and pass select function
MoveModule.TemplateCastCheck = function(excludeObj, collList, templateData, SelectFun)
    local gTable = { [excludeObj.getGUID()] = true }

    for k, coll in pairs(collList) do
        gTable[coll.getGUID()] = true
    end

    -- Find template origin and do special handling of special manouvers
    local templateOrigin = {}
    if templateData.extra == "reverse" then
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, "back")
        if templateData.dir == "left" then
            templateData.dir = "right"
        elseif templateData.dir == "right" then
            templateData.dir = "left"
        end
    elseif templateData.type == "straight" or templateData.type == "bank" or templateData.type == "turn" then
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, "front")
    elseif templateData.type:find("talon") then
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, "front")
        templateData.type = "turn"
    elseif templateData.type == "roll" then
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, templateData.dir)
        templateData.speed = 1
    elseif templateData.type == "viperF" or templateData.type == "viperB" then
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, templateData.dir)
        if templateData.dir == "right" and templateData.extra == "forward" then
            templateData.dir = "left"
        elseif templateData.dir == "left" and templateData.extra == "backward" then
            templateData.dir = "right"
        end
        templateData.speed = 1
        templateData.type = "bank"
    elseif templateData.type == "viperTurnF" or templateData.type == "viperTurnB" then
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, templateData.dir)
        if templateData.dir == "right" and templateData.extra == "forward" then
            templateData.dir = "left"
        elseif templateData.dir == "left" and templateData.extra == "backward" then
            templateData.dir = "right"
        end
        templateData.speed = 1
        templateData.type = "turn"
    elseif templateData.type == "bankSlip" then
        local template_pos = "left"
        if templateData.dir == "left" then
            template_pos = "right"
        end
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, template_pos)
        templateData.type = "bank"
    elseif templateData.type == "turnSlip" then
        local template_pos = "left"
        if templateData.dir == "left" then
            template_pos = "right"
        end
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, template_pos)
        templateData.type = "turn"
    elseif templateData.type == "echoF" then
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, templateData.dir)
        templateData.speed = 2
        templateData.type = "bank"
        if templateData.dir == "right" then
            templateData.dir = "left"
        elseif templateData.dir == "left" then
            templateData.dir = "right"
        end
    elseif templateData.type == "echoB" then
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, templateData.dir)
        templateData.speed = 2
        templateData.type = "bank"
    elseif templateData.type == "deCloak" then
        templateOrigin = MoveModule.GetTemplateOrigin(templateData.origin, templateData.orientation,
            templateData.shipSize, templateData.dir)
        if templateData.shipSize == "small" then
            templateData.speed = 2
        else
            templateData.speed = 1
        end
    else
        return
    end

    if templateData.type == "straight" or templateData.type == "roll" or templateData.type == "deCloak" then
        local offsetDistance = Dim.Convert_mm_igu(20) * tonumber(templateData.speed)
        local size = { Dim.Convert_mm_igu(20), Dim.Convert_mm_igu(6), templateData.speed * Dim.Convert_mm_igu(40) }
        if (templateData.type == "roll" or templateData.type == "deCloak") and templateData.shipSize ~= "small" then
            size = { Dim.Convert_mm_igu(40), Dim.Convert_mm_igu(6), Dim.Convert_mm_igu(20) }
            offsetDistance = Dim.Convert_mm_igu(10)
        end
        local offset = vector(offsetDistance * math.sin(math.rad(templateOrigin.rot.y)),
            0, offsetDistance * math.cos(math.rad(templateOrigin.rot.y)))

        local collissions = Physics.cast({
            origin = templateOrigin.pos + offset,
            orientation = templateOrigin.rot,
            direction = { 0, -0.001, 0 },
            type = 3,
            size = size,
            max_distance = 1,
            debug = cast_debug
        })

        MoveModule.AddCollissionEntry(gTable, collList, collissions, SelectFun)
    elseif templateData.type == "bank" then
        local radius = 0
        local iterations = 0
        if templateData.speed == 1 then
            radius = Dim.Convert_mm_igu(80)
            iterations = 10
        elseif templateData.speed == 2 then
            radius = Dim.Convert_mm_igu(130)
            iterations = 15
        elseif templateData.speed == 3 then
            radius = Dim.Convert_mm_igu(180)
            iterations = 20
        end
        local radianStep = math.pi / (4 * iterations)
        local dir_mod = 1
        if templateData.dir == "left" then
            dir_mod = -1
        end
        local c = math.cos(math.rad(templateOrigin.rot.y))
        local s = math.sin(math.rad(templateOrigin.rot.y))
        for i = 0, iterations do
            local radians = radianStep * i
            local orientation_offset = vector(0, math.deg(radians), 0)
            -- Calculate world position for template
            local pz = math.sin(radians) * radius
            local px = dir_mod * (1 - math.cos(radians)) * radius
            -- Translate point to template origin
            local position_offset = vector(px * c + pz * s, 0, pz * c - px * s)

            local collissions = Physics.cast({
                origin = templateOrigin.pos + position_offset,
                orientation = templateOrigin.rot + orientation_offset * dir_mod,
                direction = { 0, -0.001, 0 },
                type = 3,
                size = { Dim.Convert_mm_igu(20), Dim.Convert_mm_igu(6), Dim.Convert_mm_igu(1) },
                max_distance = 1,
                debug = cast_debug
            })
            MoveModule.AddCollissionEntry(gTable, collList, collissions, SelectFun)
        end
    elseif templateData.type == "turn" then
        local radius = 0
        if templateData.speed == 1 then
            radius = Dim.Convert_mm_igu(35)
        elseif templateData.speed == 2 then
            radius = Dim.Convert_mm_igu(62)
        elseif templateData.speed == 3 then
            radius = Dim.Convert_mm_igu(90)
        end
        local iterations = 10
        local radianStep = math.pi / (2 * iterations)
        local dir_mod = 1
        if templateData.dir == "left" then
            dir_mod = -1
        end
        local c = math.cos(math.rad(templateOrigin.rot.y))
        local s = math.sin(math.rad(templateOrigin.rot.y))
        for i = 0, iterations do
            local radians = radianStep * i
            local orientation_offset = vector(0, math.deg(radians), 0)
            -- Calculate world position for template
            local pz = math.sin(radians) * radius
            local px = dir_mod * (1 - math.cos(radians)) * radius
            -- Translate point to template origin
            local position_offset = vector(px * c + pz * s, 0, pz * c - px * s)

            local collissions = Physics.cast({
                origin = templateOrigin.pos + position_offset,
                orientation = templateOrigin.rot + orientation_offset * dir_mod,
                direction = { 0, -0.001, 0 },
                type = 3,
                size = { Dim.Convert_mm_igu(20), Dim.Convert_mm_igu(6), Dim.Convert_mm_igu(1) },
                max_distance = 1,
                debug = cast_debug
            })
            MoveModule.AddCollissionEntry(gTable, collList, collissions, SelectFun)
        end
    end
end


-- Adds objects from the collissions table to the collList if it pass the selectfun
-- and is not already present
-- Arguments:
--      gTable          <- GUID table, containing allready present objects
--      collList        <- List of hit objects that have passed the select fun
--      collissions     <- Table of hits returned from a Physics.cast()
--      SelectFun       <- Function that returns true if object if of correct type
MoveModule.AddCollissionEntry = function(gTable, collList, collissions, SelectFun)
    for k, hit in pairs(collissions) do
        if gTable[hit.hit_object.getGUID()] == nil and SelectFun(hit.hit_object) then
            gTable[hit.hit_object.getGUID()] = true
            table.insert(collList, hit.hit_object)
        end
    end
end

-- Return all position and rotation for a template originating position based on ship size and direction
-- Arguments:
--      shipOrigin      <- The ship origin
--      shipOrientation <- Orientation of the ship
--      shipSize        <- Size of the ship (small, medium, large)
--      templateDir     <- Which direction to get position and orientation for
-- Return:
--      TemplateOrigin (position and rotation)
MoveModule.GetTemplateOrigin = function(shipOrigin, shipOrientation, shipSize, templateDir)
    -- OBS: Ships are placed backwards
    roty = shipOrientation.y + 180
    if templateDir == "left" then
        roty = roty - 90
    elseif templateDir == "right" then
        roty = roty + 90
    elseif templateDir == "back" then
        roty = roty - 180
    end

    local distance = Dim.Convert_mm_igu(20)
    if shipSize == "medium" then
        distance = Dim.Convert_mm_igu(30)
    elseif shipSize == "large" then
        distance = Dim.Convert_mm_igu(40)
    end

    local position = shipOrigin + vector(distance * math.sin(math.rad(roty)), 0, distance * math.cos(math.rad(roty)))

    return { pos = position, rot = vector(shipOrientation.x, roty, shipOrientation.z) }
end


-- Check if provided ship in a provided position/rotation would collide with anything from the provided table
-- Return: {coll=collObject, minMargin=howFarCollisionIsStillCertain, numCheck=numCollideChecks}
MoveModule.CheckCollisions = function(ship, shipPosRot, collShipTable)
    local info = { coll = nil, minMargin = 0, numCheck = 0, numCast = 0 }
    local shipInfo = { pos = shipPosRot.pos, rot = shipPosRot.rot, ship = ship }
    local shipSize = ship.getTable("Data").Size or 'small'
    local certShipReach = Dim.Convert_mm_igu(Dim.mm_baseSize[shipSize] / 2)               -- distance at which other ships MUST bump it
    local maxShipReach = Dim.Convert_mm_igu(Dim.mm_baseSize[shipSize] * math.sqrt(2) / 2) -- distance at which other ships CAN bump it

    --for k, collShip in pairs(collShipTable) do
    --    local collShipSize = collShip.getTable("Data").Size or 'small'
    --    local certBumpDist = certShipReach + Dim.Convert_mm_igu(Dim.mm_baseSize[collShipSize]/2)            -- distance at which these two particular ships ships MUST bump
    --    local maxBumpDist = maxShipReach + Dim.Convert_mm_igu(Dim.mm_baseSize[collShipSize]*math.sqrt(2)/2) -- distance at which these two particular ships ships CAN bump
    --
    --        local dist = Vect.Distance(shipPosRot.pos, collShip.getPosition())
    --        if dist < maxBumpDist then
    --            if dist < certBumpDist then
    --                info.coll = collShip
    --                if certBumpDist - dist > info.minMargin then
    --                    info.minMargin = certBumpDist - dist
    --                end
    --            elseif collide(shipInfo, {pos=collShip.getPosition(), rot=collShip.getRotation(), ship=collShip}) == true then
    --                info.coll = collShip
    --                info.numCheck = info.numCheck + 1
    --                break
    --            end
    --        end
    --    end
    if info.coll == nil then
        local hTable = {}
        if shipSize == 'huge' then
            hTable = MoveModule.FullCastCheck(ship, shipPosRot, MoveModule.SelectHugeShips)
        else
            hTable = MoveModule.FullCastCheck(ship, shipPosRot, MoveModule.SelectShips)
        end
        info.coll = hTable[1]
        info.collidingShips = hTable
    end
    return info
end

MoveModule.partResolutionRough = 1 / 100 -- Resolution for rough checks (guaranteed)
MoveModule.partResolutionFine = 1 / 1000 -- Resolution for fine checks  (for forward adjust)

-- Module for trying and finding free positions
MoveModule.MoveProbe = {}

-- Get near ships when trying a move that allows for partial execution
-- Args: SEE MoveModule.MoveProbe.GetFreePart
-- Return: {shipRef1, shipRef2, ... , shipRefN}
MoveModule.MoveProbe.GetShipsNearPart = function(info, ship, partFun, partRange)
    local middlePart = (partRange.to - partRange.from) / 2
    local maxShipReach = Dim.Convert_mm_igu(Dim.mm_baseSize[info.size] * math.sqrt(2)) / 2
    local moveReach = math.max(
        Vect.Distance(partFun(info.code, ship, middlePart).pos, partFun(info.code, ship, partRange.to).pos),
        Vect.Distance(partFun(info.code, ship, middlePart).pos, partFun(info.code, ship, partRange.from).pos))
    local collShipRange = moveReach + maxShipReach + Dim.Convert_mm_igu(Dim.mm_largeBase * math.sqrt(2)) / 2 +
        Dim.Convert_mm_igu(10)
    return ObjType.GetNearOfType(partFun(info.code, ship, MoveData.partMax / 2).pos, collShipRange, 'ship', { ship })
end
-- Get first free part for a partial-enabled move (going through parts as partRange specifies)
-- Args:
--      info        <- move info as per MoveData.DecodeInfo
--      ship        <- object ref to a ship we want to move
--      partFun     <- function that takes (moveInfo, shipRef, part) and returns {pos=position, rot=rotation} (pure data, ignores collisions)
--      partRange   <- { from = partValueFromToCheck, to = partValueToCheckTo} ((from < to), (from > to) and (from == to) to all handled)
-- Return:  {
--      part        <- number of the part that was last checked (first free if other args specify free part was found)
--      info        <- nil if free part was found sowmehere, 'first' if partRange.from was free, 'overlap' if no part was free
--      collObj     <- nil if first part was free, object ref to last colliding ship otherwise
--          }
MoveModule.MoveProbe.GetFreePart = function(info, ship, partFun, partRange, moveLength)
    if moveLength == nil then
        moveLength = 0
    end
    moveLength = Dim.Convert_mm_igu(moveLength)
    local out = { part = nil, info = nil, collObj = nil }
    local checkNum = { rough = 0, fine = 0 }

    -- Get ships that *can* possibly collide during this move
    local collShips = MoveModule.MoveProbe.GetShipsNearPart(info, ship, partFun, partRange)

    -- Current part and part delts for ROUGH CHECKING
    local actPart = partRange.from
    local partDelta = math.sgn(partRange.to - partRange.from) * (MoveData.partMax * MoveModule.partResolutionRough)
    local minPartDelta = math.abs(partDelta)
    local collision = false

    -- Collision check, then part delta step or margin step
    repeat
        local nPos = partFun(info.code, ship, actPart)
        local collInfo = MoveModule.CheckCollisions(ship, nPos, collShips)
        checkNum.rough = checkNum.rough + collInfo.numCheck
        local distToSkip = nil
        if collInfo.coll ~= nil then
            collision = true
            distToSkip = collInfo.minMargin
            -- If there is a distance we can travel that assures collison will not end
            if distToSkip > 0 then
                -- Calculate how big part it is and skip away
                partDelta = math.sgn(partDelta) * ((distToSkip * MoveData.partMax) / moveLength)
                if math.abs(partDelta) < minPartDelta then
                    partDelta = math.sgn(partDelta) * minPartDelta
                end
            else
                partDelta = math.sgn(partDelta) * minPartDelta
            end
        else
            collision = false
        end
        if collision == true then
            out.collObj = collInfo.coll
            actPart = actPart + partDelta
        end
        -- until we're out of collisions OR we're out of part range
    until collision == false or ((partRange.to - actPart) * math.sgn(partDelta) < 0) or partDelta == 0

    if collision == false and partDelta ~= 0 and actPart ~= partRange.from then
        -- Right now, we're out of any collisions or at part 0 (no move)
        -- Go fineResolution of a move forward until we have a collision, then skip one back
        partDelta = math.sgn(partRange.to - partRange.from) * (MoveData.partMax * MoveModule.partResolutionFine) * -1
        local collInfo = nil
        repeat
            local nPos = partFun(info.code, ship, actPart)
            collInfo = MoveModule.CheckCollisions(ship, nPos, { out.collObj })
            checkNum.fine = checkNum.fine + collInfo.numCheck
            if collInfo.coll ~= nil then
                collision = true
            else
                collision = false
            end
            actPart = actPart + partDelta
        until collision == true or (partRange.from - actPart) * math.sgn(partDelta) < 0
        actPart = actPart - 2 * partDelta
        out.collObj = collInfo.coll -- This is what we hit
        out.part = actPart
    elseif collision == false then
        -- This happens if rough check didn't do anything (first part free, but no fullMove function)
        out.part = actPart
        out.info = 'first'
    elseif collision == true then
        -- This happens if rough check didn't escape collisions (no free part)
        out.info = 'overlap'
        out.part = partRange.to
    end
    -- print('-- GetFreePart CHECK_COUNT: ' .. checkNum.rough+checkNum.fine .. ' (' .. checkNum.rough .. ' + ' .. checkNum.fine .. ')')
    return out
end
-- Get near ships when trying a move that only allows for full execution
-- Args: SEE MoveModule.MoveProbe.TryFullMove
-- Return: {shipRef1, shipRef2, ... , shipRefN}
MoveModule.MoveProbe.GetShipsNearFull = function(info, ship, fullFun)
    local maxShipReach = Dim.Convert_mm_igu(Dim.mm_baseSize[info.size] * math.sqrt(2)) / 2
    local collShipRange = maxShipReach + Dim.Convert_mm_igu(Dim.mm_largeBase * math.sqrt(2)) / 2 + Dim.Convert_mm_igu(10)
    return ObjType.GetNearOfType(fullFun(info.code, ship).pos, collShipRange, 'ship', { ship })
end

-- Get near huge ships when trying a move that only allows for full execution
-- Args: SEE MoveModule.MoveProbe.TryFullMove
-- Return: {shipRef1, shipRef2, ... , shipRefN}
MoveModule.MoveProbe.GetHugeShipsNearFull = function(info, ship, fullFun)
    local shipsfound = MoveModule.MoveProbe.GetShipsNearFull(info, ship, fullFun)
    shipsfound = table.sieve(shipsfound, function(obj)
        return (obj.getTable('Data').Size == 'huge')
    end)
    return shipsfound
end

-- Try a full version of a move
-- Args:
--      info        <- move info as per MoveData.DecodeInfo
--      ship        <- object ref to a ship we want to move
--      fullFun     <- function that takes (moveInfo, shipRef) and returns {pos=position, rot=rotation} (pure data, ignores collisions)
-- Return:  {
--      done        <- TRUE if move was completed, FALSE if it was obstructed
--      finalPosRot <- the final position and rotation after this move
--      collObj     <- nil if completed, object ref to colliding ship otherwise
--      collObs     <- nil if no obstacle moved over, object ref to obstacle if otherwise
--          }
MoveModule.MoveProbe.TryFullMove = function(info, ship, fullFun)
    local collShips = nil
    if info.size == 'huge' then
        collShips = MoveModule.MoveProbe.GetHugeShipsNearFull(info, ship, fullFun)
    else
        collShips = MoveModule.MoveProbe.GetShipsNearFull(info, ship, fullFun)
    end
    local out = { done = nil, finalPosRot = nil, collObj = nil, collObs = nil }
    local checkNum = 0

    local startPosRot = { ['pos'] = ship.GetPosition(), ['rot'] = ship.GetRotation() }
    local finalPosRot = fullFun(info.code, ship)
    out.finalPosRot = finalPosRot

    -- Ship-to-ship collisions
    fullInfo = MoveModule.CheckCollisions(ship, finalPosRot, collShips)
    checkNum = checkNum + fullInfo.numCheck
    if fullInfo.coll == nil then
        out.done = true
    else
        out.done = false
        out.collObj = fullInfo.coll
        out.friendlyCollission = false
        local shipOwner = ship.getVar("owningPlayer")
        for _, colship in pairs(fullInfo.collidingShips or {}) do
            if colship.getVar("owningPlayer") == shipOwner then
                out.friendlyCollission = true
            end
        end
    end

    -- Ship-to-obstacle collisions
    -- Get any obstacles that we're currently overlapping, and ignore them
    -- for the template check (but not for the final position check)
    local startingObstacleCollisions = MoveModule.CheckMineAndObstacleCollisions(ship, startPosRot, false, nil)

    local templateData = {
        origin = ship.GetPosition(),
        orientation = ship.GetRotation(),
        dir = info.dir,
        speed = info.speed,
        type = info.type,
        shipSize = info.size,
        extra = info.extra
    }
    -- Do the template and final position check
    local endingObstacleCollisions = MoveModule.CheckMineAndObstacleCollisions(ship, finalPosRot, false, templateData,
        startingObstacleCollisions)
    if #endingObstacleCollisions ~= 0 then
        out.collObs = endingObstacleCollisions[1]
    end

    return out
end

-- Get the FINAL position for a given move, including partial move and collisions
-- Follows traits from MoveData.DecodeInfo to try different move functions
-- Return:  {
--      finType     <- 'move' when did full/part mvoe
--                     'stationary' when there was no position change (rotation change allowed)
--                     'overlap' if there was no valid free target position
--                     IF OVERLAP, OTHER KEYS ARE TO BE IGNORED
--      finPos      <- { pos = finalPosition, rot = finalRotation }
--      collObj     <- nil if no collision, object ref to colliding ship otherwise
--      finPart     <- part of partial move performed, 'max' if full move, nil if not applicable
--          }
MoveModule.GetFinalPosData = function(move_code, ship, ignoreCollisions)
    local out = { finPos = nil, collObj = nil, finType = nil, finPart = nil, friendlyCollission = false }
    local info = MoveData.DecodeInfo(move_code, ship)

    -- Don't bother with collisions if it's stationary
    if info.size ~= 'huge' and info.speed == 0 then
        ignoreCollisions = true
    end

    -- NON-COLLISION VERSION
    if ignoreCollisions then
        if info.traits.full == true then
            -- If full moves are allowed, get a full move
            out.finPos = MoveModule.GetFullMove(info.code, ship)
            if info.speed == 0 then
                out.finType = 'stationary'
            else
                out.finType = 'move'
            end
            out.finPart = 'max'
            return out
        elseif info.traits.part == true then
            -- If partial moves are allowed, get max part move
            out.finPos = MoveModule.GetPartMove(info.code, ship, MoveData.partMax)
            out.finType = 'move'
            out.finPart = 'max'
            return out
        end

        -- COLLISION VERSION
    else
        -- If move allows for full move check, try it
        if info.traits.full == true then
            local fullData = MoveModule.MoveProbe.TryFullMove(info, ship, MoveModule.GetFullMove)
            out.friendlyCollission = fullData.friendlyCollission
            while info.size == 'huge' and fullData.done == false do
                out.collObj = fullData.collObj
                info.speed = info.speed - 1
                info.extra = nil
                if info.speed == -1 then
                    out.finType = 'overlap'
                    out.finPos = { pos = ship.getPosition(), rot = ship.getRotation() }
                    return out
                else
                    info.code = string.gsub(info.code, "%d", info.speed)
                    info.code = string.gsub(info.code, "k", "s")
                end
                fullData = MoveModule.MoveProbe.TryFullMove(info, ship, MoveModule.GetFullMove)
            end
            if fullData.done == true then
                out.finPos = MoveModule.GetFullMove(info.code, ship)
                out.finType = 'move'
                out.finPart = 'max'
                return out
            end
        end
        -- If move allows for partial execution, try to find a free part
        if info.traits.part == true then
            local partRange = { from = MoveData.partMax, to = 0 }
            local freePartData = MoveModule.MoveProbe.GetFreePart(info, ship, MoveModule.GetPartMove, partRange,
                MoveData.MoveLength(info))
            if freePartData.info ~= 'overlap' then
                out.finPos = MoveModule.GetPartMove(info.code, ship, freePartData.part)
                out.finType = 'move'
                out.finPart = freePartData.part
                out.collObj = freePartData.collObj
                return out
            end
        end
        -- If nothing worked out, we have an all-overlap
        out.finType = 'overlap'
        out.finPos = { pos = ship.getPosition(), rot = ship.getRotation() }
        return out
    end
end


-- Move ship to some position and handle stuff around it
-- If move is not stationary, clear target position and move tokens with it
-- Add history entry if save move name is provided
-- Args:
--      ship        <- object reference to ship to move
--      finData     <- {pos = targetPos, rot=targetRot}
--      saveName    <- move code for history save, no save done if nil
--      finFunction <- optional, function to call when the ship has come to rest
--      waitForTokens <- optional, whether or not we have to wait for the ships tokens to also come to a rest
MoveModule.MoveShip = function(ship, finData, saveName, finFunction, waitForTokens)
    if not ShipVerification.VerifyShipBase(ship) then
        return
    end
    XW_cmd.SetBusy(ship)
    MoveModule.RemoveOverlapReminder(ship)
    if finData.type ~= 'stationary' then
        TokenModule.QueueShipTokensMove(ship)
        local baseSize = ship.getTable("Data").Size or 'small'
        local shipReach = Dim.Convert_mm_igu(Dim.mm_baseSize[baseSize] + 5) * (math.sqrt(2) / 2)
        TokenModule.ClearPosition(finData.finPos.pos, shipReach, ship)
    end
    local finPos = finData.finPos
    if finData.noSave ~= true then
        MoveModule.SaveStateToHistory(ship, true)
    end
    ship.setPositionSmooth(finPos.pos, false, true)
    ship.setRotationSmooth(finPos.rot, false, true)
    -- Wait for resting, but provide final position to set so smooth move doesn't fuck with accuracy
    MoveModule.WaitForResting(ship, finPos, finFunction, waitForTokens)
    if saveName ~= nil then
        MoveModule.AddHistoryEntry(ship,
            { pos = finPos.pos, rot = finPos.rot, move = saveName, part = finData.finPart, finType = finData.finType })
    end
end



-- This part controls the waiting part of moving
-- Basically, if anything needs to be done after the ship rests, this can trigger it

-- Ships waiting to be resting
-- Entry: {ship = shipRef, finPos={pos=posToSet, rot=rotToSet}}
MoveModule.restWaitQueue = {}

-- Tokens waiting to be moved with ships
-- Entry: { tokens={t1, t2, ... , tN}, ship=shipWaitingFor }
-- tX: {ref = tokenRef, relPos = pos, relRot = rot}
-- elements wait here until ships are ready
MoveModule.tokenWaitQueue = {}

-- Add ship to the queue so it fires once it completes the move
-- OPTIONAL: finPos     <- position to be set at the end of the wait
-- OPTIONAL: finFun     <- function to be execeuted at the end of the wait (argument: waiting ship)
-- OPTIONAL: tokens     <- whether we also have to wait for the ship's tokens to finish moving afterwards.
MoveModule.WaitForResting = function(ship, finPos, finFun, waitForTokens)
    table.insert(MoveModule.restWaitQueue,
        { ship = ship, finPos = finPos, finFun = finFun, waitForTokens = waitForTokens })
    startLuaCoroutine(Global, 'restWaitCoroutine')
end

-- This completes when a ship is resting at a table level
-- Does token movement and ship locking after
-- IF a final position was provided in the data table, set it at the end
-- IF a final function was provideed in the data table, execute it at the end
function restWaitCoroutine()
    if MoveModule.restWaitQueue[1] == nil then
        return 1
    end

    local waitData = MoveModule.restWaitQueue[#MoveModule.restWaitQueue]
    local actShip = waitData.ship
    local finPos = waitData.finPos
    local finFun = waitData.finFun
    local waitForTokens = waitData.waitForTokens
    table.remove(MoveModule.restWaitQueue, #MoveModule.restWaitQueue)
    -- Wait
    repeat
        coroutine.yield(0)
    until actShip.resting == true and actShip.isSmoothMoving() == false and actShip.held_by_color == nil

    if finPos ~= nil then
        actShip.setPosition(finPos.pos)
        actShip.setRotation(finPos.rot)
    end

    local newTokenTable = {}
    for k, tokenSetInfo in pairs(MoveModule.tokenWaitQueue) do
        -- Move and pop waiting tokens
        if tokenSetInfo.ship == actShip then
            for k2, tokenData in pairs(tokenSetInfo.tokens) do
                local offset = Vect.RotateDeg(tokenData.relPos, actShip.getRotation()[2])
                local dest = Vect.Sum(offset, actShip.getPosition())
                dest[2] = dest[2] + 0.5
                dest = TokenModule.VisiblePosition(tokenData.ref, tokenSetInfo.ship, dest)
                tokenData.ref.setPositionSmooth(dest, false, true)
                local tRot = tokenData.ref.getRotation()
                tokenData.ref.setRotationSmooth({ tRot[1], actShip.getRotation()[2] + tokenData.relRot, tRot[3] })
                tokenData.ref.highlightOn({ 0, 1, 0 }, 2)
            end
        else
            -- Index back tokens that are not waiting for this ship
            table.insert(newTokenTable, tokenSetInfo)
        end
    end

    if waitForTokens == true then
        repeat
            coroutine.yield(0)
        until TokenModule.DoesShipHasAnySmoothMovingTokens(actShip) == false
    end

    MoveModule.tokenWaitQueue = newTokenTable
    actShip.lock()
    actShip.highlightOn({ 0, 1, 0 }, 0.1)
    XW_cmd.SetReady(actShip)
    if finFun ~= nil then
        finFun(actShip)
    end
    return 1
end

-- Perform move designated by move_code on a ship and announce the result
-- How move is preformed generally relies on MoveData.DecodeInfo for its code
-- Includes token handling so nothing obscurs the final position
-- Starts the wait coroutine that handles stuff done when ship settles down
-- Takes two optional parameters, the function to call at the end of the move,
-- and whether we have to wait for the tokens to come to a rest before calling
-- it.
MoveModule.PerformMove = function(move_code, ship, ignoreCollisions, finishFunction, waitForTokens)
    ship.lock()
    local originalPos = ship.getPosition()
    local origionalRot = ship.getRotation()
    local info = MoveData.DecodeInfo(move_code, ship)
    local finData = MoveModule.GetFinalPosData(move_code, ship, ignoreCollisions)
    local annInfo = {
        type = finData.finType,
        note = info.note,
        code = info.code,
        friendlyCollission = finData
            .friendlyCollission
    }
    if finData.finType == 'overlap' then
        annInfo.note = info.collNote
    elseif finData.finType == 'move' then
        if finData.collObj ~= nil then
            annInfo.note = info.collNote
            annInfo.collidedShip = finData.collObj
        end
    elseif finData.finType == 'stationary' then
        -- And here as well
    end

    if finData.finType ~= 'overlap' then
        MoveModule.MoveShip(ship, finData, move_code, finishFunction, waitForTokens)
        if finData.collObj ~= nil then
            MoveModule.SpawnOverlapReminder(ship)
        end
    end
    AnnModule.Announce(annInfo, 'all', ship)

    local templateData = {
        origin = originalPos,
        orientation = origionalRot,
        dir = info.dir,
        speed = info.speed,
        type = info.type,
        shipSize = info.size,
        extra = info.extra
    }

    MoveModule.CheckMineAndObstacleCollisions(ship, finData.finPos, true, templateData)
    if ((finData.collObj == nil) and ship.getTable('Data').movethrough) then
        MoveModule.CheckMovethroughShips(ship, true, templateData)
    end
    return (finData.finType ~= 'overlap')
end

-- Spawn a 'BUMPED' informational button on the base that removes itself on click or next move
MoveModule.SpawnOverlapReminder = function(ship)
    Ship_RemoveOverlapReminder(ship)
    remindButton = { click_function = 'Ship_RemoveOverlapReminder', label = 'BUMPED', rotation = { 0, 0, 0 }, width = 1000, height = 350, font_size = 250 }

    local size = ship.getTable("Data").Size or 'small'
    if size == 'large' then
        remindButton.position = { 0, 0.2, 2 }
    elseif size == 'medium' then
        remindButton.position = { 0, 0.2, 1.4 }
    else
        remindButton.position = { 0, 0.3, 0.8 }
    end
    ship.createButton(remindButton)
end

-- Remove the 'BUMPED' dummy button from a ship
MoveModule.RemoveOverlapReminder = function(ship)
    local buttons = ship.getButtons()
    if buttons ~= nil then
        for k, but in pairs(buttons) do
            if but.label == 'BUMPED' then
                ship.removeButton(but.index)
            end
        end
    end
end

-- Check if a ship in some situation is overlapping any obstacles
-- Highlight overlapped obstacles red
-- If 'vocal' set to true, add a notification
-- Return table of overlapped obstacles
MoveModule.CheckObstacleCollisions = function(ship, targetPosRot, vocal, templateData)
    local collList = MoveModule.FullCastCheck(ship, targetPosRot, MoveModule.SelectObstacles)
    if templateData ~= nil then
        MoveModule.TemplateCastCheck(ship, collList, templateData, MoveModule.SelectObstacles)
    end
    if collList[1] ~= nil then
        local obsList = '('
        for k, obs in pairs(collList) do
            obs.highlightOn({ 1, 0, 0 }, 3)
            obsList = obsList .. obs.getName() .. ', '
        end
        obsList = obsList:sub(1, -3) .. ')'
        if vocal then
            AnnModule.Announce(
                { type = 'warn', note = ship.getName() .. ' appears to have overlapped an obstacle ' .. obsList }, 'all')
        end
    end
    return collList
end



-- Check if a ship in some situation is overlapping any mine tokens
-- Highlight overlapped tokens red
-- If 'vocal' set to true, add a notification
-- Return table of overlapped tokens
--TODO maybe check mine colision after bomb drop?
MoveModule.CheckMineCollisions = function(ship, targetPosRot, vocal, templateData)
    local collList = MoveModule.FullCastCheck(ship, targetPosRot, MoveModule.SelectMineTokens)
    if templateData ~= nil then
        MoveModule.TemplateCastCheck(ship, collList, templateData, MoveModule.SelectMineTokens)
    end
    if collList[1] ~= nil then
        local mineList = '('
        for k, mine in pairs(collList) do
            mine.highlightOn({ 1, 0, 0 }, 3)
            mineList = mineList .. mine.getName() .. ', '
        end
        mineList = mineList:sub(1, -3) .. ')'
        if vocal then
            AnnModule.Announce(
                { type = 'warn', note = ship.getName() .. ' appears to have overlapped a mine token ' .. mineList },
                'all')
        end
    end
    return collList
end

MoveModule.CheckMineAndObstacleCollisions = function(ship, targetPosRot, vocal, templateData, ignoredTemplateObstacles)
    local collList = MoveModule.FullCastCheck(ship, targetPosRot, MoveModule.SelectMinesAndObstacleTokens)
    if templateData ~= nil then
        MoveModule.TemplateCastCheck(ship, collList, templateData, function(obj)
            if ignoredTemplateObstacles ~= nil then
                for _, ignoredTemplate in pairs(ignoredTemplateObstacles) do
                    if obj == ignoredTemplate then
                        return false
                    end
                end
            end
            return MoveModule.SelectMinesAndObstacleTokens(obj)
        end)
    end
    if vocal then
        if collList[1] ~= nil then
            local hitList = '('
            for k, hitObj in pairs(collList) do
                hitObj.highlightOn({ 1, 0, 0 }, 3)
                hitList = hitList .. hitObj.getName() .. ', '
            end
            hitList = hitList:sub(1, -3) .. ')'
            AnnModule.Announce(
                {
                    type = 'warn',
                    note = ship.getName() ..
                        ' appears to have overlapped a mine or obstacle token ' .. hitList
                },
                'all')
        end
    end
    return collList
end

MoveModule.CheckMovethroughShips = function(ship, vocal, templateData)
    collList = {}
    if templateData ~= nil then
        MoveModule.TemplateCastCheck(ship, collList, templateData, MoveModule.SelectShips)
    end
    if vocal then
        for i, coll in pairs(collList) do
            AnnModule.Announce({
                type = 'warn',
                note = ship.getName() ..
                    ' appears to have moved through ' .. coll.getName()
            }, 'all')
            coll.highlightOn({ 0.2, 0.2, 1 }, 3)
        end
    end
    return collList
end

-- Remove the 'BUMPED' button from a ship (click function)
function Ship_RemoveOverlapReminder(ship)
    MoveModule.RemoveOverlapReminder(ship)
end

-- Check which ship has it's base closest to position (large ships have large bases!), that's the owner
--   also check how far it is to the owner-changing position (margin of safety)
-- Kinda tested: margin > 20mm = visually safe
-- Arg can be a token ref or a position
-- Returns {dist=distanceFromOwner, owner=ownerRef, margin=marginForNextCloseShip}
MoveModule.GetTokenOwner = function(tokenPos)
    local out = { owner = nil, dist = 0, margin = -1 }
    local nearShips = ObjType.GetNearOfType(tokenPos, Dim.Convert_mm_igu(120), 'ship')
    if nearShips[1] == nil then
        return out
    end
    local baseDist = {}
    -- Take the base size into account for distances
    for k, ship in pairs(nearShips) do
        local realDist = Vect.Distance(tokenPos, ship.getPosition())
        local size = ship.getTable("Data").Size or 'small'
        if size == 'large' then
            realDist = realDist - Dim.Convert_mm_igu(10)
        elseif size == 'medium' then
            realDist = realDist - Dim.Convert_mm_igu(5)
        elseif size == 'huge' then
            realDist = realDist - Dim.Convert_mm_igu(15) -- Todo, check if this arbetary number works
        end
        table.insert(baseDist, { ship = ship, dist = realDist })
    end
    local nearest = baseDist[1]
    for k, data in pairs(baseDist) do
        if data.dist < nearest.dist then
            nearest = data
        end
    end
    local nextNearest = { dist = 999 }
    for k, data in pairs(baseDist) do
        if data.ship ~= nearest.ship and (data.dist < nextNearest.dist) then
            nextNearest = data
        end
    end
    return { owner = nearest.ship, dist = nearest.dist, margin = (nextNearest.dist - nearest.dist) / 2 }
end

-- END MAIN MOVEMENT MODULE
--------

--------
-- TOKEN MODULE
-- Moves tokens, clears positions from tokens, checks its owners, deducts a visible position after a ship move

-- Table with refs for different token and template sources
TokenModule = {
    tokenSize = 1,
    tokenSources = {},
    tokenAssignments = {},
    scaleModifiers = { [1] = 1.0, [2] = 1.5, [3] = 2.0 },
}

-- Update token and template sources on each load
TokenModule.onLoad = function(save_data)
    if save_data then
        TokenModule.tokenSize = save_data.tokenSize
    end

    for k, obj in pairs(getAllObjects()) do
        if obj.tag == 'Infinite' then
            if obj.getName() == 'Focus' then
                TokenModule.tokenSources.Focus = { src = obj, hlColor = { 0, 0.5, 0 } }
            elseif obj.getName() == 'Calculate' then
                TokenModule.tokenSources.Calculate = { src = obj, hlColor = { 0, 1, 0 } }
            elseif obj.getName() == 'Evade' then
                TokenModule.tokenSources.Evade = { src = obj, hlColor = { 0, 1, 0 } }
            elseif obj.getName() == 'Stress' then
                TokenModule.tokenSources.Stress = { src = obj, hlColor = { 0.8, 0, 0 } }
            elseif obj.getName() == 'Strain' then
                TokenModule.tokenSources.Strain = { src = obj, hlColor = { 0.8, 0, 0 } }
            elseif obj.getName() == 'Deplete' then
                TokenModule.tokenSources.Deplete = { src = obj, hlColor = { 0.8, 0, 0 } }
            elseif obj.getName() == 'Ion' then
                TokenModule.tokenSources.Ion = { src = obj, hlColor = { 0.8, 0, 0 } }
            elseif obj.getName() == 'Jam' then
                TokenModule.tokenSources.Jam = { src = obj, hlColor = { 0.8, 0, 0 } }
            elseif obj.getName() == 'Tractor' then
                TokenModule.tokenSources.Tractor = { src = obj, hlColor = { 0.8, 0, 0 } }
            elseif obj.getName() == 'Disarm' then
                TokenModule.tokenSources.Disarm = { src = obj, hlColor = { 0.8, 0, 0 } }
            elseif obj.getName() == 'Reinforce' then
                TokenModule.tokenSources.Reinforce = { src = obj, hlColor = { 0.8, 0, 0 } }
            elseif obj.getName() == 'Cloak' then
                TokenModule.tokenSources.Cloak = { src = obj, hlColor = { 0.8, 0, 0 } }
            elseif obj.getName() == 'Target Locks' then
                TokenModule.tokenSources['Target Lock'] = { src = obj, hlColor = { 0, 0, 1 } }
            elseif obj.getName():find('Templates') ~= nil then
                if obj.getName():find('Straight') ~= nil then
                    TokenModule.tokenSources['s' .. obj.getName():sub(1, 1)] = obj
                elseif obj.getName():find('Turn') ~= nil then
                    TokenModule.tokenSources['t' .. obj.getName():sub(1, 1)] = obj
                elseif obj.getName():find('Bank') ~= nil then
                    TokenModule.tokenSources['b' .. obj.getName():sub(1, 1)] = obj
                end
            end
        end
    end
end

TokenModule.onSave = function()
    local saveData = {}
    saveData.tokenSize = TokenModule.tokenSize
    -- return JSON.encode(saveData)
    return saveData
end

SaveManager.Register('TokenModule', TokenModule.onSave, TokenModule.onLoad)

TokenModule.onObjectDestroyed = function(destroyed_object)
    if TokenModule.tokenAssignments[destroyed_object.getGUID()] ~= nil then
        TokenModule.tokenAssignments[destroyed_object.getGUID()].call("RemoveToken", { token = destroyed_object })
        TokenModule.tokenAssignments[destroyed_object.getGUID()] = nil
    end
end

TokenModule.onObjectDropped = function(player_color, object)
    if not isAssignable(object) then
        return
    end

    if object.getVar('__XW_TokenType') == 'targetLock' then
        return
    end

    local nearest = FindNearestShip(object, 100)
    TokenModule.AssignToken(object, nearest)
end

function isAssignable(object)
    -- Target lock has special onDrop handling on its own
    return object.getVar('__XW_TokenType') ~= 'targetLock'
        and ObjType.IsOfType(object, 'assignable_token')
end

EventSub.Register('onObjectDropped', TokenModule.onObjectDropped)

TokenModule.removeOnFlip = function(object, player)
    local ship = Global.call("getShipTokenIsAssignedTo", { token = object })
    local color = Color.fromString(player.color):toHex()
    local player = player.steam_name
    local token = object.getName()

    if ship then
        printToAll(string.format("[%s]%s spent %s's %s token[-]", color, player, ship.getName(), token))
    else
        printToAll(string.format("[%s]%s spent a %s token[-]", color, player, token))
    end

    object.destruct()
end

-- How far can tokens be to be considered owned bya  ship
TokenModule.tokenReachDistance = Dim.Convert_mm_igu(100)
-- By how much this token has to be distant from other ship "interception zone" to be visible
-- (how far from an owner-switching-border it has to be so you can see whose it is)
TokenModule.visibleMargin = Dim.Convert_mm_igu(20)

-- Preset positions for tokens on and near the base
-- Generally used only when their current position switches its owner after a move
-- Positions on the base

TokenModule.basePos = {}

-- On base - small ships
TokenModule.basePos.small = {}
TokenModule.basePos.small.Focus = { 12, 12 }
TokenModule.basePos.small.Calculate = { 12, 24 }
TokenModule.basePos.small.Evade = { 12, -12 }
TokenModule.basePos.small.Stress = { -12, 12 }
TokenModule.basePos.small.Ion = { -12, -24 }
TokenModule.basePos.small.Strain = { -12, 24 }
TokenModule.basePos.small.Deplete = { -12, 36 }

TokenModule.basePos.small.Reinforce = { -24, 24 }
TokenModule.basePos.small.Cloak = { -24, -24 }
TokenModule.basePos.small.Jam = { 24, -12 }
TokenModule.basePos.small.Disarm = { 24, 12 }
TokenModule.basePos.small.Tractor = { 24, 24 }

TokenModule.basePos.small.rest = { -12, -12 }

--On base - medium ships
TokenModule.basePos.medium = {}
TokenModule.basePos.medium.Focus = { 25, 25 }
TokenModule.basePos.medium.Calculate = { 25, 35 }
TokenModule.basePos.medium.Evade = { 25, -25 }
TokenModule.basePos.medium.Stress = { -25, 25 }
TokenModule.basePos.medium.Ion = { -25, -35 }
TokenModule.basePos.medium.Strain = { -25, 35 }
TokenModule.basePos.medium.Deplete = { -25, -45 }

TokenModule.basePos.medium.Reinfoce = { -35, 35 }
TokenModule.basePos.medium.Cloak = { -35, -35 }
TokenModule.basePos.medium.Jam = { 35, -25 }
TokenModule.basePos.medium.Disarm = { 35, 25 }
TokenModule.basePos.medium.Tractor = { 35, 35 }

TokenModule.basePos.medium.rest = { -25, -25 }

-- On base - large ships
TokenModule.basePos.large = {}
TokenModule.basePos.large.Focus = { 30, 30 }
TokenModule.basePos.large.Calculate = { 30, 40 }
TokenModule.basePos.large.Evade = { 30, 0 }
TokenModule.basePos.large.Stress = { 30, -30 }
TokenModule.basePos.large.Strain = { 30, -40 }
TokenModule.basePos.large.Deplete = { -30, -40 }
TokenModule.basePos.large.Tractor = { -30, 30 }
TokenModule.basePos.large.Ion = { -30, 0 }
TokenModule.basePos.large.Lock = { 0, 30 }

TokenModule.basePos.large.Cloak = { 30, 30 }
TokenModule.basePos.large.Reinforce = { -30, 30 }
TokenModule.basePos.large.Jam = { -30, -30 }
TokenModule.basePos.large.Disarm = { 40, 30 }

TokenModule.basePos.large.rest = { -30, -30 }

-- On base - huge ships
TokenModule.basePos.huge = {}
TokenModule.basePos.huge.Focus = { 30, 30 }
TokenModule.basePos.huge.Calculate = { 30, 40 }
TokenModule.basePos.huge.Evade = { 30, 0 }
TokenModule.basePos.huge.Stress = { 30, -30 }
TokenModule.basePos.huge.Strain = { 30, -40 }
TokenModule.basePos.huge.Deplete = { -30, -40 }
TokenModule.basePos.huge.Tractor = { -30, 30 }
TokenModule.basePos.huge.Ion = { -30, 0 }
TokenModule.basePos.huge.Lock = { 0, 30 }

TokenModule.basePos.huge.Cloak = { 30, 30 }
TokenModule.basePos.huge.Reinforce = { -30, 30 }
TokenModule.basePos.huge.Jam = { -30, -30 }
TokenModule.basePos.huge.Disarm = { 40, 30 }

TokenModule.basePos.huge.rest = { -30, -30 }

-- Positions near the base
-- Near base - small ships
TokenModule.nearPos = {}

TokenModule.nearPos.small = {}
TokenModule.nearPos.small.Focus = { 35, 25 }
TokenModule.nearPos.small.Calculate = { 15, 35 }
TokenModule.nearPos.small.Evade = { 35, 0 }
TokenModule.nearPos.small.Stress = { 35, -25 }
TokenModule.nearPos.small.Strain = { 35, -35 }
TokenModule.nearPos.small.Deplete = { -35, -35 }
TokenModule.nearPos.small.Ion = { -35, 25 }
TokenModule.nearPos.small.Tractor = { -35, 0 }
TokenModule.nearPos.small.Lock = { 0, 40 }

TokenModule.nearPos.small.Reinfoce = { -35, 35 }
TokenModule.nearPos.small.Cloak = { -35, -35 }
TokenModule.nearPos.small.Jam = { 35, -25 }
TokenModule.nearPos.small.Disarm = { 35, 25 }

TokenModule.nearPos.small.rest = { -35, -25 }

-- Near base - medium ships
TokenModule.nearPos.medium = {}
TokenModule.nearPos.medium.Focus = { 45, 28 }
TokenModule.nearPos.medium.Calculate = { 45, 56 }
TokenModule.nearPos.medium.Evade = { 45, 0 }
TokenModule.nearPos.medium.Stress = { 45, -28 }
TokenModule.nearPos.medium.Strain = { 45, -45 }
TokenModule.nearPos.medium.Deplete = { -45, -45 }
TokenModule.nearPos.medium.Ion = { -45, 28 }
TokenModule.nearPos.medium.Tractor = { -45, 0 }
TokenModule.nearPos.medium.Lock = { 0, 45 }

TokenModule.nearPos.medium.Reinfoce = { -35, 35 }
TokenModule.nearPos.medium.Cloak = { -35, -35 }
TokenModule.nearPos.medium.Jam = { 35, -25 }
TokenModule.nearPos.medium.Disarm = { 35, 25 }

TokenModule.nearPos.medium.rest = { -45, -35 }

-- Near base - large ships
TokenModule.nearPos.large = {}
TokenModule.nearPos.large.Focus = { 55, 30 }
TokenModule.nearPos.large.Calculate = { 55, 30 }
TokenModule.nearPos.large.Evade = { 55, 0 }
TokenModule.nearPos.large.Stress = { 55, -30 }
TokenModule.nearPos.large.Strain = { 55, -55 }
TokenModule.nearPos.large.Deplete = { -55, -55 }
TokenModule.nearPos.large.Tractor = { -55, 45 }
TokenModule.nearPos.large.Ion = { -55, 15 }
TokenModule.nearPos.large.Weapons = { -55, -15 }
TokenModule.nearPos.large.Lock = { 0, 50 }

TokenModule.nearPos.large.Reinfoce = { -45, 45 }
TokenModule.nearPos.large.Cloak = { -45, -45 }
TokenModule.nearPos.large.Jam = { 45, -45 }
TokenModule.nearPos.large.Disarm = { 45, 45 }

TokenModule.nearPos.large.rest = { -55, -45 }

-- Near base - large ships
TokenModule.nearPos.huge = {}
TokenModule.nearPos.huge.Focus = { 55, 30 }
TokenModule.nearPos.huge.Calculate = { 55, 30 }
TokenModule.nearPos.huge.Evade = { 55, 0 }
TokenModule.nearPos.huge.Stress = { 55, -30 }
TokenModule.nearPos.huge.Strain = { 55, -55 }
TokenModule.nearPos.huge.Deplete = { -55, -55 }
TokenModule.nearPos.huge.Tractor = { -55, 45 }
TokenModule.nearPos.huge.Ion = { -55, 15 }
TokenModule.nearPos.huge.Weapons = { -55, -15 }
TokenModule.nearPos.huge.Lock = { 0, 50 }

TokenModule.nearPos.huge.Reinfoce = { -45, 45 }
TokenModule.nearPos.huge.Cloak = { -45, -45 }
TokenModule.nearPos.huge.Jam = { 45, -45 }
TokenModule.nearPos.huge.Disarm = { 45, 45 }

TokenModule.nearPos.huge.rest = { -55, -45 }

-- Deduct target token position in the world for a ship, token and some entry from TokenModule.basePos or .nearPos
TokenModule.TokenPos = function(tokenName, ship, posTable)
    local baseSize = ship.getTable("Data").Size or 'small'
    local entry = posTable[baseSize].rest
    for tokenEntryName, tEntry in pairs(posTable[baseSize]) do
        if tokenName:find(tokenEntryName) ~= nil then
            entry = tEntry
        end
    end
    local tsPos = { Dim.Convert_mm_igu(entry[1]), 0.5, Dim.Convert_mm_igu(entry[2]) }
    return Vect.Sum(ship.getPosition(), Vect.RotateDeg(tsPos, ship.getRotation()[2] + 180))
end

-- Return position for a given token that is on the base of given ship
TokenModule.BasePosition = function(tokenName, ship)
    local name = nil
    if type(tokenName) == 'string' then
        name = tokenName
    elseif type(tokenName) == 'userdata' then
        name = tokenName.getName()
    end
    return TokenModule.TokenPos(name, ship, TokenModule.basePos)
end

-- Return position for a given token that is near the base of given ship
TokenModule.NearPosition = function(tokenName, ship)
    local name = nil
    if type(tokenName) == 'string' then
        name = tokenName
    elseif type(tokenName) == 'userdata' then
        name = tokenName.getName()
    end
    return TokenModule.TokenPos(name, ship, TokenModule.nearPos)
end

-- Return a visible position for some token near some ship
-- Priorities as follows (OK if token is still visible there as in you can see who is its owner easily):
-- 1. Prefer the position given as 3rd argument if passed
-- 2. Prefer position on a stack if a stack of tokens already belongs to a ship
-- 3. Prefer position NEAR ship base as position table dictates
-- 4. Prefer position ON ship base as position table dictates (if all else fails, this will be returned)
TokenModule.VisiblePosition = function(tokenName, ship, preferredPos)
    -- Check preferred position margin
    if preferredPos ~= nil then
        local prefInfo = TokenModule.TokenOwnerInfo(preferredPos)
        if prefInfo.owner == ship and prefInfo.margin > TokenModule.visibleMargin then
            return preferredPos
        end
    end
    -- Check for present stacks
    local currTokensInfo = TokenModule.GetShipTokensInfo(ship)
    local currStack = { qty = -2, obj = nil }
    for k, tokenInfo in pairs(currTokensInfo) do
        if tokenInfo.token.getName() == tokenName and tokenInfo.token.getQuantity() > currStack.qty and (not tokenInfo.token.IsSmoothMoving()) then
            currStack.obj = tokenInfo.token
            currStack.qty = currStack.obj.getQuantity()
        end
    end
    if currStack.obj ~= nil then
        return Vect.Sum(currStack.obj.getPosition(), { 0, 0.7, 0 })
    end
    -- Check for near near base position or return base position
    local nearPos = TokenModule.NearPosition(tokenName, ship)
    local nearData = TokenModule.TokenOwnerInfo(nearPos)
    if nearData.margin < TokenModule.visibleMargin then
        return TokenModule.BasePosition(tokenName, ship)
    else
        return nearPos
    end
end

-- Check which tokens belong to a ship and queue them to be moved with it
-- Needs the MoveModule.WaitForResting fired to actually use stuff from this queue
TokenModule.QueueShipTokensMove = function(ship)
    local selfTokens = TokenModule.GetShipTokens(ship)
    local waitTable = { tokens = {}, ship = ship }
    -- Save relative position/rotation
    for k, token in pairs(selfTokens) do
        print("QueueShipTokensMove: " .. token.getName())
        local relPos = Vect.RotateDeg(Vect.Between(ship.getPosition(), token.getPosition()), -1 * ship.getRotation()[2])
        local relRot = token.getRotation()[2] - ship.getRotation()[2]
        table.insert(waitTable.tokens, { ref = token, relPos = relPos, relRot = relRot })
    end
    table.insert(MoveModule.tokenWaitQueue, waitTable)
end

-- Table for locks to be set and callback to trigger their naming and coloring
-- Entry: {lock=targetLockRef, color=colorToTint, name=nameToSet}
TokenModule.locksToBeSet = {}

-- Callback to set ALL the locks in wueue
function TokenModule_SetLocks()
    for k, info in pairs(TokenModule.locksToBeSet) do
        print("lock: " .. tostring(info.lock))
        info.lock.call('manualSet', { color = info.color, name = info.name })
        info.lock.highlightOn({ 0, 0, 0 }, 0.01)

        if info.ship ~= nil then
            info.lock.call('setOwner', { player = info.color, ship = info.ship })
        end

        if info.target ~= nil then
            info.lock.call('assignToShip', { ship = info.target })
        end
    end
    TokenModule.locksToBeSet = {}
end

-- Table for locks to be set and callback to trigger their naming and coloring
-- Entry: {lock=targetLockRef, color=colorToTint, name=nameToSet}
TokenModule.tractorsToBeSet = {}

-- Callback to set ALL the locks in wueue
function TokenModule_SetTractors()
    for k, info in pairs(TokenModule.tractorsToBeSet) do
        info.tractor.call('manualSet', { ref = info.ref })
        info.tractor.highlightOn({ 0, 0, 0 }, 0.01)
    end
    TokenModule.tractorsToBeSet = {}
end

-- Table for tokens to be flipped and callback to trigger their flipping
-- Entry: token
TokenModule.tokensToBeFlipped = {}

function TokenModule_FlipTokens()
    for _, token in pairs(TokenModule.tokensToBeFlipped) do
        token.flip()
    end
    TokenModule.tokensToBeFlipped = {}
end

-- Table for locks to be set and callback to trigger their naming and coloring
-- Entry: {lock=targetLockRef, color=colorToTint, name=nameToSet}
TokenModule.ionsToBeSet = {}

-- Callback to set ALL the locks in wueue
function TokenModule_SetIons()
    for k, info in pairs(TokenModule.ionsToBeSet) do
        info.ion.call('manualSet', { ref = info.ref })
        info.ion.highlightOn({ 0, 0, 0 }, 0.01)
    end
    TokenModule.ionsToBeSet = {}
end

-- Take a token of some type and move to some position
-- Player color argument only matters when taking target locks
-- Returns ref to a newly taken token
-- Highlights the token with type-aware color
TokenModule.TakeToken = function(type, playerColor, dest, flip)
    local takeTable = {}
    if dest ~= nil then
        takeTable.position = dest
    end
    local highlightColor = TokenModule.tokenSources[type].hlColor
    if type == 'Target Lock' then
        takeTable.callback = 'TokenModule_SetLocks'
        takeTable.callback_owner = Global
    elseif type == 'Ion' then
        takeTable.callback = 'TokenModule_SetIons'
        takeTable.callback_owner = Global
    elseif type == 'Tractor' then
        takeTable.callback = 'TokenModule_SetTractors'
        takeTable.callback_owner = Global
    elseif flip == true then
        takeTable.callback = 'TokenModule_FlipTokens'
        takeTable.callback_owner = Global
    end
    local newToken = TokenModule.tokenSources[type].src.takeObject(takeTable)
    newToken.highlightOn(highlightColor, 3)

    local scale = TokenModule.scaleModifiers[TokenModule.tokenSize]
    newToken.setScale(newToken.getScale() * scale)
    return newToken
end

-- Get owner info from a token or positions
-- Return: {
--      token   <- passed token ref if arg was a token ref
--      owner   <- ship ref to owner, nil if none
--      dist    <- distance to owner (igu)
--      margin  <- how far from owner token would have to be moved to change owner
-- }
TokenModule.TokenOwnerInfo = function(tokenPos)
    local pos = nil
    local out = { token = nil, owner = nil, dist = 0, margin = -1 }
    if type(tokenPos) == 'table' then
        pos = tokenPos
    elseif type(tokenPos) == 'userdata' then
        out.token = tokenPos
        pos = tokenPos.getPosition()
    end
    local nearShips = ObjType.GetNearOfType(pos, TokenModule.tokenReachDistance, 'ship')
    if nearShips[1] == nil then
        return out
    end
    local baseDist = {}
    -- Take the base size into account for distances
    for k, ship in pairs(nearShips) do
        local realDist = Vect.Distance(pos, ship.getPosition())
        local size = ship.getTable("Data").Size or 'small'
        if size == 'large' then
            realDist = realDist - Dim.Convert_mm_igu(10)
        elseif size == 'medium' then
            realDist = realDist - Dim.Convert_mm_igu(5)
        end
        table.insert(baseDist, { ship = ship, dist = realDist })
    end
    local nearest = { ship = nil, dist = 999 }
    local nextNearest = { ship = nil, dist = 999 }
    for k, data in pairs(baseDist) do
        if data.dist < nearest.dist then
            nextNearest = nearest
            nearest = data
        elseif data.dist < nextNearest.dist then
            nextNearest = data
        end
    end
    out.owner = nearest.ship
    out.dist = nearest.dist
    if nextNearest.ship == nil then
        out.margin = 999
    else
        out.margin = (nextNearest.dist - nearest.dist) / 2
    end
    return out
end

-- Return table of MoveModule.GetTokenInfo entries for all tokens withis some distance of given position
TokenModule.GetNearTokensInfo = function(pos, dist)
    local reachDist = TokenModule.tokenReachDistance
    if dist ~= nil then
        reachDist = dist
    end
    local nearTokens = ObjType.GetNearOfType(pos, reachDist, 'token')
    local shipTokensInfo = {}
    for k, token in pairs(nearTokens) do
        local tokenInfo = TokenModule.TokenOwnerInfo(token)
        table.insert(shipTokensInfo, tokenInfo)
    end
    return shipTokensInfo
end

TokenModule.GetShipTokenCount = function(ship, token_name)
    local count = 0;

    for _, token in pairs(TokenModule.GetShipTokens(ship)) do
        if token.getName() == token_name and token.getVar('deleted') == nil then
            local quantity = token.getQuantity()
            if quantity < 0 then
                quantity = 1
            end
            count = count + quantity
        end
    end

    return count
end

-- Return table of MoveModule.GetTokenInfo enties for all tokens that are owned by given ship
TokenModule.GetShipTokensInfo = function(ship)
    local shipTokens = TokenModule.GetShipTokens(ship)
    local shipTokensInfo = {}
    for k, token in pairs(shipTokens) do
        table.insert(shipTokensInfo, TokenModule.TokenOwnerInfo(token))
    end

    return shipTokensInfo
end

-- Return table of object references for all tokens that are owned by given ship
TokenModule.GetShipTokens = function(ship)
    return ship.call("GetTokens")
end

-- Returns whether any of this ships tokens are currently smooth moving.
TokenModule.DoesShipHasAnySmoothMovingTokens = function(ship)
    local ship_tokens = TokenModule.GetShipTokens(ship)
    for _, token in pairs(ship_tokens) do
        if token.isSmoothMoving() then
            return true
        end
    end

    return false
end

-- Clear given distance within position from tokens
-- If given third argument, this hip tokens will be ignored
-- Tokens that have an owner will be moved near(er)/on it
-- Stray tokens will be yanked away
TokenModule.ClearPosition = function(pos, dist, ignoreShip)
    local clearDist = dist + Dim.Convert_mm_igu(20)
    local posTokenInfo = TokenModule.GetNearTokensInfo(pos, clearDist)
    for k, tokenInfo in pairs(posTokenInfo) do
        if tokenInfo.token.getButtons() == nil then
            if tokenInfo.owner ~= nil and tokenInfo.owner ~= ignoreShip then
                local visPos = TokenModule.VisiblePosition(tokenInfo.token.getName(), tokenInfo.owner)
                if Vect.Distance(visPos, pos) <= clearDist then
                    local basePos = TokenModule.BasePosition(tokenInfo.token.getName(), tokenInfo.owner)
                    tokenInfo.token.setPositionSmooth(basePos)
                else
                    tokenInfo.token.setPositionSmooth(visPos)
                end
            else
                local ptVect = Vect.Between(pos, tokenInfo.token.getPosition())
                ptVect[2] = 0
                local actDist = Vect.Distance(tokenInfo.token.getPosition(), pos)
                local distToMove = 2 * clearDist - actDist
                local targetPos = Vect.Sum(tokenInfo.token.getPosition(), Vect.SetLength(ptVect, distToMove))
                targetPos[2] = targetPos[2] + 0.5
                tokenInfo.token.setPositionSmooth(targetPos)
            end
        end
    end
end

TokenModule.AssignToken = function(token, ship)
    if token then
        Wait.condition(function()
                local guid = token.getGUID()
                if (TokenModule.tokenAssignments[guid] ~= nil) and (TokenModule.tokenAssignments[guid].tag == 'Figurine') then
                    if TokenModule.tokenAssignments[guid].getVar("RemoveToken") ~= nil then
                        TokenModule.tokenAssignments[guid].call("RemoveToken", { token = token })
                    end
                end
                TokenModule.tokenAssignments[guid] = ship
                if ship ~= nil then
                    token.setDescription("Assigned to " .. ship.getName())
                    if ship.tag == 'Figurine' then
                        if ship.getVar("AddToken") ~= nil then
                            ship.call("AddToken", { token = token })
                        end
                    end
                else
                    token.setDescription("Unassigned")
                end
            end
            ,
            function()
                return (not token.spawning)
            end)
    end
end

TokenModule.UnAssignToken = function(token)
    local guid = token.getGUID()
    if (TokenModule.tokenAssignments[guid] ~= nil) and (TokenModule.tokenAssignments[guid].tag == 'Figurine') then
        if TokenModule.tokenAssignments[guid].getVar("RemoveToken") ~= nil then
            TokenModule.tokenAssignments[guid].call("RemoveToken", { token = token })
        end
    end
    TokenModule.tokenAssignments[guid] = nil
    token.setDescription("Unassigned")
end

function getShipTokenIsAssignedTo(args)
    if args.token then
        local guid = args.token.getGUID()
        return TokenModule.tokenAssignments[guid]
    end
    return nil
end

-- END TOKEN MODULE
--------


function proxyPerformAction(table)
    ship = table[1]
    actionType = table[2]
    playerColor = table[3]
    args = table[4] or {}
    DialModule.PerformAction(ship, actionType, playerColor, args)
end

DialModule = {}
-- Perform an automated action
-- Can be called externally for stuff like range ruler spawning
DialModule.PerformAction = function(ship, type, playerColor, args)
    local tokenActions =
    ' Focus Calculate Evade Stress Strain Deplete Target Lock Ion Cloak Jam Reinforce Disarm Tractor Dummy '
    announceInfo = { type = 'action' }
    -- Ruler spawning
    if type:find('ruler') ~= nil then
        local scPos = type:find(':')
        local rulerCode = type:sub(scPos + 1, -1)
        RulerModule.ToggleRuler(ship, rulerCode)
        return
    elseif type:find('spawnMoveTemplate') ~= nil then
        local size = ship.getTable('Data').Size
        if size ~= 'huge' then
            if DialModule.DeleteTemplate(ship) == false then
                local scPos = type:find(':')
                local dialCode = type:sub(scPos + 1, -1)
                if DialModule.SpawnTemplate(ship, dialCode) ~= nil then
                    announceInfo.note = 'spawned a move template'
                else
                    announceInfo.note = 'looks at you weird'
                end
            else
                return
            end
        else
            return
        end
    elseif type:find('deleteMoveTemplate') ~= nil then
        local size = ship.getTable('Data').Size
        if size ~= 'huge' then
            DialModule.DeleteTemplate(ship)
        end
        return
    elseif tokenActions:find(' ' .. type .. ' ') ~= nil then
        if args ~= nil and args.remove == true then
            local tokens = ship.call("GetTokens", { type = string.lower(type) })
            local delToken = nil
            for k, token in pairs(tokens) do
                if token.getVar('deleted') == nil then
                    delToken = token
                end
            end
            if delToken == nil then
                announceInfo.note = 'tried to shed a ' .. type .. ' but doesn\'t have any'
            else
                announceInfo.note = 'sheds a ' .. type .. ' token'
                TokenModule.UnAssignToken(delToken)
                delToken.destruct()
            end
        else
            local destinationShip = ship
            if args ~= nil and args.target ~= nil then
                destinationShip = args.target
            end
            local dest = TokenModule.VisiblePosition(type, destinationShip)
            local flipToken = args ~= nil and args.flip == true
            local newToken = TokenModule.TakeToken(type, playerColor, dest, flipToken)

            if type == 'Target Lock' then
                local lockArguments = { ship = ship, lock = newToken, name = ship.getName(), color = playerColor }
                if args ~= nil and args.ship ~= nil and args.target ~= nil then
                    -- The AI system passes in arguments to automatically assign the
                    -- lock. Process these if they've been passed in.
                    lockArguments.ship = args.ship
                    lockArguments.target = args.target
                end
                table.insert(TokenModule.locksToBeSet, lockArguments)
                announceInfo.note = 'acquired a target lock'
                TokenModule.UnAssignToken(newToken) -- Target locks are not assigned to the spawning ship
            elseif type == 'Ion' then
                table.insert(TokenModule.ionsToBeSet, { ion = newToken, ref = ship })
                announceInfo.note = 'takes an ion token'
                TokenModule.AssignToken(newToken, ship)
            elseif type == 'Tractor' then
                table.insert(TokenModule.tractorsToBeSet, { tractor = newToken, ref = ship })
                announceInfo.note = 'takes a tractor token'
                TokenModule.AssignToken(newToken, ship)
            else
                if flipToken == true then
                    table.insert(TokenModule.tokensToBeFlipped, newToken)
                end
                if type == 'Evade' then
                    announceInfo.note = 'takes an evade token'
                else
                    announceInfo.note = 'takes a ' .. string.lower(type) .. ' token'
                end
                TokenModule.AssignToken(newToken, ship)
            end
        end
    end
    AnnModule.Announce(announceInfo, 'all', ship)
end

DialModule.RotateCmd = {
    rot = { direction = 'rotateleft', mount = 'main' },
    rotl = { direction = 'rotateleft', mount = 'main' },
    rotr = { direction = 'rotateright', mount = 'main' },
    rot1 = { direction = 'rotateleft', mount = 'front' },
    rotl1 = { direction = 'rotateleft', mount = 'front' },
    rotr1 = { direction = 'rotateright', mount = 'front' },
    rot2 = { direction = 'rotateleft', mount = 'rear' },
    rotl2 = { direction = 'rotateleft', mount = 'rear' },
    rotr2 = { direction = 'rotateright', mount = 'rear' },
}

DialModule.RotateArc = function(ship, cmd)
    ship.call("RotateAttachedArcIndicator", DialModule.RotateCmd[cmd])
end

DialModule.TurretArcCmd = {
    turret = { mount = 'main' },
    turret1 = { mount = 'front' },
    turret2 = { mount = 'rear' },
}

DialModule.TurretArc = function(ship, cmd)
    local arc = ship.call("GetTurretArc", DialModule.TurretArcCmd[cmd])
    local range = ship.call("GetTurretRange", DialModule.TurretArcCmd[cmd])
    if arc then
        command = string.upper(arcToCmnd[arc])
        if range then
            command = command .. tostring(range)
        end
        RulerModule.ToggleRuler(ship, command)
    end
end

DialModule.FixedArc = function(ship, cmd)
    arc = ship.getTable('Data').arcs.fixed
    if arc then
        command = string.upper(arcToCmnd[arc.type[1]])
        if arc.range then
            command = command .. tostring(arc.range)
        end
        RulerModule.ToggleRuler(ship, command)
    end
end




-- Spawned templates are kept there
-- Entry: {ship=shipRef, template=templateObjRef}
DialModule.SpawnedTemplates = {}

-- Position data for template spawning
-- "Trim" entries are to fine-tune the position
-- (its quite rough by the numbers since their origin was not perfectly at the center)
DialModule.TemplateData = {}
DialModule.TemplateData.straight = {}
DialModule.TemplateData.straight[1] = { 0, -2.5, 20, 0 }
DialModule.TemplateData.straight[2] = { 0, -2.5, 40, 0 }
DialModule.TemplateData.straight[3] = { 0, -2.5, 60, 0 }
DialModule.TemplateData.straight[4] = { 0, -2.5, 80, 0 }
DialModule.TemplateData.straight[5] = { 0, -2.5, 100, 0 }
DialModule.TemplateData.bank = {}
DialModule.TemplateData.bank.leftRot = 45
DialModule.TemplateData.bank.trim = { left = { { -2, 0, -4, 0 }, { -5.5, 0, -5.2, 0 }, { -9.3, 0, -6.45, 0 } }, right = { { 4.2, 0, 1.2, 0 }, { 7.8, 0, -0.3, 0 }, { 11.5, 0, -1.4, 0 } } }
DialModule.TemplateData.bank[1] = { 80 * (1 - math.cos(math.pi / 8)), 0, 80 * math.sin(math.pi / 8), 180 }
DialModule.TemplateData.bank[2] = { 130 * (1 - math.cos(math.pi / 8)), 0, 130 * math.sin(math.pi / 8), 180 }
DialModule.TemplateData.bank[3] = { 180 * (1 - math.cos(math.pi / 8)), 0, 180 * math.sin(math.pi / 8), 180 }
DialModule.TemplateData.bankSlip = {}
DialModule.TemplateData.bankSlip.leftRot = 45
DialModule.TemplateData.bankSlip.trim = { left = { { -2, 0, -4, 0 }, { -5.5, 0, -5.2, 0 }, { -9.3, 0, -6.45, 0 } }, right = { { 4.2, 0, 1.2, 0 }, { 7.8, 0, -0.3, 0 }, { 11.5, 0, -1.4, 0 } } }
DialModule.TemplateData.bankSlip[1] = { 80 * (1 - math.cos(math.pi / 8)), 0, 80 * math.sin(math.pi / 8), 180 }
DialModule.TemplateData.bankSlip[2] = { 130 * (1 - math.cos(math.pi / 8)), 0, 130 * math.sin(math.pi / 8), 180 }
DialModule.TemplateData.bankSlip[3] = { 180 * (1 - math.cos(math.pi / 8)), 0, 180 * math.sin(math.pi / 8), 180 }
DialModule.TemplateData.turn = {}
DialModule.TemplateData.turn.leftRot = 90
DialModule.TemplateData.turn.trim = { left = { { 0, -2.5, 0, 0 }, { -3, -2.5, -3.66, 0 }, { -4.7, -2.5, -7.5, 0 } }, right = { { 0, -2.5, 0, 0 }, { 3, -2.5, -4.1, 0 }, { 4.5, -2.5, -7.8, 0 } } }
DialModule.TemplateData.turn[1] = { 35 * (1 - math.cos(math.pi / 4)) + 2, 0, 35 * math.sin(math.pi / 4) - 2, 180 }
DialModule.TemplateData.turn[2] = { 62.5 * (1 - math.cos(math.pi / 4)) + 5, 0, 62.5 * math.sin(math.pi / 4) - 4, 180 }
DialModule.TemplateData.turn[3] = { 90 * (1 - math.cos(math.pi / 4)) + 9, 0, 90 * math.sin(math.pi / 4) - 6, 180 }
DialModule.TemplateData.talon = {}
DialModule.TemplateData.talon.leftRot = 90
DialModule.TemplateData.talon.trim = { left = { { 0, -2.5, 0, 0 }, { -3, -2.5, -3.66, 0 }, { -4.7, -2.5, -7.5, 0 } }, right = { { 0, -2.5, 0, 0 }, { 3, -2.5, -4.1, 0 }, { 4.5, -2.5, -7.8, 0 } } }
DialModule.TemplateData.talon[1] = { 35 * (1 - math.cos(math.pi / 4)) + 2, 0, 35 * math.sin(math.pi / 4) - 2, 180 }
DialModule.TemplateData.talon[2] = { 62.5 * (1 - math.cos(math.pi / 4)) + 5, 0, 62.5 * math.sin(math.pi / 4) - 4, 180 }
DialModule.TemplateData.talon[3] = { 90 * (1 - math.cos(math.pi / 4)) + 9, 0, 90 * math.sin(math.pi / 4) - 6, 180 }

DialModule.TemplateData.baseOffset = {}
DialModule.TemplateData.baseOffset.small = { 0, 0, 20, 0 }
DialModule.TemplateData.baseOffset.medium = { 0, 0, 30, 0 }
DialModule.TemplateData.baseOffset.large = { 0, 0, 40, 0 }

-- Spawn a template on given ship
-- dialCode is move code PLUS identifier if ship already did it or not
-- be3_A means "spawn a bank left 3 template behind me" (A as in after move)
-- tr1_B means "spawn a turn right 1 template in front of me" (B as in before move)
-- Return template reference
-- TODO toggletemplate?
-- Decode the dial code into a moveData table with move details
DialModule.decodeDialCode = function(ship, dialCode)
    local moveInfo = MoveData.DecodeInfo(dialCode:sub(1, -3), ship) -- Decodes movement type, speed, etc.
    local positionKey = dialCode:sub(-1, -1)                        -- Last character defines position

    moveInfo.position = ({
        A = 'back',
        B = 'front',
        P = 'port',
        S = 'starboard'
    })[positionKey] or 'front'

    return moveInfo
end

DialModule.SpawnTemplate = function(ship, dialCode)
    local moveInfo = DialModule.decodeDialCode(ship, dialCode)

    local speed = moveInfo.speed
    local type = moveInfo.type
    local position = moveInfo.position
    local dir = moveInfo.dir
    local extra = moveInfo.extra

    return DialModule.PlaceTemplate(ship, speed, type, position, dir, extra)
end

DialModule.PlaceTemplate = function(ship, speed, type, position, dir, extra)
    if speed == 0 then
        return nil
    end
    local tempEntry = DialModule.TemplateData[type][speed]
    local baseSize = ship.getTable("Data").Size or 'small'
    tempEntry = Vect.Sum(tempEntry, DialModule.TemplateData.baseOffset[baseSize])
    local ref = ship
    if position == 'back' then
        ref = MoveModule.GetOldMove(ship, 1)
    end
    --TODO LAST MOVE LOGIC OUT!!!
    --TODO dont barf if no last move

    if dir == 'left' then
        tempEntry = MoveData.LeftVariant(tempEntry)
        tempEntry[4] = tempEntry[4] + 180 - DialModule.TemplateData[type].leftRot
    end
    if extra == 'reverse' then
        tempEntry = MoveData.ReverseVariant(tempEntry)
        if type ~= 'straight' then
            tempEntry[4] = tempEntry[4] - DialModule.TemplateData[type].leftRot
        end
    end
    if dir ~= nil then
        if extra ~= 'reverse' then
            tempEntry = Vect.Sum(tempEntry, DialModule.TemplateData[type].trim[dir][speed])
        else
            if dir == 'right' then
                dir = 'left'
            elseif dir == 'left' then
                dir = 'right'
            end
            tempEntry = Vect.Sum(tempEntry,
                Vect.ScaleEach(DialModule.TemplateData[type].trim[dir][speed], { -1, 1, -1, -1 }))
        end
    end

    local finPos = MoveModule.EntryToPos(tempEntry, ref)
    local src = TokenModule.tokenSources[type:sub(1, 1) .. speed]
    local newTemplate = src.takeObject({ position = finPos.pos, rotation = finPos.rot })
    newTemplate.lock()
    newTemplate.setPosition(finPos.pos)
    newTemplate.setRotation(finPos.rot)
    table.insert(DialModule.SpawnedTemplates, { template = newTemplate, ship = ship })
    return newTemplate
end

-- Delete template spawned for a ship, return true if deleted, false if there was none
DialModule.DeleteTemplate = function(ship)
    for k, info in pairs(DialModule.SpawnedTemplates) do
        if info.ship == ship then
            if info.template ~= nil then
                info.template.destruct()
            end
            table.remove(DialModule.SpawnedTemplates, k)
            return true
        end
    end
    return false
end


-- Char width table by Indimeco
StringLen = {}
StringLen.charWidthTable = {
    ['`'] = 2381,
    ['~'] = 2381,
    ['1'] = 1724,
    ['!'] = 1493,
    ['2'] = 2381,
    ['@'] = 4348,
    ['3'] = 2381,
    ['#'] = 3030,
    ['4'] = 2564,
    ['$'] = 2381,
    ['5'] = 2381,
    ['%'] = 3846,
    ['6'] = 2564,
    ['^'] = 2564,
    ['7'] = 2174,
    ['&'] = 2777,
    ['8'] = 2564,
    ['*'] = 2174,
    ['9'] = 2564,
    ['('] = 1724,
    ['0'] = 2564,
    [')'] = 1724,
    ['-'] = 1724,
    ['_'] = 2381,
    ['='] = 2381,
    ['+'] = 2381,
    ['q'] = 2564,
    ['Q'] = 3226,
    ['w'] = 3704,
    ['W'] = 4167,
    ['e'] = 2174,
    ['E'] = 2381,
    ['r'] = 1724,
    ['R'] = 2777,
    ['t'] = 1724,
    ['T'] = 2381,
    ['y'] = 2564,
    ['Y'] = 2564,
    ['u'] = 2564,
    ['U'] = 3030,
    ['i'] = 1282,
    ['I'] = 1282,
    ['o'] = 2381,
    ['O'] = 3226,
    ['p'] = 2564,
    ['P'] = 2564,
    ['['] = 1724,
    ['{'] = 1724,
    [']'] = 1724,
    ['}'] = 1724,
    ['|'] = 1493,
    ['\\'] = 1923,
    ['a'] = 2564,
    ['A'] = 2777,
    ['s'] = 1923,
    ['S'] = 2381,
    ['d'] = 2564,
    ['D'] = 3030,
    ['f'] = 1724,
    ['F'] = 2381,
    ['g'] = 2564,
    ['G'] = 2777,
    ['h'] = 2564,
    ['H'] = 3030,
    ['j'] = 1075,
    ['J'] = 1282,
    ['k'] = 2381,
    ['K'] = 2777,
    ['l'] = 1282,
    ['L'] = 2174,
    [';'] = 1282,
    [':'] = 1282,
    ['\''] = 855,
    ['"'] = 1724,
    ['z'] = 1923,
    ['Z'] = 2564,
    ['x'] = 2381,
    ['X'] = 2777,
    ['c'] = 1923,
    ['C'] = 2564,
    ['v'] = 2564,
    ['V'] = 2777,
    ['b'] = 2564,
    ['B'] = 2564,
    ['n'] = 2564,
    ['N'] = 3226,
    ['m'] = 3846,
    ['M'] = 3846,
    [','] = 1282,
    ['<'] = 2174,
    ['.'] = 1282,
    ['>'] = 2174,
    ['/'] = 1923,
    ['?'] = 2174,
    [' '] = 1282,
    ['avg'] = 2500
}

-- Get real string length per char table
StringLen.GetStringLength = function(str)
    local len = 0
    for i = 1, #str do
        local c = str:sub(i, i)
        if StringLen.charWidthTable[c] ~= nil then
            len = len + StringLen.charWidthTable[c]
        else
            len = len + StringLen.charWidthTable.avg
        end
    end
    return len
end

-- Get a short name for some ship
-- Avoid user-added LGS
-- Avoid name prepositions as in ambigNames
-- Avoid too short or long names
-- Add a single number/char on the end if there is one on the ship
DialModule.GetShortName = function(ship)
    local shipNameWords = {}
    local numWords = 0
    local ambigNames = 'The Captain Colonel Cartel Lieutenant Commander Old'
    local shipName = ship.getName()
    shipName = shipName:gsub('LGS', '')       -- Delete LGS
    shipName = shipName:match("^%s*(.-)%s*$") -- Trim whitespaces
    -- Fill words table
    for word in shipName:gmatch('[\'\"%-%w]+') do
        table.insert(shipNameWords, word)
    end
    -- Delete first word if ambiguous and there's more
    if ambigNames:find(shipNameWords[1]) ~= nil and #shipNameWords > 1 then
        table.remove(shipNameWords, 1)
    end
    -- Function for checking if "short name"
    local function sizeJustRight(str)
        if str == nil then
            return false
        end
        return ((str:len() < 10) --[[and (str:len() > 3)]])
    end
    -- Delete the first word if too short/long and next is better
    if (not sizeJustRight(shipNameWords[1])) and (sizeJustRight(shipNameWords[2])) then
        table.remove(shipNameWords, 1)
    end
    -- Take the resulting first "valid" word
    local shortName = shipNameWords[1]
    -- If there were apostrophes and they are asymmetrical now, trim them
    if ((string.find('\'\"', shortName:sub(1, 1)) ~= nil) or (string.find('\'\"', shortName:sub(-1, -1)) ~= nil)) and (shortName:sub(1, 1) ~= shortName:sub(-1, -1)) then
        shortName = shortName:gsub('\'', '')
        shortName = shortName:gsub('\"', '')
    end
    if shipNameWords[#shipNameWords]:len() == 1 then
        shortName = shortName .. ' ' .. shipNameWords[#shipNameWords]
    end
    return shortName
end

-- END AUTO DIALS MODULE
--------

--------
-- RULERS MODULE

-- Since there are many ruler types (models) and commands, this takes carre of all ruler-related handling
-- TO_DO: ActionModule and include it there

RulerModule = {}

-- Table of existing spawned rulers
-- Entry: {ship=shipRef, tuler=rulerRef, type=rulerTypeCode}
RulerModule.spawnedRulers = {}
-- Click function for ruler button (destroy)
function Ruler_SelfDestruct(obj)
    for k, rTable in pairs(RulerModule.spawnedRulers) do
        if rTable.ruler == obj then
            for _, arcline in pairs(rTable.arclines) do
                if arcline ~= nil then
                    arcline.destruct()
                end
            end
            table.remove(RulerModule.spawnedRulers, k)
            break
        end
    end
    obj.destruct()
end

-- Remove appropriate entry if ruler is destroyed
RulerModule.onObjectDestroyed = function(obj)
    for k, info in pairs(RulerModule.spawnedRulers) do
        if info.ship == obj or info.ruler == obj then
            if info.ship == obj then
                info.ruler.destruct()
            end
            for _, arcline in pairs(info.arclines) do
                arcline.destruct()
            end
            table.remove(RulerModule.spawnedRulers, k)
            break
        end
    end
end

-- RULER MESHES DATABASE
RulerModule.meshes = {}
RulerModule.meshes.smallBase = {}
RulerModule.meshes.smallBase.scale = { 0.629, 0.629, 0.629 }
RulerModule.meshes.smallBase.diffuse =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/arctexture.png'
RulerModule.meshes.smallBase.collider =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Small_base_Collider.obj'
RulerModule.meshes.smallBase.front =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_front.obj'
RulerModule.meshes.smallBase.fullfront =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_fullfront.obj'
RulerModule.meshes.smallBase.rear =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_back.obj'
RulerModule.meshes.smallBase.fullback =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_fullback.obj'
RulerModule.meshes.smallBase.sideArc =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_side_4.obj'
RulerModule.meshes.smallBase.frontback =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_frontback.obj'
RulerModule.meshes.smallBase.leftright =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_leftright.obj'
RulerModule.meshes.smallBase.bullseye =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_bullseye.obj'
RulerModule.meshes.smallBase.range = {}
RulerModule.meshes.smallBase.range[1] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_range_1.obj'
RulerModule.meshes.smallBase.range[2] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_range_2.obj'
RulerModule.meshes.smallBase.range[3] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_range_3.obj'
RulerModule.meshes.smallBase.range[4] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/small_range_4.obj'


-- Ruler meshes for medium base JC
RulerModule.meshes.mediumBase = {}
RulerModule.meshes.mediumBase.scale = { 0.629, 0.629, 0.629 }
RulerModule.meshes.mediumBase.diffuse =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/arctexture.png'
RulerModule.meshes.mediumBase.collider =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Medium_base_Collider.obj'
RulerModule.meshes.mediumBase.front =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_front.obj'
RulerModule.meshes.mediumBase.fullfront =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_fullfront.obj'
RulerModule.meshes.mediumBase.rear =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_back.obj'
RulerModule.meshes.mediumBase.fullback =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_fullback.obj'
RulerModule.meshes.mediumBase.sideArc =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_side_4.obj'
RulerModule.meshes.mediumBase.frontback =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_frontback.obj'
RulerModule.meshes.mediumBase.leftright =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_leftright.obj'
RulerModule.meshes.mediumBase.bullseye =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_bullseye.obj'
RulerModule.meshes.mediumBase.range = {}
RulerModule.meshes.mediumBase.range[1] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_range_1.obj'
RulerModule.meshes.mediumBase.range[2] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_range_2.obj'
RulerModule.meshes.mediumBase.range[3] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_range_3.obj'
RulerModule.meshes.mediumBase.range[4] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/medium_range_4.obj'

RulerModule.meshes.largeBase = {}
RulerModule.meshes.largeBase.scale = { 0.629, 0.629, 0.629 }
RulerModule.meshes.largeBase.diffuse =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/arctexture.png'
RulerModule.meshes.largeBase.collider =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Large_base_Collider.obj'
RulerModule.meshes.largeBase.front =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_front.obj'
RulerModule.meshes.largeBase.fullfront =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_fullfront.obj'
RulerModule.meshes.largeBase.rear =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_back.obj'
RulerModule.meshes.largeBase.fullback =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_fullback.obj'
RulerModule.meshes.largeBase.sideArc =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_side_4.obj'
RulerModule.meshes.largeBase.frontback =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_frontback.obj'
RulerModule.meshes.largeBase.leftright =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_leftright.obj'
RulerModule.meshes.largeBase.bullseye =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_bullseye.obj'
RulerModule.meshes.largeBase.range = {}
RulerModule.meshes.largeBase.range[1] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_range_1.obj'
RulerModule.meshes.largeBase.range[2] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_range_2.obj'
RulerModule.meshes.largeBase.range[3] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_range_3.obj'
RulerModule.meshes.largeBase.range[4] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/large_range_4.obj'

RulerModule.meshes.hugeBase = {}
RulerModule.meshes.hugeBase.scale = { 0.629, 0.629, 0.629 }
RulerModule.meshes.hugeBase.diffuse =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/arctexture.png'
RulerModule.meshes.hugeBase.collider =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/colliders/Huge_base_Collider.obj'
RulerModule.meshes.hugeBase.front =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_front.obj'
RulerModule.meshes.hugeBase.fullfront =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_fullfront.obj'
RulerModule.meshes.hugeBase.rear =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_back.obj'
RulerModule.meshes.hugeBase.fullback =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_fullback.obj'
RulerModule.meshes.hugeBase.sideArc =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_side_4.obj'
RulerModule.meshes.hugeBase.frontback =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_frontback.obj'
RulerModule.meshes.hugeBase.leftright =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_leftright.obj'
RulerModule.meshes.hugeBase.bullseye =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_bullseye.obj'
RulerModule.meshes.hugeBase.range = {}
RulerModule.meshes.hugeBase.range[1] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_range_1.obj'
RulerModule.meshes.hugeBase.range[2] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_range_2.obj'
RulerModule.meshes.hugeBase.range[3] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_range_3.obj'
RulerModule.meshes.hugeBase.range[4] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_range_15.obj'
RulerModule.meshes.hugeBase.range[5] =
'{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/arcranges/new/huge_range_5.obj'


-- Avaialble ruler codes:
-- R            - 1-3 range rings
-- R1/R2/R3     - 1/2/3 range rings
-- A            - contextual arc
-- AA           - full ruler
-- AP           - primary arc
-- AS           - side arc
-- AR           - rear arc
-- AT           - turret arc
-- AM           - mobile arc

XW_cmd.AddCommand('r[1-5]?a?', 'rulerHandle')            -- Range "rings"
XW_cmd.AddCommand('[fbs][lrfb]?[1-5]?a?', 'rulerHandle') -- Rulers with arc lines
XW_cmd.AddCommand('leftright[1-5]?a?', 'rulerHandle')
XW_cmd.AddCommand('frontback[1-5]?a?', 'rulerHandle')
XW_cmd.AddCommand('bull[1-5]?a?', 'rulerHandle')


-- Translate ruler code to a mesh entry
RulerModule.typeToKey = {}
RulerModule.typeToKey.F = 'front'
RulerModule.typeToKey.FF = 'fullfront'
RulerModule.typeToKey.B = 'rear'
RulerModule.typeToKey.FB = 'fullback'
RulerModule.typeToKey.R = 'range'
RulerModule.typeToKey.SL = 'sideArc'
RulerModule.typeToKey.SR = 'sideArc'
RulerModule.typeToKey.FRONTBACK = 'frontback'
RulerModule.typeToKey.LEFTRIGHT = 'leftright'
RulerModule.typeToKey.BULL = 'bullseye'

RulerModule.typeToArc = {}
RulerModule.typeToArc.F = 'front'
RulerModule.typeToArc.FF = 'fullfront'
RulerModule.typeToArc.B = 'back'
RulerModule.typeToArc.FB = 'fullback'
RulerModule.typeToArc.R1 = 'full'
RulerModule.typeToArc.R2 = 'full'
RulerModule.typeToArc.R3 = 'full'
RulerModule.typeToArc.R = 'full'
RulerModule.typeToArc.SL = 'left'
RulerModule.typeToArc.SR = 'right'
RulerModule.typeToArc.FRONTBACK = 'frontback'
RulerModule.typeToArc.LEFTRIGHT = 'leftright'
RulerModule.typeToArc.BULL = 'bullseye'

RulerModule.CachedRulers = {}


-- Get ruler spawn tables for some ship and some ruler code
-- Return table with "mesh", "collider" and "scale" keys
--  (for appropriate ruler)
RulerModule.GetRulerData = function(ship, rulerType, range)
    local baseSize = ship.getTable("Data").Size or 'small'
    local out = { mesh = nil, collider = nil, scale = nil }
    if rulerType:sub(1, 1) == 'R' then
        out.mesh = RulerModule.meshes[baseSize .. 'Base'].range[range]
    else
        local key = RulerModule.typeToKey[rulerType]
        out.mesh = RulerModule.meshes[baseSize .. 'Base'][key]
    end
    out.scale = RulerModule.meshes[baseSize .. 'Base'].scale
    out.collider = RulerModule.meshes[baseSize .. 'Base'].collider
    out.diffuse = RulerModule.meshes[baseSize .. 'Base'].diffuse
    out.material = 3
    return out
end

-- Return a descriptive arc name of command (for announcements)
RulerModule.DescriptiveName = function(ship, rulerType, range)
    if rulerType:sub(1, 1) == 'R' then
        if range == nil then
            ranges = '1-3'
        else
            ranges = tostring(range)
        end
        return 'range ' .. ranges .. ' ruler'
    else
        if rulerType == 'A' then
            rulerType = rulerType .. RulerModule.DefaultShipArc(ship)
        end
        ranges = ''
        if range then
            ranges = 'range ' .. tostring(range) .. ' '
        end
        local arcName = RulerModule.typeToKey[rulerType]
        return ranges .. arcName .. ' arc ruler'
    end
end

-- Get the default ship arc type code
-- e.g. whip with just primary arc will return code for priamry arc spawn
RulerModule.DefaultShipArc = function(ship)
    return 'A' --Todo Remove this
end

-- Create tables for spawning a ruler
-- Return: {
--      params      <- table suitable for spawnObject(params) call
--      custom      <- table suitable for obj.setCustomObject(custom) call
-- }
RulerModule.CreateCustomTables = function(ship, rulerType, range)
    if rulerType == 'A' then
        rulerType = rulerType .. RulerModule.DefaultShipArc(ship)
    end
    local rulerData = RulerModule.GetRulerData(ship, rulerType, range)
    local paramsTable = {}
    paramsTable.type = 'Custom_Model'
    paramsTable.position = ship.getPosition()
    paramsTable.rotation = { 0, ship.getRotation()[2], 0 }
    if rulerType == 'SR' then
        rot = ship.getRotation()[2]
        paramsTable.rotation = { 0, rot + 180, 0 }
    end

    paramsTable.scale = rulerData.scale

    local customTable = {}

    customTable.mesh = rulerData.mesh
    customTable.collider = rulerData.collider
    customTable.diffuse = rulerData.diffuse
    customTable.material = 3
    return { params = paramsTable, custom = customTable }
end

-- Spawn a ruler for a ship
-- Returns new ruler reference
RulerModule.SpawnRuler = function(ship, rulerType, beQuiet, include_friendly_ships, range)
    local rulerData = RulerModule.CreateCustomTables(ship, rulerType, range)
    if rulerData.custom.mesh == nil then
        return nil
    end
    local rulerId = rulerType .. ship.getTable("Data").Size .. tostring(range)
    if not RulerModule.CachedRulers[rulerId] then
        RulerModule.CachedRulers[rulerId] = spawnObject(
            {
                type = 'Custom_Model',
                position = vector(0, -2, 0),
                scale = rulerData.scale
            })
        RulerModule.CachedRulers[rulerId].setCustomObject(rulerData.custom)
        RulerModule.CachedRulers[rulerId].addTag('TempLayoutElement')
        RulerModule.CachedRulers[rulerId].interactable = false
        RulerModule.CachedRulers[rulerId].setLock(true)
        RulerModule.CachedRulers[rulerId].setColorTint(color(1.0, 0.0, 0.0, 0.5))
    end
    local newRuler = RulerModule.CachedRulers[rulerId].clone()
    newRuler.setPosition(ship.getPosition())
    newRuler.setRotation(rulerData.params.rotation)

    local arclines = {}
    if RulerModule.typeToArc[rulerType] then
        arclines = CheckArc({
            ship = ship,
            arctype = RulerModule.typeToArc[rulerType],
            range = range,
            include_friendly_ships = include_friendly_ships
        })
    end
    table.insert(RulerModule.spawnedRulers, { ship = ship, ruler = newRuler, arclines = arclines, type = rulerType })
    newRuler.lock()
    newRuler.setScale(rulerData.params.scale)
    local button = { click_function = 'Ruler_SelfDestruct', label = 'DEL', position = { 0, 0.55, 0 }, rotation = { 0, 0, 0 }, width = 1200, height = 1200, font_size = 250 }
    newRuler.createButton(button)
    return newRuler
end

-- Delete existing ruler for a ship
-- Return deleted ruler type or nil if there was none
RulerModule.DeleteRuler = function(ship)
    for k, rTable in pairs(RulerModule.spawnedRulers) do
        if rTable.ship == ship then
            for _, arcline in pairs(rTable.arclines) do
                if arcline ~= nil then
                    arcline.destruct()
                end
            end
            rTable.ruler.destruct()
            local destType = rTable.type
            table.remove(RulerModule.spawnedRulers, k)
            return destType
        end
    end
    return nil
end

-- Toggle ruler for a ship
-- If a ruler of queried type exists, just delete it and return nil
-- If any other ruler exists, delete it (and spawn queried one), return new ruler ref
RulerModule.ToggleRuler = function(ship, rulerType, beQuiet)
    local destType = RulerModule.DeleteRuler(ship)

    if destType ~= rulerType then
        includeFriendlies = (#rulerType > 1) and (rulerType:sub(#rulerType, #rulerType) == 'A')
        includeFriendlyText = ""
        spawnType = rulerType
        if includeFriendlies then
            spawnType = rulerType:sub(1, -2)
            includeFriendlyText = " including friendlies"
        end
        range = spawnType:match(".*(%d)")
        if range then
            range = tonumber(range)
            spawnType = spawnType:match("(.*)%d")
        else
            range = 3
        end

        print("ToggleRuler range: " .. tostring(range) .. " " .. spawnType)
        if beQuiet ~= true then
            local annInfo = { type = 'action' }
            annInfo.note = 'spawned a ' ..
                RulerModule.DescriptiveName(ship, spawnType, range) .. includeFriendlyText .. ' (' .. rulerType .. ')'
            AnnModule.Announce(annInfo, 'all', ship)
        end
        ship.setLock(true)
        Wait.frames(function()
            RulerModule.SpawnRuler(ship, spawnType, beQuiet, includeFriendlies, range)
        end, 1)
    end
end

-- END RULERS MODULE
--------

--------
-- BOMB MODULE

-- Allows for creating "bomb drops" that snap bomb tokens to position

BombModule = {}

-- Delete button for the spawned template
BombModule.deleteButton = { click_function = 'BombDrop_SelfDestruct', label = 'Cancel', position = { 0, 0.1, 0 }, rotation = { 0, 0, 0 }, scale = { 0.1, 0.1, 0.1 }, width = 2000, height = 900, font_size = 400 }
function BombDrop_SelfDestruct(temp)
    BombModule.DeleteDrop(temp)
end

BombModule.dropTable = {}

XW_cmd.AddCommand('b:s[1-5][r]?', 'bombDrop')
XW_cmd.AddCommand('b:b[rle][1-3][r]?', 'bombDrop')
XW_cmd.AddCommand('b:t[rle][1-3][r]?', 'bombDrop')

-- Spawn a bomb drop, delete old ones
-- If that exact one existed, just delete
BombModule.ToggleDrop = function(ship, dropCode)
    if BombModule.DeleteDrop(ship) ~= dropCode then
        BombModule.SpawnDrop(ship, dropCode)
    end
end

-- Create a bomb drop with a template
BombModule.SpawnDrop = function(ship, dropCode)
    local scPos = dropCode:find(':')
    local templateCode = dropCode:sub(scPos + 1, -1)
    DialModule.DeleteTemplate(ship)
    local dropPos = nil
    local temp = nil
    if dropCode:sub(-1, -1) == 'r' then
        -- FRONT drops
        temp = DialModule.SpawnTemplate(ship, templateCode:sub(1, -2) .. '_B')
        temp.createButton(BombModule.deleteButton)
        dropPos = MoveModule.GetFinalPosData(templateCode:sub(1, -2), ship, true)
        dropPos.finPos.rot[2] = dropPos.finPos.rot[2] - 180
    else
        -- BACK drops
        temp = DialModule.SpawnTemplate(ship, templateCode .. 'r_B')
        temp.createButton(BombModule.deleteButton)
        dropPos = MoveModule.GetFinalPosData(templateCode .. 'r', ship, true)
    end
    if dropPos == nil or temp == nil then
        return
    end
    table.insert(BombModule.dropTable, { ship = ship, temp = temp, code = dropCode, dest = dropPos.finPos })
end

-- Delete existing drop, return deleted code or nil if there was none
BombModule.DeleteDrop = function(temp_ship)
    local newTable = {}
    local deleteCode = nil
    for k, dTable in pairs(BombModule.dropTable) do
        if dTable.ship == temp_ship or dTable.temp == temp_ship then
            deleteCode = dTable.code
            DialModule.DeleteTemplate(dTable.ship)
        else
            table.insert(newTable, dTable)
        end
    end
    BombModule.dropTable = newTable
    return deleteCode
end

-- Delete drops on ship/template delete
BombModule.onObjectDestroyed = function(obj)
    for k, dTable in pairs(BombModule.dropTable) do
        if dTable.ship == obj or dTable.temp == obj then
            BombModule.DeleteDrop(obj)
        end
    end
end

-- Bomb type -> offset data
BombModule.tokenOffset = {}
BombModule.tokenOffset.standardAoE = { pos = { 0, Dim.Convert_mm_igu(-2), Dim.Convert_mm_igu(-4.5) }, rot = { 0, 90, 0 } }
BombModule.tokenOffset.prox = { pos = { 0, Dim.Convert_mm_igu(-2), Dim.Convert_mm_igu(15) }, rot = { 0, 90, 0 } }
BombModule.tokenOffset.cluster = { pos = { 0, Dim.Convert_mm_igu(-2), 0 }, rot = { 0, 180, 0 } }
BombModule.tokenOffset.connor = { pos = { 0, Dim.Convert_mm_igu(-2), Dim.Convert_mm_igu(21) }, rot = { 0, 180, 0 } }
BombModule.tokenOffset.rgc = { pos = { 0, Dim.Convert_mm_igu(-1), Dim.Convert_mm_igu(9.5) }, rot = { 0, 0, 0 } }
BombModule.tokenOffset.chaff = { pos = { Dim.Convert_mm_igu(-0.05), Dim.Convert_mm_igu(-1), Dim.Convert_mm_igu(12.5) }, rot = { 0, 90, 0 } }

-- Bomb name -> type data
BombModule.snapTable = {}
BombModule.snapTable['Ion Bomb'] = 'standardAoE'
BombModule.snapTable['Proton Bomb'] = 'standardAoE'
BombModule.snapTable['Seismic Charge'] = 'standardAoE'
BombModule.snapTable['Thermal Detonator'] = 'standardAoE'
BombModule.snapTable.Bomblet = 'standardAoE'
BombModule.snapTable['Electro-Proton Bomb'] = 'standardAoE'
BombModule.snapTable['Proximity Mine'] = 'prox'
BombModule.snapTable['Cluster Mine (middle)'] = 'cluster'
BombModule.snapTable['Connor Net'] = 'connor'
BombModule.snapTable['Loose Cargo'] = 'rgc'
BombModule.snapTable['Concussion Bomb'] = 'standardAoE'
BombModule.snapTable['Electro-Chaff Cloud'] = 'chaff'
BombModule.snapTable['Blaze Bomb'] = 'standardAoE'

-- Minimum distance to snap
BombModule.snapDist = 1.5
-- Snap on drop
BombModule.OnTokenDrop = function(token)
    -- Get the offset data
    local offset = BombModule.tokenOffset[BombModule.snapTable[token.getName()]]

    -- Deduct closest bomb drop point within snap distance
    local closest = { dist = BombModule.snapDist + 1, pointKey = nil }
    local tPos = token.getPosition()
    for k, dTable in pairs(BombModule.dropTable) do
        local newDist = Vect.Distance(tPos, dTable.dest.pos)
        if newDist < closest.dist then
            closest.dist = newDist
            closest.pointKey = k
            closest.temp = dTable.temp
        end
    end

    -- If there was one
    if closest.pointKey ~= nil then
        -- Move the token to the snap points
        local drop = BombModule.dropTable[closest.pointKey]
        local destPos = Vect.Sum(drop.dest.pos, Vect.RotateDeg(offset.pos, drop.dest.rot[2]))

        local size = drop.ship.getTable("Data").Size or 'small'
        if size == 'large' then
            destPos = Vect.Sum(destPos, Vect.RotateDeg({ 0, 0, Dim.Convert_mm_igu(-20) }, drop.dest.rot[2]))
        elseif size == 'medium' then
            destPos = Vect.Sum(destPos, Vect.RotateDeg({ 0, 0, Dim.Convert_mm_igu(-10) }, drop.dest.rot[2]))
        end
        local destRot = Vect.Sum(drop.dest.rot, offset.rot)
        destPos[2] = drop.ship.getPosition()[2] + offset.pos[2]
        token.lock()
        token.setPositionSmooth(destPos, false, true)
        token.setRotationSmooth(destRot, false, true)
        XW_cmd.SetBusy(token)
        MoveModule.WaitForResting(token, { pos = destPos, rot = destRot })
        -- Expand clusters
        if token.getName() == 'Cluster Mine (middle)' then
            BombModule.ExpandCluster({ pos = destPos, rot = destRot })
        end

        if token.getName() == 'Electro-Chaff Cloud' then
            fuseBag = getObjectFromGUID(bagGuids['Fuse'])
            fuseBag.takeObject({
                position = vector(destPos[1], destPos[2], destPos[3]) + vector(0, 1, 0),
                smooth = true,
            })
        end

        if token.getName() == 'Blaze Bomb' then
            --BombModule.SpawnBlaze({pos=destPos, rot=destRot})
        end

        if token.hasTag('Mine') then
            BombModule.CheckMineDroppedOverlapping(token)
        end
        AnnModule.Announce(
            { type = 'action', note = drop.ship.getName() .. ' dropped a ' .. token.getName():gsub('%(middle%)', 'set') },
            'all')
        closest.temp.destruct()
        return true
    else
        return false
    end
end

BombModule.CheckMineDroppedOverlapping = function(token, ownship)
    local mine = token
    Wait.condition(
        function()
            local ships = getObjectsWithTag('Ship')
            local minDist = Dim.Convert_mm_igu(110)
            local minePos = mine.getPosition()
            for _, ship in pairs(ships) do
                if ship ~= ownship then
                    local shipPos = ship.getPosition()
                    local dist = math.sqrt(math.pow((minePos.x - shipPos.x), 2) + math.pow((minePos.z - shipPos.z), 2))
                    if dist < minDist then
                        local collissions = MoveModule.CheckMineCollisions(ship,
                            { pos = ship.GetPosition(), rot = ship.GetRotation() }, false, nil)
                        for _, col in pairs(collissions) do
                            if col == mine then
                                AnnModule.Announce(
                                    {
                                        type = 'warn',
                                        note = mine.getName() ..
                                            ' appears to have been dropped ontop of ' .. ship.getName()
                                    }, 'all')
                            end
                        end
                    end
                end
            end
        end,
        function()
            return (mine.resting == true) and (mine.isSmoothMoving() == false)
        end)
end

-- TODO: try to move or integrate this with Bomb Code
clusterScript = [[
-- Convert argument from IN-GAME UNITS to MILIMETERS
local Dim = require("Dim")
Dim.mm_igu_ratio = 0.03637
--function Convert_igu_mm(in_game_units)
--    return in_game_units/Dim.mm_igu_ratio
--end


checkingRange = nil
scale = 1/self.getScale().x

local removeButtonUp = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = {0, 0.1*scale, 0},
    rotation = {0, 0, 0},
    width = 400*scale,
    height = 300*scale,
    font_size = 100*scale,
    color = {0.7, 0.7, 0.7}
}

local removeButtonDown = {
    click_function = 'removeCheckRange',
    label = 'Remove',
    function_owner = self,
    position = {0, -0.1*scale, 0},
    rotation = {180, 0, 0},
    width = 400*scale,
    height = 300*scale,
    font_size = 100*scale,
    color = {0.7, 0.7, 0.7}
}

function removeCheckRange()
  checkRange(nil)
end

function onLoad(save_state)
    print("Test")
    self.addContextMenuItem("Check Range 1", function() checkRange(1) end, false)
    print("Test2")
end

function checkRange(range)
    if range and checkingRange ~= range then
      printToAll("Checking for ships within range ".. range .. " of " .. self.getName(), color(1.0,1.0,0))
      vector_lines = {}
      for k,obj in pairs(getObjectsWithAnyTags({'Ship'})) do
          my_pos = self.getNearestPointFromObject(obj)
          closest = Global.call("API_GetClosestPointToShip", {ship=obj,point=my_pos})
          distance = Dim.Convert_igu_mm(closest.length)
          if distance < 100*range then
              printToAll(obj.getName() .. " is within range ".. range .. " of ".. self.getName(), color(1.0,1.0,0))
              table.insert(vector_lines, {
                  points = {self.positionToLocal(closest.A), self.positionToLocal(closest.B)},
                  color = {1,1,1},
                  thickness = 0.05*scale,
                  rotation = vector(0,0,0)
              })
          end
      end
      self.clearButtons()
      self.setVectorLines(vector_lines)
      if #vector_lines > 0 then
        checkingRange = range
        if self.is_face_down then
          self.createButton(removeButtonDown)
        else
          self.createButton(removeButtonUp)
        end
      else
        checkingRange = nil
        printToAll("No ships is within range ".. range .." of " .. self.getName(), color(1.0,1.0,0))
      end
    else
      checkingRange = nil
      self.clearButtons()
      self.setVectorLines({})
    end
end
]]

-- Spawn side tokens for cluster mine
BombModule.ExpandCluster = function(center)
    local offset = { Dim.Convert_mm_igu(43.5), 0, Dim.Convert_mm_igu(-1.5) }
    local tParams = { type = 'Custom_Token' }
    local tCustom = { image = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/textures/bombs/clustermine-side.png', thickness = 0.1, merge_distance = 5 }

    local t1 = spawnObject(tParams)
    t1.setCustomObject(tCustom)
    t1.lock()
    local destOffset1 = Vect.RotateDeg(offset, center.rot[2])
    t1.setPositionSmooth(Vect.Sum(center.pos, destOffset1), false, true)
    t1.setRotationSmooth(center.rot, false, true)
    t1.setScale({ 0.4554, 0.4554, 0.4554 })
    t1.setName('Cluster Mine (side)')
    t1.addTag('Mine')
    t1.setLuaScript(clusterScript)
    BombModule.CheckMineDroppedOverlapping(t1)

    local t2 = spawnObject(tParams)
    t2.setCustomObject(tCustom)
    t2.lock()
    local destOffset2 = Vect.RotateDeg(Vect.ScaleEach(offset, { -1, 1, 1 }), center.rot[2])
    t2.setPositionSmooth(Vect.Sum(center.pos, destOffset2), false, true)
    t2.setRotationSmooth(center.rot, false, true)
    t2.setScale({ 0.4554, 0.4554, 0.4554 })
    t2.setName('Cluster Mine (side)')
    t2.addTag('Mine')
    t2.setLuaScript(clusterScript)
    BombModule.CheckMineDroppedOverlapping(t2)
end

-- TODO: compare with BlazeBomb code
BombModule.SpawnBlaze = function(center)
    local offset = { -Dim.Convert_mm_igu(53), 0, 0 }
    local tParams = { type = 'Custom_Model' }
    local tCustom = {
        mesh =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tokens/devices/proximity.obj',
        diffuse =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tokens/devices/blaze.png',
        collider =
        'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tokens/devices/proximity-col.obj',
        convex = true,
        material = 3,
        type = 0
    }

    local t1 = spawnObject(tParams)
    t1.setCustomObject(tCustom)
    t1.lock()
    local destOffset1 = Vect.RotateDeg(offset, center.rot[2])
    t1.setPositionSmooth(Vect.Sum(center.pos, destOffset1), false, true)
    t1.setRotationSmooth(center.rot, false, true)
    t1.setScale({ 0.38, 0.38, 0.38 })
    t1.setName('Blaze')
    t1.addTag('Mine')
    t1.addTag('Obstacle')
    t1.setLuaScript(clusterScript)
    BombModule.CheckMineDroppedOverlapping(t1)
    fuseBag = getObjectFromGUID(bagGuids['Fuse'])
    fuseBag.takeObject({
        position = Vect.Sum(Vect.Sum(center.pos, destOffset1), { 0, 1, 0 }),
        smooth = true,
    })
end

-- END BOMB MODULE
--------

--------
-- DIRECT TTS EVENT HANDLING
-- Watch for changed descriptions, handle destroyed objects, saving et cetera

-- ~~~~~~
-- CONFIGURATION:

-- How many frames pass between updating watched objects (ships) list
-- It's so we don't go through massive list of all objects on table each frame (why would we?)

time_time = Time.time
os_time = os.time()

function init_event_check()
    Wait.time(event_check, 0.2, -1)
    Wait.time(ShipProximityHider.proximity_check, 0.3, -1)
end

EventSub.Register('onLoad', init_event_check)

-- This is called each frame
function event_check()
    -- If description is not blank, try processing it
    for k, obj in pairs(getObjectsWithTag('Ship')) do
        if obj ~= nil and obj.getDescription() ~= '' then
            Wait.frames(
                function()
                    XW_cmd.Process(obj, obj.getDescription())
                end
                , 1) -- Waiting a frame to allow Animated Ships to pick up command
        end
    end

    --if Time.frame_count%1 == 0 then
    local os_now = os.time()
    local os_diff = os_now - os_time
    os_time = os_now
    local time_now = Time.time
    local time_diff = time_now - time_time
    time_time = time_now
    --printToAll("Frame dt: " .. Time.delta_time)
    --printToAll("DT Diff:  " .. os_diff - time_diff)
    --end
end

-- When something is destroyed, it is called as an argument here (with 1 more frame to live)
function onObjectDestroyed(dying_object)
    -- Handle history delete and emergency restore saving
    MoveModule.onObjectDestroyed(dying_object)
    -- Handle killing rulers
    RulerModule.onObjectDestroyed(dying_object)
    -- Handle killing bomb drop templates
    BombModule.onObjectDestroyed(dying_object)
    -- Handle killing tokens
    TokenModule.onObjectDestroyed(dying_object)
    -- Dial manager handeling dying dials and ships
    DialManagerModule.onObjectDestroyed(dying_object)
end

-- Report peeking on dials
function onObjectPeek(object, player_color)
    local token_type = object.getVar("__XW_TokenType")
    if token_type == "helper:Dial" then
        if object.is_face_down == false then
            local owning_player = object.getVar("playerColor")
            if owning_player == nil then
                owning_player = "no one"
            end
            if player_color ~= owning_player then
                printToAll(
                    player_color ..
                    " player attempted to peek on " .. object.getName() .. "s dial, owned by " .. owning_player .. "!!",
                    { 1, 0, 0 })
            else
                printToAll(player_color .. " peeked on " .. object.getName() .. "s dial", { 0.6, 0.6, 1 })
                local set_manouver = object.getVar("setMan")
                if set_manouver == "" then
                    printToColor(object.getName() .. "s dial is not yet set", player_color, { 0.6, 0.6, 1 })
                else
                    local info = MoveData.DecodeInfo(set_manouver)
                    local manouver = info.speed
                    -- [koiogran] [segnor] [talon] [reverse] [straight] [forward] [backward] [nil]
                    if info.extra == "koiogran" then
                        manouver = manouver .. " " .. info.extra
                    else
                        manouver = manouver .. " " .. info.type
                    end
                    if info.dir ~= nil then
                        manouver = manouver .. " " .. info.dir
                    end
                    if info.extra and info.extra ~= "koiogran" then
                        manouver = manouver .. " " .. info.extra
                    end
                    printToColor(object.getName() .. "s dial is set to: " .. manouver, player_color, { 0.6, 0.6, 1 })
                end
            end
        end
    end
end

-- END DIRECT TTS EVENT HANDLING
--------


--------
-- COLLISION CHECKING MODULE
-- Generally checking if two rotated rectangles overlap

-- ~~~~~~
-- CONFIGURATION:

-- How many milimeters should we widen the base from each side
-- With this at zero, sometimes ships overlap after a move
addidionalCollisionMargin_mm = -0.5
-- ~~~~~~

-- General idea here: https://www.gamedev.net/page/resources/_/technical/game-programming/2d-rotated-rectangle-collision-r2604
-- Originally written by Flolania and Hera Verigo, slightly refitted here

-- Return corners of ship base in a {xPos, zPos} table format
-- shipInfo: {ship=shipObjectReference, pos=shipPosition, rot=shipRotation}
function getCorners(shipInfo)
    local corners = {}
    local spos = shipInfo.pos
    local srot = shipInfo.rot[2]
    local baseSize = shipInfo.ship.getTable("Data").Size or 'small'
    local size = Dim.Convert_mm_igu((Dim.mm_baseSize[baseSize] / 2) + addidionalCollisionMargin_mm)
    local world_coords = {}
    world_coords[1] = { spos[1] - size, spos[3] + size }
    world_coords[2] = { spos[1] + size, spos[3] + size }
    world_coords[3] = { spos[1] + size, spos[3] - size }
    world_coords[4] = { spos[1] - size, spos[3] - size }
    for r, corr in ipairs(world_coords) do
        local xcoord = spos[1] + ((corr[1] - spos[1]) * math.sin(math.rad(srot))) -
            ((corr[2] - spos[3]) * math.cos(math.rad(srot)))
        local ycoord = spos[3] + ((corr[1] - spos[1]) * math.cos(math.rad(srot))) +
            ((corr[2] - spos[3]) * math.sin(math.rad(srot)))
        corners[r] = { xcoord, ycoord }
    end
    return corners
end

-- Return axes perpendicular to sides of two rectangles
function getAxis(c1, c2)
    local axis = {}
    axis[1] = { c1[2][1] - c1[1][1], c1[2][2] - c1[1][2] }
    axis[2] = { c1[4][1] - c1[1][1], c1[4][2] - c1[1][2] }
    axis[3] = { c2[2][1] - c2[1][1], c2[2][2] - c2[1][2] }
    axis[4] = { c2[4][1] - c2[1][1], c2[4][2] - c2[1][2] }
    return axis
end

function dot2d(p, o)
    return p[1] * o[1] + p[2] * o[2]
end

-- Check if any part of two rectangles overlap
-- Rectangles as in ship bases of a proper size
-- shipInfo: {ship=shipObjectReference, pos=shipPosition, rot=shipRotation}
function collide(shipInfo1, shipInfo2)
    local c2 = getCorners(shipInfo1)
    local c1 = getCorners(shipInfo2)
    local axis = getAxis(c1, c2)
    local scalars = {}
    for i1 = 1, #axis do
        for i2, set in pairs({ c1, c2 }) do
            scalars[i2] = {}
            for i3, point in pairs(set) do
                table.insert(scalars[i2], dot2d(point, axis[i1]))
            end
        end
        local s1max = math.max(unpack(scalars[1]))
        local s1min = math.min(unpack(scalars[1]))
        local s2max = math.max(unpack(scalars[2]))
        local s2min = math.min(unpack(scalars[2]))
        if s2min > s1max or s2max < s1min then
            return false
        end
    end
    return true
end

-- END COLLISION CHECKING MODULE
--------

-------
-- Local Reference function, for spawning items relative to the quick build card
function LocalPos(object, position)
    local rot = object.getRotation()
    local lPos = { position[1], position[2], position[3] }
    -- Z-X-Y extrinsic
    local zRot = RotMatrix('z', rot.z)
    lPos = RotateVector(zRot, lPos)
    local xRot = RotMatrix('x', rot.x)
    lPos = RotateVector(xRot, lPos)
    local yRot = RotMatrix('y', rot.y)
    lPos = RotateVector(yRot, lPos)

    return Vect.Sum(lPos, object.getPosition())
end

------

function onObjectSpawned(obj)
    obj.hide_when_face_down = false
end

XW_cmd.AddCommand('rot[lr]?[12]?', 'rotate')
XW_cmd.AddCommand('turret[12]?', 'turretarc')
XW_cmd.AddCommand('a', 'fixedarc')

mountRotations = {
    front = vector(0, 0, 0),
    left = vector(0, -90, 0),
    back = vector(0, 180, 0),
    right = vector(0, 90, 0),
    frontback = vector(0, 0, 0),
    leftright = vector(0, 90, 0)
}

arcNames = {
    front = "Front",
    left = "Left",
    back = "Back",
    right = "Right",
    frontback = "Front & Back",
    leftright = "Left & Right",
    fullfront = "Full Front",
    fullback = "Full Back",
    bullseye = "Bullseye",
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
    bullseye = "bull",
}

nextMountDirection = {
    rotateleft = {
        front = "left",
        left = "back",
        back = "right",
        right = "front",
        leftright = "frontback",
        frontback = "leftright"
    },
    rotateright = {
        front = "right",
        left = "front",
        back = "left",
        right = "back",
        leftright = "frontback",
        frontback = "leftright"
    }
}

mountDirectionToArcs = {
    front = { "front" },
    left = { "left" },
    back = { "back" },
    right = { "right" },
    leftright = { "left", "right" },
    frontback = { "front", "back" },
}

mountToIndex = {
    main = '',
    front = '1',
    rear = '2'
}

-- TODO: this is used by DataPad with Ship Spawning
pilotCardScript =
[[
dial = nil
ship = nil
function addTintObject(params)
    if params[1] == "ship" then
      ship = params[2]
    elseif params[1] == "dial" then
      dial = params[2]
    end
end

function DisableAttachedColliders()
  for i, child in ipairs(self.getChildren()) do
    if i ~= 1 then
      if child.getComponent("MeshCollider") then
        child.getComponent("MeshCollider").set("enabled", false)
      end
    end
  end
end

function tint_check()
    local tint = self.getColorTint()
    if tint ~= color(1,1,1,1) then
      self.setColorTint(color(1,1,1,1))
      if dial ~= nil then
        dial.setColorTint(tint)
      end

      for i, attachment in pairs(self.getAttachments()) do
        id = self.removeAttachment(attachment.index)
        id.setColorTint(tint)
        self.addAttachment(id)
      end

      if ship ~= nil then
        local data = ship.getTable("Data")
        data.ColorId = tint
        ship.setTable("Data", data)
        for i, attachment in pairs(ship.getAttachments()) do
          id = ship.removeAttachment(0) -- This process puts the front attachment in the back, and the index is rearranged
          if id.getName():find("Arc Indicator") then
            local indicator = ship.getTable('arc_indicators')[id.getDescription()] or {}
            if indicator.color_by_id then
              id.setColorTint(tint)
            end
          elseif id.getName() == "ColorId" then
            id.setColorTint(tint)
          end
          ship.addAttachment(id)
        end
      end
      Wait.frames(DisableAttachedColliders, 1)

    end
end

loaded = false

function onLoad(savestate)
  loaded = true
  Wait.time(tint_check, 0.5, -1)
end

function isLoadedAndStill()
  return loaded and self.resting
end
]]

-------
--spawner function, checks for Pilots and Upgrades lists and spawn the respective objects

function newSpawner(listTable)
    --listTable contains :

    --Pilots[x] = table

    --Upgrades[x] = {string1, string2...}
    --spawnCard = Object reference used to position the spawned material
    --Faction = String

    Pilots = listTable.Pilots
    Upgrades = listTable.Upgrades
    spawnCard = listTable.spawnCard
    Faction = listTable.Faction
    Customization = listTable.Customization or {}
    local dialSkin = listTable.factionDial
    spawnedPilotList = {}
    local spawnPrefix =
    "{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/"
    local factionnames = { "rebel", "empire", "scum", "resistance", "first-order", "republic", "separatists" }

    PosBag1 = { 5, 5, 0 }
    PosBag2 = { 10, 10, 0 }
    PosBag3 = { 15, 15, 0 }
    PosBag4 = { 20, 20, 0 }
    PoaBag5 = { 25, 25, 0 }
    tempBagAcc = getObjectFromGUID(bagGuids['Accessories']).clone({ position = PosBag3 })

    --Stablishes lists of available upgrades, pilots, accessories, ships and mobile upgrades
    listaAcc = tempBagAcc.getObjects()

    tokens = {}
    for k, acc in ipairs(listaAcc) do
        if acc.name == 'Charge' then
            tokens.Charge = tempBagAcc.takeObject({ rotation = spawnCard.getRotation(), guid = acc.guid, smooth = false })
        elseif acc.name == 'Force' then
            tokens.Force = tempBagAcc.takeObject({ rotation = spawnCard.getRotation(), guid = acc.guid, smooth = false })
        elseif acc.name == 'Shield' then
            tokens.Shield = tempBagAcc.takeObject({ rotation = spawnCard.getRotation(), guid = acc.guid, smooth = false })
        elseif acc.name == 'Energy' then
            tokens.Energy = tempBagAcc.takeObject({ rotation = spawnCard.getRotation(), guid = acc.guid, smooth = false })
        end
    end

    --Store the initial position of the Quick Build Card
    storePos = spawnCard.getPosition()
    storeRot = spawnCard.getRotation()

    shipIndex = 1 --Sets index of ship being spawned

    while Pilots[shipIndex] ~= nil do
        --Values used for accessories spawn and layout
        UpNum = 0
        Turret = 0
        dualTurret = 0
        Bombs = 0
        hasMob = 0
        bombTokenDescription = ''
        local configCardGUID = nil

        if Pilots[shipIndex].standardized_loadout then
            spawnCard.setPosition(LocalPos(spawnCard, { -1.1, 0, 0 }))
        end

        -- Spawn Mobile Upgrades
        for j, Up in pairs(Upgrades[shipIndex]) do
            if Up.Config == true then
                finalPos = LocalPos(spawnCard, { -1.9, 0, 0 }) --Layout adjustment
                spawnCard.setPosition(finalPos)
                pos = LocalPos(spawnCard, { 1.42, 0, 5.5 })
                rot = spawnCard.getRotation()
                rot.y = rot.y
                cardLink = Up.card
                cardBackLink = Up.cardB
                if Customization[Up.name] ~= nil then
                    cardLink = Customization[Up.name].face or Up.card
                    cardBackLink = Customization[Up.name].back or Up.cardB
                end
                deck = Decker.Asset(cardLink, cardBackLink)
                card = Decker.Card(deck, 1, 1)
                newUp = card:spawn({ position = pos, rotation = rot, scale = { 0.68, 0.68, 0.68 } })
                newUp.setName(Up.name)
                newUp.addTag("ConfigCard")
                configCardGUID = newUp.getGUID()
                hasMob = 1
                charges = Up.Charge
                while charges > 0 do
                    if charges == 5 then
                        pos = LocalPos(spawnCard, { -1.7 + 4, 0, 1.9 })
                    elseif charges == 4 then
                        pos = LocalPos(spawnCard, { -1.7 + 4, 0, 2.8 })
                    elseif charges == 3 then
                        pos = LocalPos(spawnCard, { -2.6 + 4, 0, 2.8 })
                    elseif charges == 2 then
                        pos = LocalPos(spawnCard, { -1.7 + 4, 0, 3.7 })
                    elseif charges == 1 then
                        pos = LocalPos(spawnCard, { -2.6 + 4, 0, 3.7 })
                    else
                        charges = 0
                    end
                    charges = charges - 1
                    chargeClone = tokens.Charge.clone()
                    chargeClone.setPosition(pos)
                    chargeClone.setVar("charge_owner", Pilots[shipIndex].name)
                    chargeClone.setVar("charge_name", Up.name)
                end
            end
        end
        for j, Up in pairs(Upgrades[shipIndex]) do
            if Up.Config ~= true then
                --Indicates there's a card left of the pilot card, for layout purposes
                pos = LocalPos(spawnCard, { -1.42 - 1.78 * UpNum, 1 - 0.2 * UpNum, 5.5 })
                rot = spawnCard.getRotation()
                rot.y = rot.y - 90
                cardLink = Up.card
                cardBackLink = Up.cardB
                if Customization[Up.name] ~= nil then
                    cardLink = Customization[Up.name].face or Up.card
                    cardBackLink = Customization[Up.name].back or Up.cardB
                end
                deck = Decker.Asset(cardLink, cardBackLink)
                card = Decker.Card(deck, 1, 1)
                local rotUp = rot
                rotUp.y = rotUp.y + 90
                newUp = card:spawn({ position = pos, rotation = rotUp, scale = { 0.68, 0.68, 0.68 } })
                newUp.setName(Up.name)
                if Up.Condition ~= nil then
                    --Checks and spawn conditions associated to pilots
                    for k, acc in ipairs(listaAcc) do
                        if acc.name == Up.Condition then
                            pos = LocalPos(spawnCard, { -2 - 1.78 * UpNum, 1 - 0.2 * UpNum, 8 })
                            rot = spawnCard.getRotation()
                            newAsset = tempBagAcc.takeObject({ position = pos, rotation = rot, guid = acc.guid, smooth = false })
                            assetClone = newAsset.clone()
                            assetClone.setPosition(pos)
                            tempBagAcc.putObject(newAsset)
                        end
                    end
                end
                --Checks and spawns Charge Tokens with appropriate layout (up to 4 tokens)
                charges = Up.Charge
                if charges > 0 then
                    while charges > 0 do
                        if charges == 5 then
                            pos = LocalPos(spawnCard, { -1.7 - 1.78 * UpNum, 1, 1.9 })
                        elseif charges == 4 then
                            pos = LocalPos(spawnCard, { -1.7 - 1.78 * UpNum, 1, 2.8 })
                        elseif charges == 3 then
                            pos = LocalPos(spawnCard, { -2.6 - 1.78 * UpNum, 1, 2.8 })
                        elseif charges == 2 then
                            pos = LocalPos(spawnCard, { -1.7 - 1.78 * UpNum, 1, 3.7 })
                        elseif charges == 1 then
                            pos = LocalPos(spawnCard, { -2.6 - 1.78 * UpNum, 1, 3.7 })
                        else
                            charges = 0
                        end
                        charges = charges - 1
                        chargeClone = tokens.Charge.clone()
                        chargeClone.setPosition(pos)
                        chargeClone.setVar("charge_owner", Pilots[shipIndex].name)
                        chargeClone.setVar("charge_name", Up.name)
                    end
                end
                UpNum = UpNum + 1 --Update number of upgrade being spawned
            end
        end

        if Pilots[shipIndex].id ~= 0 then
            --Pilot and Ship Spawn
            pilotName = Pilots[shipIndex].name
            card = Pilots[shipIndex].card
            cardB = Pilots[shipIndex].cardB
            local tint = color(0, 0, 0, 0)
            local modeltint = color(1, 1, 1, 1)
            if Customization[pilotName] ~= nil then
                tint = Customization[pilotName].tint or color(0, 0, 0, 0)
                card = Customization[pilotName].face or Pilots[shipIndex].card
                cardB = Customization[pilotName].back or Pilots[shipIndex].cardB
                modeltint = Customization[pilotName].modeltint or color(1, 1, 1, 1)
            end

            pos = LocalPos(spawnCard, { 0, 1.2, 5.5 })
            rot = spawnCard.getRotation()
            local newPil = nil
            if card ~= '' then
                if cardB ~= nil then
                    deck = Decker.Asset(card, cardB)
                    card = Decker.Card(deck, 1, 1)
                    newPil = card:spawn({ position = pos, rotation = rot })
                    newPil.setName(pilotName)
                    newPil.setDescription(Pilots[shipIndex].list)
                    newPil.setLuaScript(pilotCardScript)
                    newPil.setLock(true)

                    -- Spawn Pilot Identifier
                    local card = newPil
                    local idpos = pos
                    local idrot = rot

                    pilotIdSpawnFunc = function()
                        local pilotId = spawnObject({
                            type = "Custom_Model",
                            position = idpos,
                            rotation = idrot,
                            scale = Dim.mm_ship_scale,
                            sound = false,
                            snap_to_grid = false,
                        })
                        pilotId.setCustomObject({
                            mesh =
                            '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/cardid.obj',
                            convex = true,
                            material = 1,
                            type = 0
                        })
                        pilotId.setColorTint(tint)
                        card.addAttachment(pilotId)
                        card.setLock(false)
                    end
                    Wait.condition(pilotIdSpawnFunc, function()
                        return (not card.spawning)
                    end)
                end
            end
            if pilotName ~= '' then
                for k, acc in pairs(listaAcc) do
                    local card = newPil
                    if acc.name == 'Unassigned Dial' then
                        local dialpos = LocalPos(spawnCard, { 0, 1, 12 })
                        local dialrot = rot
                        local dial = tempBagAcc.takeObject(
                            {
                                position = dialpos,
                                rotation = dialrot,
                                guid = acc.guid
                            })
                        local newDial = dial.clone()
                        newDial.setPosition(pos)
                        tempBagAcc.putObject(dial)
                        local conditionFunc = function()
                            return (not card.spawning) and (not newDial.spawning)
                        end
                        local executeFunc = function()
                            newDial.setCustomObject({ ['diffuse'] = dialSkin })
                            newDial = newDial.reload()
                            newDial.setColorTint(tint)
                            newDial.setPosition(dialpos)
                            newDial.setRotation(dialrot)
                            card.call('addTintObject', { 'dial', newDial })
                        end
                        Wait.condition(executeFunc, conditionFunc)
                    end
                end
            end
            if Pilots[shipIndex].Condition ~= nil then
                --Checks and spawn conditions associated to pilots
                for k, acc in ipairs(listaAcc) do
                    if acc.name == Pilots[shipIndex].Condition then
                        pos = LocalPos(spawnCard, { -2 - 1.78 * UpNum, 1, 8 })
                        rot = spawnCard.getRotation()
                        newAsset = tempBagAcc.takeObject({ position = pos, rotation = rot, guid = acc.guid })
                        assetClone = newAsset.clone()
                        assetClone.setPosition(pos)
                        tempBagAcc.putObject(newAsset)
                    end
                end
            end

            local newShip = nil
            local texture = nil
            if Customization[pilotName].texture ~= nil then
                texture = Customization[pilotName].texture
            elseif Pilots[shipIndex].Data.texture ~= nil then
                texture = '{verifycache}' .. Pilots[shipIndex].Data.texture
            end
            local shipoffset = vector(0, 0, 0)
            Pilots[shipIndex].Data.ColorId = tint
            if Pilots[shipIndex].Data.Config then
                Pilots[shipIndex].Data.Config.CardGUID = configCardGUID
            end

            if Customization[pilotName].texture ~= nil then
                texture = Customization[pilotName].texture
            elseif Pilots[shipIndex].Data.texture ~= nil then
                texture = '{verifycache}' .. Pilots[shipIndex].Data.textures[Pilots[shipIndex].Data.texture]
            end
            shipoffset = vector(0, 2.2, 0)
            local size = Pilots[shipIndex].Size
            local arcs = Pilots[shipIndex].Data.arcs
            local fixedarc = "none"
            if arcs.fixed then
                fixedarc = arcs.fixed.type[1] or "none"
            end
            if size == "huge" then
                pos = LocalPos(spawnCard, { 0, 0, 12 })
            else
                pos = LocalPos(spawnCard, { 0, 0, 9 })
            end
            rot = spawnCard.getRotation()
            local base_prototype = getObjectFromGUID(CompositeBase_GUID)
            newShip = base_prototype.clone()
            newShip.setPositionSmooth(pos, false, true)
            newShip.setRotationSmooth(rot, false, true)
            newShip.setScale(Dim.mm_ship_scale)

            newShip.setCustomObject({
                mesh = spawnPrefix .. "bases/" .. size .. "/base.obj?1",
                collider = ShipVerification.colliders[size],
                diffuse = spawnPrefix ..
                    "bases/" .. size .. "/" .. fixedarc .. "/" .. factionnames[Faction] .. ".png",
                convex = true,
                material = 1,
                type = 1
            })
            newShip.setTable("Data", Pilots[shipIndex].Data)
            newShip.setLock(true)
            if Pilots[shipIndex].Data.ProximityHider then
                newShip.addTag("ProximityHider")
            end

            local base_name_str = pilotName
            if Pilots[shipIndex].Data.limited and Pilots[shipIndex].Data.limited > 0 then
                base_name_str = string.rep("•", Pilots[shipIndex].Data.limited) .. " " .. pilotName
            end
            newShip.setTable("UiData", {
                name = base_name_str,
                icon = Pilots[shipIndex].Ship,
                init = "init" .. Pilots[shipIndex].Data.initiative
            })

            local pegtype = Pilots[shipIndex].peg or size
            local pegCustomObject = {
                mesh = spawnPrefix .. "bases/pegs/" .. pegtype .. ".obj",
                diffuse = spawnPrefix .. "bases/" .. size .. "/" .. fixedarc .. "/" .. factionnames[Faction] .. ".png",
                collider =
                '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/minisculebox.obj',
                convex = true,
                material = 1,
                type = 1
            }
            local shippos = pos
            local shiprot = rot
            local ship = newShip
            local shipCustomObject = nil
            if Pilots[shipIndex].Data.mesh then
                shipCustomObject = {
                    mesh = '{verifycache}' .. Pilots[shipIndex].Data.mesh,
                    diffuse = texture,
                    collider =
                    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/minisculebox.obj',
                    convex = true,
                    material = 1,
                    type = 1
                }
            end

            local pegAndShipSpawnFunction = function()
                local pegModel = spawnObject({
                    type         = "Custom_Model",
                    position     = shippos,
                    rotation     = shiprot,
                    scale        = Dim.mm_ship_scale,
                    sound        = false,
                    snap_to_grid = false,
                })
                pegModel.setName("Peg")
                pegModel.setCustomObject(pegCustomObject)
                ship.addAttachment(pegModel)
                if shipCustomObject then
                    local shipModel = spawnObject({
                        type         = "Custom_Model",
                        position     = vector(shippos[1], shippos[2], shippos[3]) + shipoffset,
                        rotation     = shiprot,
                        scale        = Dim.mm_ship_scale,
                        sound        = false,
                        snap_to_grid = false,
                    })
                    shipModel.setName("Ship")
                    shipModel.setCustomObject(shipCustomObject)
                    shipModel.setColorTint(modeltint)
                    ship.addAttachment(shipModel)
                end
            end
            Wait.condition(pegAndShipSpawnFunction,
                function() return (not ship.spawning) and (not ship.isSmoothMoving()) end)
            if newShip ~= nil then
                local ship = newShip
                local card = newPil
                local idpos = pos
                local idrot = rot
                local customObj = {
                    convex = true,
                    material = 1,
                    type = 1,
                    collider =
                    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/minisculebox.obj',
                }
                if Pilots[shipIndex].Size == "small" then
                    customObj.mesh =
                    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base_ID_Marker.obj'
                elseif Pilots[shipIndex].Size == "medium" then
                    customObj.mesh =
                    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base%20ID%20MED.obj'
                elseif Pilots[shipIndex].Size == "large" then
                    customObj.mesh =
                    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base%20ID%20LAR.obj'
                elseif Pilots[shipIndex].Size == "huge" then
                    customObj.mesh =
                    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base_ID_HUGE.obj'
                end
                local shipIdSpawnFunc = function()
                    local shipId = spawnObject({
                        type = "Custom_Model",
                        position = idpos,
                        rotation = idrot,
                        scale = Dim.mm_ship_scale * 0.99,
                        sound = false,
                        snap_to_grid = false,
                    })
                    shipId.setCustomObject(customObj)
                    shipId.setColorTint(tint)
                    shipId.setName("ColorId")
                    ship.addAttachment(shipId)
                    ship.setLock(false)
                    ship.addTag("Ship")
                    ship.drag_selectable = true
                    ship.interactable = true

                    card.call('addTintObject', { 'ship', ship })
                    ship.call('initContextMenu')
                end
                if Pilots[shipIndex].Data.ProximityHider then
                    ship.addTag("ProximityHider")
                end
                Wait.condition(shipIdSpawnFunc,
                    function()
                        return (not ship.spawning) and (not ship.isSmoothMoving()) and (not card.spawning)
                    end)

                if Pilots[shipIndex].Data.Config and Pilots[shipIndex].Data.Config.States then
                    for k, config in pairs(Pilots[shipIndex].Data.Config.States) do
                        if config.Model then
                            local customObject = ship.getCustomObject()
                            customObject.mesh = config.Model
                            customObject.diffuse = texture
                            local configSpawnFunction = function()
                                local configModel = spawnObject({
                                    type = "Custom_Model",
                                    position = vector(idpos[1], idpos[2], idpos[3]) + shipoffset,
                                    rotation = idrot,
                                    scale = Dim.mm_ship_scale,
                                    sound = false,
                                    snap_to_grid = false,
                                })
                                configModel.setName("Config")
                                configModel.setDescription(tostring(k))
                                configModel.setCustomObject(customObject)
                                configModel.setColorTint(modeltint)
                                if k ~= 1 then
                                    configModel.setScale(vector(0.0001, 0.0001, 0.0001))
                                end
                                ship.addAttachment(configModel)
                                Wait.frames(function()
                                    ship.call("DisableAttachedColliders")
                                end, 2)
                                Wait.frames(function()
                                    ship.call("DisableAttachedColliders")
                                end, 10)
                                Wait.frames(function()
                                    ship.call("DisableAttachedColliders")
                                end, 30)
                            end
                            Wait.condition(configSpawnFunction,
                                function()
                                    return (not ship.spawning) and (not ship.isSmoothMoving())
                                end)
                        end -- if Config.Model
                    end     -- for Data.Config
                    if Pilots[shipIndex].Data.Config and Pilots[shipIndex].Data.Config.Token then
                        pos = LocalPos(spawnCard, { -1.5, 1, 8.7 })
                        local configToken = spawnObject({
                            type = "Custom_Model",
                            scale = { 0.38, 0.38, 0.38 },
                            rotation = { 0, 270, 0 },
                            position = pos,
                        })
                        configToken.setCustomObject({
                            mesh =
                            "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tokens/flip/flipToken.obj",
                            diffuse = Pilots[shipIndex].Data.Config.Token,
                            type = 5,
                            material = 1,
                            specular_intensity = 0
                        })
                        configToken.setLuaScript(
                            [[
        __XW_Token = true
        __XW_TokenIdle = true
        __XW_TokenType = 'config'

        self.addTag('Flippable')

        function onFlip()
        local ship = Global.call("getShipTokenIsAssignedTo",{token=self})
        if ship and ship.getVar("SetConfiguration") then
            ship.call("SetConfiguration", {ConfigId=self.is_face_down and 1 or 2})
        end
        end
        ]])
                    end -- token
                end     -- config


                --[[customization_parts = {
                canopy = {
                model = 'https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/medium/firesprayclasspatrolcraft/firesprayV3-canopy.obj',
                material = 2,
                tintable = true
                }
            }]]
                --[[
            local Dim = require("Dim")
            for k, customization_part in pairs(Pilots[shipIndex].Data.customization_parts or {}) do
                if customization_part.model then
                local customObject = ship.getCustomObject()
                customObject.mesh = customization_part.model
                if customization_part.texture then
                    customObject.diffuse = customization_part.texture
                else
                    customObject.diffuse = texture
                end
                if customization_part.material then
                    customObject.material = customization_part.material
                end
                customObject.specular_sharpness = customization_part.specular_sharpness or 3
                customObject.specular_intensity = customization_part.specular_intensity or 0.1
                local customSpawnFunction = function()
                    local partModel = spawnObject({
                        type              = "Custom_Model",
                        position          = vector(idpos[1],idpos[2],idpos[3]) + shipoffset,
                        rotation          = idrot,
                        scale             = Dim.mm_ship_scale*1.01,
                        sound             = false,
                        snap_to_grid      = false,
                    })
                    partModel.setName("Part")
                    partModel.setDescription(tostring(k))
                    partModel.setCustomObject(customObject)
                    if customization_part.tint then
                    partModel.setColorTint(customization_part.tint)
                    end
                    ship.addAttachment(partModel)
                    Wait.frames(function() ship.call("DisableAttachedColliders") end, 2)
                    Wait.frames(function() ship.call("DisableAttachedColliders") end, 10)
                    Wait.frames(function() ship.call("DisableAttachedColliders") end, 30)
                end
                Wait.condition(customSpawnFunction , function() return (not ship.spawning) and (not ship.isSmoothMoving() ) end)
                end -- if customization_part.models
            end -- for Data.customization_parts

            ]]
            end

            for mount, turret in pairs(Pilots[shipIndex].Data.arcs.turret or {}) do
                local indicator_name = 'Arc Indicator' .. tostring(Faction)
                if turret.type[1] == 'doubleturret' then
                    indicator_name = 'Dual Arc Indicator' .. tostring(Faction)
                end
                local mount_pos = Pilots[shipIndex].Data.mountingPoints[mount]
                local offset = LocalPos(spawnCard, { mount_pos[1], 0, mount_pos[2] + 9 })
                for k, acc in pairs(listaAcc) do
                    if acc.name == indicator_name then
                        arcInd = tempBagAcc.takeObject({ position = offset, rotation = rot, guid = acc.guid, smooth = false })
                        newInd = arcInd.clone()
                        newInd.setPosition(pos)
                        tempBagAcc.putObject(arcInd)
                        newInd.setName(string.gsub(newInd.getName(), Faction, ''))
                    end
                end
            end

            if Pilots[shipIndex].Bomb == true then
                --Checks and spawn bomb drop token if needed
                for k, acc in ipairs(listaAcc) do
                    if acc.name == 'Bomb drop token (unassigned)' then
                        pos = LocalPos(spawnCard, { -1.5, 1, 8.7 })
                        bombDrop = tempBagAcc.takeObject({ position = pos, rotation = rot, guid = acc.guid, smooth = false })
                        dropClone = bombDrop.clone()
                        dropClone.setPosition(pos)
                        tempBagAcc.putObject(bombDrop)
                        dropClone.setDescription(Pilots[shipIndex].bombD)
                    end
                end
            end
            if Pilots[shipIndex].Docking == true then
                for k, acc in ipairs(listaAcc) do
                    if acc.name == 'Shuttle Launcher (assigned to mothership)' then
                        pos = LocalPos(spawnCard, { -1.5, 1, 8.7 })
                        shuttleDrop = tempBagAcc.takeObject({ position = pos, rotation = rot, guid = acc.guid, smooth = false })
                        dropClone = shuttleDrop.clone()
                        dropClone.setPosition(pos)
                        tempBagAcc.putObject(shuttleDrop)
                    end
                end
            end
            if Pilots[shipIndex].wingleader == true then
                for k, acc in ipairs(listaAcc) do
                    if acc.name == 'Epic Wing Token' then
                        pos = LocalPos(spawnCard, { -1.5, 1, 8.7 })
                        wingtoken = tempBagAcc.takeObject({ position = pos, rotation = rot, guid = acc.guid, smooth = false })
                        wingtokenclone = wingtoken.clone()
                        wingtokenclone.setPosition(pos)
                        tempBagAcc.putObject(wingtoken)
                    end
                end
            end

            --spawn pilot charge tokens
            if Pilots[shipIndex].Charge > 0 or Pilots[shipIndex].standardized_loadout then
                local chargeValue = Pilots[shipIndex].Charge
                while chargeValue > 0 do
                    chargeValue = chargeValue - 1
                    if Pilots[shipIndex].standardized_loadout then
                        pos = LocalPos(spawnCard, { 0.5 + 0.9 * chargeValue, 1, 3.4 })
                        if chargeValue > 2 then
                            pos = LocalPos(spawnCard, { 0.5 + 0.9 * (chargeValue - 3), 1, 2.5 })
                        end
                    elseif chargeValue == 3 then
                        pos = LocalPos(spawnCard, { -0.9, 1, 0.6 })
                    elseif chargeValue == 2 then
                        pos = LocalPos(spawnCard, { 0.9, 1, 1.6 })
                    elseif chargeValue == 1 then
                        pos = LocalPos(spawnCard, { 0, 1, 1.6 })
                    elseif chargeValue == 0 then
                        pos = LocalPos(spawnCard, { -0.9, 1, 1.6 })
                    else
                        charges = 0
                        pos = vector(0, 0, 0)
                    end
                    chargeClone = tokens.Charge.clone()
                    chargeClone.setPosition(pos)
                    chargeClone.setVar("charge_owner", Pilots[shipIndex].name)
                end
                if Pilots[shipIndex].standardized_loadout and Pilots[shipIndex].standardized_upgrades then
                    local total_height = 3.0
                    local step = total_height / #Pilots[shipIndex].standardized_upgrades
                    for k, upg in pairs(Pilots[shipIndex].standardized_upgrades) do
                        if upg.charge > 0 then
                            for i = 1, upg.charge, 1 do
                                chargeClone = tokens.Charge.clone()
                                chargeClone.setPosition(LocalPos(spawnCard,
                                    { -2.7 - i * 0.6, 1, 4 + step * (k - 1) + step /
                                    2 }))
                                chargeClone.setVar("charge_owner", Pilots[shipIndex].name)
                                chargeClone.setVar("charge_name", upg.name)
                                chargeClone.setScale(chargeClone.getScale() * 0.75)
                            end
                        end
                    end
                end
            end

            -- spawn force
            if Pilots[shipIndex].Force > 0 then
                local forceValue = Pilots[shipIndex].Force
                while forceValue > 0 do
                    forceValue = forceValue - 1
                    if Pilots[shipIndex].standardized_loadout then
                        pos = LocalPos(spawnCard, { 3.2, 1, 4.5 + 0.9 * forceValue })
                    elseif hasMob == 1 then
                        --adjusts layout if Mobile Upgrade is present
                        pos = LocalPos(spawnCard, { 1.7 + 0.9 * forceValue, 1, 3.4 })
                        if forceValue > 2 then
                            pos = LocalPos(spawnCard, { 1.7 + 0.9 * (forceValue - 3), 1, 2.5 })
                        end
                    else
                        pos = LocalPos(spawnCard, { 1.7, 1, 3.7 + 0.9 * forceValue })
                    end
                    forceClone = tokens.Force.clone()
                    forceClone.setPosition(pos)
                    forceClone.setVar("force_owner", Pilots[shipIndex].name)
                end
            end

            -- spawn energy
            if Pilots[shipIndex].Energy > 0 then
                local energyValue = Pilots[shipIndex].Energy
                while energyValue > 0 do
                    energyValue = energyValue - 1
                    if Pilots[shipIndex].standardized_loadout then
                        --pos = LocalPos(spawnCard, {3.3, 1, 5 + 0.9*Pilots[shipIndex].Force})
                        pos = LocalPos(spawnCard, { 0.5 + 0.9 * energyValue, 1, 3.4 })
                        if energyValue > 2 then
                            pos = LocalPos(spawnCard, { 0.5 + 0.9 * (energyValue - 3), 1, 2.5 })
                        end
                    else
                        pos = LocalPos(spawnCard, { 1.7, 1, 3.7 + 0.9 * energyValue })
                    end
                    energyClone = tokens.Energy.clone()
                    energyClone.setPosition(pos)
                    energyClone.setVar("energy_owner", Pilots[shipIndex].name)
                end
            end

            --Spawns Shields
            if Pilots[shipIndex].Shield > 0 then
                local shieldValue = Pilots[shipIndex].Shield
                --spawn shield tokens, layout good for up to 9 shields
                while shieldValue > 0 do
                    shieldValue = shieldValue - 1
                    if Pilots[shipIndex].standardized_loadout then
                        pos = LocalPos(spawnCard, { -2.2 + 0.9 * shieldValue, 1, 3.4 })
                        if shieldValue > 5 then
                            pos = LocalPos(spawnCard, { -2.2 + 0.9 * (shieldValue - 6), 1, 1.6 })
                        elseif shieldValue > 2 then
                            pos = LocalPos(spawnCard, { -2.2 + 0.9 * (shieldValue - 3), 1, 2.5 })
                        end
                    else
                        pos = LocalPos(spawnCard, { -1 + 0.9 * shieldValue, 1, 3.4 })
                        if shieldValue > 5 then
                            pos = LocalPos(spawnCard, { -1 + 0.9 * (shieldValue - 6), 1, 1.6 })
                        elseif shieldValue > 2 then
                            pos = LocalPos(spawnCard, { -1 + 0.9 * (shieldValue - 3), 1, 2.5 })
                        end
                    end
                    shieldClone = tokens.Shield.clone()
                    shieldClone.setPosition(pos)
                    shieldClone.setVar("shield_owner", Pilots[shipIndex].name)
                end
            end
        end

        if Pilots[shipIndex].standardized_loadout then
            charges = 0
            for _, upgrade in pairs(Pilots[shipIndex].standardized_upgrades) do
                charges = math.max(charges, upgrade.charge)
            end
            finalPos = LocalPos(spawnCard, { -(5.5 + charges * 0.7), 0, 0 })
        else
            finalPos = LocalPos(spawnCard, { -4 - 1.78 * UpNum, 0, 0 })
        end
        spawnCard.setPosition(finalPos)
        shipIndex = shipIndex + 1
    end

    finalPos = LocalPos(spawnCard, { 0, 0, 5.5 })
    spawnCard.setPosition(finalPos)

    for i, remote in pairs(listTable.Remotes or {}) do
        print("Spawning remote:" .. remote)
        for k, acc in ipairs(listaAcc) do
            if acc.name == remote then
                pos = LocalPos(spawnCard, { 1, 1, 0 })
                print("Found remote, spawning pos: " .. tostring(pos[1]) .. "," ..
                    tostring(pos[2]) .. "," .. tostring(pos[3]))
                remObj = tempBagAcc.takeObject({ rotation = spawnCard.getRotation(), guid = acc.guid, smooth = false })
                remoteClone = remObj.clone()
                remoteClone.setPosition(pos)
                tempBagAcc.putObject(remObj)
                finalpos = LocalPos(spawnCard, { -3, 0, 0 })
                spawnCard.setPosition(finalpos)
                break
            end
        end
    end

    -- Delete cloned bags
    tempBagAcc.destruct()
    for k, token in pairs(tokens) do
        token.destruct()
    end

    if listTable.Obstacles ~= nil then
        tempObstacleBag = getObjectFromGUID(bagGuids['Obstacles']).clone({ position = PosBag3 }) -- Obstacles bag
        obstacleAcc = tempObstacleBag.getObjects()
        for i, obstacleName in ipairs(listTable.Obstacles) do
            local found = false
            for j, obstacle in ipairs(obstacleAcc) do
                if obstacle.name == obstacleName then
                    print("Found obstacle: " .. obstacle.name .. " - " .. obstacleName)
                    pos = LocalPos(spawnCard, { 0, 1, 0 })
                    obstacleToken = tempObstacleBag.takeObject({
                        rotation = spawnCard.getRotation(),
                        guid = obstacle.guid,
                        smooth = false
                    })
                    obstacleClone = obstacleToken.clone()
                    obstacleClone.setPosition(pos)
                    tempObstacleBag.putObject(obstacleToken)
                    found = true
                    break
                end
            end
            if not found then
                print("Couldnt find obstacle: " .. obstacleName)
            else
                finalPos = LocalPos(spawnCard, { -4, 0, 0 })
                spawnCard.setPosition(finalPos)
            end
        end
        tempObstacleBag.destruct()
    end

    --returns Quick Build Card to initial position
    spawnCard.setPosition(storePos)
    spawnCard.setRotation(storeRot)
end

function RotMatrix(axis, angDeg)
    local ang = math.rad(angDeg)
    local cs = math.cos
    local sn = math.sin

    if axis == 'x' then
        return {
            { 1, 0,       0 },
            { 0, cs(ang), -1 * sn(ang) },
            { 0, sn(ang), cs(ang) }
        }
    elseif axis == 'y' then
        return {
            { cs(ang),      0, sn(ang) },
            { 0,            1, 0 },
            { -1 * sn(ang), 0, cs(ang) }
        }
    elseif axis == 'z' then
        return {
            { cs(ang), -1 * sn(ang), 0 },
            { sn(ang), cs(ang),      0 },
            { 0,       0,            1 }
        }
    end
end

-- Apply given rotation matrix on given vector
-- (multiply matrix and column vector)
function RotateVector(rotMat, vect)
    local out = { 0, 0, 0 }
    for i = 1, 3, 1 do
        for j = 1, 3, 1 do
            out[i] = out[i] + rotMat[i][j] * vect[j]
        end
    end
    return out
end

--Decker module

do
    Decker = {}

    -- provide unique ID starting from 20 for present decks
    local nextID = nil
    do
        local _nextID = 20
        nextID = function()
            _nextID = _nextID + 1
            return tostring(_nextID)
        end
    end

    -- Asset signature (equality comparison)
    local function assetSignature(assetData)
        return table.concat({
            assetData.FaceURL,
            assetData.BackURL,
            assetData.NumWidth,
            assetData.NumHeight,
            assetData.BackIsHidden and 'hb' or '',
            assetData.UniqueBack and 'ub' or ''
        })
    end
    -- Asset ID storage to avoid new ones for identical assets
    local idLookup = {}
    local function assetID(assetData)
        local sig = assetSignature(assetData)
        local key = idLookup[sig]
        if not key then
            key = nextID()
            idLookup[sig] = key
        end
        return key
    end

    local assetMeta = {
        deck = function(self, cardNum, options)
            return Decker.AssetDeck(self, cardNum, options)
        end
    }
    assetMeta = { __index = assetMeta }

    -- Create a new CustomDeck asset
    function Decker.Asset(face, back, options)
        local asset = {}
        options = options or {}
        asset.data = {
            FaceURL = face or error('Decker.Asset: faceImg link required'),
            BackURL = back or error('Decker.Asset: backImg link required'),
            NumWidth = options.width or 1,
            NumHeight = options.height or 1,
            BackIsHidden = options.hiddenBack or false,
            UniqueBack = options.uniqueBack or false
        }
        -- Reuse ID if asset existing
        asset.id = assetID(asset.data)
        return setmetatable(asset, assetMeta)
    end

    function Decker.AssetFromData(assetData)
        return setmetatable({ data = assetData, id = assetID(assetData) }, assetMeta)
    end

    -- Create a base for JSON objects
    function Decker.BaseObject()
        return {
            Name = 'Base',
            Transform = {
                posX = 0,
                posY = 5,
                posZ = 0,
                rotX = 0,
                rotY = 0,
                rotZ = 0,
                scaleX = 1,
                scaleY = 1,
                scaleZ = 1
            },
            Nickname = '',
            Description = '',
            ColorDiffuse = { r = 1, g = 1, b = 1 },
            Locked = false,
            Grid = true,
            Snap = true,
            Autoraise = true,
            Sticky = true,
            Tooltip = true,
            GridProjection = false,
            Hands = false,
            XmlUI = '',
            LuaScript = '',
            LuaScriptState = '',
            GUID = 'deadbf'
        }
    end

    -- Apply some basic parameters on base JSON object
    function Decker.SetCommonOptions(obj, options)
        options = options or {}
        obj.Nickname = options.name or ''
        obj.Description = options.desc or ''
        obj.LuaScript = options.script or ''
        obj.XmlUI = options.xmlui or ''
        obj.LuaScriptState = options.scriptState or ''
        obj.Locked = options.locked or false
        obj.Tooltip = options.tooltip or true
        obj.GUID = options.guid or 'deadbf'
    end

    -- default spawnObjectJSON params since it doesn't like blank fields
    local function defaultParams(params, json)
        params = params or {}
        params.json = json
        params.position = params.position or { 0, 5, 0 }
        params.rotation = params.rotation or { 0, 0, 0 }
        params.scale = params.scale or { 1, 1, 1 }
        if params.sound == nil then
            params.sound = true
        end
        return params
    end

    -- For copy method
    local deepcopy = nil
    deepcopy = function(t)
        local copy = {}
        for k, v in pairs(t) do
            if type(v) == 'table' then
                copy[k] = deepcopy(v)
            else
                copy[k] = v
            end
        end
        return copy
    end
    -- meta for all Decker derived objects
    local commonMeta = {
        -- return object JSON string, used cached if present
        _cache = function(self)
            if not self.json then
                self.json = JSON.encode(self.data)
            end
            return self.json
        end,
        -- invalidate JSON string cache
        _recache = function(self)
            self.json = nil
            return self
        end,
        spawn = function(self, params)
            params = defaultParams(params, self:_cache())
            return spawnObjectJSON(params)
        end,
        copy = function(self)
            return setmetatable(deepcopy(self), getmetatable(self))
        end,
        setCommon = function(self, options)
            Decker.SetCommonOptions(self.data, options)
            return self
        end,
    }
    -- apply common part on a specific metatable
    local function customMeta(mt)
        for k, v in pairs(commonMeta) do
            mt[k] = v
        end
        mt.__index = mt
        return mt
    end

    -- DeckerCard metatable
    local cardMeta = {
        setAsset = function(self, asset)
            local cardIndex = self.data.CardID:sub(-2, -1)
            self.data.CardID = asset.id .. cardIndex
            self.data.CustomDeck = { [asset.id] = asset.data }
            return self:_recache()
        end,
        getAsset = function(self)
            local deckID = next(self.data.CustomDeck)
            return Decker.AssetFromData(self.data.CustomDeck[deckID])
        end,
        -- reset deck ID to a consistent value script-wise
        _recheckDeckID = function(self)
            local oldID = next(self.data.CustomDeck)
            local correctID = assetID(self.data.CustomDeck[oldID])
            if oldID ~= correctID then
                local cardIndex = self.data.CardID:sub(-2, -1)
                self.data.CardID = correctID .. cardIndex
                self.data.CustomDeck[correctID] = self.data.CustomDeck[oldID]
                self.data.CustomDeck[oldID] = nil
            end
            return self
        end
    }
    cardMeta = customMeta(cardMeta)
    -- Create a DeckerCard from an asset
    function Decker.Card(asset, row, col, options)
        options = options or {}
        local card = Decker.BaseObject()
        card.Name = 'Card'
        -- optional custom fields
        Decker.SetCommonOptions(card, options)
        if options.sideways ~= nil then
            card.SidewaysCard = options.sideways
        end
        -- CardID string is parent deck ID concat with its 0-based index (always two digits)
        local num = (row - 1) * asset.data.NumWidth + col - 1
        num = string.format('%02d', num)
        card.CardID = asset.id .. num
        -- just the parent asset reference needed
        card.CustomDeck = { [asset.id] = asset.data }

        local obj = setmetatable({ data = card }, cardMeta)
        obj:_cache()
        return obj
    end

    -- DeckerDeck meta
    local deckMeta = {
        count = function(self)
            return #self.data.DeckIDs
        end,
        -- Transform index into positive
        index = function(self, ind)
            if ind < 0 then
                return self:count() + ind + 1
            else
                return ind
            end
        end,
        swap = function(self, i1, i2)
            local ri1, ri2 = self:index(i1), self:index(i2)
            assert(ri1 > 0 and ri1 <= self:count(), 'DeckObj.rearrange: index ' .. i1 .. ' out of bounds')
            assert(ri2 > 0 and ri2 <= self:count(), 'DeckObj.rearrange: index ' .. i2 .. ' out of bounds')
            self.data.DeckIDs[ri1], self.data.DeckIDs[ri2] = self.data.DeckIDs[ri2], self.data.DeckIDs[ri1]
            local co = self.data.ContainedObjects
            co[ri1], co[ri2] = co[ri2], co[ri1]
            return self:_recache()
        end,
        -- rebuild self.data.CustomDeck based on contained cards
        _rescanDeckIDs = function(self, id)
            local cardIDs = {}
            for k, card in ipairs(self.data.ContainedObjects) do
                local cardID = next(card.CustomDeck)
                if not cardIDs[cardID] then
                    cardIDs[cardID] = card.CustomDeck[cardID]
                end
            end
            --[[
            for id,data in pairs(cardIDs) do
                self.data.CustomDeck[id] = data
            end
            for id,data in pairs(self.data.CustomDeck) do
                if not cardIDs[id] then
                    self.data.CustomDeck[id] = nil
                end
            end
            ]]
            --
            -- eeh, GC gotta earn its keep as well
            self.data.CustomDeck = cardIDs
        end,
        remove = function(self, ind, skipRescan)
            local rind = self:index(ind)
            assert(rind > 0 and rind <= self:count(), 'DeckObj.remove: index ' .. ind .. ' out of bounds')
            local card = self.data.ContainedObjects[rind]
            table.remove(self.data.DeckIDs, rind)
            table.remove(self.data.ContainedObjects, rind)
            if not skipRescan then
                self:_rescanDeckIDs(next(card.CustomDeck))
            end
            return self:_recache()
        end,
        removeMany = function(self, ...)
            local indices = { ... }
            table.sort(indices, function(e1, e2)
                return self:index(e1) > self:index(e2)
            end)
            for _, ind in ipairs(indices) do
                self:remove(ind, true)
            end
            self:_rescanDeckIDs()
            return self:_recache()
        end,
        insert = function(self, card, ind)
            local rind = self:index(ind)
            assert(rind > 0 and rind <= (self:count() + 1), 'DeckObj.insert: index ' .. ind .. ' out of bounds')
            table.insert(self.data.DeckIDs, rind, card.data.CardID)
            table.insert(self.data.ContainedObjects, rind, card.data)
            local id = next(card.data.CustomDeck)
            if not self.data.CustomDeck[id] then
                self.data.CustomDeck[id] = card.data.CustomDeck[id]
            end
            return self:_recache()
        end,
        reverse = function(self)
            local s, e = 1, self:count()
            while s < e do
                self:swap(s, e)
                s = s + 1
                e = e - 1
            end
            return self:_recache()
        end,
        cardAt = function(self, ind)
            local rind = self:index(ind)
            assert(rind > 0 and rind <= (self:count() + 1), 'DeckObj.insert: index ' .. ind .. ' out of bounds')
            local card = setmetatable({ data = deepcopy(self.data.ContainedObjects[rind]) }, cardMeta)
            card:_cache()
            return card
        end,
        switchAssets = function(self, replaceTable)
            -- destructure replace table into
            -- [ID_to_replace] -> [ID_to_replace_with]
            -- [new_asset_ID] -> [new_asset_data]
            local idReplace = {}
            local assets = {}
            for oldAsset, newAsset in pairs(replaceTable) do
                assets[newAsset.id] = newAsset.data
                idReplace[oldAsset.id] = newAsset.id
            end
            -- update deckIDs
            for k, cardID in ipairs(self.data.DeckIDs) do
                local deckID, cardInd = cardID:sub(1, -3), cardID:sub(-2, -1)
                if idReplace[deckID] then
                    self.data.DeckIDs[k] = idReplace[deckID] .. cardInd
                end
            end
            -- update CustomDeck data - nil replaced
            for replacedID in pairs(idReplace) do
                if self.data.CustomDeck[replacedID] then
                    self.data.CustomDeck[replacedID] = nil
                end
            end
            -- update CustomDeck data - add replacing
            for _, replacingID in pairs(idReplace) do
                self.data.CustomDeck[replacingID] = assets[replacingID]
            end
            -- update card data
            for k, cardData in ipairs(self.data.ContainedObjects) do
                local deckID = next(cardData.CustomDeck)
                if idReplace[deckID] then
                    cardData.CustomDeck[deckID] = nil
                    cardData.CustomDeck[idReplace[deckID]] = assets[idReplace[deckID]]
                end
            end
            return self:_recache()
        end,
        getAssets = function(self)
            local assets = {}
            for id, assetData in pairs(self.data.CustomDeck) do
                assets[#assets + 1] = Decker.AssetFromData(assetData)
            end
            return assets
        end
    }
    deckMeta = customMeta(deckMeta)
    -- Create DeckerDeck object from DeckerCards
    function Decker.Deck(cards, options)
        local deck = Decker.BaseObject()
        deck.Name = 'Deck'
        Decker.SetCommonOptions(deck, options)
        deck.DeckIDs = {}
        deck.CustomDeck = {}
        deck.ContainedObjects = {}
        for _, card in ipairs(cards) do
            deck.DeckIDs[#deck.DeckIDs + 1] = card.data.CardID
            local id = next(card.data.CustomDeck)
            if not deck.CustomDeck[id] then
                deck.CustomDeck[id] = card.data.CustomDeck[id]
            end
            deck.ContainedObjects[#deck.ContainedObjects + 1] = card.data
        end

        local obj = setmetatable({ data = deck }, deckMeta)
        obj:_cache()
        return obj
    end

    -- Create DeckerDeck from an asset using X cards on its sheet
    function Decker.AssetDeck(asset, cardNum, options)
        cardNum = cardNum or asset.data.NumWidth * asset.data.NumHeight
        local row, col, width = 1, 1, asset.data.NumWidth
        local cards = {}
        for k = 1, cardNum do
            cards[#cards + 1] = Decker.Card(asset, row, col)
            col = col + 1
            if col > width then
                row, col = row + 1, 1
            end
        end
        return Decker.Deck(cards, options)
    end
end

-- for use with Epic Wing Tool to check if the landing space is empty
function epicMoveWingmate(table)
    local ship = table[1]
    local desiredPosRot = { pos = table[2], rot = table[3] }
    print("Ship size=" .. ship.getTable("Data").Size)
    local info = { size = ship.getTable("Data").Size, code = "dummy", type = "" }
    local fullFunc = function(info, ship)
        return desiredPosRot
    end
    result = MoveModule.MoveProbe.TryFullMove(info, ship, fullFunc)
    if result.done then
        MoveModule.MoveShip(ship, { finPos = desiredPosRot })
        MoveModule.CheckMineAndObstacleCollisions(ship, desiredPosRot, true, nil)
        return true
    else
        -- Todo announce some stuff
        return false
    end
end

---------------------
-- START EZ-TEMPLATES
local ezTemplates = {}

function ezTemplates.Maneuver(object)
    function direction(object, bearing)
        if bearing == 'straight' then
            return nil
        end

        if object.is_face_down then
            return 'left'
        else
            return 'right'
        end
    end

    local name = object.getName():lower()
    local bearing, speed = string.match(name, "^(%a+) (%d)$")
    return tonumber(speed), bearing, direction(object, bearing)
end

function ezTemplates.IsEasyTemplate(object)
    if not object then return false end
    local name = object.getName():lower()
    if not (string.match(name, "^straight %d+$")
            or string.match(name, "^bank %d+$")
            or string.match(name, "^turn %d+$")) then
        return false
    end

    local function ezTemplatesEnabled()
        local s1Bag = getObjectFromGUID(Straight_1_Bag_GUID)
        return s1Bag and s1Bag.hasTag('ezTemplates') or false
    end
    local speed, bearing, direction = ezTemplates.Maneuver(object)
    local enabled = ezTemplatesEnabled()
    return enabled and bearing ~= nil and speed ~= nil
end

function ezTemplates.SnapToShip(player_color, template)
    local ship = FindNearestShip(template, 40, IsInFrontOfShip)
    if ship == nil then
        return
    end

    local speed, bearing, direction = ezTemplates.Maneuver(template)
    local position = 'front' -- For now, just spawn out the front
    destroyObject(template)
    template = DialModule.PlaceTemplate(ship, speed, bearing, position, direction, nil)

    function alignButtonWithShip(template, ship)
        -- Get world rotations
        local shipRot = ship.getRotation()
        local templateRot = template.getRotation()

        -- Calculate relative rotation
        local relativeRot = {
            x = shipRot.x - templateRot.x,
            y = shipRot.y - templateRot.y,
            z = shipRot.z - templateRot.z,
        }

        return relativeRot
    end

    local buttonRot = alignButtonWithShip(template, ship)

    local removeButton = {
        -- click_function = 'deleteObject',
        click_function = 'destroyObject',
        label = 'Del',
        position = { 0, 0.05, 0 },
        rotation = buttonRot,
        width = 180,
        height = 125,
        font_size = 100,
        font_color = { 225 / 255, 225 / 255, 225 / 255 },
        color = { 17 / 255, 16 / 255, 15 / 255 },
        tooltip = "Remove the template"
    }
    template.createButton(removeButton)
end

function ezTemplates.onObjectDropped(player_color, template)
    if not ezTemplates.IsEasyTemplate(template) then
        return
    end

    ezTemplates.SnapToShip(player_color, template)
end

EventSub.Register('onObjectDropped', ezTemplates.onObjectDropped)

-- END EZ-TEMPLATES
-------------------

function IsInFrontOfShip(object, ship)
    -- Get the positions of the object and the ship
    local objPos = object.getPosition()
    local shipPos = ship.getPosition()

    -- Calculate the forward direction vector of the ship
    local shipForward = ship.getTransformForward()

    -- Calculate the vector from the ship to the object
    local toObject = {
        x = shipPos.x - objPos.x,
        y = shipPos.y - objPos.y,
        z = shipPos.z - objPos.z
    }

    -- Convert to a normalized vector (direction only)
    local toObjectNormalized = Vector(toObject):normalize()

    -- Calculate the dot product between the forward vector and the toObject vector
    local dotProduct = shipForward.x * toObjectNormalized.x +
        shipForward.y * toObjectNormalized.y +
        shipForward.z * toObjectNormalized.z

    -- Check if the object is in front (dotProduct > 0) and within a reasonable margin
    return dotProduct > 0.01 -- Adjust the threshold for precision if needed
end

function FindNearestShip(object, max_distance, filter_function)
    filter_function = filter_function or function(obj, ship) return true end

    local min_dist = Dim.Convert_mm_igu(max_distance or 100) -- default 100 mm
    local objPos = object.getPosition():setAt('y', 0)
    local nearest = nil

    for _, ship in pairs(getObjects()) do
        if MoveModule.SelectShips(ship) then
            local shipPos = ship.getPosition():copy():setAt('y', 0)
            local dist = shipPos:distance(objPos)
            if dist < min_dist and filter_function(object, ship) then
                nearest = ship
                min_dist = dist
            end
        end
    end

    return nearest
end

-- require("Test.GlobalSuite")
