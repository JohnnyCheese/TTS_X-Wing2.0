local ObjectiveTokenData = require("Marker.Scenario.ObjectiveTokenData")
local Vect = require("TTS_Lib.Vector.Vector")
local Dim = require("Dim")

ArcCheck = {}
ArcCheck.initialized = false
ArcCheck.arc_check_rulers = {}
ArcCheck.current_arc = "none"

ArcCheck.model_cache = {}

ArcCheck.arc_line_segments = {}
ArcCheck.arc_line_segments.small = {}
ArcCheck.arc_line_segments.medium = {}
ArcCheck.arc_line_segments.large = {}
ArcCheck.arc_line_segments.huge = {}
ArcCheck.arc_line_segments.objective = {}

ArcCheck.bullseye_data = {
    pos = {
        small = Vector(0, 0, Dim.Convert_mm_igu(170)),
        medium = Vector(0, 0, Dim.Convert_mm_igu(180)),
        large = Vector(0, 0, Dim.Convert_mm_igu(190)),
        huge = Vector(0, 0, Dim.Convert_mm_igu(110.5)),
        objective = nil
    },
    size = Vector(Dim.Convert_mm_igu(14), 0.1, Dim.Convert_mm_igu(300))
}

ArcCheck.Initialize = function()
    -- Arc values based on Muon's assessments (vassal)
    if ArcCheck.initialized == false then
        ArcCheck.CalculateArcLineSegments(ArcCheck.arc_line_segments.small, 81.24, 20, 20)
        ArcCheck.CalculateArcLineSegments(ArcCheck.arc_line_segments.medium, 82.8, 30, 30)
        ArcCheck.CalculateArcLineSegments(ArcCheck.arc_line_segments.large, 83.52, 40, 40)
        ArcCheck.CalculateArcLineSegments(ArcCheck.arc_line_segments.huge, 82.9, 40, 110.5)
        ArcCheck.arc_line_segments.objective = ObjectiveTokenData.arc_line_segments
        ArcCheck.initialized = true
    end
end

--[[ArcCheck.Initialize = function() -- Arc values matching TTS ruler objects
    if ArcCheck.initialized == false then
        ArcCheck.CalculateArcLineSegments(ArcCheck.arc_line_segments.small, 79.1, 20, 20)
        ArcCheck.CalculateArcLineSegments(ArcCheck.arc_line_segments.medium, 82.35, 30, 30)
        ArcCheck.CalculateArcLineSegments(ArcCheck.arc_line_segments.large, 82.9, 40, 40)
        ArcCheck.CalculateArcLineSegments(ArcCheck.arc_line_segments.huge, 82.9, 40, 110.5 )
        ArcCheck.initialized = true
    end
end]]


ArcCheck.CalculateArcLineSegments = function(table, degree, size_w, size_l)
    size_w = Dim.Convert_mm_igu(size_w)
    size_l = Dim.Convert_mm_igu(size_l)
    local edge_arc = Vect.AngleDeg2D({ -size_w, 0, size_l }, { size_w, 0, size_l })
    --print("Size_W:" .. tostring(size_w) .. " size_l:"..size_l .. " edge_arc=".. tostring(edge_arc))
    if size_w == size_l then
        -- Rectangular base sizes (small, medium and large ships)
        --print("Rectangular:".. tostring(size_w)..","..tostring(size_l))
        local r = math.rad(degree / 2)
        local a = math.tan(r) * size_l
        table.front = {
            segments = { { Vector(-a, 0, size_l), Vector(a, 0, size_l) } }, -- Front segment
            degrees = { direction = 0, spread = degree / 2 }
        }
        table.back = {
            segments = { { Vector(-a, 0, -size_l), Vector(a, 0, -size_l) } }, -- Front segment
            degrees = { direction = 180, spread = degree / 2 }
        }
        table.left = {
            segments = { { Vector(-a, 0, -size_l), Vector(-size_w, 0, -size_l) }, -- back segment
                { Vector(-size_w, 0, -size_l), Vector(-size_w, 0, size_l) },      -- left edge
                { Vector(-size_w, 0, size_l),  Vector(-a, 0, size_l) }            -- front segment
            },
            degrees = { direction = -90, spread = (180 - degree) / 2 }
        }
        table.right = {
            segments = { { Vector(a, 0, -size_l), Vector(size_w, 0, -size_l) }, -- back segment
                { Vector(size_w, 0, -size_l), Vector(size_w, 0, size_l) },      -- right edge
                { Vector(size_w, 0, size_l),  Vector(a, 0, size_l) }            -- front segment
            },
            degrees = { direction = 90, spread = (180 - degree) / 2 }
        }
    else
        -- Long base size (huge ships)
        --print("Long:".. tostring(size_w)..","..tostring(size_l))
        local r = math.rad(90 - degree / 2)
        local a = math.tan(r) * size_w
        table.front = {
            segments = { { Vector(-size_w, 0, a), Vector(-size_w, 0, size_l) }, -- left segment
                { Vector(-size_w, 0, size_l), Vector(size_w, 0, size_l) },      -- front edge
                { Vector(size_w, 0, size_l),  Vector(size_w, 0, a) } },         -- right segment
            degrees = { direction = 0, spread = degree / 2 }
        }
        table.back = {
            segments = { { Vector(-size_w, 0, -a), Vector(-size_w, 0, -size_l) }, -- left segment
                { Vector(-size_w, 0, -size_l), Vector(size_w, 0, -size_l) },      -- back edge
                { Vector(size_w, 0, -size_l),  Vector(size_w, 0, -a) } },         -- right segment
            degrees = { direction = 180, spread = degree / 2 }
        }
        table.left = {
            segments = { { Vector(-size_w, 0, -a), Vector(-size_w, 0, a) } }, -- left segment
            degrees = { direction = -90, spread = (180 - degree) / 2 }
        }
        table.right = {
            segments = { { Vector(size_w, 0, -a), Vector(size_w, 0, a) } }, -- right segment
            degrees = { direction = 90, spread = (180 - degree) / 2 }
        }
    end
    table.bullseye = {
        segments = { { Vector(-ArcCheck.bullseye_data.size[1] / 2, 0, size_l), Vector(ArcCheck.bullseye_data.size[1] / 2, 0, size_l) } }, -- Bullseye segments
        degrees = { direction = 0, spread = 0, bullseye = true }
    }
    table.fullfront = {
        segments = { { Vector(-size_w, 0, 0), Vector(-size_w, 0, size_l) }, -- left segment
            { Vector(-size_w, 0, size_l), Vector(size_w, 0, size_l) },      -- front edge
            { Vector(size_w, 0, size_l),  Vector(size_w, 0, 0) }            -- right segment
        },
        degrees = { direction = 0, spread = 90 }
    }
    table.fullback = {
        segments = { { Vector(-size_w, 0, 0), Vector(-size_w, 0, -size_l) }, -- left segment
            { Vector(-size_w, 0, -size_l), Vector(size_w, 0, -size_l) },     -- back edge
            { Vector(size_w, 0, -size_l),  Vector(size_w, 0, 0) }            -- right segment
        },
        degrees = { direction = 180, spread = 90 }
    }
    table.full = {
        segments = { { Vector(-size_w, 0, size_l), Vector(size_w, 0, size_l) }, -- front edge
            { Vector(size_w, 0, size_l),   Vector(size_w, 0, -size_l) },        -- right edge
            { Vector(size_w, 0, -size_l),  Vector(-size_w, 0, -size_l) },       -- back edge
            { Vector(-size_w, 0, -size_l), Vector(-size_w, 0, size_l) }         -- left edge
        },
        degrees = { direction = 0, spread = 180 }
    }
end

function ArcCheck.CheckArc(args)
    -- Remove player selection to prevent accidental deletion.
    local playerColors = getSelectingPlayers(args.ship)
    for _, player in ipairs(playerColors) do
        args.ship.removeFromPlayerSelection(player.color)
    end

    range = args.range or 3
    -- Iterate over the potential targets and display their statuses.
    local spawnedRulers = {}
    if args.arctype ~= "full" then
        printToAll(args.ship.getName() .. ' checks for targets in the ' .. args.arctype .. ' arc:', Color(1.0, 1.0, 0.2, 0.9))
    end
    targets = ArcCheck.GetTargetsInRelationToArc(args.ship, args.arctype, nil, range, args.include_friendly_ships)

    table.sort(targets, ArcCheck.SortTargetsByDesirability)
    local found = false
    for _, target in pairs(targets) do
        ship = target.ship
        if target.in_arc == false then
            printToAll(' - ' .. ship.getName() .. ' not in arc')
        elseif target.closest.range > range then
            printToAll(' - ' .. ship.getName() .. ' not in range (' .. range .. ')')
        else
            found = true
            ship.setLock(true)
            table.insert(spawnedRulers, ArcCheck.SpawnObstructionRuler(target.closest))
            if target.other_closest ~= nil then
                table.insert(spawnedRulers, ArcCheck.SpawnObstructionRuler(target.other_closest))
            end

            if args.arctype == "full" then
                printToAll(" - " .. ship.getName() .. " in range", Color(1.0, 1.0, 0.2, 0.9))
            else
                obstructedtext = ' is'
                if (target.obstructed == 'likely_unobstructed') then
                    obstructedtext = ' is most likely UNOBSTRUCTED'
                elseif (target.obstructed == 'obstructed') then
                    obstructedtext = ' is OBSTRUCTED'
                elseif (target.obstructed == 'likely_obstructed') then
                    obstructedtext = ' is most likely OBSTRUCTED'
                elseif (target.obstructed == 'chosen_obstructed') then
                    obstructedtext = ' can be chosen to be OBSTRUCTED'
                end

                multipletext = ''
                if target.multiple_points == true then
                    multipletext = ' has multiple closest points and'
                end

                bullseyetext = ''
                if target.bullseye == true then
                    bullseyetext = ' in bullseye'
                end
                printToAll( " - " ..  ship.getName() ..  multipletext .. obstructedtext ..
                    ' at range ' .. tostring(target.closest.range) .. bullseyetext, Color(1.0, 1.0, 0.2, 0.9))
            end
        end
    end

    if found == false then
        printToAll(' - No valid targets', Color(1.0, 1.0, 0.2, 0.9))
    end
    return spawnedRulers
end

--[[ GetTargetsInRelationToArc
This function returns a table containing all non-friendly ships within 900mm and
information based on the provided arc type for each one.

ship: TTS Object, the ship whose arc will be tested.
arc: Table or String. The arc/s of the ship being tested. If a string, it is an
    arc description such as 'front', 'bullseye', etc. See DataPad for full list.
    If a table, it is a list of arc descriptions. Note that a single string
    is expanded (so "frontback" becomes "front", "back"), but table entries are
    not.
fixed_targets: [optional]A list of TTS Objects, if passed in these are the only
    ships that will be checked.

returns a table of targets, each containing the following:
    ship: TTS Object, the ship being targetted
    bullseye: Boolean, true if the target is in the ship's bullseye
    closest: Table, the closest points and the range between the ship and the
        target. See ArcCheck.GetDistanceBetweenLineSegments
    in_arc: Boolean, true if the target is in the specified arc.
    obstructed: String, the state of the obstruction between the ship and the
        target. One of:
        - 'unobstructed' (no obstruction)
        - 'obstructed' (definite obstruction)
        - 'likely_unobstructed' (multiple points, but none are obstructed)
        - 'likely_obstructed' (multiple points, but both are obstructed)
        - 'chosen_obstructed' (multiple points, but only one is obstructed)
    multiple_points: Boolean, true if there is more than one closest point.
        This occurs when the two ships have the same rotation. I this is true,
        then 'other_closest' will be non-nil.
    other_closest: Table, the other closest point. See 'closest' and
        'multiple_points'. This is nil if only one closest point.
--]]
ArcCheck.GetTargetsInRelationToArc = function(ship, arc, fixed_targets, range, include_friendly_ships)
    if ArcCheck.initialized == false then
        ArcCheck.Initialize()
    end

    range = range or 3
    local arc_parts = {}
    local arc_table = {}
    if type(arc) == 'string' then
        arc_table = { arc }
    else
        arc_table = arc;
    end
    for _, arc in pairs(arc_table) do
        if arc == "frontback" then
            table.insert(arc_parts, "front")
            table.insert(arc_parts, "back")
        elseif arc == "leftright" then
            table.insert(arc_parts, "left")
            table.insert(arc_parts, "right")
        elseif arc == "all" then
            table.insert(arc_parts, "front")
            table.insert(arc_parts, "back")
            table.insert(arc_parts, "left")
            table.insert(arc_parts, "right")
        else
            table.insert(arc_parts, arc)
        end
    end
    ship.setLock(true)
    local shipSize = ship.getTable("Data").Size or 'small'

    local potential_targets = fixed_targets or
        ArcCheck.GetPotentialTargets(ship, (range + 1) * 250, true, include_friendly_ships or false)
    local bullseye_targets = ArcCheck.GetBullseyeTargets(ship, ArcCheck.bullseye_data.pos[shipSize])

    local own_line_segments = {}
    for _, arc in ipairs(arc_parts) do
        local segments = ArcCheck.GetOwnArcLineSegments(ship, ArcCheck.arc_line_segments[shipSize][arc]["segments"])
        for _, segment in ipairs(segments) do
            table.insert(own_line_segments, segment)
        end
    end

    targets = {}
    local found = false
    for _, pt in pairs(potential_targets) do
        target = { ['ship'] = pt, ['bullseye'] = false }
        for _, bt in pairs(bullseye_targets) do
            if bt == pt then
                target.bullseye = true
            end
        end
        local target_line_segments = {}
        for _, arc in ipairs(arc_parts) do
            local segments = ArcCheck.GetTargetLineSegmentsInArc(ship, pt,
                ArcCheck.arc_line_segments[shipSize][arc]["degrees"])
            for _, segment in ipairs(segments) do
                table.insert(target_line_segments, segment)
            end
        end

        if #target_line_segments ~= 0 then
            local other = nil
            local closest = nil
            closest, other = ArcCheck.GetDistanceBetweenLineSegments(own_line_segments, target_line_segments)
            target.in_arc = true
            target.obstructed = 'unobstructed'
            target.closest = closest
            target.multiple_points = false

            if closest.range <= range then
                found = true
                target.closest.obstructions = ArcCheck.CheckObstruction(closest, target.ship, ship)
                target.closest.in_bullseye = target.bullseye
                if other ~= nil then
                    target.obstructed = 'likely_unobstructed'
                    target.multiple_points = true

                    other.obstructions = ArcCheck.CheckObstruction(other, target.ship, ship)
                    other.in_bullseye = target.bullseye
                    target.other_closest = other
                end

                if #closest.obstructions ~= 0 then
                    if other ~= nil then
                        if #other.obstructions ~= 0 then
                            target.obstructed = 'likely_obstructed'
                        else
                            target.obstructed = 'chosen_obstructed'
                        end
                    else
                        target.obstructed = 'obstructed'
                    end
                else
                    if other ~= nil and #other.obstructions ~= 0 then
                        target.obstructed = 'chosen_obstructed'
                    end
                end
            end
        else
            target.in_arc = false
        end

        table.insert(targets, target)
    end
    if found == false then
        ArcCheck.current_arc = "none"
    end

    return targets
end

--[[ ArcCheck.SortTargetsByDesirability
This is a table sorting function, used to sort the results of
GetTargetsInRelationToArc. It sorts based on desirability of selecting a target,
in the following order:
- in arc before out of arc
- closer range band before more distant range band
- less obstructed before more obstructed
- GUID as a fallback
--]]
ArcCheck.SortTargetsByDesirability = function(e1, e2)
    if e1.in_arc == true and e2.in_arc == false then
        return true
    elseif e1.in_arc == false and e2.in_arc == true then
        return false
    elseif e1.in_arc == true then
        if e1.closest.range < e2.closest.range then
            return true
        elseif e1.closest.range > e2.closest.range then
            return false
        end

        -- Gotta be a better way of doing this...
        if e1.obstructed ~= e2.obstructed then
            if e1.obstructed == 'unobstructed' then
                return true
            elseif e2.obstructed == 'unobstructed' then
                return false
            end

            if e1.obstructed == 'likely_unobstructed' then
                return true
            elseif e2.obstructed == 'likely_unobstructed' then
                return false
            end

            if e1.obstructed == 'chosen_obstructed' then
                return true
            elseif e2.obstructed == 'chosen_obstructed' then
                return false
            end

            if e1.obstructed == 'likely_obstructed' then
                return true
            elseif e2.obstructed == 'likely_obstructed' then
                return false
            end

            if e1.obstructed == 'obstructed' then
                return true
            elseif e2.obstructed == 'obstructed' then
                return false
            end
        end
    end

    return e1.ship.getGUID() > e2.ship.getGUID()
end

ArcCheck.CheckObstruction = function(data, ship, ownship)
    local collissions = Physics.cast({
        origin = data.midpoint,
        orientation = { 0, data.angle, 0 },
        direction = { 0, -0.3, 0 },
        type = 3,
        size = { 0, 0, data.length },
        max_distance = 3,
        debug = false
    })
    local hit_obstacles = {}
    for _, hit in pairs(collissions) do
        if (hit.hit_object ~= ship) and (hit.hit_object ~= ownship) and (MoveModule.SelectObstacles(hit.hit_object) or MoveModule.SelectHugeShips(hit.hit_object)) then
            table.insert(hit_obstacles, hit.hit_object)
        end
    end
    return hit_obstacles;
end

ArcCheck.SpawnObstructionRuler = function(data)
    if data.range > 0 then
        if not (ArcCheck.model_cache["ArcCheckRuler" .. data.range]) then
            ArcCheck.model_cache["ArcCheckRuler" .. data.range] = spawnObject({
                type = "Custom_Model",
                position = { 0, -1.21, 0 },
                rotation = { 0, 0, 0 },
                scale = { 0.363, 0.363, 0.5 },
                sound = false,
                snap_to_grid = false
            })
            ArcCheck.model_cache["ArcCheckRuler" .. data.range].setCustomObject({
                mesh =
                    '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/ArcCheckRuler' ..
                    data.range .. '.obj',
                material = 3
            })
            ArcCheck.model_cache["ArcCheckRuler" .. data.range].addTag('TempLayoutElement')
            ArcCheck.model_cache["ArcCheckRuler" .. data.range].interactable = false
            ArcCheck.model_cache["ArcCheckRuler" .. data.range].setLock(true)
        end
        ruler = ArcCheck.model_cache["ArcCheckRuler" .. data.range].clone()
        ruler.setRotation({ 0, data.angle + 90, 0 })
        ruler.setPosition(Vector(data.A[1], 1.21, data.A[3]))
        local tintcolor = Color(1.0, 1.0, 0.2, 1.0) -- Yellow obstructed tint
        if #data.obstructions == 0 then
            if data.in_bullseye then
                tintcolor = Color(1.0, 0.2, 1.0, 1.0) -- Purple unobstructed bullseye tint
            else
                tintcolor = Color(0.2, 0.2, 1.0, 1.0) -- Blue unobstructed tint
            end
        else
            if data.in_bullseye then
                tintcolor = Color(1.0, 0.2, 0.0, 1.0) -- orange obstructed bullseye tint
            else
                tintcolor = Color(1.0, 1.0, 0.2, 1.0) -- yellow obstructed tint
            end
        end

        ruler.setColorTint(tintcolor)
        ruler.setLock(true)
        local rigid = ruler.getComponent("Rigidbody")
        rigid.set("isKinematic", true)
        rigid.set("detectCollisions", false)
        return ruler
        --table.insert(ArcCheck.arc_check_rulers, ruler)
    end
end


-- Calculates closest distance between two set of line segments. Returns table with range, and line points
ArcCheck.GetDistanceBetweenLineSegments = function(own_line_segments, target_line_segments)
    local closest = {
        length = 10000,
        range = 0,
        midpoint = { 0, 0, 0 },
        angle = 0,
        A = { 0, 0, 0 },
        B = { 0, 0, 0 }
    }
    local other = nil
    local epsilon = 0.001 -- This to dumb down the mathematical accuracy to match the analog game experience
    for _, seg_o in pairs(own_line_segments) do
        for _, seg_t in pairs(target_line_segments) do
            for _, point in pairs(seg_t) do
                local distance = ArcCheck.GetDistanceBetweenLineSegmentAndPoint(seg_o, point, false)
                if not ArcCheck.CheckEqualLineSegments(distance.A, distance.B, closest.A, closest.B) then
                    if (distance.length <= (closest.length + epsilon)) then
                        if math.abs(distance.length - closest.length) < epsilon then
                            --print("Real close: " .. tostring(distance.length).. " - " .. tostring(distance.length - closest.length))
                            if distance.length < closest.length then
                                other = closest
                                closest = distance
                            else
                                other = distance
                            end
                        else
                            --print("Closer: " .. tostring(distance.length) .. " - " .. tostring(distance.length - closest.length))
                            closest = distance
                            other = nil
                        end
                    end
                elseif distance.length < closest.length then
                    --print("Equal lines, and closer")
                    closest = distance
                    other = nil
                else
                    --print("Equal lines, farther")
                end
            end
            for _, point in pairs(seg_o) do
                local distance = ArcCheck.GetDistanceBetweenLineSegmentAndPoint(seg_t, point, true)
                if not ArcCheck.CheckEqualLineSegments(distance.A, distance.B, closest.A, closest.B) then
                    if (distance.length <= (closest.length + epsilon)) then
                        if math.abs(distance.length - closest.length) < epsilon then
                            --print("Real close2: " .. tostring(distance.length).. " - " .. tostring(distance.length - closest.length))
                            if distance.length < closest.length then
                                other = closest
                                closest = distance
                            else
                                other = distance
                            end
                        else
                            --print("Closer2: " .. tostring(distance.length) .. " - " .. tostring(distance.length - closest.length))
                            closest = distance
                            other = nil
                        end
                    end
                elseif distance.length < closest.length then
                    --print("Equal lines, and closer")
                    closest = distance
                    other = nil
                else
                    --print("Equal lines, farther")
                end
            end
        end
    end
    return closest, other
end

ArcCheck.GetAngleBetweenPoints = function(A, B, C)
    local BA = Vect.Between(B, A)
    local BC = Vect.Between(B, C)
    return Vect.AngleDeg(BA, BC)
end

ArcCheck.CheckEqualLineSegments = function(line1A, line1B, line2A, line2B)
    local epsilon = 0.02
    if Vect.Distance(line1A, line2A) < epsilon then
        return true
    elseif Vect.Distance(line1B, line2B) < epsilon then
        return true
    elseif Vect.Distance(line1A, line2B) < epsilon then
        return true
    elseif Vect.Distance(line1B, line2A) < epsilon then
        return true
    end
    return false
end


-- Gets the closest point on a line segment to a point
ArcCheck.GetDistanceBetweenLineSegmentAndPoint = function(segment, point, reverse)
    local P = {}
    -- Check if the angle at the first segment point is larger than 90 degrees, the point bust be it, and the endpoint will be closest point
    if (math.abs(ArcCheck.GetAngleBetweenPoints(segment[2], segment[1], point)) >= 90) then
        P = segment[1]
    elseif (math.abs(ArcCheck.GetAngleBetweenPoints(segment[1], segment[2], point)) >= 90) then
        -- Similarily for the second segment point
        P = segment[2]
    else
        -- The closest point is somewhere in between, along the normal of the line segment
        local u = Vect.ToUnit(Vect.Between(segment[1], segment[2]))
        local baseline_norm = Vector(-u[3], u[2], u[1])
        local d = Vect.DotProd(Vect.Between(point, segment[1]), baseline_norm)
        P = Vect.Sum(point, Vect.Scale(baseline_norm, d))
    end

    if reverse then
        A = point
        B = P
    else
        A = P
        B = point
    end
    local distance = Vect.Distance(P, point)
    local range = math.floor(Dim.Convert_igu_mm(distance / 100)) + 1

    local midpoint = Vect.Middle(A, B)
    midpoint[2] = 1.52

    local AB = Vect.Between(A, B)
    local angle = Vect.AngleDeg(AB, Vector(0, 0, 1))
    if AB[1] < 0 then
        angle = -angle
    end

    return {
        length = distance,
        A = A,
        B = B,
        range = range,
        midpoint = midpoint,
        angle = angle
    }
end

-- Returns list of line segments which are within a given arc type
ArcCheck.GetOwnArcLineSegments = function(ship, segments)
    local outsegments = {}
    for _, segment in pairs(segments) do
        table.insert(outsegments,
            { Vect.Sum(ship.getPosition(), Vect.RotateDeg(segment[1], ship.getRotation()[2] + 180)),
                Vect.Sum(ship.getPosition(), Vect.RotateDeg(segment[2], ship.getRotation()[2] + 180)) })
    end
    return outsegments
end

-- Finds all potential ships within a little more than range 3 from the ship
ArcCheck.GetPotentialTargets = function(ship, length, include_enemy_ships, include_friendly_ships)
    return ArcCheck.GetShipsWithinRange(ship, length, include_enemy_ships, include_friendly_ships)
end

-- Finds all targets in bullseye
ArcCheck.GetBullseyeTargets = function(ship, pos, length)
    if pos == nil then
        -- This is a non bullseye remote
        return {}
    end
    if length ~= nil then
        length = Dim.Convert_mm_igu(length)
    end
    local castSize = Vector(ArcCheck.bullseye_data.size[1], ArcCheck.bullseye_data.size[2],
        length or ArcCheck.bullseye_data.size[3])
    local collissions = Physics.cast({
        origin = Vect.Sum(ship.getPosition() + Vector(0, 0.1, 0), Vect.RotateDeg(pos, ship.getRotation()[2] + 180)),
        orientation = ship.getRotation(),
        direction = { 0, -0.03, 0 },
        type = 3,
        size = castSize,
        max_distance = 3,
        debug = false
    })
    local myOwningPlayer = ship.getVar("owningPlayer")
    local bullseye_targets = {}
    for _, hit in pairs(collissions) do
        if hit.hit_object.getGUID() ~= ship.getGUID() and MoveModule.SelectShipsAndRemotes(hit.hit_object) then
            if hit.hit_object.getVar("owningPlayer") ~= myOwningPlayer then
                -- remove false targets, where only the nub is hit
                if ArcCheck.VerifyBullseye(ship, hit.hit_object) then
                    table.insert(bullseye_targets, hit.hit_object)
                end
            end
        end
    end
    return bullseye_targets
end

ArcCheck.VerifyBullseye = function(ship, target)
    if MoveModule.SelectRemotes(target) then
        return true
    end
    local left = false
    local right = false
    local half_bullseye = (ArcCheck.bullseye_data.size[1] / 2)

    -- Translate target corners into ship object Space
    local size = Dim.Convert_mm_igu((Dim.mm_baseSize[target.getTable("Data").Size] / 2))
    local t_rotation = target.getRotation().y
    local s_rotation = ship.getRotation().y
    local target_corners = {}
    target_corners[1] = Vector(-size, 0, size)
    target_corners[2] = Vector(-size, 0, -size)
    target_corners[3] = Vector(size, 0, size)
    target_corners[4] = Vector(size, 0, -size)
    for _, target_corner in pairs(target_corners) do
        local world_corner = target_corner:rotateOver('y', t_rotation) + target.getPosition() - ship.getPosition()
        local local_corner = world_corner:rotateOver('y', -s_rotation)
        --print ("Local corner: " .. tostring(local_corner[1]) .. "," .. tostring(local_corner[2]) ..  "," .. tostring(local_corner[3]))
        if local_corner.x > -half_bullseye then
            right = true
        end
        if local_corner.x < half_bullseye then
            left = true
        end
        if left and right then
            return true
        end
    end
    return false
end


-- Finds friendly or enemy ships within a particular range
ArcCheck.GetShipsWithinRange = function(ship, range, include_enemy_ships, include_friendly_ships)
    range = range or 900
    if include_enemy_ships == nil then
        include_enemy_ships = true
    end
    if include_friendly_ships == nil then
        include_friendly_ships = false
    end

    local cast_radius = Dim.Convert_mm_igu(range)
    local collisions = Physics.cast({
        origin = ship.getPosition() + Vector(0, 0.1, 0),
        direction = { 0, -0.001, 0 },
        type = 2,
        size = { cast_radius, cast_radius, cast_radius },
        max_distance = 1,
        debug = false
    })

    local ship_owning_player = ship.getVar("owningPlayer")
    local potential_ships = {}
    for _, hit in pairs(collisions) do
        if hit.hit_object.getGUID() ~= ship.getGUID() and MoveModule.SelectShipsAndRemotes(hit.hit_object) then
            local is_enemy_ship = hit.hit_object.getVar("owningPlayer") ~= ship_owning_player
            if (include_enemy_ships and is_enemy_ship) or (include_friendly_ships and not is_enemy_ship) then
                table.insert(potential_ships, hit.hit_object)
            end
        end
    end

    return potential_ships
end

ArcCheck.GetDistanceBetweenShips = function(ship, target, arcs)
    local arcs = arcs or { 'front', 'back', 'left', 'right' }
    local ship_size = ship.getTable("Data").Size or 'small'

    local ship_line_segments = {}
    local target_line_segments = {}
    for _, arc in pairs(arcs) do
        local ship_segments = ArcCheck.GetOwnArcLineSegments(ship, ArcCheck.arc_line_segments[ship_size][arc]
            ["segments"])
        for _, ship_segment in pairs(ship_segments) do
            table.insert(ship_line_segments, ship_segment)
        end

        local target_segments = ArcCheck.GetTargetLineSegmentsInArc(ship, target,
            ArcCheck.arc_line_segments[ship_size][arc]["degrees"])
        for _, target_segment in pairs(target_segments) do
            table.insert(target_line_segments, target_segment)
        end
    end

    if #target_line_segments ~= 0 then
        local closest = nil
        closest, _ = ArcCheck.GetDistanceBetweenLineSegments(ship_line_segments, target_line_segments)
        return closest
    end

    return nil
end


-- Returns a list of line segments which are within the arc
ArcCheck.GetTargetLineSegmentsInArc = function(ship, target, arcinfo)
    local targetShipData = target.getTable("Data")
    -- Get the full line segments for the ship
    if targetShipData == nil then
        printToAll("Unable to get Data table for " .. ship.getName())
        return {}
    end
    local segments = ArcCheck.arc_line_segments[targetShipData.Size]["full"]["segments"]
    local outsegments = {}
    local arc_center_vector = Vect.RotateDeg(Vector(0, 0, -30), ship.getRotation()[2] + arcinfo.direction)
    --print("Arc_center_vector = " .. tostring(arc_center_vector[1]).."," .. tostring(arc_center_vector[2]) ..","..tostring(arc_center_vector[3]))
    if arcinfo.bullseye == nil then
        for _, segment in pairs(segments) do
            -- Calculate part of line segment within arc
            local rotated_segment = { Vect.Sum(target.getPosition(), Vect.RotateDeg(segment[1], target.getRotation()[2])),
                Vect.Sum(target.getPosition(), Vect.RotateDeg(segment[2], target.getRotation()[2])) }

            -- Check if points are in arc
            local angleoffsets = { Vect.AngleDeg(Vect.Between(ship.getPosition(), rotated_segment[1]), arc_center_vector),
                Vect.AngleDeg(Vect.Between(ship.getPosition(), rotated_segment[2]), arc_center_vector) }

            --print("Angle offsets: " .. target.getName() .. "[".. tostring(k) .. "] "..  tostring(angleoffsets[1]) .. " - " .. tostring(angleoffsets[2]) )

            if angleoffsets[1] < arcinfo.spread and angleoffsets[2] < arcinfo.spread then
                -- Both points are in arc
                --print("Both in arc")
                table.insert(outsegments, rotated_segment)
            elseif angleoffsets[1] > arcinfo.spread and angleoffsets[2] > arcinfo.spread then
                -- both outside
                if Vect.AngleDeg(Vect.Between(ship.getPosition(), Vect.Middle(rotated_segment[1], rotated_segment[2])), arc_center_vector) < arcinfo.spread then
                    -- print("Both out, in front. deg: " .. tostring(Vect.AngleDeg(Vect.Between(ship.getPosition(), Vect.Middle(rotated_segment[1], rotated_segment[2])), arc_center_vector)))
                    -- The target is infront, but both points are outside the arc.
                    local newsegment = { ArcCheck.GetLineLineIntersection(ship.getPosition(),
                        Vect.Sum(ship.getPosition(), Vect.RotateDeg(arc_center_vector, -arcinfo.spread))
                        , rotated_segment[1], rotated_segment[2]),
                        ArcCheck.GetLineLineIntersection(ship.getPosition(),
                            Vect.Sum(ship.getPosition(), Vect.RotateDeg(arc_center_vector, arcinfo.spread))
                            , rotated_segment[1], rotated_segment[2]) }
                    --print("Newsegment: ".. tostring(newsegment[1]) .. "," .. tostring(newsegment[2]))
                    table.insert(outsegments, newsegment)
                else
                    --print("Both out, behind")
                end
            else
                -- one inside, one out
                local p1 = rotated_segment[1]
                if (angleoffsets[1] > arcinfo.spread) then
                    p1 = rotated_segment[2]
                end
                local p2 = ArcCheck.GetLineLineIntersection(ship.getPosition(),
                    Vect.Sum(ship.getPosition(), Vect.RotateDeg(arc_center_vector, arcinfo.spread)), rotated_segment[1],
                    rotated_segment[2])
                if p2 == nil then
                    p2 = ArcCheck.GetLineLineIntersection(ship.getPosition(),
                        Vect.Sum(ship.getPosition(), Vect.RotateDeg(arc_center_vector, -arcinfo.spread)),
                        rotated_segment[1], rotated_segment[2])
                end
                if p2 ~= nil then
                    table.insert(outsegments, { p1, p2 })
                end
            end
        end
    else
        -- Special Bullseye handling
        local half_bullseye = ArcCheck.bullseye_data.size[1] / 2
        --print("\nBullseye check to: " ..target.getName() .. " half bullseye: " .. tostring(half_bullseye))
        for _, segment in pairs(segments) do
            local rotated_segment = { Vect.Sum(target.getPosition(), Vect.RotateDeg(segment[1], target.getRotation()[2])),
                Vect.Sum(target.getPosition(), Vect.RotateDeg(segment[2], target.getRotation()[2])) }
            local ownship_oriented_segment = { Vect.RotateDeg(Vect.Between(ship.getPosition(), rotated_segment[1]),
                -ship.getRotation()[2]),
                Vect.RotateDeg(Vect.Between(ship.getPosition(), rotated_segment[2]), -ship.getRotation()[2]) }
            local x1 = math.min(ownship_oriented_segment[1][1], ownship_oriented_segment[2][1])
            local x2 = math.max(ownship_oriented_segment[1][1], ownship_oriented_segment[2][1])
            --print("x1:" .. tostring(x1) .. " x2:" .. tostring(x2))
            --print("ownship_oriented_segment[1][3]:" .. tostring(ownship_oriented_segment[1][3]))
            if ownship_oriented_segment[1][3] < 0 then
                -- Target in front (Yeah it is backwards)
                if x1 < -half_bullseye then
                    --print("From minus")
                    x1 = -half_bullseye
                    if x2 > -half_bullseye then
                        x2 = math.min(half_bullseye, x2)
                        p1 = ArcCheck.GetLineLineIntersection(ownship_oriented_segment[1], ownship_oriented_segment[2],
                            Vector(x1, ownship_oriented_segment[1][2], 0),
                            Vector(x1, ownship_oriented_segment[1][2], -100), true)
                        p2 = ArcCheck.GetLineLineIntersection(ownship_oriented_segment[1], ownship_oriented_segment[2],
                            Vector(x2, ownship_oriented_segment[1][2], 0),
                            Vector(x2, ownship_oriented_segment[1][2], -100), true)
                        if p1 ~= nil and p2 ~= nil then
                            print("test1")
                            table.insert(outsegments,
                                { Vect.Sum(Vect.RotateDeg(p1, ship.getRotation()[2]), ship.getPosition()),
                                    Vect.Sum(Vect.RotateDeg(p2, ship.getRotation()[2]), ship.getPosition()) })
                        end
                    end
                elseif x1 < half_bullseye then
                    --print("From plus")
                    x2 = math.min(half_bullseye, x2)
                    p1 = ArcCheck.GetLineLineIntersection(ownship_oriented_segment[1], ownship_oriented_segment[2],
                        Vector(x1, ownship_oriented_segment[1][2], 0), Vector(x1, ownship_oriented_segment[1][2], -100),
                        true)
                    p2 = ArcCheck.GetLineLineIntersection(ownship_oriented_segment[1], ownship_oriented_segment[2],
                        Vector(x2, ownship_oriented_segment[1][2], 0), Vector(x2, ownship_oriented_segment[1][2], -100),
                        true)
                    if p1 ~= nil and p2 ~= nil then
                        --print("test2")
                        table.insert(outsegments,
                            { Vect.Sum(Vect.RotateDeg(p1, ship.getRotation()[2]), ship.getPosition()),
                                Vect.Sum(Vect.RotateDeg(p2, ship.getRotation()[2]), ship.getPosition()) })
                    end
                end
            end
        end
    end
    return outsegments
end

ArcCheck.GetLineLineIntersection = function(p0, p1, p2, p3, expect_intersection)
    local max = 1
    local min = 0
    if expect_intersection then
        max = 1.00001
        min = -0.00001
    end

    local s1_x = p1[1] - p0[1]
    local s1_y = p1[3] - p0[3]
    local s2_x = p3[1] - p2[1]
    local s2_y = p3[3] - p2[3]

    local s = (-s1_y * (p0[1] - p2[1]) + s1_x * (p0[3] - p2[3])) / (-s2_x * s1_y + s1_x * s2_y)
    local t = (s2_x * (p0[3] - p2[3]) - s2_y * (p0[1] - p2[1])) / (-s2_x * s1_y + s1_x * s2_y)
    if (s >= min and s <= max and t >= min and t <= max) then
        -- Collision detected
        return Vector(p0[1] + (t * s1_x), p0[2], p0[3] + (t * s1_y))
    end
    print("S:" .. tostring(s) .. " t:" .. tostring(t))

    return nil -- no collision
end

return ArcCheck
