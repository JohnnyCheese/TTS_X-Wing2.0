-- ~~~~~~
-- Script by shiprib
-- Issues, history at: https://github.com/JohnnyCheese/TTS_X-Wing2.0
--
-- Module for storing different AI behaviour engines and individual ship
-- behaviours
-- ~~~~~~

local BehaviourDB = {}
BehaviourDB.GetRuleSet = function()
    return BehaviourDB.rule_sets[1]
end

BehaviourDB.rule_sets = {}

--[[ A "rule set" is an AI ruleset that fits with the HotAC template defined by
the 0.7 version of Heroes of the Aturi Cluster by Josh Derksen:
http://dockingbay416.com/campaign/
HotAC 0.7 is for v1 of X-Wing however there have been several v2 adaptations
published.
]]

--[[ Each behaviour set is represented by a table in the following format:
name: String used to identify which set this is. This should contain the
    author and the date of last publication
usesBullseyeArc: A boolean, true if this behaviour set uses the bullseye arc.
degreesToArc: A function that the AI calls to convert the angle from its ship
    to its target into the name of the arc in its maneuver lookup table. This
    is here, rather than generalised, because different behaviour sets have
    different numbers of arcs.
    It takes a single argument (float), which is the angle from the AI ship to
    its target. Sample parameter values are:
        -180: directly behind
        -135: behind and to the left
        -90: directly to the left
        0: directly ahead
        90: directly to the right
        180: directly behind (identical to -180)
    It returns a table with the following keys:
        target_arc: String, the name of the arc. This can be anything, as long
            as it matches the arc names in the ship lookup tables.
        arc_parts: Table of strings, one or two of "front", "back", "left", or
            "right". These correspond to the sides of the AI ship that we needs
            to do range-checking from. These should be the two closest sides to
            the target arc.
flipArc: A function that takes one arc and flips it left-to-right. HotAC AI
    tables typically only cover the right half of the arc spectrum and rely
    on flipping the right arcs when the target is to the left.
    Takes a single argument (string), the name of the arc to flip
    Returns a string, which is the opposite of the specified arc.
targetSelectionFunctions: A table containing custom target selection functions.
    TODO: This has not been implemented yet!
ships: A table containing the AI data for each ship. This table is keyed with
the ID numbers found in the Datapad Lua script. The format for ships is below.
]]

--[[ Each ship is represted by a table with the following format:
target_selection: An ordered table containing the function names used for
    choosing a target, sorted by priority. There is a base set of functions
    defined in the core AI module, these are:
        'ClosestInArc': selects the closest ship, in the front arc, at range 1-3
        'Closest': selects the closest ship. Treats range 0 as range 1 directly
            behind.
move_table: A table containing the ship's move data, organised into arcs and
    distances.
    The first depth of tbe table, the arc, is defined by the ruleset in
        the function "degreesToArc". The only one specified by the underlying
        system is 'bullseye', which is only used if 'usesBullseyeArc' is true.
    The second depth of the table, the distance, is one of four:
        'near': the target is at range 0 or 1, or at range 2 and is moving
            towards the AI ship.
        'far': the target is at range 3, or at range 2 and is moving away from
            the AI ship.
        'distant': the target is at range 4 or beyond.
        'stress': the AI ship is stressed, and the target's range is irrelevant.
]]

-- This is the upgrade of the HotAC-style AI to X-wing v2, ultimately published
-- by Justin Gan. The AIs cover all three Rebellion-era factions and are made
-- for the broader Flight Group Alpha ruleset.
-- see: https://www.facebook.com/groups/872507722883025/permalink/1970166016450518/
BehaviourDB.rule_sets[1] = {}
BehaviourDB.rule_sets[1].name = 'XW-v2-FGA-v7-Gan-2020-04-07'
BehaviourDB.rule_sets[1].usesBullseyeArc = true
BehaviourDB.rule_sets[1].degreesToArc = function(angle_to_target)
    result = {}
    if angle_to_target < -135 then
        result.target_arc = 'back_left'
        result.arc_parts = { 'back', 'left' }
    elseif angle_to_target < -90 then
        result.target_arc = 'left_back'
        result.arc_parts = { 'left', 'back' }
    elseif angle_to_target < -45 then
        result.target_arc = 'left_front'
        result.arc_parts = { 'left', 'front' }
    elseif angle_to_target < 0 then
        result.target_arc = 'front_left'
        result.arc_parts = { 'front', 'left' }
    elseif angle_to_target < 45 then
        result.target_arc = 'front_right'
        result.arc_parts = { 'front', 'right' }
    elseif angle_to_target < 90 then
        result.target_arc = 'right_front'
        result.arc_parts = { 'right', 'front' }
    elseif angle_to_target < 135 then
        result.target_arc = 'right_back'
        result.arc_parts = { 'right', 'back' }
    else
        result.target_arc = 'back_right'
        result.arc_parts = { 'back', 'right' }
    end

    return result;
end
BehaviourDB.rule_sets[1].flipArc = function(arc)
    if string.find(arc, 'left') then
        arc = string.gsub(arc, 'left', 'right')
    elseif string.find(targetArc, 'right') then
        arc = string.gsub(arc, 'right', 'left')
    end

    return arc
end

BehaviourDB.rule_sets[1].GetShipBehaviour = function(ship)
    return BehaviourDB.rule_sets[1].GetShipBehaviourById(ship.getTable('Data').shipId, ship.getTable('Data').Faction)
end

BehaviourDB.rule_sets[1].GetShipBehaviourById = function(ship_id, faction_id)
    ship_behaviour = BehaviourDB.rule_sets[1].ships[ship_id]

    if ship_behaviour == nil or ship_behaviour.factions == nil then
        return ship_behaviour
    else
        return ship_behaviour.factions[faction_id]
    end
end

BehaviourDB.rule_sets[1].ships = {}

--------------------
-- Imperial Ships --
--------------------

-- TIE/ln Fighter
---- This logic is shared between Imperial and Rebel. See Z-95 for an example on how to split them if necessary.
BehaviourDB.rule_sets[1].ships['tielnfighter'] = {}
BehaviourDB.rule_sets[1].ships['tielnfighter'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['tielnfighter'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 'bl2', [4] = 'br2', [5] = 's2' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 'bl2', [3] = 'br2', [5] = 's2' }
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'tr1', [5] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br2', [4] = 's2', [6] = 's3' }
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'tr1', [4] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr1', [2] = 'br2' }
    },
    right_back = {
        near = { [1] = 'k3', [2] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k3', [3] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr1' },
        stress = { [1] = 'tr1', [2] = 'tr2', [3] = 'br2' }
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'k3', [5] = 'tr2' },
        far = { [1] = 'k3', [3] = 'tr1', [4] = 'tr3' },
        distant = { [1] = 'k3', [5] = 'tr1' },
        stress = { [1] = 'br2', [6] = 'tr3' }
    }
}
BehaviourDB.rule_sets[1].ships['tielnfighter'].action_selection = {
    [1] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [2] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true },
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false },
    },
    [5] = { -- Evade
        description = "%s evaded.",
        action = 'evade'
    }
}

-- TIE/in Interceptor
BehaviourDB.rule_sets[1].ships['tieininterceptor'] = {}
BehaviourDB.rule_sets[1].ships['tieininterceptor'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['tieininterceptor'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [2] = 'br3s', [4] = 'bl3s', [6] = 's2' },
        far = { [1] = 's2', [4] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 'tl2', [2] = 'tr2', [3] = 's2' },
    },
    front_right = {
        near = { [1] = 'bl3s', [3] = 'tr1', [5] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'bl2', [2] = 'br2', [4] = 's2', [6] = 's4' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'bl3s', [5] = 'tr1' },
        far = { [1] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr2', [3] = 'bl2', [4] = 'br2', [6] = 's4' },
    },
    right_back = {
        near = { [1] = 'bl3s', [4] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'bl3s', [5] = 'tr2' },
        distant = { [1] = 'bl3s', [4] = 'tr1' },
        stress = { [1] = 'tl2', [2] = 'tr2', [5] = 'bl2', [6] = 's4' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'bl3s', [5] = 'tr2' },
        far = { [1] = 'br3s', [3] = 'bl3s' },
        distant = { [1] = 'bl3s', [4] = 'tr1' },
        stress = { [1] = 'tl2', [4] = 'tr2', [6] = 's4' },
    },
}
BehaviourDB.rule_sets[1].ships['tieininterceptor'].action_selection = {
    [1] = { -- (target moved) Focus > boost or focus > barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled/boosted and focused to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = true, inTargetsArc = true },
        action = {
            [1] = { focus = false, boost = true },
            [2] = { focus = false, barrelRoll = true }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [2] = { -- (target moved) Boost > barrel roll or barrel roll > boost to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled/boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, inTargetsArc = true },
        action = {
            [1] = { boost = false, barrelRoll = true },
            [2] = { barrelRoll = false, boost = true }
        },
        postconditions = { inTargetsArc = false, hasShot = true },
    },
    [3] = { -- (target moved) Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { targetMoved = true, hasShot = true },
        action = 'focus'
    },
    [4] = { -- (target moved) Evade
        description = "%s evaded.",
        preconditions = { targetMoved = true },
        action = 'evade'
    },
    [5] = { -- (target not moved) Boost > barrel roll or barrel roll > boost to get a shot
        description = "%s barrel rolled/boosted to get a shot.",
        preconditions = { targetMoved = false, hasShot = false },
        action = {
            [1] = { boost = false, barrelRoll = true },
            [2] = { barrelRoll = false, boost = true }
        },
        postconditions = { hasShot = true },
    },
    [6] = { -- (target not moved) Focus
        description = "%s focused.",
        preconditions = { targetMoved = false },
        action = 'focus'
    },
}

-- TIE Advanced x1
BehaviourDB.rule_sets[1].ships['tieadvancedx1'] = {}
BehaviourDB.rule_sets[1].ships['tieadvancedx1'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tieadvancedx1'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 's1', [5] = 's2' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 'bl1', [2] = 'br2', [3] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br1', [3] = 'br2', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'tr3t', [4] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [3] = 'tr2', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'tr3t', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'tr3t', [5] = 'tr2' },
        distant = { [1] = 'tr3t', [4] = 'tr3' },
        stress = { [1] = 'br1', [2] = 'tr2', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'tr3t', [5] = 'tr2' },
        far = { [1] = 'tl3t', [3] = 'tr3t' },
        distant = { [1] = 'tr3t', [4] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'br2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['tieadvancedx1'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in target's arc
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inTargetsArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Focus > barrel roll to avoid target's arc and still get a shot
        description = { text = "%s focused and barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = true, inTargetsArc = true },
        action = { focus = false, barrelRoll = true },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- (target moved) Focus > barrel roll to get a shot
        description = { text = "%s focused and barrel rolled to get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = false },
        action = { focus = false, barrelRoll = true },
        postconditions = { hasShot = true },
    },
    [5] = { -- (target moved) Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false },
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- TIE/sa Bomber
BehaviourDB.rule_sets[1].ships['tiesabomber'] = {}
BehaviourDB.rule_sets[1].ships['tiesabomber'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tiesabomber'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 's1', [5] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k5', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k5', [2] = 'k3', [4] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [3] = 'tr2', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k3', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k5', [2] = 'k3', [5] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr2' },
        stress = { [1] = 'br1', [2] = 'tr2', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k5', [3] = 'k3', [5] = 'tr3' },
        far = { [1] = 'k3', [4] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'br2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['tiesabomber'].action_selection = {
    [1] = { --  Reload ordnance if no charges left (no shot)
        pass_through = true,
        preconditions = { hasShot = false },
        description =
        "If %s has no charges on its upgrades, then undo the following action and take a red Reload action.",
    },
    [2] = { --  Barrel roll > target lock to avoid target arc and still get a shot (with the > target lock)
        description = { text = "%s barrel rolled and target locked to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, hasShot = true, targetLocked = false },
        action = { barrelRoll = false, targetLock = true },
        postconditions = { inTargetsArc = false, hasShot = true, targetWithinRange = true },
    },
    [3] = { --  Barrel roll > target lock to avoid target arc and still get a shot (without the > target lock)
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, hasShot = true, targetLocked = true },
        action = { barrelRoll = false },
        postconditions = { inTargetsArc = false, hasShot = true },
    },
    [4] = { --  Barrel roll > target lock to get a shot (with the > target lock)
        description = "%s barrel rolled and target locked to get a shot.",
        preconditions = { hasShot = false, targetLocked = false },
        action = { barrelRoll = false, targetLock = true },
        postconditions = { hasShot = true, targetWithinRange = true },
    },
    [5] = { --  Barrel roll > target lock to get a shot (without the > target lock)
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false, targetLocked = true },
        action = { barrelRoll = false },
        postconditions = { hasShot = true },
    },
    [6] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [7] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false },
    },
    [8] = { --  Reload ordnance if no charges left (no shot or defense)
        pass_through = true,
        preconditions = { inTargetsArc = false, hasShot = false },
        description = "If %s has no charges on upgrades, then undo the following action and take a red Reload action.",
    },
    [9] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- TIE/de Defender
BehaviourDB.rule_sets[1].ships['tiededefender'] = {}
BehaviourDB.rule_sets[1].ships['tiededefender'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tiededefender'].action_selection = {}
BehaviourDB.rule_sets[1].ships['tiededefender'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 'bl1', [4] = 'br1', [5] = 's2' },
        far = { [1] = 's2', [4] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 'bl1', [2] = 'br1', [3] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'br2', [4] = 'tr3' },
        distant = { [1] = 'tr1', [2] = 'tr3' },
        stress = { [1] = 'br1', [4] = 's2', [5] = 'tr3' },
    },
    right_back = {
        near = { [1] = 'k4', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'tr1', [3] = 'tr3' },
        stress = { [1] = 'br1', [5] = 'tr3' },
    },
    back_right = {
        near = { [1] = 'k4', [5] = 'tr3' },
        far = { [1] = 'k4', [5] = 'tr1' },
        distant = { [1] = 'tr1', [4] = 'tr3' },
        stress = { [1] = 'br1', [5] = 's2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['tiededefender'].action_selection = {
    [1] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, hasShot = true, inEnemyArc = false },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Boost or barrel roll to get a shot at range 1
        description = "%s barrel rolled/boosted to get a close range shot.",
        preconditions = { targetMoved = true, hasShot = { arguments = { maxRange = 1 }, requiredResult = false } },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } },
    },
    [3] = { -- (target moved) Boost or barrel roll to get a shot
        description = "%s barrel rolled/boosted to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { hasShot = true },
    },
    [4] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [5] = { -- Evade, if not already
        description = "%s evaded.",
        preconditions = { evading = false },
        action = 'evade'
    },
    [6] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, inEnemyArc = false, hasShot = true },
        action = 'targetLock'
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}
BehaviourDB.rule_sets[1].ships['tiededefender'].special_rules = { 'fullThrottle' }

-- TIE/ph Phantom
BehaviourDB.rule_sets[1].ships['tiephphantom'] = {}
-- Need to add decloaking in the system phase
BehaviourDB.rule_sets[1].ships['tiephphantom'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['tiephphantom'].action_selection = {}
BehaviourDB.rule_sets[1].ships['tiephphantom'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [4] = 'bl1', [5] = 'br1', [6] = 's2' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 'bl2', [3] = 'br2', [5] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [5] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br2', [3] = 's2', [5] = 's3' },
    },
    right_front = {
        near = { [1] = 'k4', [3] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr1', [2] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k4', [2] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'k3', [4] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr1' },
        stress = { [1] = 'tr1', [2] = 'tr2', [3] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'k3', [5] = 'tr2' },
        far = { [1] = 'k4', [3] = 'k3' },
        distant = { [1] = 'k3', [4] = 'tr1' },
        stress = { [1] = 'br2', [5] = 's2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['tiephphantom'].action_selection = {
    [1] = { -- Cloak if no shot
        description = "%s cloaked.",
        preconditions = { hasShot = false },
        action = 'cloak'
    },
    [2] = { -- Evade if not already evading
        description = "%s evaded.",
        preconditions = { evading = false },
        action = 'evade'
    },
    [3] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false },
    },
    [4] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- T-4a Lambda-class Shuttle
BehaviourDB.rule_sets[1].ships['lambdaclasst4ashuttle'] = {}
BehaviourDB.rule_sets[1].ships['lambdaclasst4ashuttle'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['lambdaclasst4ashuttle'].action_selection = {}
BehaviourDB.rule_sets[1].ships['lambdaclasst4ashuttle'].move_table = {
    bullseye = {
        near = { [1] = 's0', [4] = 'bl1', [5] = 'br1', [6] = 's1' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's2', [2] = 's3' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's0', [3] = 'br1', [5] = 's1', [6] = 'tr2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 's2' },
    },
    right_front = {
        near = { [1] = 's0', [2] = 'br1', [4] = 'tr2' },
        far = { [1] = 'br1', [3] = 'tr2', [4] = 'br2' },
        distant = { [1] = 'tr2', [2] = 'br2' },
        stress = { [1] = 'br1', [5] = 's1' },
    },
    right_back = {
        near = { [1] = 's0', [2] = 'br1', [4] = 'tr2' },
        far = { [1] = 'br1', [3] = 'tr2' },
        distant = { [1] = 'br1', [3] = 'tr2' },
        stress = { [1] = 'br1', [6] = 's1' },
    },
    back_right = {
        near = { [1] = 's0', [3] = 'br1', [4] = 'tr2', [5] = 'br2' },
        far = { [1] = 'br1', [3] = 'tr2' },
        distant = { [1] = 'br1', [3] = 'tr2' },
        stress = { [1] = 'br1', [6] = 's1' },
    },
}
BehaviourDB.rule_sets[1].ships['lambdaclasst4ashuttle'].action_selection = {
    [1] = { -- Focus if have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [2] = { -- Reinforce the fore if within arc of two or more enemies in that full arc
        description = "%s reinforced fore.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullfront', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceFore'
    },
    [3] = { -- Reinforce the aft if within arc of two or more enemies in that full arc
        description = "%s reinforced aft.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullback', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceAft'
    },
    [4] = { -- Coordinate the nearest friendly (unstressed) ship
        description = { text = "%s coordinated %s.", strings = { 'ship', 'coordinate' } },
        preconditions = { hasCoordinateTarget = true },
        action = 'coordinate'
    },
    [5] = { -- Jam the target
        description = { text = "%s jammed %s.", strings = { 'ship', 'target' } },
        preconditions = { targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } },
        action = { jam = true },
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    },
}

-- VT-49 Decimator
BehaviourDB.rule_sets[1].ships['vt49decimator'] = {}
BehaviourDB.rule_sets[1].ships['vt49decimator'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['vt49decimator'].action_selection = {}
BehaviourDB.rule_sets[1].ships['vt49decimator'].move_table = {
    bullseye = {
        near = { [1] = 'tl2', [3] = 'tr2', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'bl1', [3] = 'tl2', [6] = 'bl2' },
        far = { [1] = 'br1', [4] = 'br2', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'bl1', [2] = 'br1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'bl1', [2] = 'br2', [4] = 's2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [5] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'tr1', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'tr1', [3] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'br1', [3] = 'tr2', [5] = 'tr3' },
        far = { [1] = 'tl2', [3] = 'tr2' },
        distant = { [1] = 'tl2', [2] = 'tr3' },
        stress = { [1] = 'br1', [4] = 's1', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['vt49decimator'].action_selection = {
    [1] = { -- Rotate turret to get a shot
        description = "%s rotated its turret to get a shot.",
        preconditions = { hasShot = false },
        action = { rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [2] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [4] = { -- Reinforce the fore if within arc of two or more enemies in that full arc
        description = "%s reinforced fore.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullfront', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceFore'
    },
    [5] = { -- Reinforce the aft if within arc of two or more enemies in that full arc
        description = "%s reinforced aft.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullback', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceAft'
    },
    [6] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [7] = { -- Coordinate (stress) the nearest friendly (unstressed) ship
        description = { text = "%s coordinated %s.", strings = { 'ship', 'coordinate' } },
        preconditions = { hasCoordinateTarget = true },
        action = { coordinate = true }
    },
    [8] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    },
}

-- TIE/rb Heavy
BehaviourDB.rule_sets[1].ships['tierbheavy'] = {}
BehaviourDB.rule_sets[1].ships['tierbheavy'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tierbheavy'].move_table = {
    bullseye = {
        near = { [1] = 's1', [3] = 's2', [4] = 'tl2', [5] = 'tr2', [6] = 's4' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'tr3t', [3] = 'br1', [4] = 'bl2', [5] = 'br2', [6] = 'tl2' },
        far = { [1] = 'br1', [2] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 's1', [3] = 'bl2', [4] = 'br2', [6] = 's2' },
    },
    right_front = {
        near = { [1] = 'tr3t', [3] = 'bl1', [4] = 'tr1', [5] = 'bl2', [6] = 's2' },
        far = { [1] = 'br1', [2] = 'tr1', [3] = 'br2', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'bl2', [3] = 'br2', [5] = 's1', [6] = 's2' },
    },
    right_back = {
        near = { [1] = 'tr3t', [4] = 'bl1', [5] = 's1', [6] = 'bl2' },
        far = { [1] = 'tr3t', [5] = 'tr2' },
        distant = { [1] = 'tr3t', [4] = 'tr2' },
        stress = { [1] = 's1', [2] = 'bl1', [3] = 'bl2', [5] = 'br2', [6] = 's2' },
    },
    back_right = {
        near = { [1] = 'tr3t', [4] = 's1', [5] = 'bl1', [6] = 'bl2' },
        far = { [1] = 'tr3t', [4] = 's1', [5] = 'bl1', [6] = 'tr2' },
        distant = { [1] = 'tr3t', [4] = 'tr2' },
        stress = { [1] = 's1', [3] = 'bl2', [5] = 'br2', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['tierbheavy'].action_selection = {
    [1] = { -- Rotate turret > Calculate (stress) to get a shot
        description = "%s rotated its turret and calculated to get a shot.",
        preconditions = { hasShot = false },
        action = { calculate = true, rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [2] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [4] = { -- Reinforce the fore if within arc of two or more enemies in that full arc
        description = "%s reinforced fore.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullfront', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceFore'
    },
    [5] = { -- Reinforce the aft if within arc of two or more enemies in that full arc
        description = "%s reinforced aft.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullback', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceAft'
    },
    [6] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [7] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [8] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true },
    },
    [9] = { -- Barrel roll (stress) to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { inTargetsArc = false },
    },
    [10] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- TIE/ca Punisher
BehaviourDB.rule_sets[1].ships['tiecapunisher'] = {}
BehaviourDB.rule_sets[1].ships['tiecapunisher'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tiecapunisher'].move_table = {
    bullseye = {
        near = { [1] = 's0', [2] = 'k4', [4] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's2', [2] = 's3' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's0', [2] = 'k4', [4] = 'br1', [6] = 's1' },
        far = { [1] = 'br1', [3] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br1', [4] = 's1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [3] = 'br1', [5] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'bl1', [2] = 'br1^', [5] = 's1' },
    },
    right_back = {
        near = { [1] = 'k4', [5] = 'bl1', [6] = 'tr2' },
        far = { [1] = 'k4', [5] = 'tr2' },
        distant = { [1] = 'k4', [4] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 's1', [2] = 'bl1', [4] = 'br1' },
    },
    back_right = {
        near = { [1] = 'k4', [5] = 's1', [6] = 'tr2' },
        far = { [1] = 'k4', [5] = 'tr2' },
        distant = { [1] = 'k4', [3] = 'tr2' },
        stress = { [1] = 'bl1', [3] = 'br1', [6] = 's1' },
    },
}
BehaviourDB.rule_sets[1].ships['tiecapunisher'].action_selection = {
    [1] = { --  Boost > target lock to avoid target arc and still get a shot (with the > target lock)
        description = { text = "%s boosted and target locked to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, hasShot = true, targetLocked = false },
        action = { boost = false, targetLock = true },
        postconditions = { inTargetsArc = false, hasShot = true, targetWithinRange = true },
    },
    [2] = { --  Boost > target lock to avoid target arc and still get a shot (without the > target lock)
        description = { text = "%s boosted to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, hasShot = true, targetLocked = true },
        action = { boost = false },
        postconditions = { inTargetsArc = false, hasShot = true },
    },
    [3] = { --  Boost > target lock to get a shot (with the > target lock)
        description = "%s boosted and target locked to get a shot.",
        preconditions = { hasShot = false, targetLocked = false },
        action = { boost = false, targetLock = true },
        postconditions = { hasShot = true, targetWithinRange = true },
    },
    [4] = { --  Boost > target lock to get a shot (without the > target lock)
        description = "%s boosted to get a shot.",
        preconditions = { hasShot = false, targetLocked = true },
        action = { boost = false },
        postconditions = { hasShot = true },
    },
    [5] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [6] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [7] = { --  Reload ordnance if no charges left
        pass_through = true,
        description =
        "If %s has no charges on its missile or torpedo upgrades, then undo the following action and take a reload action.",
    },
    [8] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true },
    },
    [9] = { -- Barrel roll (stress) to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { inTargetsArc = false },
    },
    [10] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- TIE/ag Aggressor
BehaviourDB.rule_sets[1].ships['tieagaggressor'] = {}
BehaviourDB.rule_sets[1].ships['tieagaggressor'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tieagaggressor'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [3] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br2', [3] = 's1', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'br1', [3] = 's1', [4] = 'br2', [5] = 'tr2', [6] = 'tr3' },
        far = { [1] = 'br1', [2] = 'br2', [3] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 's1', [2] = 'bl2', [3] = 'br2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k4~', [5] = 'tr2', [6] = 'tr3' },
        far = { [1] = 'k4', [5] = 'tr2' },
        distant = { [1] = 'k4', [3] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 's1', [3] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [5] = 'tr2', [6] = 'tr3' },
        far = { [1] = 'k4', [5] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'k4', [3] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 's1', [2] = 'bl2', [3] = 'br2', [6] = 's3' },
    },
}
BehaviourDB.rule_sets[1].ships['tieagaggressor'].action_selection = {
    [1] = { --  manual Rotate (upgrade) prompt
        pass_through = true,
        description =
        "If %s has a turret indicator and can get a shot by rotating, then undo the following action and take a Rotate action.",
    },
    [2] = { -- Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [5] = { -- Barrel roll > Evade (stress) to get a shot and defend
        description = "%s barrel rolled into an evade (stress) to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = false, evade = true },
        postconditions = { hasShot = true, inTargetsArc = true },
    },
    [6] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true }
    },
    [7] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false },
    },
    [8] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- TIE Advanced v1
BehaviourDB.rule_sets[1].ships['tieadvancedv1'] = {}
BehaviourDB.rule_sets[1].ships['tieadvancedv1'].target_selection = {
    [1] = 'ClosestInArcLowerInitiative',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tieadvancedv1'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 'bl1', [4] = 'br1', [5] = 's2' },
        far = { [1] = 's2', [4] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 'bl1', [2] = 'br1', [3] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'tr1', [6] = 'br2' },
        far = { [1] = 'br1', [3] = 'br2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'tr1', [4] = 'tr2' },
        far = { [1] = 'tr1', [3] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr1', [4] = 'br1', [6] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'tr2t', [4] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'tr2t', [5] = 'tr2' },
        distant = { [1] = 'tr2t', [4] = 'tr3' },
        stress = { [1] = 'tr1', [5] = 'br1', [6] = 'br2' },
    },
    back_right = {
        near = { [1] = 'tl2t', [3] = 'tr2t', [5] = 'tr2' },
        far = { [1] = 'tl2t', [3] = 'tr2t' },
        distant = { [1] = 'tr2t', [4] = 'tr2' },
        stress = { [1] = 'tr1', [4] = 'br1', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['tieadvancedv1'].action_selection = {
    [1] = { -- (target moved) Boost or barrel roll > Focus (stress) to avoid Target arc and still get a shot
        description = "%s barrel rolled/boosted into a focus (stress) to avoid target's arc and still get a shot.",
        preconditions = { targetMoved = true, inTargetsArc = true, hasShot = true },
        action = {
            [1] = { boost = false, focus = true },
            [2] = { barrelRoll = false, focus = true }
        },
        postconditions = { hasShot = true, inTargetsArc = false },
    },
    [2] = { -- (target moved) Boost or barrel roll > Focus (stress) to get a shot
        description = "%s barrel rolled/boosted into a focus (stress) to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = {
            [1] = { boost = false, focus = true },
            [2] = { barrelRoll = false, focus = true }
        },
        postconditions = { hasShot = true },
    },
    [3] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, inEnemyArc = false, hasShot = true },
        action = 'targetLock'
    },
    [4] = { -- (target moved) Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { targetMoved = true, hasShot = true },
        action = 'focus'
    },
    [5] = { -- (target moved) Evade
        description = "%s evades.",
        preconditions = { targetMoved = true },
        action = 'evade'
    },
    [6] = { -- (target not moved) Boost or barrel roll > Focus (stress) to get a shot
        description = "%s barrel rolled/boosted into a focus (stress) to get a shot.",
        preconditions = { targetMoved = false, hasShot = false },
        action = {
            [1] = { boost = false, focus = true },
            [2] = { barrelRoll = false, focus = true }
        },
        postconditions = { hasShot = true },
    },
    [7] = { -- (target not moved) Focus
        description = "%s focused.",
        preconditions = { targetMoved = false },
        action = 'focus'
    }
}

-- Alpha-class Star Wing
BehaviourDB.rule_sets[1].ships['alphaclassstarwing'] = {}
BehaviourDB.rule_sets[1].ships['alphaclassstarwing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['alphaclassstarwing'].move_table = {
    bullseye = {
        near = { [1] = 's1', [3] = 'bl1', [4] = 'br1', [5] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [6] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's1', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 's1', [3] = 'br2', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'br1', [4] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'br2', [2] = 'tr2', [3] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'br1', [3] = 'tr2', [6] = 'tr3' },
        far = { [1] = 'br1', [2] = 'br2', [3] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 's1', [3] = 'br2' },
    },
    back_right = {
        near = { [1] = 'br2', [2] = 'tr2', [4] = 's3', [5] = 'tr3' },
        far = { [1] = 'tr2', [4] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'bl2', [2] = 'br2', [5] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['alphaclassstarwing'].action_selection = {
    [1] = { -- SLAM if no shot and target outside of range 2
        description = "%s took a SLAM action. Perform the appropriate SLAM movement manually.",
        preconditions = { hasShot = false, targetWithinRange = { arguments = { maxRange = 2 }, requiredResult = false } },
        action = 'disarm'
    },
    [2] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { --  Reload ordnance if no charges left
        pass_through = true,
        description =
        "If %s has no charges on its missile or torpedo upgrades, then undo the following action and take a Reload action.",
    },
    [5] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- TIE Reaper
BehaviourDB.rule_sets[1].ships['tierereaper'] = {}
BehaviourDB.rule_sets[1].ships['tierereaper'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['tierereaper'].action_selection = {}
BehaviourDB.rule_sets[1].ships['tierereaper'].move_table = {
    bullseye = {
        near = { [1] = 's0', [3] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's2', [2] = 's3' },
        stress = { [1] = 'bl1', [2] = 'br1', [3] = 's1', [5] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 's0', [2] = 'bl1s', [3] = 'br1', [5] = 's1' },
        far = { [1] = 's1', [2] = 'br1', [3] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br1', [4] = 's1', [5] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'bl1s', [4] = 'br1', [5] = 'tr1' },
        far = { [1] = 'br1', [3] = 'tr1', [4] = 'br2', [6] = 'tr2' },
        distant = { [1] = 'tr1', [2] = 'tr2', [3] = 'br2', [5] = 'br3' },
        stress = { [1] = 'br1', [5] = 's1' },
    },
    right_back = {
        near = { [1] = 's0', [2] = 'br1s', [3] = 'bl1s', [6] = 'br1' },
        far = { [1] = 'bl1s', [4] = 'br1', [5] = 'tr1' },
        distant = { [1] = 'bl1s', [4] = 'br1', [5] = 'tr2' },
        stress = { [1] = 's1', [3] = 'br1' },
    },
    back_right = {
        near = { [1] = 's0', [2] = 'br1s', [3] = 'bl1s', [6] = 'br1' },
        far = { [1] = 'br1s', [2] = 'bl1s', [5] = 'br1', [6] = 'tr1' },
        distant = { [1] = 'bl1s', [4] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'bl1', [2] = 'br1', [5] = 's1' },
    },
}
BehaviourDB.rule_sets[1].ships['tierereaper'].action_selection = {
    [1] = { --  manual Ailerons prompt
        pass_through = true,
        description = "If not stressed, perform the Ailerons movement manually before clicking Move & Act.",
    },
    [2] = { -- Focus if have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [3] = { -- Jam the target
        description = { text = "%s jammed %s.", strings = { 'ship', 'target' } },
        preconditions = { targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } },
        action = 'jam'
    },
    [4] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true },
        action = 'evade'
    },
    [5] = { -- Coordinate (stress) the nearest friendly (unstressed) ship
        description = { text = "%s coordinated (stress) %s.", strings = { 'ship', 'coordinate' } },
        preconditions = { ['hasCoordinateTarget'] = true },
        action = { ['coordinate'] = true }
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    },
}

-- TIE/sk Striker
BehaviourDB.rule_sets[1].ships['tieskstriker'] = {}
BehaviourDB.rule_sets[1].ships['tieskstriker'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['tieskstriker'].move_table = {
    bullseye = {
        near = { [1] = 'br2s', [2] = 'bl2s', [3] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's2', [2] = 's3' },
        stress = { [1] = 's1', [4] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 'bl2s', [3] = 'br1', [5] = 's1' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 's1', [2] = 'br1', [3] = 'br2', [5] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'bl2s', [3] = 'br1', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr1', [4] = 'br2', [5] = 'tr2' },
        distant = { [1] = 'tr1', [2] = 'br2', [3] = 'tr2', [6] = 'br3' },
        stress = { [1] = 'br1', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k1', [2] = 'bl2s', [5] = 'tr1' },
        far = { [1] = 'k1', [2] = 'bl2s', [5] = 'tr1' },
        distant = { [1] = 'bl2s', [3] = 'tr1', [5] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k1', [4] = 'br2s', [5] = 'bl2s' },
        far = { [1] = 'k1', [3] = 'br2s', [4] = 'bl2s', [6] = 'tr2' },
        distant = { [1] = 'k1', [3] = 'bl2s', [5] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'br2', [6] = 'br3' },
    },
}
BehaviourDB.rule_sets[1].ships['tieskstriker'].action_selection = {
    [1] = { --  manual Ailerons prompt
        pass_through = true,
        description = "If not stressed, perform the Ailerons movement manually before clicking Move & Act.",
    },
    [2] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true },
    },
    [5] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false },
    },
    [6] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true },
        action = 'evade'
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    },
}

-- Gauntlet Fighter
---- This logic is shared between Imperial, Rebel, Scum, Republic, and Separatist. See Z-95 for an example on how to split them if necessary.
BehaviourDB.rule_sets[1].ships['gauntletfighter'] = {}
BehaviourDB.rule_sets[1].ships['gauntletfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['gauntletfighter'].move_table = {
    bullseye = {
        near = { [1] = 's0', [3] = 's2', [4] = 'tl2', [5] = 'tr2', [6] = 's4' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's2', [5] = 'bl2', [6] = 'br2' },
    },
    front_right = {
        near = { [1] = 's0', [3] = 'tl2', [5] = 'br3', [6] = 'bl3' },
        far = { [1] = 'br1', [3] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br1', [4] = 'br2', [6] = 's2' },
    },
    right_front = {
        near = { [1] = 's0', [4] = 'bl1', [6] = 'tl2' },
        far = { [1] = 'br1', [3] = 'br2', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [5] = 'tr3' },
        stress = { [1] = 'br1', [3] = 'bl1', [5] = 'br2', [6] = 'bl2' },
    },
    right_back = {
        near = { [1] = 's0', [4] = 'bl1', [5] = 's2', [6] = 'bl3' },
        far = { [1] = 's0', [4] = 'bl1', [5] = 'tr2' },
        distant = { [1] = 's0', [3] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 'br1', [3] = 'bl1', [4] = 'br2', [5] = 'bl2', [6] = 's2' },
    },
    back_right = {
        near = { [1] = 's0', [4] = 'br1', [5] = 's2', [6] = 's4' },
        far = { [1] = 's0', [4] = 's2', [5] = 'tr2' },
        distant = { [1] = 's0', [3] = 'tr2' },
        stress = { [1] = 'br1', [2] = 'bl1', [3] = 'br2', [4] = 'bl2', [5] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['gauntletfighter'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in target's arc
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inTargetsArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [4] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [5] = { -- Reinforce (stress) the fore if within arc of two or more enemies in that full arc
        description = "%s reinforced (stress) fore.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullfront', enemyCount = 2 }, requiredResult = true } },
        action = { ['reinforceFore'] = true }
    },
    [6] = { -- Reinforce (stress) the aft if within arc of two or more enemies in that full arc
        description = "%s reinforced (stress) aft.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullback', enemyCount = 2 }, requiredResult = true } },
        action = { ['reinforceAft'] = true }
    },
    [7] = { -- Coordinate (stress) the nearest friendly (unstressed) ship
        description = { text = "%s coordinated %s.", strings = { 'ship', 'coordinate' } },
        preconditions = { hasCoordinateTarget = true },
        action = { coordinate = true }
    },
    [8] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}


-----------------
-- Rebel Ships --
-----------------

-- Z-95-AF4 Headhunter. This is split by faction because the Rebel and S&V Z-95s
-- have slightly different tables.
BehaviourDB.rule_sets[1].ships['z95af4headhunter'] = {}
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions = {}
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions[1] = {}
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions[1].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions[1].move_table = {
    bullseye = {
        near = { [1] = 'k3', [3] = 's1', [5] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'k3', [4] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr2', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k3', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'k3', [5] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr3' },
        stress = { [1] = 'tr2', [3] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'k3', [5] = 'tr2' },
        far = { [1] = 'k3', [3] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr2' },
        stress = { [1] = 's1', [3] = 'br2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions[1].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 'bl2', [2] = 'br2', [3] = 's2', [5] = 's3' }
}
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions[1].action_selection = {
    [1] = { -- Target lock if not in enemy's arc
        description = { text = "%s target locked %s outside target's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- Barrel roll (stress) to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll (stress) to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- T-65 X-Wing
BehaviourDB.rule_sets[1].ships['t65xwing'] = {}
BehaviourDB.rule_sets[1].ships['t65xwing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['t65xwing'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 's1', [5] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'tr3t', [4] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [3] = 'tr2', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'tr3t', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'tr3t', [5] = 'tr2' },
        distant = { [1] = 'tr3t', [4] = 'tr3' },
        stress = { [1] = 'br1', [2] = 'tr2', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'tr3t', [5] = 'tr2' },
        far = { [1] = 'tl3t', [3] = 'tr3t' },
        distant = { [1] = 'tr3t', [4] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'br2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['t65xwing'].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 's1', [3] = 'bl1', [4] = 'br1', [5] = 's2' }
}
BehaviourDB.rule_sets[1].ships['t65xwing'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- (target moved) Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true },
    },
    [5] = { -- (target moved) Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false },
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- BTL-A4 Y-Wing
---- This logic is shared between Rebel and Scum. See Z-95 for an example on how to split them if necessary.
BehaviourDB.rule_sets[1].ships['btla4ywing'] = {}
BehaviourDB.rule_sets[1].ships['btla4ywing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['btla4ywing'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [2] = 's1', [5] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [4] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [5] = 'bl2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br1', [4] = 'br2', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'bl1', [2] = 'bl2', [5] = 's2' },
        far = { [1] = 'br1', [2] = 'tr2', [5] = 'br2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'br2', [5] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k4', [2] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k4', [3] = 'tr2' },
        distant = { [1] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 'br1', [4] = 'tr2' },
    },
    back_right = {
        near = { [1] = 's1', [3] = 'tr2', [5] = 's2' },
        far = { [1] = 'br1', [3] = 'tr2' },
        distant = { [1] = 'k4', [3] = 'tr2' },
        stress = { [1] = 'br1', [4] = 's1', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['btla4ywing'].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 's1', [2] = 'bl1', [4] = 'br1', [6] = 's2' }
}
BehaviourDB.rule_sets[1].ships['btla4ywing'].action_selection = {
    [1] = { -- Target lock if charges left
        description = { text = "%s target locked %s. If %s has no charges on its upgrades, then undo this action and perform it manually.", strings = { 'ship', 'target', 'ship' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { --  manual Rotate (upgrade) prompt
        pass_through = true,
        description =
        "If %s has a turret indicator and can get a shot by rotating, then undo the following action and take a Rotate action.",
    },
    -- Previous Rotate action (not working - no primary turret arc)
    --  [2] = { -- Rotate turret to get a shot
    --      description = "%s rotated its turret to get a shot.",
    --      preconditions = {hasShot = {arguments = {['includeArcs'] = {'front'}}, requiredResult = false}},
    --      action = {rotateTurret = {mount = 'main'}},
    --      postconditions = {hasShot = {arguments = {['includeArcs'] = {'front'}}, requiredResult = true}},
    --  },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [5] = { --  Reload ordnance (stress) if no charges left
        pass_through = true,
        description =
        "If %s has no charges on its upgrades, then undo the following action and take a red Reload action.",
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- RZ-1 A-Wing
BehaviourDB.rule_sets[1].ships['rz1awing'] = {}
BehaviourDB.rule_sets[1].ships['rz1awing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['rz1awing'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [2] = 'br3s', [4] = 'bl3s', [6] = 's2' },
        far = { [1] = 's2', [3] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [5] = 's3' },
    },
    front_right = {
        near = { [1] = 'bl3s', [4] = 'tr1', [5] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'tr2', [2] = 'br2', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'k5', [2] = 'bl3s', [4] = 'tr1' },
        far = { [1] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr2', [4] = 'br2', [6] = 'tr3' },
    },
    right_back = {
        near = { [1] = 'bl3s', [4] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'br3s', [3] = 'bl3s', [4] = 'tr2' },
        distant = { [1] = 'bl3s', [4] = 'tr1' },
        stress = { [1] = 'tr1', [2] = 'tr2', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k5', [3] = 'bl3s', [5] = 'tr2' },
        far = { [1] = 'bl3s', [3] = 'tr2' },
        distant = { [1] = 'bl3s', [4] = 'tr2' },
        stress = { [1] = 'tr2', [5] = 'tr3', [6] = 's5' },
    },
}
BehaviourDB.rule_sets[1].ships['rz1awing'].flee_table = {
    edge = { bullseye = 's5' },
    hyper = { [1] = 'bl2', [2] = 'br2', [3] = 's4', [5] = 's5' }
}
BehaviourDB.rule_sets[1].ships['rz1awing'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- (target not moved) Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { targetMoved = false, hasShot = true },
        action = 'focus'
    },
    [3] = { -- (target not moved) Evade
        description = "%s evaded.",
        preconditions = { targetMoved = false },
        action = 'evade'
    },
    [4] = { -- (target moved) Boost or barrel roll to get a shot
        description = "%s barrel rolled/boosted to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { hasShot = true }
    },
    [5] = { -- (target moved) Focus > Boost (stress) to get a shot at range 1
        description = "%s focused into a boost (stress) to get a close range shot.",
        preconditions = { targetMoved = true, hasShot = { arguments = { maxRange = 1 }, requiredResult = false } },
        action = { focus = false, boost = true },
        postconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } }
    },
    [6] = { -- (target moved) Barrel roll or boost to avoid target's arc
        description = { text = "%s barrel roll/boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, inTargetsArc = true },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- (target moved) Target lock if charges left
        description = { text = "%s target locked %s. If %s has no charges on its upgrades, then undo this action and perform it manually.", strings = { 'ship', 'target', 'ship' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [8] = { -- (target moved) Focus
        description = "%s focused.",
        preconditions = { targetMoved = true },
        action = 'focus'
    }
}

-- A/SF-01 B-Wing
BehaviourDB.rule_sets[1].ships['asf01bwing'] = {}
BehaviourDB.rule_sets[1].ships['asf01bwing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['asf01bwing'].move_table = {
    bullseye = {
        near = { [1] = 's1', [5] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k2', [2] = 'br1', [6] = 'bl2' },
        far = { [1] = 'br1', [4] = 'br2', [6] = 'br3' },
        distant = { [1] = 'br2', [5] = 'br3' },
        stress = { [1] = 'br1', [4] = 'br2', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'tr1', [3] = 'br1', [4] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [6] = 'br2' },
        distant = { [1] = 'tr2', [4] = 'br2' },
        stress = { [1] = 'br1', [5] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k2', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k2', [2] = 'tr1t', [5] = 'tr2' },
        distant = { [1] = 'tr1t', [3] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k2', [3] = 'tl1t', [5] = 'tr2' },
        far = { [1] = 'k2', [3] = 'tr1t' },
        distant = { [1] = 'tr1t', [4] = 'tr2' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['asf01bwing'].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 's1', [3] = 'bl1', [4] = 'br1', [5] = 's3' }
}
BehaviourDB.rule_sets[1].ships['asf01bwing'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Focus > barrel roll (stress) to avoid target's arc and still get a shot
        description = { text = "%s focused and barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = true, inTargetsArc = true },
        action = { focus = false, barrelRoll = true },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- (target moved) Focus > barrel roll (stress) to get a shot
        description = { text = "%s focused and barrel rolled to get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = false },
        action = { focus = false, barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [5] = { -- (target moved) Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- YT-2400 Light Freighter
BehaviourDB.rule_sets[1].ships['yt2400lightfreighter'] = {}
BehaviourDB.rule_sets[1].ships['yt2400lightfreighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['yt2400lightfreighter'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 'tl2', [5] = 'tr2' },
        far = { [1] = 's1', [2] = 's2', [6] = 's3' },
        distant = { [1] = 's3', [3] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'bl1', [3] = 'tl2', [6] = 'bl2' },
        far = { [1] = 'br1', [4] = 'br2', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br1', [3] = 's1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'bl1', [2] = 'bl2', [4] = 's2' },
        far = { [1] = 'tr1', [2] = 'br1', [3] = 'br2', [5] = 'tr2' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr1', [2] = 'br1', [6] = 's1' },
    },
    right_back = {
        near = { [1] = 's1', [4] = 'bl1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'k4', [4] = 'tr1' },
        stress = { [1] = 'tr1', [2] = 'br1', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k4', [4] = 'tr2' },
        far = { [1] = 'tr1', [3] = 'tr2' },
        distant = { [1] = 'tr1', [4] = 'tr2' },
        stress = { [1] = 'tr1', [3] = 'br1' },
    },
}
BehaviourDB.rule_sets[1].ships['yt2400lightfreighter'].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 'bl1', [3] = 'br1', [4] = 's1', [5] = 's2' }
}
BehaviourDB.rule_sets[1].ships['yt2400lightfreighter'].action_selection = {
    [1] = { -- Rotate turret to get a shot
        description = "%s rotated its turret to get a shot.",
        preconditions = { hasShot = false },
        action = { rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [2] = { -- (target moved) Target lock if target is in turret arc at range 2
        description = "%s target locked target at range 2 in turret arc.",
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = { arguments = { maxRange = 2 }, { ['minRange'] = 2 }, requiredResult = true }, hasShot = { arguments = { maxRange = 2 }, requiredResult = true } },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Barrel roll (stress) to get target at range 2 and in turret arc
        description = "%s barrel rolled to get target in turret arc at range 2.",
        preconditions = { targetMoved = true, targetWithinRange = { arguments = { maxRange = 2 }, { ['minRange'] = 2 }, requiredResult = false } },
        action = { barrelRoll = true },
        postconditions = { targetWithinRange = { arguments = { maxRange = 2 }, { ['minRange'] = 2 }, requiredResult = true }, hasShot = { arguments = { maxRange = 2 }, requiredResult = true } },
    },
    [4] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Modified YT-1300 Light Freighter
BehaviourDB.rule_sets[1].ships['modifiedyt1300lightfreighter'] = {}
BehaviourDB.rule_sets[1].ships['modifiedyt1300lightfreighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['modifiedyt1300lightfreighter'].move_table = {
    bullseye = {
        near = { [1] = 'tl2', [3] = 'tr2', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'bl1', [3] = 'tl2', [6] = 'bl2' },
        far = { [1] = 'br1', [4] = 'br2', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [2] = 'bl2', [3] = 'br2' },
    },
    right_front = {
        near = { [1] = 'bl1', [2] = 'bl2', [4] = 's2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr2', [2] = 'br2' },
    },
    right_back = {
        near = { [1] = 'bl3s', [3] = 'br1', [4] = 'tr2' },
        far = { [1] = 'k4', [2] = 'bl3s', [5] = 'tr2' },
        distant = { [1] = 'bl3s', [4] = 'tr2' },
        stress = { [1] = 'tr2', [3] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [2] = 'bl3s', [4] = 'tr2' },
        far = { [1] = 'br3s', [3] = 'bl3s' },
        distant = { [1] = 'bl3s', [4] = 'tr2' },
        stress = { [1] = 'tr2', [4] = 'br2' },
    },
}
BehaviourDB.rule_sets[1].ships['modifiedyt1300lightfreighter'].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 'bl2', [2] = 'br2', [3] = 's2', [5] = 's3' }
}
BehaviourDB.rule_sets[1].ships['modifiedyt1300lightfreighter'].action_selection = {
    [1] = { -- Rotate turret to get a shot
        description = "%s rotated its turret to get a shot.",
        preconditions = { hasShot = false },
        action = { rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [2] = { -- Boost (stress) to get a shot
        description = "%s boosted to get a shot.",
        preconditions = { hasShot = false },
        action = { boost = true },
        postconditions = { hasShot = true }
    },
    [3] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [4] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- VCX-100 Light Freighter
BehaviourDB.rule_sets[1].ships['vcx100lightfreighter'] = {}
BehaviourDB.rule_sets[1].ships['vcx100lightfreighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['vcx100lightfreighter'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [2] = 's1', [3] = 'tl2', [5] = 'tr2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'br1', [3] = 'bl2', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [2] = 'bl2', [3] = 'br2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'bl2', [4] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [4] = 'br2', [6] = 'tr3' },
        distant = { [1] = 'tr1', [4] = 'tr2' },
        stress = { [1] = 'tr2', [2] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k4', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'tr1', [3] = 'tr2' },
        distant = { [1] = 'k4', [4] = 'tr2' },
        stress = { [1] = 'tr2', [3] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'tl2', [5] = 'tr2' },
        far = { [1] = 'k4', [3] = 'tr2' },
        distant = { [1] = 'k4', [4] = 'tr2' },
        stress = { [1] = 'tr2', [4] = 'br2' },
    },
}
BehaviourDB.rule_sets[1].ships['vcx100lightfreighter'].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 's1', [2] = 'bl2', [4] = 'br2', [6] = 's2' }
}
BehaviourDB.rule_sets[1].ships['vcx100lightfreighter'].action_selection = {
    [1] = { --  manual Rotate (upgrade) prompt
        pass_through = true,
        description =
        "If %s has a turret indicator and can get a shot by rotating, then undo the following action and take a Rotate action.",
    },
    [2] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Reinforce the fore if within arc of two or more enemies in that full arc
        description = "%s reinforced fore.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullfront', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceFore'
    },
    [5] = { -- Reinforce the aft if within arc of two or more enemies in that full arc
        description = "%s reinforced aft.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullback', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceAft'
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- ARC-170 Starfighter
---- This logic is shared between Rebel and Republic. See Z-95 for an example on how to split them if necessary.
BehaviourDB.rule_sets[1].ships['arc170starfighter'] = {}
BehaviourDB.rule_sets[1].ships['arc170starfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['arc170starfighter'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 's1', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [4] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'bl2', [4] = 'tl2', [5] = 'bl3', [6] = 'tr3' },
        far = { [1] = 'br1', [2] = 's1', [3] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br1', [2] = 's1', [3] = 'bl2', [4] = 'br2', [6] = 's2' },
    },
    right_front = {
        near = { [1] = 'bl1', [3] = 'bl2', [5] = 'tl2', [6] = 'bl3' },
        far = { [1] = 'br1', [3] = 'br2', [4] = 'tr2' },
        distant = { [1] = 'br2', [2] = 'tr2', [4] = 'br3', [6] = 'tr3' },
        stress = { [1] = 'br1', [3] = 'bl1', [4] = 'br2', [6] = 'bl2' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'bl1', [5] = 's1', [6] = 'bl2' },
        far = { [1] = 'k4', [3] = 'tr2' },
        distant = { [1] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'bl1', [2] = 'br1', [4] = 'bl2', [5] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [4] = 'bl1', [5] = 's1', [6] = 's2' },
        far = { [1] = 'k4', [3] = 'bl1', [4] = 's1', [5] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'k4', [3] = 'tr2' },
        stress = { [1] = 'bl1', [3] = 'br1', [5] = 's1', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['arc170starfighter'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll (stress) to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Attack Shuttle
BehaviourDB.rule_sets[1].ships['attackshuttle'] = {}
BehaviourDB.rule_sets[1].ships['attackshuttle'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['attackshuttle'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [4] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [4] = 'br1', [6] = 's1' },
        far = { [1] = 'br1', [2] = 's2', [3] = 'br2', [5] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [4] = 's1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'br1', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [5] = 'br2', [6] = 'tr3' },
        distant = { [1] = 'br2', [2] = 'tr2', [4] = 'br3', [5] = 'tr3' },
        stress = { [1] = 'br1', [5] = 's1' },
    },
    right_back = {
        near = { [1] = 'k4', [4] = 'tr1', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 'k4', [2] = 'tr1', [4] = 'tr2' },
        distant = { [1] = 'k4', [2] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 's1', [2] = 'br1', [6] = 's2' },
    },
    back_right = {
        near = { [1] = 'k4', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 'k4', [4] = 'tr2' },
        distant = { [1] = 'k4', [4] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['attackshuttle'].action_selection = {
    [1] = { --  manual Rotate (upgrade) prompt
        pass_through = true,
        description =
        "If %s has a turret indicator and can get a shot by rotating, then undo the following action and take a Rotate action.",
    },
    [2] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll > Evade (stress) to get a shot and defend
        description = "%s barrel rolled into an evade (stress) to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = false, evade = true },
        postconditions = { hasShot = true, inTargetsArc = true }
    },
    [5] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true }
    },
    [6] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true },
        action = 'evade'
    },
    [8] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Auzituck Gunship
BehaviourDB.rule_sets[1].ships['auzituckgunship'] = {}
BehaviourDB.rule_sets[1].ships['auzituckgunship'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['auzituckgunship'].move_table = {
    bullseye = {
        near = { [1] = 's0', [3] = 'bl1', [4] = 'br1', [5] = 's1' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [2] = 'bl1', [3] = 'br1', [4] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 's0', [3] = 's1', [5] = 'br1' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 's1', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 's0', [2] = 'br1', [4] = 's1', [5] = 'br2', [6] = 'tr2' },
        far = { [1] = 'br1', [3] = 'br2', [5] = 'tr2' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [6] = 's1' },
    },
    right_back = {
        near = { [1] = 'br1', [5] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br1', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 's0', [3] = 'br1', [4] = 'tr2', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 'br1', [2] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'br1', [2] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['auzituckgunship'].action_selection = {
    [1] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [2] = { -- Reinforce the fore if within arc of two or more enemies in that full arc
        description = "%s reinforced fore.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullfront', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceFore'
    },
    [3] = { -- Reinforce the aft if within arc of two or more enemies in that full arc
        description = "%s reinforced aft.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullback', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceAft'
    },
    [4] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true },
    },
    [5] = { -- Barrel roll (stress) to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { inTargetsArc = false },
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- E-Wing
BehaviourDB.rule_sets[1].ships['ewing'] = {}
BehaviourDB.rule_sets[1].ships['ewing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['ewing'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 'bl3s', [4] = 'br3s', [5] = 's1' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's1', [3] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 'k4', [4] = 'br1', [6] = 's1' },
        far = { [1] = 'br1', [2] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [4] = 's3', [5] = 's4' },
        stress = { [1] = 'br1', [4] = 's1', [5] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k4', [3] = 'br3s', [4] = 'bl3s', [6] = 'tr1' },
        far = { [1] = 'br1', [2] = 'tr1', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'br3s', [4] = 'bl3s', [6] = 'tr1' },
        far = { [1] = 'k4', [2] = 'bl3s', [5] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'bl3s', [2] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k4', [4] = 'br3s', [5] = 'bl3s' },
        far = { [1] = 'k4', [3] = 'bl3s', [5] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'k4', [2] = 'bl3s', [4] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 'br1', [5] = 's4', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['ewing'].action_selection = {
    [1] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, inTargetsArc = false, hasShot = false, targetWithinRange = false },
        action = 'targetLock'
    },
    [2] = { --  (target moved) Boost or Barrel roll > target lock (stress) to avoid target arc and still get a shot (with the > target lock)
        description = { text = "%s barrel rolled/boosted and target locked to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, targetMoved = true, targetLocked = false },
        action = {
            [1] = { boost = false, targetLock = true },
            [2] = { barrelRoll = false, targetLock = true },
        },
        postconditions = { inTargetsArc = false, hasShot = { arguments = { ['minRange'] = 2 }, requiredResult = true }, targetWithinRange = true },
    },
    [3] = { --  (target moved) Boost or Barrel roll to avoid target arc and still get a shot (without the > target lock)
        description = { text = "%s barrel rolled/boosted to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, targetMoved = true, hasShot = true, targetLocked = true },
        action = {
            [1] = { boost = false, },
            [2] = { barrelRoll = false, }
        },
        postconditions = { inTargetsArc = false, hasShot = true }
    },
    [4] = { --  Boost or Barrel roll > target lock (stress) to get a shot (with the > target lock)
        description = "%s barrel rolled and target locked to get a shot.",
        preconditions = { hasShot = false, targetLocked = false },
        action = {
            [1] = { boost = false, targetLock = true },
            [2] = { barrelRoll = false, targetLock = true },
        },
        postconditions = { hasShot = { arguments = { ['minRange'] = 2 }, requiredResult = true }, targetWithinRange = true },
    },
    [5] = { --  Boost or Barrel roll  to get a shot (without the > target lock)
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false, targetLocked = true },
        action = {
            [1] = { boost = false, },
            [2] = { barrelRoll = false, }
        },
        postconditions = { hasShot = true }
    },
    [6] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [7] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [8] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true },
        action = 'evade'
    },
    [9] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Sheathipede-class Shuttle
BehaviourDB.rule_sets[1].ships['sheathipedeclassshuttle'] = {}
BehaviourDB.rule_sets[1].ships['sheathipedeclassshuttle'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['sheathipedeclassshuttle'].move_table = {
    bullseye = {
        near = { [1] = 's1r', [2] = 'k4', [3] = 's1', [4] = 'bl3', [5] = 'br3', [6] = 's4' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's3', [6] = 's4' },
        stress = { [1] = 's1', [2] = 's2', [4] = 's3', [5] = 'bl3', [6] = 'br3' },
    },
    front_right = {
        near = { [1] = 's1r', [2] = 'br1', [3] = 'bl2', [4] = 'tl2', [5] = 'bl3', [6] = 'tr3' },
        far = { [1] = 'br1', [2] = 'br2', [4] = 's2', [5] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 's1', [2] = 'br2', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 's1r', [2] = 'k3', [3] = 'bl1', [4] = 'tl2', [5] = 'tr2', [6] = 'bl2' },
        far = { [1] = 'br1', [2] = 'br2', [3] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'br2', [2] = 'tr2', [3] = 'br3', [5] = 'tr3' },
        stress = { [1] = 'bl2', [4] = 'br2', [5] = 's2', [6] = 's3' },
    },
    right_back = {
        near = { [1] = 'k3', [4] = 'bl1', [6] = 's1' },
        far = { [1] = 'k3', [5] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 's1', [2] = 's2', [3] = 'bl2', [5] = 'br2^', [6] = 's3' },
    },
    back_right = {
        near = { [1] = 's1r', [2] = 'k3', [3] = 'bl1', [5] = 's1', [6] = 'bl2' },
        far = { [1] = 's1r', [2] = 'k3', [4] = 'bl1', [5] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'k3', [4] = 'tr2' },
        stress = { [1] = 's1', [3] = 'bl2', [5] = 'br2', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['sheathipedeclassshuttle'].action_selection = {
    [1] = { -- Focus/Calc if have a shot
        description = "%s has a shot so focused/calculated.",
        preconditions = { hasShot = true },
        action = 'focuscalculate'
    },
    [2] = { -- Coordinate the nearest friendly (unstressed) ship
        description = { text = "%s coordinated %s.", strings = { 'ship', 'coordinate' } },
        preconditions = { hasCoordinateTarget = true },
        action = 'coordinate'
    },
    [3] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    },
}

-- UT-60D U-Wing
BehaviourDB.rule_sets[1].ships['ut60duwing'] = {}
BehaviourDB.rule_sets[1].ships['ut60duwing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['ut60duwing'].move_table = {
    bullseye = {
        near = { [1] = 's0', [3] = 's1', [4] = 'tl2', [5] = 'tr2', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's0', [4] = 's1', [6] = 'br1' },
        far = { [1] = 'br1', [2] = 's1', [3] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 's1', [4] = 'br2', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 's0', [5] = 'br1', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'br2', [3] = 'tr2' },
        distant = { [1] = 'tr2', [5] = 'br3' },
        stress = { [1] = 'br1', [4] = 'br2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 's0', [5] = 'tr2', [6] = 's4' },
        far = { [1] = 's0', [5] = 'tr2' },
        distant = { [1] = 's0', [3] = 'tr2' },
        stress = { [1] = 'br1', [3] = 's1', [4] = 'br2', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 's0', [5] = 'tr2', [6] = 's4' },
        far = { [1] = 's0', [5] = 'tr2' },
        distant = { [1] = 's0', [3] = 'tr2' },
        stress = { [1] = 'br1', [2] = 's1', [3] = 'bl2', [4] = 'br2', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['ut60duwing'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Focus/Calc if have a shot
        description = "%s has a shot so focused/calculated.",
        preconditions = { hasShot = true },
        action = 'focuscalculate'
    },
    [4] = { -- Coordinate (stress) the nearest friendly (unstressed) ship
        description = { text = "%s coordinated %s.", strings = { 'ship', 'coordinate' } },
        preconditions = { hasCoordinateTarget = true },
        action = { coordinate = true }
    },
    [5] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    },
}

-- BTL-S8 K-Wing
BehaviourDB.rule_sets[1].ships['btls8kwing'] = {}
BehaviourDB.rule_sets[1].ships['btls8kwing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['btls8kwing'].move_table = {
    bullseye = {
        near = { [1] = 's1', [3] = 'tl2', [4] = 'tr2', [5] = 'bl3', [6] = 'br3' },
        far = { [1] = 's1^', [3] = 's2^', [6] = 's3' },
        distant = { [1] = 's2', [2] = 's3' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'bl2', [2] = 'tl2', [4] = 'tr2', [5] = 'bl3', [6] = 'br3' },
        far = { [1] = 'br1', [3] = 's1', [4] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'bl1', [2] = 'br1', [4] = 's1', [6] = 's2' },
    },
    right_front = {
        near = { [1] = 'bl1', [3] = 'bl2', [4] = 'tl2', [6] = 'bl3' },
        far = { [1] = 'br1', [3] = 'br2', [4] = 'tr2' },
        distant = { [1] = 'br2', [3] = 'tr2', [6] = 'br3' },
        stress = { [1] = 'br1', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'bl1', [3] = 's1', [4] = 's2', [5] = 'bl2', [6] = 'tl2' },
        far = { [1] = 'bl1', [3] = 'tr2' },
        distant = { [1] = 'br2', [2] = 'tr2', [6] = 'br3' },
        stress = { [1] = 's1', [3] = 'bl1', [5] = 'br1', [6] = 's2' },
    },
    back_right = {
        near = { [1] = 's1', [3] = 'bl1', [5] = 's2', [6] = 'bl2' },
        far = { [1] = 'bl1', [3] = 's1', [5] = 'tr2' },
        distant = { [1] = 'br2', [2] = 'tr2' },
        stress = { [1] = 's1', [2] = 'bl1', [4] = 'br1', [5] = 's2', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['btls8kwing'].action_selection = {
    [1] = { -- Rotate turret to get a shot
        description = "%s rotated its turret to get a shot.",
        preconditions = { hasShot = false },
        action = { rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [2] = { -- SLAM if no shot and target outside of range 2
        description = "%s took a SLAM action. Perform the appropriate SLAM movement manually.",
        preconditions = { hasShot = false, targetWithinRange = { arguments = { maxRange = 2 }, requiredResult = false } },
        action = 'disarm'
    },
    [3] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [4] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [5] = { --  Reload ordnance if no charges left
        pass_through = true,
        description =
        "If %s has no charges on its missile or torpedo upgrades, then undo the following action and take a Reload action.",
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}


----------------
-- Scum Ships --
----------------

-- The Z-95 Scum has slightly different AI from the Rebel one (less self-preservation)
-- Z-95-AF4 Headhunter. This is already defined in the Rebel section, so we have
-- to add a new faction to the existing one.
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions[3] = {}
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions[3].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions[3].move_table = {
    bullseye = {
        near = { [1] = 'k3', [3] = 's1', [5] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'k3', [4] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr2', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k3', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'k3', [5] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr3' },
        stress = { [1] = 'tr2', [3] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'k3', [5] = 'tr2' },
        far = { [1] = 'k3', [3] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr2' },
        stress = { [1] = 's1', [3] = 'br2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions[3].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 'bl2', [2] = 'br2', [3] = 's2', [5] = 's3' }
}
BehaviourDB.rule_sets[1].ships['z95af4headhunter'].factions[3].action_selection = {
    [1] = { -- Target lock if not in enemy's arc
        description = { text = "%s target locked %s outside target's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [3] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [4] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- M3-A Interceptor
BehaviourDB.rule_sets[1].ships['m3ainterceptor'] = {}
BehaviourDB.rule_sets[1].ships['m3ainterceptor'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['m3ainterceptor'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 'k3', [5] = 'bl1', [6] = 'br1' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [5] = 's3' },
    },
    front_right = {
        near = { [1] = 'k3', [4] = 'tr1', [6] = 'br1' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k5', [3] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'br1', [3] = 'tr2', [6] = 'br2' },
        distant = { [1] = 'tr1', [3] = 'tr2' },
        stress = { [1] = 'tr1', [2] = 'br1' },
    },
    right_back = {
        near = { [1] = 'k5', [2] = 'k3', [4] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k3', [3] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr1' },
        stress = { [1] = 'tr1', [3] = 'br1' },
    },
    back_right = {
        near = { [1] = 'k5', [3] = 'k3', [5] = 'tr2' },
        far = { [1] = 'k3', [4] = 'tr2' },
        distant = { [1] = 'k3', [5] = 'tr1' },
        stress = { [1] = 'br1', [3] = 'tr2', [5] = 's3' },
    },
}
BehaviourDB.rule_sets[1].ships['m3ainterceptor'].flee_table = {
    edge = { bullseye = 's5' },
    hyper = { [1] = 'bl1', [3] = 'br1', [5] = 's2', [6] = 's3' }
}
BehaviourDB.rule_sets[1].ships['m3ainterceptor'].action_selection = {
    [1] = { -- Target lock if charges left
        description = { text = "%s target locked %s. If %s has no charges on its upgrades, then undo this action and perform it manually.", strings = { 'ship', 'target', 'ship' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = false },
        postconditions = { hasShot = true }
    },
    [3] = { -- Focus/Calc if have a shot
        description = "%s has a shot so focused/calculated.",
        preconditions = { hasShot = true },
        action = 'focuscalculate'
    },
    [4] = { -- Evade
        description = "%s evaded.",
        action = 'evade'
    }
}

-- Khiraxz Fighter
BehaviourDB.rule_sets[1].ships['kihraxzfighter'] = {}
BehaviourDB.rule_sets[1].ships['kihraxzfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['kihraxzfighter'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 'bl1', [5] = 'br1' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's2', [5] = 's3' },
    },
    front_right = {
        near = { [1] = 'k4', [4] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'tr2t', [4] = 'tr1' },
        far = { [1] = 'tr1', [2] = 'br1', [3] = 'br2', [5] = 'tr2' },
        distant = { [1] = 'tr1', [4] = 'tr2' },
        stress = { [1] = 'tr1', [3] = 'br1', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'tr2t', [4] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'tr2t', [5] = 'tr1' },
        distant = { [1] = 'tr2t', [4] = 'tr1' },
        stress = { [1] = 'tr1', [2] = 'br1', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'tr2t', [5] = 'tr2' },
        far = { [1] = 'tl2t', [3] = 'tr2t' },
        distant = { [1] = 'tr2t', [4] = 'tr1' },
        stress = { [1] = 'tr1', [2] = 'br1', [4] = 'br2' },
    },
}
BehaviourDB.rule_sets[1].ships['kihraxzfighter'].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 'bl2', [3] = 'br2', [5] = 's2', [6] = 's3' }
}
BehaviourDB.rule_sets[1].ships['kihraxzfighter'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s focused and barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = true, inTargetsArc = true },
        action = { barrelRoll = false },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- (target moved) Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { targetMoved = true, hasShot = true },
        action = 'focus'
    },
    [5] = { -- (target moved) Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- StarViper-class Attack Platform
BehaviourDB.rule_sets[1].ships['starviperclassattackplatform'] = {}
BehaviourDB.rule_sets[1].ships['starviperclassattackplatform'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['starviperclassattackplatform'].move_table = {
    bullseye = {
        near = { [1] = 'br3s', [2] = 'bl3s', [3] = 's1', [5] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'bl3s', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'bl3s', [3] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'tr2', [6] = 'br2' },
        distant = { [1] = 'tr1', [4] = 'tr2' },
        stress = { [1] = 'br1', [3] = 'tr2', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'bl3s', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'br3s', [2] = 'bl3s', [5] = 'tr2' },
        distant = { [1] = 'br3s', [4] = 'tr2' },
        stress = { [1] = 'br1', [2] = 'tr2', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'br3s', [3] = 'bl3s', [5] = 'tr1' },
        far = { [1] = 'br3s', [3] = 'bl3s' },
        distant = { [1] = 'br3s', [4] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'tr2', [5] = 'br2' },
    },
}
BehaviourDB.rule_sets[1].ships['starviperclassattackplatform'].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 'bl2', [2] = 'br2', [3] = 's2', [5] = 's3' }
}
BehaviourDB.rule_sets[1].ships['starviperclassattackplatform'].action_selection = {
    [1] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- Boost or barrel roll > Focus/Calc (stress) to avoid Target arc and still get a shot
        description =
        "%s barrel rolled/boosted into a focus/calculate (stress) to avoid target's arc and still get a shot.",
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false, focuscalculate = true },
            [2] = { barrelRoll = false, focuscalculate = true }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Boost or barrel roll > Focus/Calc (stress) to get a shot at range 1
        description = "%s barrel rolled/boosted into a focus/calculate (stress) to get a close range shot.",
        preconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = false } },
        action = {
            [1] = { boost = false, focuscalculate = true },
            [2] = { barrelRoll = false, focuscalculate = true }
        },
        postconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } }
    },
    [4] = { -- Boost or barrel roll > Focus/Calc (stress) to get a shot
        description = "%s barrel rolled/boosted into a focus/calculate (stress) to get a shot.",
        preconditions = { hasShot = false },
        action = {
            [1] = { boost = false, focuscalculate = true },
            [2] = { barrelRoll = false, focuscalculate = true }
        },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll or boost to avoid target's arc
        description = { text = "%s barrel roll/boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    }
}

-- Fang Fighter
---- This logic is shared between Scum and Rebel. See Z-95 for an example on how to split them if necessary.
BehaviourDB.rule_sets[1].ships['fangfighter'] = {}
BehaviourDB.rule_sets[1].ships['fangfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['fangfighter'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 'bl2', [4] = 'br2', [5] = 's2' },
        far = { [1] = 's2', [4] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 'bl2', [2] = 'br2', [3] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'tr1', [5] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br2', [4] = 's2', [5] = 's3' },
    },
    right_front = {
        near = { [1] = 'k4', [3] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr2', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'tr2t', [4] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'tr2t', [5] = 'tr2' },
        distant = { [1] = 'tr2t', [4] = 'tr3' },
        stress = { [1] = 'tr2', [5] = 'br2' },
    },
    back_right = {
        near = { [1] = 'tl2t', [3] = 'tr2t', [5] = 'tr2' },
        far = { [1] = 'tl2t', [3] = 'tr2t' },
        distant = { [1] = 'tr2t', [4] = 'tr2' },
        stress = { [1] = 'tr2', [4] = 'br2', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['fangfighter'].flee_table = {
    edge = { bullseye = 's5' },
    hyper = { [1] = 'tl2', [2] = 'tr2', [3] = 'bl2', [5] = 'br2' }
}
BehaviourDB.rule_sets[1].ships['fangfighter'].action_selection = {
    [1] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- Boost or barrel roll > Focus (stress) to avoid Target arc and still get a shot
        description = "%s barrel rolled/boosted into a focus (stress) to avoid target's arc and still get a shot.",
        preconditions = { hasShot = true, inTargetsArc = true },
        action = {
            [1] = { boost = false, focus = true },
            [2] = { barrelRoll = false, focus = true }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Boost or barrel roll > Focus (stress) to get a shot at range 1
        description = "%s barrel rolled/boosted into a focus (stress) to get a close range shot.",
        preconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = false } },
        action = {
            [1] = { boost = false, focus = true },
            [2] = { barrelRoll = false, focus = true }
        },
        postconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } }
    },
    [4] = { -- Boost or barrel roll > Focus (stress) to get a shot
        description = "%s barrel rolled/boosted into a focus (stress) to get a shot.",
        preconditions = { hasShot = false },
        action = {
            [1] = { boost = false, focus = true },
            [2] = { barrelRoll = false, focus = true }
        },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll or boost to avoid target's arc
        description = { text = "%s barrel roll/boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- HWK-290 Light Freighter
---- This logic is shared between Scum and Rebel. See Z-95 for an example on how to split them if necessary.
BehaviourDB.rule_sets[1].ships['hwk290lightfreighter'] = {}
BehaviourDB.rule_sets[1].ships['hwk290lightfreighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['hwk290lightfreighter'].move_table = {
    bullseye = {
        near = { [1] = 's0', [4] = 'bl1', [5] = 'br1', [6] = 's1' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's0', [3] = 's1', [5] = 'br1', [6] = 'tl2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'bl1', [2] = 'tr2', [4] = 'bl2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 's0', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'br1', [3] = 'tr2' },
        distant = { [1] = 'br1', [3] = 'tr2' },
        stress = { [1] = 'br1', [5] = 'tr2' },
    },
    back_right = {
        near = { [1] = 's0', [3] = 'br1', [5] = 'tr2', [6] = 'br3' },
        far = { [1] = 'br1', [3] = 'tr2' },
        distant = { [1] = 'br1', [4] = 'tr2' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['hwk290lightfreighter'].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 'bl1', [2] = 'br1', [3] = 's2', [5] = 's3' }
}
BehaviourDB.rule_sets[1].ships['hwk290lightfreighter'].action_selection = {
    [1] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- Target Lock > Rotate turret (stress) to get a shot
        description = { text = "%s target locked %s and rotated to get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = false },
        action = { targetLock = true, rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true, targetWithinRange = true }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Focus > Rotate turret (stress) to get a shot
        description = "%s focused and rotated to get a shot.",
        preconditions = { hasShot = false },
        action = { focus = true, rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true }
    },
    [5] = { -- Rotate turret to get a shot
        description = "%s rotated its turret to get a shot.",
        preconditions = { hasShot = false },
        action = { rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [6] = { -- Boost (stress) to get a shot
        description = { text = "%s boosted to get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = false },
        action = { boost = true },
        postconditions = { hasShot = true }
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Firespray-Class Patrol Craft
---- This logic is shared between Scum and CIS. See Z-95 for an example on how to split them if necessary.
BehaviourDB.rule_sets[1].ships['firesprayclasspatrolcraft'] = {}
BehaviourDB.rule_sets[1].ships['firesprayclasspatrolcraft'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['firesprayclasspatrolcraft'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 's1', [5] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's1', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'tr3t', [4] = 'tr1' },
        far = { [1] = 'tr1', [3] = 'br1', [5] = 'tr2' },
        distant = { [1] = 'tr1', [4] = 'tr2' },
        stress = { [1] = 'tr1', [2] = 'bl1', [4] = 'br1' },
    },
    right_back = {
        near = { [1] = 'tr3t', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'tr3t', [5] = 'tr2' },
        distant = { [1] = 'tr3t', [4] = 'tr2' },
        stress = { [1] = 'bl1', [3] = 'br1', [5] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'tr3t', [5] = 'tr2' },
        far = { [1] = 'tl3t', [3] = 'tr3t' },
        distant = { [1] = 'tr3t', [4] = 'tr2' },
        stress = { [1] = 'bl1', [3] = 'br1', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['firesprayclasspatrolcraft'].flee_table = {
    edge = { bullseye = 's4' },
    hyper = { [1] = 'bl1', [2] = 'br1', [3] = 's2', [5] = 's3' }
}
BehaviourDB.rule_sets[1].ships['firesprayclasspatrolcraft'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Boost to get a shot
        description = { text = "%s boosted to get a shot.", strings = { 'ship' } },
        preconditions = { targetMoved = true, hasShot = false },
        action = { boost = false },
        postconditions = { hasShot = true }
    },
    [4] = { -- (target moved) Boost to get within Range 1 and still get a shot
        description = "%s boosted to get a close range shot.",
        preconditions = { hasShot = { arguments = { ['minRange'] = 2 }, requiredResult = true } },
        action = { boost = false },
        postconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } }
    },
    [5] = { -- (target moved) Boost to avoid target's arc
        description = { text = "%s boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, inTargetsArc = true },
        action = 'boost',
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Reinforce (stress) the fore if within arc of two or more enemies in that full arc
        description = "%s reinforced fore.",
        preconditions = { hasShot = false, inEnemyArc = { arguments = { arc = 'fullfront', enemyCount = 2 }, requiredResult = true } },
        action = { ['reinforceFore'] = true }
    },
    [7] = { -- Reinforce (stress) the aft if within arc of two or more enemies in that full arc
        description = "%s reinforced aft.",
        preconditions = { hasShot = false, inEnemyArc = { arguments = { arc = 'fullback', enemyCount = 2 }, requiredResult = true } },
        action = { ['reinforceAft'] = true }
    },
    [8] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Modified TIE/Ln Fighter (Mining Guild)
BehaviourDB.rule_sets[1].ships['modifiedtielnfighter'] = {}
BehaviourDB.rule_sets[1].ships['modifiedtielnfighter'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['modifiedtielnfighter'].move_table = {
    bullseye = {
        near = { [1] = 'k3', [3] = 'bl2', [4] = 'br2', [5] = 's2' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [6] = 's5' },
        stress = { [1] = 'bl2', [3] = 'br2', [5] = 's2' },
    },
    front_right = {
        near = { [1] = 'k3', [3] = 'tr1', [5] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br2', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k3', [2] = 'tr1', [4] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr1', [2] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k3', [2] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k3', [3] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr1' },
        stress = { [1] = 'tr1', [2] = 'tr2', [3] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k3', [4] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k3', [3] = 'tr1', [4] = 'tr3' },
        distant = { [1] = 'k3', [5] = 'tr1' },
        stress = { [1] = 'br2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['modifiedtielnfighter'].flee_table = {
    edge = { nearest = 's5' },
}
BehaviourDB.rule_sets[1].ships['modifiedtielnfighter'].action_selection = {
    [1] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [2] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true },
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [5] = { -- Evade
        description = "%s evaded.",
        action = 'evade'
    }
}

-- Customized YT-1300 Light Freighter
BehaviourDB.rule_sets[1].ships['customizedyt1300lightfreighter'] = {}
BehaviourDB.rule_sets[1].ships['customizedyt1300lightfreighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['customizedyt1300lightfreighter'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [2] = 'bl3s', [3] = 'br3s', [4] = 's1', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 'k4', [2] = 'bl3s', [4] = 'br1', [5] = 'tl2', [6] = 'bl3' },
        far = { [1] = 'br1', [3] = 's1', [4] = 'br2', [6] = 's2' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 's1', [2] = 'bl1', [3] = 'br1', [5] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'bl3s', [3] = 'bl1', [4] = 'bl2', [5] = 'tr2', [6] = 'tl2' },
        far = { [1] = 'br1', [2] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'bl1', [4] = 'br1', [6] = 's3' },
    },
    right_back = {
        near = { [1] = 'k4', [2] = 'bl3s', [4] = 'bl1', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 'k4', [2] = 'bl3s', [4] = 'bl1', [5] = 'tr2' },
        distant = { [1] = 'bl3s', [3] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'bl1', [3] = 'br1', [4] = 's1', [5] = 's2', [6] = 's3' },
    },
    back_right = {
        near = { [1] = 'k4', [2] = 'br3s', [3] = 'bl3s', [5] = 'bl1', [6] = 's1' },
        far = { [1] = 'k4', [2] = 'bl3s', [4] = 'bl1', [5] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'bl3s', [3] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'bl1', [3] = 'br1', [4] = 's1', [5] = 's2', [6] = 's3' },
    },
}

BehaviourDB.rule_sets[1].ships['customizedyt1300lightfreighter'].action_selection = {
    [1] = { -- Rotate turret to get a shot
        description = "%s rotated its turret to get a shot.",
        preconditions = { hasShot = false },
        action = { rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [2] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [3] = { -- Boost (stress) to get a shot
        description = "%s boosted to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = { boost = true },
        postconditions = { hasShot = true }
    },
    [4] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Aggressor Assault StarFighter
BehaviourDB.rule_sets[1].ships['aggressorassaultfighter'] = {}
BehaviourDB.rule_sets[1].ships['aggressorassaultfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['aggressorassaultfighter'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 'bl3s', [4] = 'br3s', [5] = 's1', [6] = 's2' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [3] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'bl3s', [5] = 's1', [6] = 'br1' },
        far = { [1] = 'br1', [3] = 's1', [4] = 'br2', [6] = 's2' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br1', [2] = 's1', [3] = 'br2', [5] = 's2', [6] = 'br3' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'bl3s', [5] = 'tr1' },
        far = { [1] = 'br1', [2] = 'tr1', [4] = 'br2', [5] = 'tr2' },
        distant = { [1] = 'tr1', [2] = 'br2', [3] = 'tr2', [6] = 'br3' },
        stress = { [1] = 'br1', [3] = 'tr1', [4] = 'br2', [6] = 'br3' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'bl3s', [5] = 'tr1' },
        far = { [1] = 'k4', [2] = 'br3s', [5] = 'tr1' },
        distant = { [1] = 'k4', [2] = 'bl3s', [4] = 'tr1', [5] = 'tr2' },
        stress = { [1] = 'br1', [3] = 'tr1', [4] = 'br2', [6] = 'bl3' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'br3s', [4] = 'bl3s', [6] = 'tr2' },
        far = { [1] = 'k4', [3] = 'bl3s', [4] = 'br3s', [6] = 'tr1' },
        distant = { [1] = 'k4', [2] = 'bl3s', [4] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'br1', [3] = 'br2', [5] = 'br3', [6] = 'bl3' },
    },
}
BehaviourDB.rule_sets[1].ships['aggressorassaultfighter'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Boost to avoid target's arc and still get a shot
        description = { text = "%s boosted to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = true, inTargetsArc = true },
        action = 'boost',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- Calculate x2 if you have a shot
        description = "%s has a shot so calculated.",
        preconditions = { hasShot = true },
        action = { calculate = false, calculate = false }
    },
    [5] = { -- (target moved) Boost to get a shot
        description = "%s boosted to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = 'boost',
        postconditions = { hasShot = true }
    },
    [6] = { -- (target moved) Boost to avoid target's arc
        description = { text = "%s boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, inTargetsArc = true },
        action = 'boost',
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true, hasShot = false },
        action = 'evade'
    },
    [8] = { -- Calculate x2
        description = "%s calculated.",
        action = { calculate = false, calculate = false }
    }
}

-- Escape Craft
BehaviourDB.rule_sets[1].ships['escapecraft'] = {}
BehaviourDB.rule_sets[1].ships['escapecraft'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['escapecraft'].move_table = {
    bullseye = {
        near = { [1] = 'k3', [2] = 's0', [4] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's2', [2] = 's3' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k3', [2] = 's0', [3] = 'br1', [5] = 's1', [6] = 'bl3' },
        far = { [1] = 'br1', [2] = 'br2', [4] = 's2', [5] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br1', [3] = 's1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'k3', [2] = 's0', [3] = 'br1', [5] = 'tr2' },
        far = { [1] = 'br1', [3] = 'br2', [4] = 'tr2' },
        distant = { [1] = 'tr2', [3] = 'br2', [4] = 'br3' },
        stress = { [1] = 'br1', [6] = 's1' },
    },
    right_back = {
        near = { [1] = 'k3', [4] = 's0', [5] = 'br1', [6] = 'tr2' },
        far = { [1] = 'k3', [3] = 'br1', [4] = 'tr2', [6] = 'br3' },
        distant = { [1] = 'k3', [3] = 'tr2', [6] = 'br3' },
        stress = { [1] = 's1', [3] = 'br1' },
    },
    back_right = {
        near = { [1] = 'k3', [4] = 's0', [5] = 's2', [6] = 'bl3' },
        far = { [1] = 'k3', [3] = 'br1', [4] = 'tr2', [6] = 'br3' },
        distant = { [1] = 'k3', [3] = 'br1', [4] = 'tr2', [6] = 'br3' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['escapecraft'].action_selection = {
    [1] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [2] = { -- Focus/Calc if have a shot
        description = "%s has a shot so focused/calculated.",
        preconditions = { hasShot = true },
        action = 'focuscalculate'
    },
    [3] = { -- Coordinate the nearest friendly (unstressed) ship
        description = { text = "%s coordinated %s.", strings = { 'ship', 'coordinate' } },
        preconditions = { hasCoordinateTarget = true },
        action = 'coordinate'
    },
    [4] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    },
}

-- G-1A Starfighter
BehaviourDB.rule_sets[1].ships['g1astarfighter'] = {}
BehaviourDB.rule_sets[1].ships['g1astarfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['g1astarfighter'].move_table = {
    bullseye = {
        near = { [1] = 's0', [3] = 'k4', [5] = 's1' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [4] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [4] = 's0', [5] = 'br1', [6] = 's1' },
        far = { [1] = 'br1', [3] = 's1', [4] = 'br2', [6] = 's2' },
        distant = { [1] = 'br2', [3] = 's3', [5] = 'br3' },
        stress = { [1] = 's1', [3] = 'br1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 's0', [2] = 'tr1', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr1', [3] = 'tr2', [6] = 'br2' },
        distant = { [1] = 'tr2', [5] = 'br2', [6] = 'br3' },
        stress = { [1] = 'br1', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'k2', [5] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'k2', [4] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'k2', [3] = 'tr2' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 's0', [2] = 'k4', [3] = 'k2', [5] = 'tr2', [6] = 'tl2' },
        far = { [1] = 'k4', [2] = 'k2', [5] = 'tr2' },
        distant = { [1] = 'k2', [4] = 'tr2' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['g1astarfighter'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in target's arc
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inTargetsArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Focus/Calc if have a shot
        description = "%s has a shot so focused/calculated.",
        preconditions = { hasShot = true },
        action = 'focuscalculate'
    },
    [4] = { -- Jam the target
        description = { text = "%s jammed %s.", strings = { 'ship', 'target' } },
        preconditions = { targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } },
        action = 'jam'
    },
    [5] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    },
}

-- Lancer-class Pursuit Craft
BehaviourDB.rule_sets[1].ships['lancerclasspursuitcraft'] = {}
BehaviourDB.rule_sets[1].ships['lancerclasspursuitcraft'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['lancerclasspursuitcraft'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 's1', [4] = 'tl3', [5] = 'tr3', [6] = 's4' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [3] = 's3', [4] = 's4', [5] = 'tl3', [6] = 'tr3' },
    },
    front_right = {
        near = { [1] = 'k5', [3] = 'br1', [4] = 's1', [5] = 'bl3', [6] = 'tr3' },
        far = { [1] = 'br1', [2] = 's1', [3] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's4', [6] = 's5' },
        stress = { [1] = 's2', [3] = 'br3', [5] = 's3', [6] = 'tr3' },
    },
    right_front = {
        near = { [1] = 'k5', [3] = 'br1', [4] = 'tr2', [5] = 'br3', [6] = 'tr3' },
        far = { [1] = 'br1', [2] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [3] = 'tr3' },
        stress = { [1] = 's2', [2] = 'br3', [4] = 'tr3' },
    },
    right_back = {
        near = { [1] = 'k5', [4] = 'br1', [5] = 'tr2', [6] = 'tr3' },
        far = { [1] = 'k5', [3] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'k5', [2] = 'tr2', [3] = 'tr3' },
        stress = { [1] = 's2', [2] = 'br3', [4] = 'tr3' },
    },
    back_right = {
        near = { [1] = 'k5', [3] = 'br1', [4] = 's1', [5] = 'tr2', [6] = 'tr3' },
        far = { [1] = 'k5', [3] = 's1', [4] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'k5', [3] = 'br3', [4] = 'tr3' },
        stress = { [1] = 's2', [2] = 'br3', [4] = 'tl3', [5] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['lancerclasspursuitcraft'].action_selection = {
    [1] = { -- Rotate turret to get a shot
        description = "%s rotated its turret to get a shot.",
        preconditions = { hasShot = false },
        action = { rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [2] = { -- (target not moved) Target lock if not in target's arc
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inTargetsArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [4] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [5] = { -- Focus if have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [6] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true, hasShot = false },
        action = 'evade'
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- M12-L Kimogila Fighter
BehaviourDB.rule_sets[1].ships['m12lkimogilafighter'] = {}
BehaviourDB.rule_sets[1].ships['m12lkimogilafighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['m12lkimogilafighter'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [4] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [6] = 's3' },
        distant = { [1] = 's2', [2] = 's3' },
        stress = { [1] = 's1', [3] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [6] = 's1' },
        far = { [1] = 'br1', [2] = 'br2', [4] = 's2', [5] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 's1', [3] = 'br2', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [4] = 'br1', [5] = 'tr1' },
        far = { [1] = 'br1', [2] = 'br2', [3] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [4] = 'tr3' },
        stress = { [1] = 's1', [2] = 'br2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k4', [4] = 'tr1', [5] = 'br3', [6] = 'tl3' },
        far = { [1] = 'k4', [3] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'k4', [3] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 's1', [2] = 'br2', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k4', [4] = 'tr1', [5] = 'tr3', [6] = 'tl3' },
        far = { [1] = 'k4', [5] = 'tr3' },
        distant = { [1] = 'k4', [3] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'br2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['m12lkimogilafighter'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in target's arc
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inTargetsArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true },
    },
    [5] = { --  Reload ordnance if no charges left
        pass_through = true,
        description =
        "If %s has no charges on its missile or torpedo upgrades, then undo the following action and take a Reload action.",
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Scurrg H-6 Bomber
BehaviourDB.rule_sets[1].ships['scurrgh6bomber'] = {}
BehaviourDB.rule_sets[1].ships['scurrgh6bomber'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['scurrgh6bomber'].move_table = {
    bullseye = {
        near = { [1] = 'tl3t', [2] = 'tr3t', [3] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [4] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'tr3t', [2] = 'br1', [4] = 's1', [5] = 'bl2', [6] = 'tl2' },
        far = { [1] = 'br1', [3] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br1', [3] = 's1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'tr3t', [3] = 'bl1', [5] = 'br1', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'br2', [3] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'br2', [2] = 'tr2', [4] = 'br3', [5] = 'tr3' },
        stress = { [1] = 'bl1', [3] = 'br1', [5] = 's1' },
    },
    right_back = {
        near = { [1] = 'tr3t', [5] = 'bl1', [6] = 'tr2' },
        far = { [1] = 'tr3t', [5] = 'tr2' },
        distant = { [1] = 'tr3t', [3] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 's1', [3] = 'bl1', [5] = 'br1' },
    },
    back_right = {
        near = { [1] = 'tl3t', [2] = 'tr3t', [4] = 's1', [5] = 'bl1', [6] = 'br1' },
        far = { [1] = 'tr3t', [5] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr3t', [3] = 'tr2' },
        stress = { [1] = 'bl1', [3] = 'br1', [5] = 's1', [6] = 's2' },
    },
}

BehaviourDB.rule_sets[1].ships['scurrgh6bomber'].action_selection = {
    [1] = { --  manual Rotate (upgrade) prompt
        pass_through = true,
        description =
        "If %s has a turret indicator and can get a shot by rotating, then undo the following action and take a Rotate action.",
    },
    [2] = { -- (target not moved) Target lock if not in target's arc
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inTargetsArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [4] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [5] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- YV-666 Light Freighter
BehaviourDB.rule_sets[1].ships['yv666lightfreighter'] = {}
BehaviourDB.rule_sets[1].ships['yv666lightfreighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['yv666lightfreighter'].move_table = {
    bullseye = {
        near = { [1] = 's0', [3] = 'bl1', [4] = 'br1', [5] = 's1' }
        ,
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [3] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 's0', [3] = 's1', [5] = 'br1', [6] = 's2' },
        far = { [1] = 'br1', [2] = 's1', [3] = 'br2', [5] = 's2', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 's1', [2] = 'br1', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 's0', [3] = 'br1', [5] = 'br2', [6] = 'tr2' },
        far = { [1] = 'br1', [3] = 'br2', [5] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br1', [5] = 's1' },
    },
    right_back = {
        near = { [1] = 's0', [2] = 'br1', [4] = 'tr2', [6] = 'tr3' },
        far = { [1] = 'br1', [3] = 'tr2', [4] = 'tr3' },
        distant = { [1] = 'br1', [3] = 'tr2', [4] = 'br3', [5] = 'tr3' },
        stress = { [1] = 'br1', [6] = 'tr3' },
    },
    back_right = {
        near = { [1] = 's0', [2] = 'br1', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 'br1', [3] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'br1', [4] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'br1', [5] = 's3', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['yv666lightfreighter'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Reinforce the fore if within arc of two or more enemies in that full arc
        description = "%s reinforced fore.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullfront', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceFore'
    },
    [4] = { -- Reinforce the aft if within arc of two or more enemies in that full arc
        description = "%s reinforced aft.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullback', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceAft'
    },
    [5] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- JumpMaster 5000
BehaviourDB.rule_sets[1].ships['jumpmaster5000'] = {}
BehaviourDB.rule_sets[1].ships['jumpmaster5000'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['jumpmaster5000'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 'bl3s', [4] = 's1', [5] = 'tl2', [6] = 'bl3' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [2] = 'bl1', [3] = 's2', [4] = 'bl2', [5] = 's3', [6] = 'bl3' },
    },
    front_right = {
        near = { [1] = 'k4', [2] = 'bl3s', [4] = 'br1', [5] = 's1', [6] = 'tl2' },
        far = { [1] = 'br1', [3] = 's1', [4] = 'br2', [5] = 'bl2', [6] = 's2' },
        distant = { [1] = 'bl3', [2] = 'br3', [5] = 's3', [6] = 's4' },
        stress = { [1] = 'bl1', [2] = 's1', [4] = 'bl2', [5] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'bl3s', [4] = 'bl1', [5] = 's1', [6] = 'tr1' },
        far = { [1] = 'br1', [3] = 'tr1', [4] = 'br2', [6] = 'tr2' },
        distant = { [1] = 'tr1', [2] = 'br2', [4] = 'tr2', [5] = 'br3' },
        stress = { [1] = 'bl1', [2] = 's1', [4] = 'br2', [5] = 's2' },
    },
    right_back = {
        near = { [1] = 'k4', [2] = 'bl3s', [4] = 'bl1', [5] = 'br1', [6] = 'br2' },
        far = { [1] = 'k4', [2] = 'bl3s', [5] = 'br1', [6] = 'tr1' },
        distant = { [1] = 'bl3s', [4] = 'tr1', [5] = 'tr2', [6] = 'br3' },
        stress = { [1] = 'bl1', [3] = 's1', [5] = 'bl2', [6] = 's2' },
    },
    back_right = {
        near = { [1] = 'k4', [2] = 'bl3s', [4] = 's1', [5] = 'tl1', [6] = 'tl2' },
        far = { [1] = 'k4', [3] = 'bl3s', [5] = 's1', [6] = 'tl2' },
        distant = { [1] = 'k4', [2] = 'bl3s', [4] = 'tl1', [5] = 'tr1', [6] = 'tl2' },
        stress = { [1] = 'bl1', [2] = 's1', [4] = 'bl2', [5] = 's2', [6] = 'bl3' },
    },
    front_left = {
        near = { [1] = 'k4', [2] = 'bl3s', [4] = 'bl1', [5] = 's1', [6] = 'tl2' },
        far = { [1] = 'bl1', [3] = 's1', [4] = 'bl2', [6] = 's2' },
        distant = { [1] = 'bl3', [5] = 's3', [6] = 's4' },
        stress = { [1] = 'bl1', [3] = 's1', [4] = 'bl2', [5] = 's2', [6] = 's3' },
    },
    left_front = {
        near = { [1] = 'k4', [3] = 'bl1', [4] = 'bl2', [5] = 's1', [6] = 'tl1' },
        far = { [1] = 'bl1', [2] = 'tr1', [4] = 'bl2', [5] = 'tr2' },
        distant = { [1] = 'bl2', [2] = 'tl2', [6] = 'bl3' },
        stress = { [1] = 'bl1', [2] = 'bl2', [5] = 'tl2', [6] = 'bl3' },
    },
    left_back = {
        near = { [1] = 'k4', [3] = 'bl3s', [4] = 'bl1', [6] = 'tl1' },
        far = { [1] = 'k4', [3] = 'tl1', [5] = 'tl2' },
        distant = { [1] = 'tl1', [2] = 'bl2', [3] = 'tl2', [6] = 'bl3' },
        stress = { [1] = 'bl1', [3] = 'bl2', [5] = 'bl3' },
    },
    back_left = {
        near = { [1] = 'k4', [3] = 'bl3s', [5] = 'tl1', [6] = 'tl2' },
        far = { [1] = 'k4', [2] = 'bl3s', [3] = 'tl1', [5] = 'tl2' },
        distant = { [1] = 'k4', [2] = 'bl3s', [3] = 'tl1', [6] = 'tl2' },
        stress = { [1] = 'bl1', [4] = 's1', [5] = 'bl2' },
    },
}

BehaviourDB.rule_sets[1].ships['jumpmaster5000'].action_selection = {
    [1] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- Target Lock > Rotate turret (stress) to get a shot
        description = { text = "%s target locked %s and rotated to get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = false },
        action = { targetLock = true, rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true, targetWithinRange = true }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Focus > Rotate turret (stress) to get a shot
        description = "%s focused and rotated to get a shot.",
        preconditions = { hasShot = false },
        action = { focus = true, rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [6] = { -- Barrel roll (stress) to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Quadrijet Transfer Spacetug
BehaviourDB.rule_sets[1].ships['quadrijettransferspacetug'] = {}
BehaviourDB.rule_sets[1].ships['quadrijettransferspacetug'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['quadrijettransferspacetug'].move_table = {
    bullseye = {
        near = { [1] = 'bl2s', [2] = 'br2s', [3] = 's2r', [4] = 'bl1r', [5] = 'br1r', [6] = 's1' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's2', [2] = 's3' },
        stress = { [1] = 'bl2', [2] = 'br2', [3] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 's2r', [2] = 'bl1r', [4] = 's1', [5] = 'br1' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 'br2', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'bl2s', [2] = 'bl1r', [3] = 'br1', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr1', [3] = 'br2', [4] = 'tr2' },
        distant = { [1] = 'tr1', [2] = 'tr2', [5] = 'br3' },
        stress = { [1] = 'br2', [5] = 's2', [6] = 'tr1' },
    },
    right_back = {
        near = { [1] = 'bl2s', [3] = 's2r', [4] = 'bl1r', [5] = 'tr1' },
        far = { [1] = 'bl2s', [3] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'bl2s', [3] = 'tr1', [4] = 'tr2' },
        stress = { [1] = 's2', [3] = 'br2' },
    },
    back_right = {
        near = { [1] = 's2r', [2] = 'bl1r', [3] = 'br2s', [4] = 'bl2s', [6] = 'br3' },
        far = { [1] = 'bl2s', [4] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'bl2s', [3] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'bl2', [2] = 'br2', [4] = 's2', [6] = 's3' },
    },
}
BehaviourDB.rule_sets[1].ships['quadrijettransferspacetug'].action_selection = {
    [1] = { -- Tractor range 1 front arc
        description = { text = "%s tractored %s in forward arc at range 1. Add a 2nd token if in Bullseye", strings = { 'ship', 'target' } },
        preconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } },
        action = 'tractor',
    },
    [2] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true }
    },
    [4] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [5] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Evade (stress)
        description = "%s evaded.",
        preconditions = { inTargetsArc = true, hasShot = false },
        action = { evade = true }
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- ST-70 Assault Ship
BehaviourDB.rule_sets[1].ships['st70assaultship'] = {}
BehaviourDB.rule_sets[1].ships['st70assaultship'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['st70assaultship'].move_table = {
    bullseye = {
        near = { [1] = 's0', [3] = 'k5', [5] = 's1' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [2] = 's2', [4] = 's3', [6] = 's4' },
    },
    front_right = {
        near = { [1] = 's0', [2] = 'k5', [3] = 's1', [4] = 'br1', [5] = 'bl3', [6] = 'tr3' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 's1', [3] = 's2', [5] = 's3', [6] = 's4' },
    },
    right_front = {
        near = { [1] = 's0', [2] = 'k5', [3] = 'tr2t', [4] = 'tr1', [5] = 'tr2', [6] = 'bl3' },
        far = { [1] = 'br1', [2] = 'tr2', [4] = 'br2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [5] = 'tr3' },
        stress = { [1] = 's1', [4] = 's2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k5', [2] = 'tr2t', [5] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'k5', [2] = 'tr2t', [4] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'k5', [2] = 'tr2t', [3] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 's1', [4] = 's2', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 's0', [2] = 'k5', [3] = 'tl2t', [4] = 'tr2t', [6] = 'tr2' },
        far = { [1] = 'k5', [2] = 'tr2t', [5] = 'tr2' },
        distant = { [1] = 'tr2t', [3] = 'tr2' },
        stress = { [1] = 's1', [3] = 's2', [5] = 's3', [6] = 's4' },
    },
}

BehaviourDB.rule_sets[1].ships['st70assaultship'].action_selection = {
    [1] = { -- Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Focus/Calc if have a shot
        description = "%s has a shot so focused/calculated.",
        preconditions = { hasShot = true },
        action = 'focuscalculate'
    },
    [4] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true, hasShot = false },
        action = 'evade'
    },
    [7] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    },
}

-- Rogue-class Starfighter
---- This logic is shared between Scum and CIS. See Z-95 for an example on how to split them if necessary.
BehaviourDB.rule_sets[1].ships['rogueclassstarfighter'] = {}
BehaviourDB.rule_sets[1].ships['rogueclassstarfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['rogueclassstarfighter'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 'bl1', [5] = 'br1' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [5] = 's3' },
    },
    front_right = {
        near = { [1] = 'k5', [4] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k5', [2] = 'tr2t', [4] = 'tr1' },
        far = { [1] = 'tr1', [2] = 'br1', [3] = 'br2', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr1', [2] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'tr1', [3] = 'br1', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k5', [3] = 'tr2t', [4] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k5', [2] = 'tr2t', [5] = 'tr1' },
        distant = { [1] = 'tr2t', [4] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'tr1', [2] = 'br1', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k5', [3] = 'tr2t', [5] = 'tr2' },
        far = { [1] = 'tl2t', [3] = 'tr2t' },
        distant = { [1] = 'tr2t', [4] = 'tr1' },
        stress = { [1] = 'tr1', [2] = 'br1', [4] = 'br2' },
    },
}

BehaviourDB.rule_sets[1].ships['rogueclassstarfighter'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [3] = { -- Focus/Calc > boost or focus/Calc > barrel roll to avoid target's arc and still get a shot
        description = { text = "%s focused/calculated and barrel rolled/boosted to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = {
            [1] = { focuscalculate = false, boost = true },
            [2] = { focuscalculate = false, barrelRoll = true }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- (target moved) Focus/Calc if you have a shot
        description = "%s has a shot so focused/calculated.",
        preconditions = { targetMoved = true, hasShot = true },
        action = 'focuscalculate'
    },
    [5] = { -- (target not moved) Evade > barrel roll to get a shot
        description = { text = "%s evaded and barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, hasShot = false, inTargetsArc = true },
        action = { evade = false, barrelRoll = true },
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true },
        action = 'evade'
    },
    [7] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    },
}


--------------
-- FO Ships --
--------------

-- TIE/fo Fighter
BehaviourDB.rule_sets[1].ships['tiefofighter'] = {}
BehaviourDB.rule_sets[1].ships['tiefofighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tiefofighter'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 'bl2', [4] = 'br2', [5] = 's2' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 'bl2', [3] = 'br2', [5] = 's2' },
    },
    front_right = {
        near = { [1] = 'bl2s', [3] = 'tr1', [5] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br2', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k4', [3] = 'bl2s', [5] = 'tr1' },
        far = { [1] = 'tr1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr1', [2] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'bl2s', [4] = 'tr1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'bl2s', [5] = 'tr2' },
        distant = { [1] = 'bl2s', [4] = 'tr1' },
        stress = { [1] = 'tr1', [2] = 'tr2', [6] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'bl2s', [5] = 'tr2' },
        far = { [1] = 'br2s', [3] = 'bl2s' },
        distant = { [1] = 'bl2s', [4] = 'tr1' },
        stress = { [1] = 'tl2', [4] = 'tr2', [6] = 's4' },
    },
}
BehaviourDB.rule_sets[1].ships['tiefofighter'].action_selection = {
    [1] = { -- Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Evade
        description = "%s evaded.",
        action = 'evade'
    }
}

-- TIE/sf Fighter
BehaviourDB.rule_sets[1].ships['tiesffighter'] = {}
BehaviourDB.rule_sets[1].ships['tiesffighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tiesffighter'].move_table = {
    bullseye = {
        near = { [1] = 'br3s', [2] = 'bl3s', [3] = 's1', [5] = 's2' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 'bl1', [3] = 'br1', [5] = 's2' },
    },
    front_right = {
        near = { [1] = 'bl3s', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [4] = 'br2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'bl3s', [3] = 'tr1', [4] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [5] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'bl3s', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'br3s', [2] = 'bl3s', [5] = 'tr2' },
        distant = { [1] = 'br3s', [4] = 'tr2' },
        stress = { [1] = 'br1', [2] = 'tr2', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'br3s', [3] = 'bl3s', [5] = 'tr2' },
        far = { [1] = 'br3s', [3] = 'bl3s' },
        distant = { [1] = 'br3s', [4] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'tr2', [5] = 'br2' },
    },
}
BehaviourDB.rule_sets[1].ships['tiesffighter'].action_selection = {
    [1] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- Target Lock > Rotate turret to get a shot
        description = { text = "%s target locked %s and rotated to get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = false },
        action = { targetLock = false, rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true, targetWithinRange = true }
    },
    [3] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- Barrel roll > Rotate to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and rotated to still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = false, inTargetsArc = true },
        action = { barrelRoll = false, rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [5] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [6] = { -- Focus > Rotate turret to get a shot
        description = "%s focused and rotated to get a shot.",
        preconditions = { hasShot = false },
        action = { focus = false, rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true }
    },
    [7] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true }
    },
    [8] = { -- Barrel roll > Rotate to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = false, rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true }
    },
    [9] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [10] = { -- Evade
        description = "%s evaded.",
        action = 'evade'
    }
}

-- TIE/se Bomber
BehaviourDB.rule_sets[1].ships['tiesebomber'] = {}
BehaviourDB.rule_sets[1].ships['tiesebomber'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tiesebomber'].move_table = {
    bullseye = {
        near = { [1] = 'br3s', [2] = 'bl3s', [3] = 's1', [5] = 's2', [6] = 's4' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [3] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 'bl3s', [4] = 'br1', [5] = 's1', [6] = 'tl2' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 's1', [3] = 's2', [5] = 's3' },
    },
    right_front = {
        near = { [1] = 'bl3s', [3] = 'bl1', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 's1', [4] = 's2', [5] = 'tr2', [6] = 'tr3' },
    },
    right_back = {
        near = { [1] = 'bl3s', [3] = 'bl1', [4] = 'tr1', [6] = 'tr3' },
        far = { [1] = 'bl3s', [3] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'bl3s', [3] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 's1', [5] = 's2', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'br3s', [2] = 'bl3s', [4] = 'bl1', [5] = 's1', [6] = 'tr3' },
        far = { [1] = 'bl3s', [4] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'bl3s', [3] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 's1', [4] = 'tr2', [5] = 's2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['tiesebomber'].action_selection = {
    [1] = { --  Barrel roll > target lock (stress) to avoid target arc and still get a shot (with the > target lock)
        description = { text = "%s barrel rolled and target locked to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, hasShot = true, targetLocked = false },
        action = { barrelRoll = false, targetLock = true },
        postconditions = { inTargetsArc = false, hasShot = true, targetWithinRange = true }
    },
    [2] = { --  Barrel roll > target lock (stress) to avoid target arc and still get a shot (without the > target lock)
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, hasShot = true, targetLocked = true },
        action = { barrelRoll = false },
        postconditions = { inTargetsArc = false, hasShot = true }
    },
    [3] = { --  Barrel roll > target lock (stress) to get a shot (with the > target lock)
        description = "%s barrel rolled and target locked to get a shot.",
        preconditions = { hasShot = false, targetLocked = false },
        action = { barrelRoll = false, targetLock = true },
        postconditions = { hasShot = true, targetWithinRange = true }
    },
    [4] = { --  Barrel roll > target lock (stress) to get a shot (without the > target lock)
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false, targetLocked = true },
        action = { barrelRoll = false },
        postconditions = { hasShot = true }
    },
    [5] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [6] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [7] = { -- Boost (stress) to get a shot
        description = "%s boosted to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = { boost = true },
        postconditions = { hasShot = true }
    },
    [8] = { -- Barrel roll or boost (stress) to avoid target's arc
        description = { text = "%s barrel roll/boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { barrelRoll = false },
            [2] = { boost = true },
        },
        postconditions = { inTargetsArc = false }
    },
    [9] = { --  Reload ordnance if no charges left
        pass_through = true,
        description =
        "If %s has no charges on its upgrades, then undo the following action and take a Reload action. Perform a linked Evade (stress) if appropriate.",
    },
    [10] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- TIE/vn Silencer
BehaviourDB.rule_sets[1].ships['tievnsilencer'] = {}
BehaviourDB.rule_sets[1].ships['tievnsilencer'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tievnsilencer'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [4] = 's2', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 's2', [4] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [4] = 's3', [6] = 's4' },
    },
    front_right = {
        near = { [1] = 'br2', [2] = 's2', [4] = 'bl3', [5] = 'tl3', [6] = 's5' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br2', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'tr3t', [4] = 'tr1' },
        far = { [1] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br2', [3] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k4', [2] = 'tr3t', [5] = 'tr1' },
        far = { [1] = 'tr3t', [3] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'tr3t', [3] = 'tr1', [4] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 'br2', [3] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'tl3t', [4] = 'tr3t', [6] = 'tr3' },
        far = { [1] = 'k4', [2] = 'tr3t', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr3t', [3] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'br2', [2] = 'tl2', [3] = 'tr2', [6] = 's5' },
    },
}
BehaviourDB.rule_sets[1].ships['tievnsilencer'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target not moved) Target lock > Boost (stress) or Target Lock > barrel roll (stress) if not in any arcs
        description = { text = "%s target locked %s and boosted/barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = true, targetWithinRange = true },
        action = {
            [1] = { targetLock = false, boost = true },
            [2] = { targetLock = false, barrelRoll = true }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Focus > boost (stress) or focus > barrel roll (stress) to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled/boosted and focused to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = {
            [1] = { focus = false, boost = true },
            [2] = { focus = false, barrelRoll = true }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- Boost > barrel roll (stress) or barrel roll > boost (stress) to get a shot
        description = "%s barrel rolled/boosted to get a shot.",
        preconditions = { hasShot = false },
        action = {
            [1] = { boost = false, barrelRoll = true },
            [2] = { barrelRoll = false, boost = true }
        },
        postconditions = { hasShot = true }
    },
    [5] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [6] = { -- Boost > barrel roll (stress) or barrel roll > boost (stress) to avoid target's arc
        description = { text = "%s barrel rolled > boost/boosted > barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false, barrelRoll = true },
            [2] = { barrelRoll = false, boost = true }
        },
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [8] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- TIE/wi Whisper Modified Interceptor
BehaviourDB.rule_sets[1].ships['tiewiwhispermodifiedinterceptor'] = {}
BehaviourDB.rule_sets[1].ships['tiewiwhispermodifiedinterceptor'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tiewiwhispermodifiedinterceptor'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 'bl3s', [4] = 'br3s', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 'bl3', [2] = 'br3', [3] = 's2', [4] = 's3', [5] = 's4', [6] = 's5' },
    },
    front_right = {
        near = { [1] = 'k5', [2] = 'bl3s', [4] = 'br2', [5] = 's2', [6] = 'tl2' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br2', [3] = 's2', [4] = 'br3', [5] = 's3', [6] = 's4' },
    },
    right_front = {
        near = { [1] = 'k5', [2] = 'bl3s', [4] = 'tl1', [5] = 'tr1', [6] = 'bl2' },
        far = { [1] = 'tr2', [3] = 'br2', [4] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [3] = 'tr3' },
        stress = { [1] = 'bl2', [3] = 'br2', [5] = 'br3' },
    },
    right_back = {
        near = { [1] = 'k4', [2] = 'bl3s', [4] = 'tr1', [5] = 's2', [6] = 'bl2' },
        far = { [1] = 'k4', [2] = 'bl3s', [4] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'k4', [2] = 'bl3s', [3] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'bl2', [3] = 'br2', [5] = 'br3' },
    },
    back_right = {
        near = { [1] = 'k4', [2] = 'br3s', [3] = 'bl3s', [5] = 's2', [6] = 'bl2' },
        far = { [1] = 'k4', [2] = 'bl3s', [4] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'k4', [2] = 'bl3s', [3] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'bl2', [3] = 'br2', [5] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['tiewiwhispermodifiedinterceptor'].action_selection = {
    [1] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, inTargetsArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- Focus > Jam if you have a shot
        description = "%s has a shot so focused and jammed.",
        preconditions = { hasShot = true, targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } },
        action = { focus = false, jam = false }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Focus > Rotate to get a shot
        description = "%s focused and rotated to get a shot.",
        preconditions = { hasShot = false },
        action = { focus = false, rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll/Boost > Jam to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled/boosted to avoid %s's arc and jammed to still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false, jam = false },
            [2] = { barrelRoll = false, jam = false }
        },
        postconditions = { hasShot = true, inTargetsArc = false, targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } }
    },
    [6] = { -- Barrel roll/Boost > Rotate to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled/boosted to avoid %s's arc and rotated to still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = false, inTargetsArc = true },
        action = {
            [1] = { boost = false, rotateTurret = { mount = 'main' } },
            [2] = { barrelRoll = false, rotateTurret = { mount = 'main' } }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [7] = { -- Barrel roll/Boost > Jam to get a shot
        description = "%s barrel rolled/boosted and jammed to get a shot.",
        preconditions = { hasShot = false },
        action = {
            [1] = { boost = false, jam = false },
            [2] = { barrelRoll = false, jam = false }
        },
        postconditions = { hasShot = true, targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } }
    },
    [8] = { -- Barrel roll/Boost > Rotate to get a shot
        description = "%s barrel rolled/boosted and rotated to get a shot.",
        preconditions = { hasShot = false },
        action = {
            [1] = { boost = false, rotateTurret = { mount = 'main' } },
            [2] = { barrelRoll = false, rotateTurret = { mount = 'main' } }
        },
        postconditions = { hasShot = true }
    },
    [9] = { -- Barrel roll/Boost > Jam to avoid target's arc
        description = "%s barrel rolled/boosted and jammed to avoid target's arc.",
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false, jam = false },
            [2] = { barrelRoll = false, jam = false }
        },
        postconditions = { inTargetsArc = false, targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } }
    },
    [10] = { -- Barrel roll/Boost > Rotate to avoid target's arc
        description = "%s barrel rolled/boosted and rotated to avoid target's arc.",
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false, rotateTurret = { mount = 'main' } },
            [2] = { barrelRoll = false, rotateTurret = { mount = 'main' } }
        },
        postconditions = { inTargetsArc = false }
    },
    [11] = { -- Evade
        description = "%s evaded.",
        action = 'evade'
    },
}

-- Upsilon-class Shuttle
BehaviourDB.rule_sets[1].ships['upsilonclasscommandshuttle'] = {}
BehaviourDB.rule_sets[1].ships['upsilonclasscommandshuttle'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['upsilonclasscommandshuttle'].action_selection = {}
BehaviourDB.rule_sets[1].ships['upsilonclasscommandshuttle'].move_table = {
    bullseye = {
        near = { [1] = 's0', [3] = 's1', [6] = 's2' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's2', [2] = 's3' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's0', [3] = 'br1', [4] = 's1', [5] = 'tl2', [6] = 'bl3' },
        far = { [1] = 'br1', [2] = 's1', [3] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 's1', [3] = 'br2', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 's0', [2] = 'br1', [3] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'br2', [3] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'br3', [5] = 'tr3' },
        stress = { [1] = 's1', [3] = 'br2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 's0', [3] = 'tr1', [4] = 'br1', [5] = 'tl2', [6] = 'bl3' },
        far = { [1] = 'br1', [2] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'br2', [2] = 'tr2', [5] = 'br3', [6] = 'tr3' },
        stress = { [1] = 's1', [3] = 'br2', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 's0', [2] = 's2', [3] = 'tl2', [4] = 'tr2', [5] = 'bl3', [6] = 'br3' },
        far = { [1] = 'tr1', [2] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr1', [2] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 's2', [3] = 'br2', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['upsilonclasscommandshuttle'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- Reinforce the fore if within arc of two or more enemies in that full arc
        description = "%s reinforced fore.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullfront', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceFore'
    },
    [3] = { -- Reinforce the aft if within arc of two or more enemies in that full arc
        description = "%s reinforced aft.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullback', enemyCount = 2 }, requiredResult = true } },
        action = 'reinforceAft'
    },
    [4] = { -- Focus if have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [5] = { -- Coordinate the nearest friendly (unstressed) ship
        description = { text = "%s coordinated %s.", strings = { 'ship', 'coordinate' } },
        preconditions = { hasCoordinateTarget = true },
        action = 'coordinate'
    },
    [6] = { -- Jam the target
        description = { text = "%s jammed %s.", strings = { 'ship', 'target' } },
        preconditions = { targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } },
        action = 'jam'
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    },
}

-- Xi-class Light Shuttle
BehaviourDB.rule_sets[1].ships['xiclasslightshuttle'] = {}
BehaviourDB.rule_sets[1].ships['xiclasslightshuttle'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['xiclasslightshuttle'].action_selection = {}
BehaviourDB.rule_sets[1].ships['xiclasslightshuttle'].move_table = {
    bullseye = {
        near = { [1] = 's0', [3] = 's1', [6] = 's2' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's0', [3] = 's1', [4] = 'br1', [6] = 'tl2' },
        far = { [1] = 'br1', [2] = 'br2', [4] = 's2', [5] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 's1', [4] = 'br2', [6] = 's2' },
    },
    right_front = {
        near = { [1] = 's0', [2] = 'br1', [4] = 'tl2', [5] = 'tr2' },
        far = { [1] = 'br1', [2] = 'br2', [3] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [5] = 'tr3' },
        stress = { [1] = 'br1', [3] = 's1', [4] = 'br2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 's0', [2] = 's1', [3] = 'tl2', [4] = 'tr2', [6] = 'bl3' },
        far = { [1] = 'br1', [2] = 'br2', [3] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'br2', [2] = 'br3', [3] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'br1', [3] = 's1', [4] = 'br2', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 's0', [3] = 's1', [4] = 'tl2', [5] = 'tr2', [6] = 'br3' },
        far = { [1] = 'br2', [2] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'br2', [2] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 'br1', [2] = 's1', [3] = 'br2', [5] = 's2', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['xiclasslightshuttle'].action_selection = {
    [1] = { -- Focus if have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [2] = { -- Jam the target
        description = { text = "%s jammed %s.", strings = { 'ship', 'target' } },
        preconditions = { targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } },
        action = 'jam'
    },
    [3] = { -- (target not moved) Target lock (stress) if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = { targetLock = true }
    },
    [4] = { -- Coordinate (stress) the nearest friendly (unstressed) ship
        description = { text = "%s coordinated %s.", strings = { 'ship', 'coordinate' } },
        preconditions = { hasCoordinateTarget = true },
        action = { coordinate = true }
    },
    [5] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    },
}

-- TIE/ba Interceptor
BehaviourDB.rule_sets[1].ships['tiebainterceptor'] = {}
BehaviourDB.rule_sets[1].ships['tiebainterceptor'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['tiebainterceptor'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 'bl2s', [4] = 'br2s', [5] = 's2' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [4] = 's3', [6] = 's4' },
    },
    front_right = {
        near = { [1] = 'k5', [3] = 'bl2s', [4] = 'br1', [6] = 'br2' },
        far = { [1] = 'br1', [2] = 's2', [3] = 'br2', [5] = 's3', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [5] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k5', [3] = 'bl2s', [5] = 'tr1' },
        far = { [1] = 'br1', [2] = 'tr1', [3] = 'br2', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br1', [2] = 'tr1', [5] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k5', [3] = 'bl2s', [5] = 'tr1' },
        far = { [1] = 'bl2s', [3] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'bl2s', [3] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [2] = 'tr1', [6] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k5', [3] = 'br2s', [4] = 'bl2s', [6] = 'tr3' },
        far = { [1] = 'k5', [2] = 'bl2s', [4] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'k5', [2] = 'bl2s', [4] = 'tr1' },
        stress = { [1] = 'br1', [2] = 'tr1', [6] = 'br2' },
    },
}
BehaviourDB.rule_sets[1].ships['tiebainterceptor'].action_selection = {
    [1] = { -- (target moved) Focus > Lock (Deplete/Strain) if you have a shot
        description = "%s has a shot so Focused into Target Lock, taking a Strain.",
        preconditions = { ['targetMoved'] = true, hasShot = true, targetLocked = false },
        action = { ['focus'] = false, ['targetLock'] = false, ['strain'] = false }
    },
    [2] = { --  (target moved) Boost or Barrel roll > Lock (Deplete/Strain) to avoid target arc and still get a shot (with the > target lock)
        description = { text = "%s barrel rolled/boosted and target locked to avoid %s's arc and still get a shot, taking a Strain.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, ['targetMoved'] = true, targetLocked = false },
        action = {
            [1] = { ['boost'] = false, ['targetLock'] = false, ['strain'] = false },
            [2] = { ['barrelRoll'] = false, ['targetLock'] = false, ['strain'] = false }
        },
        postconditions = { inTargetsArc = false, hasShot = { arguments = { ['minRange'] = 2 }, requiredResult = true }, targetWithinRange = true },
    },
    [3] = { -- (target moved) Focus > Lock (Deplete/Strain) to get a shot at range 1
        description = "%s focused into a target lock to get a close range shot, taking a Strain.",
        preconditions = { ['targetMoved'] = true, hasShot = { arguments = { maxRange = 1 }, requiredResult = false } },
        action = { ['focus'] = false, ['barrelRoll'] = false, ['strain'] = false },
        postconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } }
    },
    [4] = { -- Boost > barrel roll (Deplete/Strain) to get a shot
        description = "%s boosted into barrel rolled to get a shot, taking a Strain.",
        preconditions = { hasShot = false },
        action = { ['boost'] = false, ['barrelRoll'] = false, ['strain'] = false },
        postconditions = { hasShot = true }
    },
    [5] = { -- (target not moved) Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { ['targetMoved'] = false, hasShot = true, targetLocked = true },
        action = 'focus'
    },
    [6] = { -- (target moved) Barrel roll or boost or Boost > barrel roll (Deplete/Strain) to avoid target's arc
        description = { text = "%s barrel roll/boosted/boosted into barrel roll (taking a Deplete) to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { ['targetMoved'] = true, inTargetsArc = true },
        action = {
            [1] = { ['boost'] = false },
            [2] = { ['barrelRoll'] = false },
            [3] = { ['boost'] = false, ['barrelRoll'] = false, ['deplete'] = false }
        },
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true, hasShot = false },
        action = 'evade'
    },
    [8] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}


----------------------
-- Resistance ships --
----------------------

-- Scavenged YT-1300
BehaviourDB.rule_sets[1].ships['scavengedyt1300lightfreighter'] = {}
BehaviourDB.rule_sets[1].ships['scavengedyt1300lightfreighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['scavengedyt1300lightfreighter'].move_table = {
    bullseye = {
        near = { [1] = 'bl3s', [2] = 'br3s', [3] = 's1', [4] = 'tl3', [5] = 'tr3', [6] = 's4' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's3', [4] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'bl3s', [3] = 'bl2', [4] = 'tl2', [5] = 's3', [6] = 'tr3' },
        far = { [1] = 'br1', [3] = 's1', [4] = 'br2', [6] = 's2' },
        distant = { [1] = 'br3', [5] = 's3', [6] = 's4' },
        stress = { [1] = 'bl2', [3] = 'br2', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'bl3s', [2] = 'bl1', [3] = 'bl2', [4] = 's2', [5] = 'br3', [6] = 'tr3' },
        far = { [1] = 'br1', [2] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'bl2', [3] = 's2', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'bl3s', [3] = 'bl1', [4] = 'tr2', [6] = 'tr3' },
        far = { [1] = 'bl3s', [3] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'bl3s', [3] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 's1', [2] = 'bl2', [4] = 'br2', [6] = 's2' },
    },
    back_right = {
        near = { [1] = 'br3s', [2] = 'bl3s', [4] = 'bl1', [5] = 'tr2' },
        far = { [1] = 'bl3s', [3] = 'tr2', [4] = 'tr3' },
        distant = { [1] = 'bl3s', [3] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 's1', [2] = 'bl2', [4] = 'br2', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['scavengedyt1300lightfreighter'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Rotate turret (stress) to get a shot
        description = "%s rotated its turret to get a shot. Add Stress manually",
        preconditions = { hasShot = false },
        action = { rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [5] = { -- Boost (stress) to get a shot
        description = "%s boosted to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = { boost = true },
        postconditions = { hasShot = true },
    },
    [6] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- T-70 X-Wing
BehaviourDB.rule_sets[1].ships['t70xwing'] = {}
BehaviourDB.rule_sets[1].ships['t70xwing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['t70xwing'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [3] = 's2', [5] = 's3' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [5] = 's1', [6] = 'tr3' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [2] = 's1', [3] = 'br2', [5] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k4', [3] = 'tr3t', [5] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br1', [3] = 'tr2', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k4', [2] = 'tr3t', [5] = 'tr2', [6] = 'tl3' },
        far = { [1] = 'k4', [2] = 'tr3t', [5] = 'tr2' },
        distant = { [1] = 'tr3t', [2] = 'tr2', [3] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br1', [3] = 'tr2', [4] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'tl3t', [4] = 'tr3t', [6] = 'tr3' },
        far = { [1] = 'k4', [2] = 'tr3t', [5] = 'tr3' },
        distant = { [1] = 'tr3t', [3] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 'bl1', [2] = 'br1', [4] = 'bl2', [5] = 'br2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['t70xwing'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Boost to avoid target's arc and still get a shot
        description = { text = "%s boosted to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = true, inTargetsArc = true },
        action = 'boost',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [5] = { -- (target moved) Boost to get a shot
        description = "%s boosted to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = 'boost',
        postconditions = { hasShot = true }
    },
    [6] = { -- (target moved) Boost to avoid target's arc
        description = { text = "%s boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, inTargetsArc = true },
        action = 'boost',
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- BTL-NR2 Y-Wing
BehaviourDB.rule_sets[1].ships['btanr2ywing'] = {}
BehaviourDB.rule_sets[1].ships['btanr2ywing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['btanr2ywing'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [4] = 's4' },
        stress = { [1] = 's1', [4] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 'k5', [3] = 'br1', [5] = 's1', [6] = 'bl3' },
        far = { [1] = 'br1', [2] = 'br2', [4] = 's2', [5] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3', [6] = 's4' },
        stress = { [1] = 'br1', [3] = 's1', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'bl1', [2] = 'br1', [4] = 'bl2', [5] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [5] = 'br2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [5] = 'tr3' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k5', [3] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k5', [2] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'bl1', [2] = 'br1', [5] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k5', [4] = 's1', [5] = 's2', [6] = 'tr2' },
        far = { [1] = 'k5', [3] = 'br1', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'k5', [3] = 'tr2' },
        stress = { [1] = 'bl1', [2] = 'br1', [4] = 's1', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['btanr2ywing'].action_selection = {
    [1] = { --  manual Rotate (upgrade) prompt
        pass_through = true,
        description =
        "If %s has a turret indicator and can get a shot by rotating, then undo the following action and take a Rotate action.",
    },
    [2] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [3] = { -- (target moved) Target lock (stress)
        description = { text = "%s target locked (stress) %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = { targetLock = true }
    },
    [4] = { -- (target moved) Boost (stress) or barrel roll (stress) to get a shot at range 1
        description = "%s barrel rolled/boosted (stress) to get a close range shot.",
        preconditions = { targetMoved = true, hasShot = { arguments = { maxRange = 1 }, requiredResult = false } },
        action = {
            [1] = { boost = true },
            [2] = { barrelRoll = true }
        },
        postconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } },
    },
    [5] = { -- (target moved) Boost (stress) or barrel roll (stress) to get a shot
        description = "%s barrel rolled/boosted (stress) to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = {
            [1] = { boost = true },
            [2] = { barrelRoll = true }
        },
        postconditions = { hasShot = true }
    },
    [6] = { -- Barrel roll (stress) or boost (stress) to avoid target's arc
        description = { text = "%s barrel roll/boosted (stress) to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = true },
            [2] = { barrelRoll = true }
        },
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- MG-100 StarFortress SF-17
BehaviourDB.rule_sets[1].ships['mg100starfortress'] = {}
BehaviourDB.rule_sets[1].ships['mg100starfortress'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['mg100starfortress'].move_table = {
    bullseye = {
        near = { [1] = 's0', [3] = 's1', [4] = 's3', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's2', [2] = 's3' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's0', [3] = 'bl1', [4] = 'br1', [5] = 'bl2', [6] = 'tl2' },
        far = { [1] = 's1', [2] = 'br1', [4] = 's2', [5] = 'br2' },
        distant = { [1] = 'br2', [3] = 's3', [5] = 'br3' },
        stress = { [1] = 's1', [2] = 'bl1', [3] = 'br1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'tr1', [2] = 'bl1', [3] = 'br1', [4] = 'bl2', [5] = 'br2', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr1', [3] = 'tr2', [6] = 'br2' },
        distant = { [1] = 'tr2', [4] = 'br2', [6] = 'br3' },
        stress = { [1] = 'bl1', [3] = 'br1', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 's0', [2] = 'bl1', [3] = 'br1', [4] = 's1', [5] = 'tr2' },
        far = { [1] = 's1', [2] = 'bl1', [3] = 'br1', [5] = 'tr2' },
        distant = { [1] = 'br2', [3] = 'tr2' },
        stress = { [1] = 'bl1', [2] = 's1', [3] = 'br1', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 's0', [2] = 's1', [3] = 'bl1', [4] = 'br1', [5] = 's2', [6] = 'tr2' },
        far = { [1] = 's0', [2] = 's1', [3] = 'br1', [4] = 'tl2', [5] = 'tr2' },
        distant = { [1] = 'br2', [2] = 'tl2', [3] = 'tr2' },
        stress = { [1] = 'bl1', [2] = 'br1', [4] = 's1', [6] = 's2' },
    },
}
BehaviourDB.rule_sets[1].ships['mg100starfortress'].action_selection = {
    [1] = { -- Rotate turret to get a shot
        description = "%s rotated its turret to get a shot.",
        preconditions = { hasShot = false },
        action = { rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [2] = { -- (target not moved) Target lock if not in target's arc
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inTargetsArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [4] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [5] = { --  Reload ordnance if no charges left
        pass_through = true,
        description =
        "If %s has no charges on its missile or torpedo upgrades, then undo the following action and take a Reload action.",
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Resistance Transport
BehaviourDB.rule_sets[1].ships['resistancetransport'] = {}
BehaviourDB.rule_sets[1].ships['resistancetransport'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['resistancetransport'].action_selection = {}
BehaviourDB.rule_sets[1].ships['resistancetransport'].move_table = {
    bullseye = {
        near = { [1] = 's0', [2] = 'bl1r', [3] = 'br1r', [4] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [4] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's0', [2] = 'bl1r', [4] = 'br1', [6] = 's1' },
        far = { [1] = 'br1', [3] = 's1', [4] = 'br2', [6] = 's2' },
        distant = { [1] = 'br2', [3] = 's3', [4] = 'br3', [6] = 's4' },
        stress = { [1] = 'br1', [3] = 's1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 's0', [2] = 'bl1r', [4] = 'tr1', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr1', [3] = 'br2', [4] = 'tr2' },
        distant = { [1] = 'br2', [3] = 'tr2', [6] = 'br3' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 's0', [2] = 'bl1r', [4] = 'br1', [5] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'bl1r', [3] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'bl1r', [3] = 'br2', [4] = 'tr2' },
        stress = { [1] = 's1', [2] = 'br1', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 's0', [2] = 'br1r', [3] = 'bl1r', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 'br1r', [2] = 'bl1r', [4] = 'tl2', [5] = 'tr2' },
        distant = { [1] = 'bl1r', [2] = 'tr1', [3] = 'tr2' },
        stress = { [1] = 'bl1', [2] = 'br1', [5] = 's1', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['resistancetransport'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in target's arc
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inTargetsArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [4] = { -- Focus if have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [5] = { -- Coordinate (stress) the nearest friendly (unstressed) ship
        description = { text = "%s coordinated (stress) %s.", strings = { 'ship', 'coordinate' } },
        preconditions = { hasCoordinateTarget = true },
        action = { coordinate = true }
    },
    [6] = { -- Jam (stress) the target
        description = { text = "%s jammed (stress) %s.", strings = { 'ship', 'target' } },
        preconditions = { targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } },
        action = { jam = true }
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    },
}

-- Resistance Transport Pod
BehaviourDB.rule_sets[1].ships['resistancetransportpod'] = {}
BehaviourDB.rule_sets[1].ships['resistancetransportpod'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['resistancetransportpod'].move_table = {
    bullseye = {
        near = { [1] = 'k3', [2] = 's1', [4] = 's2', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [4] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k3', [3] = 'br1', [5] = 's1', [6] = 'tl2' },
        far = { [1] = 'br1', [2] = 's1', [3] = 'br2', [5] = 's2', [6] = 'br3' },
        distant = { [1] = 'br2', [3] = 's3', [5] = 'br3', [6] = 's4' },
        stress = { [1] = 'br1', [3] = 's1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'k3', [3] = 'br1', [4] = 'tr1', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 'br1', [3] = 'tr1', [4] = 'br2', [5] = 'tr2' },
        distant = { [1] = 'br2', [3] = 'tr2', [6] = 'br3' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k3', [4] = 'tr1', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 'k3', [2] = 'tr1', [4] = 'tr2' },
        distant = { [1] = 'k3', [2] = 'br2', [3] = 'tr2' },
        stress = { [1] = 's1', [2] = 'br1', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k3', [4] = 'tl2', [5] = 'tr2' },
        far = { [1] = 'k3', [3] = 'tr1', [4] = 'tr2' },
        distant = { [1] = 'k3', [2] = 'tr1', [3] = 'tr2' },
        stress = { [1] = 'bl1', [3] = 'br1', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['resistancetransportpod'].action_selection = {
    [1] = { -- Focus/Calc if have a shot
        description = "%s has a shot so focused/calculated.",
        preconditions = { hasShot = true },
        action = 'focuscalculate'
    },
    [2] = { -- (target moved) Target lock (stress)
        description = { text = "%s target locked (stress) %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = { targetLock = true }
    },
    [3] = { -- Barrel roll (stress) to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll (stress) to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Jam (stress) the target
        description = { text = "%s jammed (stress) %s.", strings = { 'ship', 'target' } },
        preconditions = { targetWithinRange = { arguments = { maxRange = 1 }, requiredResult = true } },
        action = { jam = true }
    },
    [7] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    }
}

-- RZ-2 A-Wing
BehaviourDB.rule_sets[1].ships['rz2awing'] = {}
BehaviourDB.rule_sets[1].ships['rz2awing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['rz2awing'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 's2', [4] = 'tl3', [5] = 'tr3', [6] = 's5' },
        far = { [1] = 's2', [4] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [2] = 'bl3', [3] = 'br3', [4] = 's3', [5] = 's4', [6] = 's5' },
    },
    front_right = {
        near = { [1] = 'k5', [2] = 'bl3s', [3] = 'bl3', [4] = 'br3', [5] = 'tr3', [6] = 's4' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [4] = 's4', [6] = 's5' },
        stress = { [1] = 'br2', [3] = 's2', [4] = 'bl3', [5] = 'br3', [6] = 's4' },
    },
    right_front = {
        near = { [1] = 'k5', [2] = 'bl3s', [3] = 'tr1', [5] = 'bl2', [6] = 's3' },
        far = { [1] = 'br2', [3] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br2', [2] = 'tr2', [5] = 'br3', [6] = 's3' },
    },
    right_back = {
        near = { [1] = 'k5', [2] = 'bl3s', [4] = 'tr1', [5] = 'bl2', [6] = 's2' },
        far = { [1] = 'k5', [2] = 'bl3s', [4] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'bl3s', [3] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'bl2', [2] = 'tr2', [6] = 'br3' },
    },
    back_right = {
        near = { [1] = 'k5', [3] = 'br3s', [4] = 'bl3s', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 'k5', [2] = 'bl3s', [4] = 'tl2', [5] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'k5', [2] = 'bl3s', [3] = 'tr1', [4] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 'br2', [2] = 'tl2', [4] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['rz2awing'].action_selection = {
    [1] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, inTargetsArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock > Boost/Rotate (stress) to get a shot
        description = { text = "%s target locked %s and boosted/rotated to get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, inTargetsArc = false, targetWithinRange = true, hasShot = false },
        action = {
            [1] = { targetLock = false, boost = true },
            [2] = { targetLock = true, rotateTurret = { mount = 'main' } }
        },
        postconditions = { hasShot = true, targetWithinRange = true }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Focus > Boost/Rotate (stress) to get a shot
        description = "%s focused and boosted/rotated to get a shot.",
        preconditions = { hasShot = false },
        action = {
            [1] = { focus = false, boost = true },
            [2] = { focus = true, rotateTurret = { mount = 'main' } }
        },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [6] = { -- Barrel roll > Boost/Rotate to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and boosted/rotated to still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = false, inTargetsArc = true },
        action = {
            [1] = { barrelRoll = false, boost = true },
            [2] = { barrelRoll = true, rotateTurret = { mount = 'main' } }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [7] = { -- (target moved) Boost or barrel roll or barrel roll > Boost to get a shot
        description = "%s barrel rolled/boosted or both to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false },
            [3] = { barrelRoll = false, boost = true }
        },
        postconditions = { hasShot = true }
    },
    [8] = { -- (target not moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = false },
        action = 'targetLock'
    },
    [9] = { -- (target not moved) Target lock > Boost/Rotate (stress) to get a shot
        description = { text = "%s target locked %s and boosted/rotated to get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = false },
        action = {
            [1] = { targetLock = false, boost = true },
            [2] = { targetLock = true, rotateTurret = { mount = 'main' } }
        },
        postconditions = { hasShot = true, targetWithinRange = true }
    },
    [10] = { -- Boost or barrel roll or barrel roll > Boost avoid target's arc
        description = "%s barrel rolled/boosted or both to avoid arcs.",
        preconditions = { inEnemyArc = true },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false },
            [3] = { barrelRoll = false, boost = true }
        },
        postconditions = { inEnemyArc = false }
    },
    [11] = { -- Evade
        description = "%s evaded.",
        action = 'evade'
    }
}

-- Fireball
BehaviourDB.rule_sets[1].ships['fireball'] = {}
BehaviourDB.rule_sets[1].ships['fireball'].target_selection = { [1] = 'ClosestInArc', [2] = 'Closest' }
BehaviourDB.rule_sets[1].ships['fireball'].move_table = {
    bullseye = {
        near = { [1] = 's1', [4] = 's2', [5] = 'bl3', [6] = 'br3' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [6] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'tr3t', [2] = 's1', [3] = 'br1', [5] = 'tl2', [6] = 'br3' },
        far = { [1] = 'br1', [3] = 's2', [4] = 'br2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's3', [6] = 's4' },
        stress = { [1] = 'br1', [4] = 's1', [5] = 's2' },
    },
    right_front = {
        near = { [1] = 'tr3t', [3] = 'br1', [4] = 'tr1', [6] = 'br3' },
        far = { [1] = 'br1', [2] = 'br2', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [5] = 'tr3' },
        stress = { [1] = 'br1', [4] = 's1', [5] = 's2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'tr3t', [4] = 'tr1', [6] = 'br3' },
        far = { [1] = 'tr3t', [3] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'tr3t', [3] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 's1', [3] = 'br1', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'tl3t', [2] = 'tr3t', [5] = 'tr2', [6] = 'br3' },
        far = { [1] = 'tr3t', [4] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'tr3t', [3] = 'tr1', [5] = 'tr2' },
        stress = { [1] = 'br1', [5] = 's2', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['fireball'].action_selection = {
    [1] = { -- SLAM if no shot and target outside of range 2
        description = "%s took a SLAM action. Perform the appropriate SLAM movement manually.",
        preconditions = { hasShot = false, targetWithinRange = { arguments = { maxRange = 2 }, requiredResult = false } },
        action = 'disarm'
    },
    [2] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = false },
        postconditions = { hasShot = true }
    },
    [3] = { -- Focus/Calc if have a shot
        description = "%s has a shot so focused/calculated.",
        preconditions = { hasShot = true },
        action = 'focuscalculate'
    },
    [4] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true, hasShot = false },
        action = 'evade'
    },
    [5] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    }
}


--------------------
-- Republic ships --
--------------------

-- BTL-B Y-Wing
BehaviourDB.rule_sets[1].ships['btlbywing'] = {}
BehaviourDB.rule_sets[1].ships['btlbywing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['btlbywing'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [3] = 's1', [6] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [4] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [4] = 's1', [5] = 'bl2', [6] = 'tl2' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'bl1', [3] = 's1', [4] = 'tl2', [5] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [5] = 'br2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [5] = 'tr3' },
        stress = { [1] = 's1', [4] = 's2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'bl1', [4] = 's1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'br1', [3] = 'br2', [4] = 'tr2' },
        distant = { [1] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 's1', [4] = 'tr2', [5] = 's2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 's1', [4] = 'tr2', [6] = 'br3' },
        far = { [1] = 'k4', [3] = 'tr2' },
        distant = { [1] = 'k4', [3] = 'tr2' },
        stress = { [1] = 's1', [4] = 's2', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['btlbywing'].action_selection = {
    [1] = { --  manual Rotate (upgrade) prompt
        pass_through = true,
        description =
        "If %s has a turret indicator and can get a shot by rotating, then undo the following action and take a Rotate action.",
    },
    [2] = { -- Target lock if charges left
        description = { text = "%s target locked %s. If %s has no charges on its missile or torpedo upgrades, then undo this action and perform it manually.", strings = { 'ship', 'target', 'ship' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Focus/Calc if have a shot
        description = "%s has a shot so focused/calculated.",
        preconditions = { hasShot = true },
        action = 'focuscalculate'
    },
    [4] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [5] = { --  Reload ordnance (stress) if no charges left
        pass_through = true,
        description =
        "If %s has no charges on its missile or torpedo upgrades, then undo the following action and take a red Reload action.",
    },
    [6] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    }
}

-- V-19 Torrent Starfighter
BehaviourDB.rule_sets[1].ships['v19torrentstarfighter'] = {}
BehaviourDB.rule_sets[1].ships['v19torrentstarfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['v19torrentstarfighter'].move_table = {
    bullseye = {
        near = { [1] = 'k3', [3] = 's1', [4] = 's2', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [3] = 's2', [6] = 's3' },
    },
    front_right = {
        near = { [1] = 'k3', [3] = 'br1', [5] = 's1', [6] = 'tl2' },
        far = { [1] = 'br1', [2] = 's2', [3] = 'br2', [5] = 's3', [6] = 'br3' },
        distant = { [1] = 's3', [3] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 's1', [4] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k3', [2] = 'tr2t', [3] = 'tr1', [5] = 'br1', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr1', [3] = 'br2', [4] = 'tr2' },
        distant = { [1] = 'br2', [2] = 'tr2', [6] = 'br3' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k3', [3] = 'tr2t', [5] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'k3', [2] = 'tr2t', [4] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'k3', [2] = 'tr2t', [3] = 'br2', [4] = 'tr2' },
        stress = { [1] = 'br1', [5] = 's1', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k3', [2] = 'tl2t', [3] = 'tr2t', [5] = 'tl2', [6] = 'tr2' },
        far = { [1] = 'k3', [3] = 'tr2t', [5] = 'tr2' },
        distant = { [1] = 'k3', [2] = 'tr2t', [3] = 'tr2' },
        stress = { [1] = 'bl1', [2] = 'br1', [5] = 's1', [6] = 's3' },
    },
}
BehaviourDB.rule_sets[1].ships['v19torrentstarfighter'].action_selection = {
    [1] = { -- Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll > Evade (stress) to get a shot and defend
        description = "%s barrel rolled into an evade (stress) to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = false, evade = true },
        postconditions = { hasShot = true, inTargetsArc = true }
    },
    [5] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true }
    },
    [6] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true, hasShot = false },
        action = 'evade'
    },
    [8] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Nimbus-class V-Wing
BehaviourDB.rule_sets[1].ships['nimbusclassvwing'] = {}
BehaviourDB.rule_sets[1].ships['nimbusclassvwing'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['nimbusclassvwing'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [4] = 's2', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [4] = 's3' },
    },
    front_right = {
        near = { [1] = 'k4', [4] = 'br1', [5] = 's2', [6] = 'tr3' },
        far = { [1] = 'br2', [3] = 's2', [5] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4', [6] = 's5' },
        stress = { [1] = 'br2', [3] = 's2', [5] = 's3' },
    },
    right_front = {
        near = { [1] = 'k4', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'br2', [3] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br2', [3] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'k2', [5] = 'tr1', [6] = 'tr3' },
        far = { [1] = 'k4', [2] = 'k2', [4] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'k2', [2] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br2', [3] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'k2', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 'k4', [2] = 'k2', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'k2', [4] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'br2', [2] = 'tl2', [4] = 'tr2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['nimbusclassvwing'].action_selection = {
    [1] = { --  Boost > target lock (stress) to avoid target arc and still get a shot (with the > target lock)
        description = { text = "%s boosted and target locked to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, hasShot = true, targetLocked = false },
        action = { boost = false, targetLock = true },
        postconditions = { inTargetsArc = false, hasShot = true, targetWithinRange = true }
    },
    [2] = { --  Boost > target lock (stress) to avoid target arc and still get a shot (without the > target lock)
        description = { text = "%s boosted to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, hasShot = true, targetLocked = true },
        action = { boost = false },
        postconditions = { inTargetsArc = false, hasShot = true }
    },
    [3] = { --  Boost > target lock (stress) to get a shot (with the > target lock)
        description = "%s boosted and target locked to get a shot.",
        preconditions = { hasShot = false, targetLocked = false },
        action = { boost = false, targetLock = true },
        postconditions = { hasShot = true, targetWithinRange = true }
    },
    [4] = { --  Boost > target lock (stress) to get a shot (without the > target lock)
        description = "%s boosted to get a shot.",
        preconditions = { hasShot = false, targetLocked = true },
        action = { boost = false },
        postconditions = { hasShot = true }
    },
    [5] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        inTargetsArc = false,
        hasShot = true,
        action = 'targetLock'
    },
    [6] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [7] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [8] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Delta-7 Aethersprite
BehaviourDB.rule_sets[1].ships['delta7aethersprite'] = {}
BehaviourDB.rule_sets[1].ships['delta7aethersprite'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['delta7aethersprite'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 'bl2s', [4] = 'br2s', [5] = 's2', [6] = 's5' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [4] = 's3' },
    },
    front_right = {
        near = { [1] = 'k5', [3] = 'bl2s', [5] = 'br1' },
        far = { [1] = 'br1', [2] = 'br2', [4] = 's2', [5] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4', [6] = 's5' },
        stress = { [1] = 'br1', [3] = 'br2', [5] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k5', [2] = 'bl2s', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'br1', [3] = 'br2', [5] = 'tr2' },
        distant = { [1] = 'br2', [2] = 'tr2', [5] = 'br3' },
        stress = { [1] = 'br1', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'bl2s', [5] = 'tr1' },
        far = { [1] = 'k4', [2] = 'bl2s', [4] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'bl2s', [3] = 'tr1', [4] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'tr1', [5] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'bl2s', [5] = 'tr2', [6] = 'br3' },
        far = { [1] = 'k4', [2] = 'bl2s', [4] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'k4', [2] = 'bl2s', [3] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'br1', [2] = 'bl2', [3] = 'br2', [6] = 's3' },
    },
}
BehaviourDB.rule_sets[1].ships['delta7aethersprite'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target not moved) Target lock > Boost (Force) or Target Lock > barrel roll (Force) if not in any arcs
        description = { text = "%s target locked %s and boosted/barrel rolled (Force) to avoid %s's arc and still get a shot.", strings = { 'ship', 'target', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = true, targetWithinRange = true },
        action = {
            [1] = { targetLock = false, boost = false },
            [2] = { targetLock = false, barrelRoll = false }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Focus > boost (Force) or focus > barrel roll (Force) to avoid target's arc and still get a shot
        description = { text = "%s focused and barrel rolled/boosted (Force) to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = {
            [1] = { focus = false, boost = false },
            [2] = { focus = false, barrelRoll = false }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- Boost > barrel roll (Force) or barrel roll > boost (Force) to get a shot
        description = "%s barrel rolled/boosted (Force) to get a shot.",
        preconditions = { hasShot = false },
        action = {
            [1] = { boost = false, barrelRoll = false },
            [2] = { barrelRoll = false, boost = false }
        },
        postconditions = { hasShot = true }
    },
    [5] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [6] = { -- Boost > barrel roll (Force) or barrel roll > boost (Force) to avoid target's arc
        description = { text = "%s barrel rolled > boost/boosted > barrel rolled (Force) to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false, barrelRoll = false },
            [2] = { barrelRoll = false, boost = false }
        },
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [8] = { -- Evade (Force)
        description = "%s evaded (Force).",
        preconditions = { evading = false },
        action = 'evade'
    },
    [9] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Delta-7b Aethersprite
BehaviourDB.rule_sets[1].ships['delta7baethersprite'] = {}
BehaviourDB.rule_sets[1].ships['delta7baethersprite'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['delta7baethersprite'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 'bl2s', [4] = 'br2s', [5] = 's2', [6] = 's5' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [4] = 's3' },
    },
    front_right = {
        near = { [1] = 'k5', [3] = 'bl2s', [5] = 'br1' },
        far = { [1] = 'br1', [2] = 'br2', [4] = 's2', [5] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4', [6] = 's5' },
        stress = { [1] = 'br1', [3] = 'br2', [5] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k5', [2] = 'bl2s', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'br1', [3] = 'br2', [5] = 'tr2' },
        distant = { [1] = 'br2', [2] = 'tr2', [5] = 'br3' },
        stress = { [1] = 'br1', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'bl2s', [5] = 'tr1' },
        far = { [1] = 'k4', [2] = 'bl2s', [4] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'bl2s', [3] = 'tr1', [4] = 'tr2' },
        stress = { [1] = 'br1', [4] = 'tr1', [5] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'bl2s', [5] = 'tr2', [6] = 'br3' },
        far = { [1] = 'k4', [2] = 'bl2s', [4] = 'tr1', [5] = 'tr2' },
        distant = { [1] = 'k4', [2] = 'bl2s', [3] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'br1', [2] = 'bl2', [3] = 'br2', [6] = 's3' },
    },
}
BehaviourDB.rule_sets[1].ships['delta7baethersprite'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target not moved) Target lock > Boost (Force) or Target Lock > barrel roll (Force) if not in any arcs
        description = { text = "%s target locked %s and boosted/barrel rolled (Force) to avoid %s's arc and still get a shot.", strings = { 'ship', 'target', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = true, targetWithinRange = true },
        action = {
            [1] = { targetLock = false, boost = false },
            [2] = { targetLock = false, barrelRoll = false }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Focus > boost (Force) or focus > barrel roll (Force) to avoid target's arc and still get a shot
        description = { text = "%s focused and barrel rolled/boosted (Force) to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = {
            [1] = { focus = false, boost = false },
            [2] = { focus = false, barrelRoll = false }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [4] = { -- Boost > barrel roll (Force) or barrel roll > boost (Force) to get a shot
        description = "%s barrel rolled/boosted (Force) to get a shot.",
        preconditions = { hasShot = false },
        action = {
            [1] = { boost = false, barrelRoll = false },
            [2] = { barrelRoll = false, boost = false }
        },
        postconditions = { hasShot = true }
    },
    [5] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [6] = { -- Boost > barrel roll (Force) or barrel roll > boost (Force) to avoid target's arc
        description = { text = "%s barrel rolled > boost/boosted > barrel rolled (Force) to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false, barrelRoll = false },
            [2] = { barrelRoll = false, boost = false }
        },
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [8] = { -- Evade (Force)
        description = "%s evaded (Force).",
        preconditions = { evading = false },
        action = 'evade'
    },
    [9] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Eta-2 Actis-class Interceptor
BehaviourDB.rule_sets[1].ships['eta2actis'] = {}
BehaviourDB.rule_sets[1].ships['eta2actis'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['eta2actis'].action_selection = {}
BehaviourDB.rule_sets[1].ships['eta2actis'].move_table = {
    bullseye = {
        near = { [1] = 'k4', [4] = 's2', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [4] = 's3' },
    },
    front_right = {
        near = { [1] = 'k4', [4] = 's2', [5] = 'br2', [6] = 'tl3' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [4] = 's4', [6] = 's5' },
        stress = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k4', [3] = 'tr2t', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'tr2', [5] = 'br2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br2', [5] = 'br3' },
    },
    right_back = {
        near = { [1] = 'k4', [3] = 'tr2t', [5] = 'tr1' },
        far = { [1] = 'k4', [2] = 'tr2t', [4] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'k4', [2] = 'tr2t', [3] = 'tr1', [4] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'tr1', [2] = 'br2', [5] = 'br3' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'tl2t', [4] = 'tr2t', [6] = 'tr3' },
        far = { [1] = 'k4', [2] = 'tr2t', [4] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'k4', [2] = 'tr2t', [4] = 'tr1' },
        stress = { [1] = 'br2', [3] = 'tr2', [4] = 'br3', [6] = 's4' },
    },
}
BehaviourDB.rule_sets[1].ships['eta2actis'].action_selection = {
    [1] = { -- (target moved) Boost or barrel roll to get a shot at range 1
        description = "%s barrel rolled/boosted to get a close range shot.",
        preconditions = { targetMoved = true, hasShot = { arguments = { maxRange = 1 }, requiredResult = false } },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } },
    },
    [2] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [3] = { -- (target moved) Boost or barrel roll to get a shot
        description = "%s barrel rolled/boosted to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { hasShot = true },
    },
    [4] = { -- Barrel roll or boost to avoid target's arc
        description = { text = "%s barrel roll/boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { inTargetsArc = false },
    },
    [5] = { -- Evade
        description = "%s evaded.",
        preconditions = { evading = false },
        action = 'evade'
    },
    [6] = { -- (target moved) Target lock (Force)
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- LAAT/i Gunship
BehaviourDB.rule_sets[1].ships['laatigunship'] = {}
BehaviourDB.rule_sets[1].ships['laatigunship'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['laatigunship'].move_table = {
    bullseye = {
        near = { [1] = 's0', [2] = 's1', [3] = 'tl2', [4] = 'tr2', [5] = 'bl3', [6] = 'br3' },
        far = { [1] = 's1', [3] = 's2', [6] = 's3' },
        distant = { [1] = 's3', [4] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 's0', [2] = 'bl1', [3] = 's1', [4] = 'tl2', [5] = 'tr2', [6] = 'bl3' },
        far = { [1] = 's1', [2] = 'br1', [3] = 's2', [4] = 'br2', [6] = 'br3' },
        distant = { [1] = 'br3', [5] = 's3' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'bl1', [2] = 'br1', [3] = 's1', [4] = 'bl2', [5] = 'br2', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [5] = 'br2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [5] = 'tr3' },
        stress = { [1] = 's1', [3] = 's2', [6] = 'bl2' },
    },
    right_back = {
        near = { [1] = 's0', [2] = 'bl1', [3] = 'br1', [4] = 's1', [5] = 'tr2' },
        far = { [1] = 's1', [2] = 'bl1', [3] = 'br1', [4] = 'tr2' },
        distant = { [1] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 's1', [4] = 's2', [6] = 'bl2' },
    },
    back_right = {
        near = { [1] = 's0', [2] = 's1', [3] = 'bl1', [4] = 'tr2', [6] = 's2' },
        far = { [1] = 's0', [2] = 's1', [4] = 'bl1', [5] = 'tr2' },
        distant = { [1] = 'tr2', [6] = 'br3' },
        stress = { [1] = 's1', [4] = 's2', [6] = 'br3' },
    },
}
BehaviourDB.rule_sets[1].ships['laatigunship'].action_selection = {
    [1] = { -- Rotate turret to get a shot
        description = "%s rotated its turret to get a shot.",
        preconditions = { hasShot = false },
        action = { rotateTurret = { mount = 'main' } },
        postconditions = { hasShot = true },
    },
    [2] = { -- (target not moved) Target lock if not in target's arc
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inTargetsArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [4] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [5] = { --  Reload ordnance if no charges left
        pass_through = true,
        description =
        "If %s has no charges on its missile or torpedo upgrades, then undo the following action and take a Reload action.",
    },
    [6] = { -- Reinforce (stress) the fore if within arc of two or more enemies in that full arc
        description = "%s reinforced (stress) fore.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullfront', enemyCount = 2 }, requiredResult = true } },
        action = { ['reinforceFore'] = true }
    },
    [7] = { -- Reinforce (stress) the aft if within arc of two or more enemies in that full arc
        description = "%s reinforced (stress) aft.",
        preconditions = { inEnemyArc = { arguments = { arc = 'fullback', enemyCount = 2 }, requiredResult = true } },
        action = { ['reinforceAft'] = true }
    },
    [8] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Naboo Royal N-1 Starfighter
BehaviourDB.rule_sets[1].ships['nabooroyaln1starfighter'] = {}
BehaviourDB.rule_sets[1].ships['nabooroyaln1starfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['nabooroyaln1starfighter'].action_selection = {}
BehaviourDB.rule_sets[1].ships['nabooroyaln1starfighter'].move_table = {
    bullseye = {
        near = { [1] = 's1', [3] = 's2', [4] = 'tl3', [5] = 'tr3', [6] = 's5' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [4] = 's3' },
    },
    front_right = {
        near = { [1] = 'br1', [2] = 's1', [3] = 's2', [4] = 'bl3', [5] = 'tl3', [6] = 's5' },
        far = { [1] = 'br1', [2] = 's2', [3] = 'br2', [5] = 's3', [6] = 'br3' },
        distant = { [1] = 'br3', [4] = 's4', [6] = 's5' },
        stress = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'tr3t', [3] = 'br1', [4] = 'tr2', [5] = 'br3', [6] = 'tr3' },
        far = { [1] = 'br1', [2] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br2', [4] = 'tr2', [5] = 'br3' },
    },
    right_back = {
        near = { [1] = 'tr3t', [4] = 'tr2', [5] = 'br3', [6] = 'tr3' },
        far = { [1] = 'tr3t', [3] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr3t', [2] = 'tr2', [3] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br2', [3] = 'bl3', [4] = 'br3' },
    },
    back_right = {
        near = { [1] = 'tl3t', [2] = 'tr3t', [4] = 'br3', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 'tr3t', [3] = 'tr2', [4] = 'tr3' },
        distant = { [1] = 'tr3t', [3] = 'tr2', [5] = 'tr3' },
        stress = { [1] = 'br2', [3] = 'bl3', [4] = 'br3', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['nabooroyaln1starfighter'].action_selection = {
    [1] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Boost or barrel roll to get a shot at range 1
        description = "%s barrel rolled/boosted to get a close range shot.",
        preconditions = { targetMoved = true, hasShot = { arguments = { maxRange = 1 }, requiredResult = false } },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } },
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- (target moved) Boost or barrel roll to get a shot
        description = "%s barrel rolled/boosted to get a shot.",
        preconditions = { targetMoved = true, hasShot = false },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { hasShot = true },
    },
    [5] = { -- Barrel roll or boost to avoid target's arc
        description = { text = "%s barrel roll/boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { inTargetsArc = false },
    },
    [6] = { -- Evade, if not already
        description = "%s evaded.",
        preconditions = { evading = false },
        action = 'evade'
    },
    [7] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}
BehaviourDB.rule_sets[1].ships['nabooroyaln1starfighter'].special_rules = { 'fullThrottle' }


-- Clone Z-95 Headhunter.
BehaviourDB.rule_sets[1].ships['clonez95headhunter'] = {}
BehaviourDB.rule_sets[1].ships['clonez95headhunter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['clonez95headhunter'].action_selection = {}
BehaviourDB.rule_sets[1].ships['clonez95headhunter'].move_table = {
    bullseye = {
        near = { [1] = 'k3', [3] = 's1', [5] = 's2' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [4] = 's2' },
    },
    front_right = {
        near = { [1] = 'k4', [3] = 'br1', [6] = 'br2' },
        far = { [1] = 'br2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [3] = 'br2', [4] = 's2' },
    },
    right_front = {
        near = { [1] = 'k4', [2] = 'k3', [4] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr2', [4] = 'br2' },
    },
    right_back = {
        near = { [1] = 'k3', [4] = 'br1', [5] = 'tr2' },
        far = { [1] = 'k4', [2] = 'k3', [5] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr3' },
        stress = { [1] = 'tr2', [3] = 'br2' },
    },
    back_right = {
        near = { [1] = 'k4', [3] = 'k3', [5] = 'tr2' },
        far = { [1] = 'k3', [3] = 'tr2' },
        distant = { [1] = 'k3', [4] = 'tr2' },
        stress = { [1] = 's1', [3] = 'br2', [6] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['clonez95headhunter'].action_selection = {
    [1] = { -- Target lock if not in enemy's arc
        description = { text = "%s target locked %s outside target's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, inEnemyArc = false, targetWithinRange = true, hasShot = true },
        action = 'targetLock'
    },
    [2] = { -- Barrel roll (stress) to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll (stress) to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}


---------------
-- CIS ships --
---------------

-- Hyena-class Droid Bomber
BehaviourDB.rule_sets[1].ships['hyenaclassdroidbomber'] = {}
BehaviourDB.rule_sets[1].ships['hyenaclassdroidbomber'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['hyenaclassdroidbomber'].move_table = {
    bullseye = {
        near = { [1] = 's1', [3] = 's2', [4] = 'tl2', [5] = 'tr2', [6] = 's4' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [4] = 's5' },
        stress = { [1] = 's2', [4] = 's3' },
    },
    front_right = {
        near = { [1] = 'k2', [2] = 's1', [3] = 'br1', [5] = 'tl2', [6] = 'tr3' },
        far = { [1] = 'br1', [2] = 's2', [3] = 'br2', [6] = 's3' },
        distant = { [1] = 'br2', [4] = 's4', [6] = 's5' },
        stress = { [1] = 's2', [4] = 'tl2', [5] = 's3' },
    },
    right_front = {
        near = { [1] = 'k2', [2] = 'tr2t', [3] = 'br1', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'br2', [2] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'br2', [2] = 'tr2', [3] = 'tr3' },
        stress = { [1] = 'tr1', [2] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k2', [3] = 'tr2t', [5] = 'tr1' },
        far = { [1] = 'k2', [2] = 'tr2t', [4] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'tr2t', [2] = 'tr2', [3] = 'tr3' },
        stress = { [1] = 'tr1', [2] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k2', [3] = 'tl2t', [4] = 'tr2t', [6] = 'tl3' },
        far = { [1] = 'k2', [3] = 'tr2t', [6] = 'tr3' },
        distant = { [1] = 'k2', [2] = 'tr2t', [4] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'tr1', [2] = 'tl2', [3] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['hyenaclassdroidbomber'].action_selection = {
    [1] = { --  Barrel roll > target lock (stress) to avoid target arc and still get a shot (with the > target lock)
        description = { text = "%s barrel rolled and target locked to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, hasShot = true, targetLocked = false },
        action = { barrelRoll = false, targetLock = true },
        postconditions = { inTargetsArc = false, hasShot = true, targetWithinRange = true }
    },
    [2] = { --  Barrel roll > target lock (stress) to avoid target arc and still get a shot (without the > target lock)
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true, hasShot = true, targetLocked = true },
        action = { barrelRoll = false },
        postconditions = { inTargetsArc = false, hasShot = true }
    },
    [3] = { --  Barrel roll > target lock (stress) to get a shot (with the > target lock)
        description = "%s barrel rolled and target locked to get a shot.",
        preconditions = { hasShot = false, targetLocked = false },
        action = { barrelRoll = false, targetLock = true },
        postconditions = { hasShot = true, targetWithinRange = true }
    },
    [4] = { --  Barrel roll > target lock (stress) to get a shot (without the > target lock)
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false, targetLocked = true },
        action = { barrelRoll = false },
        postconditions = { hasShot = true }
    },
    [5] = { -- Calculate if you have a shot
        description = "%s has a shot so calculated.",
        preconditions = { hasShot = true },
        action = 'calculate'
    },
    [6] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [7] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [8] = { --  Reload ordnance if no charges left
        pass_through = true,
        description =
        "If %s has no charges on its missile or torpedo upgrades, then undo the following action and take a red reload action.",
    },
    [9] = { -- Calculate
        description = "%s calculated.",
        action = 'calculate'
    }
}

-- Vulture-class Droid Fighter
BehaviourDB.rule_sets[1].ships['vultureclassdroidfighter'] = {}
BehaviourDB.rule_sets[1].ships['vultureclassdroidfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['vultureclassdroidfighter'].move_table = {
    bullseye = {
        near = { [1] = 's2', [2] = 'tl2', [3] = 'tr2', [4] = 'tl3', [5] = 'tr3', [6] = 's5' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [4] = 's3', [6] = 's4' },
    },
    front_right = {
        near = { [1] = 's2', [2] = 'br2', [3] = 'tl3', [4] = 'tr3', [5] = 's4', [6] = 's5' },
        far = { [1] = 's2', [2] = 'br2', [5] = 's3', [6] = 'br3' },
        distant = { [1] = 'br2', [3] = 'br3', [4] = 's4', [5] = 's5' },
        stress = { [1] = 's2', [4] = 's3', [6] = 's4' },
    },
    right_front = {
        near = { [1] = 'k1', [3] = 'tr2t', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'tr2', [5] = 'br2', [6] = 'tr3' },
        distant = { [1] = 'br2', [2] = 'tr2', [3] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'tr1', [2] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k1', [3] = 'tr2t', [5] = 'tr1' },
        far = { [1] = 'k1', [2] = 'tr2t', [4] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'tr2t', [2] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr1', [2] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k1', [3] = 'tl2t', [4] = 'tr2t', [5] = 'tr2', [6] = 'tr3' },
        far = { [1] = 'k1', [2] = 'tr2t', [4] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'k1', [2] = 'tr2t', [3] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'tl2', [3] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['vultureclassdroidfighter'].action_selection = {
    [1] = { -- (target moved) Barrel roll > Calculate (stress) to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled and calculated to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = true, inTargetsArc = true },
        action = { barrelRoll = true, calculate = false },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [2] = { -- (target moved) Barrel roll > Calculate (stress) to get a shot
        description = { text = "%s barrel rolled and calculated to get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = false },
        action = { barrelRoll = true, calculate = false },
        postconditions = { hasShot = true }
    },
    [3] = { -- Calculate if you have a shot
        description = "%s has a shot so calculated.",
        preconditions = { hasShot = true },
        action = 'calculate'
    },
    [4] = { -- (target not moved) Target lock if not in target's arc
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inTargetsArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [5] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        hasShot = true,
        action = 'targetLock'
    },
    [6] = { -- (target moved) Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false },
        hasShot = false
    },
    [7] = { -- Calculate
        description = "%s calculated.",
        action = 'calculate'
    }
}

-- Belbullab-22 Starfighter
BehaviourDB.rule_sets[1].ships['belbulab22starfighter'] = {}
BehaviourDB.rule_sets[1].ships['belbulab22starfighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['belbulab22starfighter'].move_table = {
    bullseye = {
        near = { [1] = 'bl3s', [3] = 'br3s', [5] = 's2', [6] = 's5' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [5] = 's3' },
    },
    front_right = {
        near = { [1] = 'br3s', [2] = 'bl3s', [4] = 'br1', [6] = 's2' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4', [6] = 's5' },
        stress = { [1] = 'br2', [3] = 's2', [5] = 's3' },
    },
    right_front = {
        near = { [1] = 'bl3s', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr2', [4] = 'br2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'br3', [5] = 'tr3' },
        stress = { [1] = 's2', [2] = 'br2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'bl3s', [4] = 'tr1', [6] = 'br3' },
        far = { [1] = 'bl3s', [3] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'bl3s', [3] = 'tr1', [4] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 's2', [2] = 'br2', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'br3s', [2] = 'bl3s', [5] = 'tl2', [6] = 'br3' },
        far = { [1] = 'bl3s', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'bl3s', [3] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'bl2', [2] = 'br2', [5] = 'tr2', [6] = 's3' },
    },
}
BehaviourDB.rule_sets[1].ships['belbulab22starfighter'].action_selection = {
    [1] = { -- Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- Boost or barrel roll > Focus/Calc (stress) to avoid Target arc and still get a shot
        description =
        "%s barrel rolled/boosted into a focus/calculate (stress) to avoid target's arc and still get a shot.",
        preconditions = { hasShot = true, inTargetsArc = true },
        action = {
            [1] = { boost = false, focuscalculate = true },
            [2] = { barrelRoll = false, focuscalculate = true }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- Boost or barrel roll > Focus/Calc (stress) to get a shot at range 1
        description = "%s barrel rolled/boosted into a focus/calculate (stress) to get a close range shot.",
        preconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = false } },
        action = {
            [1] = { boost = false, focuscalculate = true },
            [2] = { barrelRoll = false, focuscalculate = true }
        },
        postconditions = { hasShot = { arguments = { maxRange = 1 }, requiredResult = true } }
    },
    [4] = { -- Boost or barrel roll > Focus/Calc (stress) to get a shot
        description = "%s barrel rolled/boosted into a focus/calculate (stress) to get a shot.",
        preconditions = { hasShot = false },
        action = {
            [1] = { boost = false, focuscalculate = true },
            [2] = { barrelRoll = false, focuscalculate = true }
        },
        postconditions = { hasShot = true }
    },
    [5] = { -- Focus/Calc if you have a shot
        description = "%s has a shot so focused/calculate.",
        preconditions = { hasShot = true },
        action = 'focuscalculate'
    },
    [6] = { -- Barrel roll or boost to avoid target's arc
        description = { text = "%s barrel roll/boosted to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = {
            [1] = { boost = false },
            [2] = { barrelRoll = false }
        },
        postconditions = { inTargetsArc = false }
    },
    [7] = { -- Focus/Calc
        description = "%s focused/calculated.",
        action = 'focuscalculate'
    }
}

-- Droid Tri-Fighter
BehaviourDB.rule_sets[1].ships['droidtrifighter'] = {}
BehaviourDB.rule_sets[1].ships['droidtrifighter'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['droidtrifighter'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [4] = 's2', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [4] = 's3', [6] = 's4' },
    },
    front_right = {
        near = { [1] = 'k5', [3] = 'k3', [4] = 's2', [5] = 'tl3', [6] = 'tr3' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4', [6] = 's5' },
        stress = { [1] = 's2', [4] = 's3', [6] = 's4' },
    },
    right_front = {
        near = { [1] = 'k5', [3] = 'tr1t', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'tr1', [2] = 'tr2', [4] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'tr2', [4] = 'tr3' },
    },
    right_back = {
        near = { [1] = 'k3', [2] = 'tr1t', [5] = 'tr1' },
        far = { [1] = 'k3', [2] = 'tr1t', [4] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'tr1t', [3] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'tr2', [4] = 'tr3' },
    },
    back_right = {
        near = { [1] = 'k3', [2] = 'tl1t', [3] = 'tr1t', [5] = 'tr3' },
        far = { [1] = 'k3', [2] = 'tr1t', [5] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr1t', [3] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'tl2', [2] = 'tr2', [4] = 'tl3', [5] = 'tr3' },
    },
}
BehaviourDB.rule_sets[1].ships['droidtrifighter'].action_selection = {
    [1] = { -- Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Boost > Calculate (stress) to avoid target's arc and still get a shot
        description = { text = "%s boosted and calculated to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = true, inTargetsArc = true },
        action = { boost = true, calculate = true },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [3] = { -- (target moved) Boost > Calculate (stress) to get a shot
        description = { text = "%s boosted and calculated to get a shot.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, hasShot = false },
        action = { boost = false, calculate = true },
        postconditions = { hasShot = true }
    },
    [4] = { -- Calculate if you have a shot
        description = "%s has a shot so calculated.",
        preconditions = { hasShot = true },
        action = 'calculate'
    },
    [5] = { -- Barrel roll to avoid target's arc and still get a shot
        description = { text = "%s barrel rolled to avoid %s's arc and still get a shot.", strings = { 'ship', 'target' } },
        preconditions = { hasShot = true, inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [6] = { -- Barrel roll > Evade (stress) to get a shot and defend
        description = "%s barrel rolled into an evade (stress) to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = false, evade = true },
        postconditions = { hasShot = true, inTargetsArc = true }
    },
    [7] = { -- Barrel roll to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = 'barrelRoll',
        postconditions = { hasShot = true }
    },
    [8] = { -- Barrel roll to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = 'barrelRoll',
        postconditions = { inTargetsArc = false }
    },
    [9] = { -- Evade
        description = "%s evaded.",
        preconditions = { inTargetsArc = true, hasShot = false },
        action = 'evade'
    },
    [10] = { -- Calculate
        description = "%s calculated.",
        action = 'calculate'
    }
}

-- HMP Droid Gunship
BehaviourDB.rule_sets[1].ships['hmpdroidgunship'] = {}
BehaviourDB.rule_sets[1].ships['hmpdroidgunship'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['hmpdroidgunship'].move_table = {
    bullseye = {
        near = { [1] = 's0', [2] = 's1', [3] = 'bl2z', [4] = 'br2z', [5] = 'tl2z', [6] = 'tr2z' },
        far = { [1] = 's1', [2] = 's2', [5] = 's3' },
        distant = { [1] = 's3', [2] = 's4', [4] = 's5' },
        stress = { [1] = 's1', [3] = 's2', [5] = 'tl2z', [6] = 'tr2z' },
    },
    front_right = {
        near = { [1] = 's0', [2] = 's1', [3] = 'bl2z', [5] = 'tr2z', [6] = 'tr3z' },
        far = { [1] = 'bl2z', [2] = 'br2', [4] = 's2', [5] = 'br3', [6] = 's3' },
        distant = { [1] = 'br2', [2] = 'br3', [4] = 's3', [5] = 's4', [6] = 's5' },
        stress = { [1] = 's1', [3] = 's2', [5] = 'tl2z', [6] = 'tr2z' },
    },
    right_front = {
        near = { [1] = 's1', [2] = 'br1', [3] = 'br2z', [4] = 'tr2z', [6] = 'tr2' },
        far = { [1] = 'tr2', [3] = 'br2', [5] = 'tr3' },
        distant = { [1] = 'br2', [2] = 'tr2', [3] = 'br3', [4] = 'tr3' },
        stress = { [1] = 's1', [2] = 'tr2', [5] = 'tr2z' },
    },
    right_back = {
        near = { [1] = 'br2z', [2] = 'tr2', [4] = 'tr2z', [6] = 'tr3z' },
        far = { [1] = 'tr2', [4] = 'tr2z', [6] = 'tr3' },
        distant = { [1] = 'tr2', [3] = 'tr2z', [4] = 'tr3' },
        stress = { [1] = 'tr2', [5] = 'tr2z' },
    },
    back_right = {
        near = { [1] = 'tr2z', [4] = 'tl3z', [5] = 'tr3z' },
        far = { [1] = 'tr2', [2] = 'tr2z', [5] = 'tr3z' },
        distant = { [1] = 'tr2', [3] = 'tr2z', [5] = 'tr3z' },
        stress = { [1] = 'tr2', [3] = 'tl2z', [4] = 'tr2z' },
    },
}
BehaviourDB.rule_sets[1].ships['hmpdroidgunship'].special_move_difficulties = {
    bl1z = 'r',
    br1z = 'r',
    bl2z = 'w',
    br2z = 'w',
    bl3z = 'r',
    br3z = 'r',
    tl2z = 'b',
    tr2z = 'b',
    tl3z = 'w',
    tr3z = 'w',
}

BehaviourDB.rule_sets[1].ships['hmpdroidgunship'].action_selection = {
    [1] = { -- Target lock if charges left
        description = { text = "%s target locked %s. If %s has no charges on its missile or torpedo upgrades, then undo this action and perform it manually.", strings = { 'ship', 'target', 'ship' } },
        preconditions = { targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { --  Reload > Calculate (stress) if no charges left and defending
        pass_through = true,
        description = "If %s has no charges on its missile or torpedo upgrades, take a Reload action.",
        preconditions = { hasShot = false, inTargetsArc = true },
        action = { calculate = true }
    },
    [3] = { -- Calculate if you have a shot
        description = "%s has a shot so calculated.",
        preconditions = { hasShot = true },
        action = 'calculate'
    },
    [4] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [5] = { --  Reload ordnance (stress) if no charges left
        pass_through = true,
        description = "If %s has no charges on its missile or torpedo upgrades, take a Reload action.",
        preconditions = { hasShot = false }
    },
    [6] = { -- Calculate
        description = "%s calculated.",
        action = 'calculate'
    }
}

-- Sith Infiltrator
BehaviourDB.rule_sets[1].ships['sithinfiltrator'] = {}
BehaviourDB.rule_sets[1].ships['sithinfiltrator'].target_selection = {
    [1] = 'LockedInRange',
    [2] = 'ClosestInArcLowerInitiative',
    [3] = 'ClosestInArc',
    [4] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['sithinfiltrator'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 'br2s', [4] = 'bl2s', [5] = 's1', [6] = 's4' },
        far = { [1] = 's1', [4] = 's2' },
        distant = { [1] = 's3', [2] = 's4' },
        stress = { [1] = 's1', [3] = 's2', [5] = 's3' },
    },
    front_right = {
        near = { [1] = 'k5', [3] = 'bl2s', [5] = 'br1', [6] = 's1' },
        far = { [1] = 'br1', [3] = 's1', [4] = 'br2', [6] = 's2' },
        distant = { [1] = 'br3', [5] = 's4' },
        stress = { [1] = 'br1', [2] = 's1', [3] = 'br2', [5] = 's2', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k5', [2] = 'bl2s', [5] = 'br1', [6] = 'tr1' },
        far = { [1] = 'br1', [2] = 'tr1', [3] = 'br2', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br1', [4] = 'br2', [6] = 'tr2' },
    },
    right_back = {
        near = { [1] = 'k5', [3] = 'bl2s', [6] = 'br3' },
        far = { [1] = 'k5', [2] = 'bl2s', [4] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'bl2s', [2] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [4] = 'br2', [6] = 'tr2' },
    },
    back_right = {
        near = { [1] = 'k5', [3] = 'br2s', [4] = 'bl2s', [6] = 'tr3' },
        far = { [1] = 'k5', [2] = 'bl2s', [4] = 'tr2', [5] = 'tr3' },
        distant = { [1] = 'bl2s', [2] = 'tr1', [3] = 'tr2', [6] = 'tr3' },
        stress = { [1] = 'br1', [3] = 'bl2', [4] = 'br2', [6] = 'tr2' },
    },
}
BehaviourDB.rule_sets[1].ships['sithinfiltrator'].action_selection = {
    [1] = { -- (target not moved) Target lock if not in any arcs
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = false, targetLocked = false, inEnemyArc = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [2] = { -- (target moved) Target lock
        description = { text = "%s target locked %s.", strings = { 'ship', 'target' } },
        preconditions = { targetMoved = true, targetLocked = false, targetWithinRange = true },
        action = 'targetLock'
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Barrel roll (stress) to get a shot
        description = "%s barrel rolled to get a shot.",
        preconditions = { hasShot = false },
        action = { barrelRoll = true },
        postconditions = { hasShot = true }
    },
    [5] = { -- Barrel roll (stress) to avoid target's arc
        description = { text = "%s barrel rolled to avoid %s's arc.", strings = { 'ship', 'target' } },
        preconditions = { inTargetsArc = true },
        action = { barrelRoll = true },
        postconditions = { inTargetsArc = false }
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    }
}

-- Nantex-class Starfighter
BehaviourDB.rule_sets[1].ships['nantexclassstarfighter'] = {}
BehaviourDB.rule_sets[1].ships['nantexclassstarfighter'].target_selection = {
    [1] = 'ClosestInArcLowerInitiative',
    [2] = 'ClosestInArc',
    [3] = 'Closest'
}
BehaviourDB.rule_sets[1].ships['nantexclassstarfighter'].move_table = {
    bullseye = {
        near = { [1] = 'k5', [3] = 'bl3s', [4] = 'br3s', [5] = 'bl2', [6] = 'br2' },
        far = { [1] = 's2', [5] = 's3' },
        distant = { [1] = 's4', [2] = 's5' },
        stress = { [1] = 's2', [4] = 's3' },
    },
    front_right = {
        near = { [1] = 'k5', [2] = 'bl3s', [3] = 'br1', [4] = 'tr1', [6] = 's2' },
        far = { [1] = 'br2', [3] = 's2', [4] = 'br3', [6] = 's3' },
        distant = { [1] = 'br3', [5] = 's4', [6] = 's5' },
        stress = { [1] = 'br1', [2] = 'br2', [4] = 's2', [5] = 'br3', [6] = 's3' },
    },
    right_front = {
        near = { [1] = 'k5', [2] = 'bl3s', [3] = 'br1', [4] = 'tr1', [5] = 'br2', [6] = 'tr2' },
        far = { [1] = 'br1', [2] = 'tr1', [3] = 'br2', [4] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'tr2', [2] = 'br3', [4] = 'tr3' },
        stress = { [1] = 'br1', [3] = 'br2', [5] = 'br3' },
    },
    right_back = {
        near = { [1] = 'k5', [2] = 'bl3s', [3] = 'br1', [4] = 'tr1', [6] = 'tr2' },
        far = { [1] = 'bl3s', [2] = 'br1', [3] = 'tr1', [6] = 'tr2' },
        distant = { [1] = 'bl3s', [2] = 'tr2', [4] = 'tr3' },
        stress = { [1] = 'br1', [4] = 'br2', [6] = 'br3' },
    },
    back_right = {
        near = { [1] = 'k5', [2] = 'bl3s', [3] = 'br3s', [4] = 'tr1', [5] = 'tr2', [6] = 'tr3' },
        far = { [1] = 'k5', [2] = 'bl3s', [3] = 'tr1', [5] = 'tr2', [6] = 'tr3' },
        distant = { [1] = 'k5', [2] = 'bl3s', [3] = 'tr1', [6] = 'tr2' },
        stress = { [1] = 'br1', [3] = 'tr1', [4] = 'br2', [6] = 'br3' },
    },
}
BehaviourDB.rule_sets[1].ships['nantexclassstarfighter'].action_selection = {
    --[1] = { --  manual Tractor/Rotate prompt
    --    pass_through = true,
    --    description = "If %s can get a shot with Pinpoint Tractor Array, then take a Tractor token and Rotate action.",
    --},
    [1] = { -- Tractor(br)/Rotate
        description =
        "%s can avoid target arc and get a shot with Pinpoint Tractor Array by focusing and tractoring and rotating.",
        preconditions = { hasShot = false, inTargetsArc = true },
        action = {
            [1] = { focus = false, tractorSelf = false, rotateTurret = { mount = 'main' } },
            [2] = { focus = false, barrelRoll = false, tractorSelf = false, rotateTurret = { mount = 'main' } },
            [3] = { focus = false, boost = false, tractorSelf = false, rotateTurret = { mount = 'main' } }
        },
        postconditions = { hasShot = true, inTargetsArc = false }
    },
    [2] = { -- Tractor(br)/Rotate
        description = "%s can get a shot with Pinpoint Tractor Array by focusing and tractoring and rotating.",
        preconditions = { hasShot = false },
        action = {
            [1] = { focus = false, tractorSelf = false, rotateTurret = { mount = 'main' } },
            [2] = { focus = false, barrelRoll = false, tractorSelf = false, rotateTurret = { mount = 'main' } },
            [3] = { focus = false, boost = false, tractorSelf = false, rotateTurret = { mount = 'main' } }
        },
        postconditions = { hasShot = true }
    },
    [3] = { -- Focus if you have a shot
        description = "%s has a shot so focused.",
        preconditions = { hasShot = true },
        action = 'focus'
    },
    [4] = { -- Tractor(br)/Rotate
        description = "%s can avoid enemy arc with Pinpoint Tractor Array by evading and tractoring and rotating.",
        preconditions = { inEnemyArc = true },
        action = {
            [1] = { evade = false, tractorSelf = false, rotateTurret = { mount = 'main' } },
            [2] = { evade = false, barrelRoll = false, tractorSelf = false, rotateTurret = { mount = 'main' } },
            [3] = { evade = false, boost = false, tractorSelf = false, rotateTurret = { mount = 'main' } }
        },
        postconditions = { inEnemyArc = false }
    },
    [5] = { -- Evade
        description = "%s evaded.",
        preconditions = { inEnemyArc = true },
        action = 'evade'
    },
    [6] = { -- Focus
        description = "%s focused.",
        action = 'focus'
    },
}

return BehaviourDB
