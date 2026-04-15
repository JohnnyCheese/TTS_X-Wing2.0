-- Fog of War Module
FogOfWar = {}
FogOfWar.BUILD = "fog-0.26-directpoll"
FogOfWar.enabled = false
FogOfWar.debug = false
FogOfWar.rangeMm      = 400
FogOfWar.cloakRangeMm = 300
FogOfWar.claimRangeMm = 100
FogOfWar.proximityRevealMm = 60
FogOfWar.nearbyHideIgu = 14.55 -- R4 in IGU: radius around a ship whose nearby tokens/peg/ColorId/dial/flying tokens also get hidden
FogOfWar.visionPartner = {
    Purple = "Red", Red = "Purple",
    Orange = "Blue", Blue = "Orange",
}
FogOfWar.revealTokenNames = { "Crate", "Ancient Knowledge", "Energy" }

local function fow_isSpectator(c)
    return c == "Grey" or c == "Black" or c == "White"
end

local function fow_areAllies(a, b)
    if a == b then return true end
    local p1, p2 = nil, nil
    for _, pl in ipairs(Player.getPlayers()) do
        if pl.color == a then p1 = pl end
        if pl.color == b then p2 = pl end
    end
    if p1 and p2 then return p1.team == p2.team end
    return false
end

local function fow_sameTeam(a, b)
    if fow_areAllies(a, b) then return true end
    local pa = FogOfWar.visionPartner[a]
    local pb = FogOfWar.visionPartner[b]
    if pa and (pa == b or fow_areAllies(pa, b)) then return true end
    if pb and (pb == a or fow_areAllies(a, pb)) then return true end
    if pa and pb and fow_areAllies(pa, pb) then return true end
    return false
end

local function fow_nameMatchesReveal(name)
    if not name or name == "" then return false end
    local lower = name:lower()
    for _, t in ipairs(FogOfWar.revealTokenNames) do
        local tl = t:lower()
        if lower == tl or lower:find(tl, 1, true) then return true end
    end
    return false
end

local function fow_baseDistMm(a, b)
    local ok, result = pcall(function()
        local my_pos = a.getNearestPointFromObject(b)
        local closest = API_GetClosestPointToShip({ ship = b, point = my_pos })
        if closest and closest.length then
            return Dim.Convert_igu_mm(closest.length)
        end
        return nil
    end)
    if ok and result then return result end
    return Dim.Convert_igu_mm(a.getPosition():distance(b.getPosition()))
end

-- cloakTokens = pre-filtered list of objects with __XW_TokenType == 'cloak'
local function fow_collectCloaked(cloakTokens)
    local cloaked = {}
    for _, obj in ipairs(cloakTokens or {}) do
        local ok, ship = pcall(function() return obj.getVar("assignedShip") end)
        if ok and ship then
            local ok2, g = pcall(function() return ship.getGUID() end)
            if ok2 and g then cloaked[g] = true end
        end
    end
    return cloaked
end

-- revealNamed = pre-filtered list of non-ship objects whose name matched
-- a reveal token (crate/AK/energy). Still handles TokenModule assignments.
local function fow_collectAlwaysVisible(all_ships, revealNamed)
    local always = {}
    if type(TokenModule) == "table" and type(TokenModule.tokenAssignments) == "table" then
        for guid, ship in pairs(TokenModule.tokenAssignments) do
            if ship ~= nil then
                local token = getObjectFromGUID(guid)
                if token and fow_nameMatchesReveal(token.getName()) then
                    always[ship.getGUID()] = true
                end
            end
        end
    end
    if revealNamed and #revealNamed > 0 then
        for _, obj in ipairs(revealNamed) do
            local nearest, nearMm = nil, FogOfWar.proximityRevealMm
            for _, ship in pairs(all_ships) do
                local ok, d = pcall(fow_baseDistMm, obj, ship)
                if ok and d and d < nearMm then nearMm = d; nearest = ship end
            end
            if nearest then always[nearest.getGUID()] = true end
        end
    end
    return always
end

local function fow_collectLockReveals(all_ships)
    local reveals = {}
    if type(TokenModule) ~= "table" or type(TokenModule.tokenAssignments) ~= "table" then
        return reveals
    end
    local byName = {}
    for _, s in pairs(all_ships) do byName[s.getName()] = s end
    for guid, target in pairs(TokenModule.tokenAssignments) do
        if target ~= nil then
            local token = getObjectFromGUID(guid)
            if token and token.getVar("__XW_TokenType") == "targetLock" then
                local owner = byName[token.getName()]
                if owner then
                    local oc = owner.getVar("owningPlayer")
                    local tc = target.getVar("owningPlayer")
                    if oc and tc and not fow_sameTeam(oc, tc) then
                        local tg = target.getGUID()
                        local set = reveals[tg] or {}
                        set[oc] = true
                        if FogOfWar.visionPartner[oc] then
                            set[FogOfWar.visionPartner[oc]] = true
                        end
                        reveals[tg] = set
                    end
                end
            end
        end
    end
    return reveals
end

-- Player color RGB reference for tint-based claim inference. The objective
-- token's claim(player) sets the color tint to Color.fromString(player), so
-- we can read the tint back and match to a player color.
-- Actual TTS player color RGB values (from Color.fromString(color)).
local FOW_PLAYER_RGB = {
    Red    = {0.856, 0.100, 0.094},
    Orange = {0.956, 0.392, 0.113},
    Yellow = {0.905, 0.898, 0.172},
    Green  = {0.192, 0.701, 0.168},
    Teal   = {0.129, 0.694, 0.607},
    Blue   = {0.118, 0.530, 1.000},
    Purple = {0.627, 0.125, 0.941},
    Pink   = {0.960, 0.439, 0.800},
    Brown  = {0.443, 0.231, 0.090},
}

local function fow_tintToColor(tint)
    if not tint then return nil end
    -- Ignore (near-)white/transparent (unclaimed default).
    local r, g, b = tint[1] or tint.r or 0, tint[2] or tint.g or 0, tint[3] or tint.b or 0
    if r > 0.9 and g > 0.9 and b > 0.9 then return nil end
    if r < 0.05 and g < 0.05 and b < 0.05 then return nil end
    local best, bestD = nil, 0.25 -- threshold; anything further isn't a match
    for color, rgb in pairs(FOW_PLAYER_RGB) do
        local dr, dg, db = r - rgb[1], g - rgb[2], b - rgb[3]
        local d = dr*dr + dg*dg + db*db
        if d < bestD then bestD = d; best = color end
    end
    return best
end

local function fow_collectClaims()
    local claims = {}
    local function consider(obj)
        -- Prefer explicit claimedBy if the objective script sets it.
        local by = obj.getVar("claimedBy")
        if not (by and by ~= "") then
            -- Fall back to inferring from the tint the claim function set.
            local ok, tint = pcall(function() return obj.getColorTint() end)
            if ok then by = fow_tintToColor(tint) end
        end
        if by and by ~= "" then
            table.insert(claims, { obj = obj, by = by })
        end
    end
    for _, obj in pairs(getObjectsWithTag("Objective")) do consider(obj) end
    for _, obj in pairs(getObjectsWithTag("CenterObjective")) do consider(obj) end
    return claims
end

-- Classify an object as a LOS-blocking obstacle. Per user, treat asteroid,
-- debris, clouds, spare parts, loose cargo, chaff all as hard blockers.
local function fow_isLosBlocker(obj)
    if not obj then return false end
    if obj.hasTag('Ship') then return false end
    if obj.hasTag('Obstacle') then return true end
    local n = (obj.getName() or ''):lower()
    for _, kw in ipairs({ 'asteroid', 'debris', 'cloud', 'spare', 'cargo', 'chaff' }) do
        if n:find(kw, 1, true) then return true end
    end
    return false
end

-- LOS check using the same box-cast pattern the in-game arc checker uses
-- (ArcCheck.CheckObstruction). We compute the closest-point line segment
-- between the two ships and box-cast along it at table height.
local function fow_losStatus(fromShip, toShip)
    local ok, result = pcall(function()
        local my_pos = fromShip.getNearestPointFromObject(toShip)
        local closest = API_GetClosestPointToShip({ ship = toShip, point = my_pos })
        if not closest or not closest.length or closest.length < 0.01 then
            return 'clean'
        end
        local hits = Physics.cast({
            origin = closest.midpoint,
            orientation = { 0, closest.angle, 0 },
            direction = { 0, -0.3, 0 },
            type = 3,
            size = { 0, 0, closest.length },
            max_distance = 3,
            debug = false,
        })
        for _, h in ipairs(hits or {}) do
            local obj = h.hit_object
            if obj and obj ~= fromShip and obj ~= toShip then
                if fow_isLosBlocker(obj) then return 'blocked' end
            end
        end
        return 'clean'
    end)
    if ok then return result end
    return 'clean'
end

-- Whitelist of tokens whose visibility should follow their parent ship.
-- Anything not in this list stays visible (dials, templates, damage deck,
-- obstacles, saved objects, etc.).
local FOW_HIDEABLE_TOKENS = {
    cloak = true,
    stress = true,
    strain = true,
    ion = true,
    force = true,
    deplete = true,
    calculate = true,
    evade = true,
    reinforce = true,
    focus = true,
    disarm = true,
}

local function fow_isHideableToken(obj)
    if not obj then return false end
    local n = (obj.getName() or ''):lower()
    if n == "" then return false end
    if FOW_HIDEABLE_TOKENS[n] then return true end
    for k in pairs(FOW_HIDEABLE_TOKENS) do
        if n:sub(1, #k) == k then return true end
    end
    return false
end

-- Return true if this ship is within R1 of any gas cloud obstacle.
local function fow_gasConcealed(ship, gasClouds)
    for _, c in ipairs(gasClouds) do
        local ok, d = pcall(fow_baseDistMm, ship, c)
        if ok and d and d < FogOfWar.claimRangeMm then return true end
    end
    return false
end

local function fow_collectGasClouds(all_objs)
    local clouds = {}
    for _, obj in pairs(all_objs or getAllObjects()) do
        local n = (obj.getName() or ''):lower()
        if n:find('gas') and n:find('cloud') then
            table.insert(clouds, obj)
        end
    end
    return clouds
end

-- =========================================================================
-- TURBO: Persistent caches across ticks. Invalidated by movement (distances,
-- LOS) or by object spawn/destroy (classification). Wiped on fog toggle off.
-- =========================================================================

FogOfWar._scan       = nil  -- cached classification scan
FogOfWar._scanTime   = 0
FogOfWar._scanTTL    = 10.0 -- seconds
FogOfWar._distCache  = {}   -- key -> {d=mm, pa=Vec, pb=Vec}
FogOfWar._losCache   = {}   -- key -> {r='clean'|'blocked', pa=Vec, pb=Vec}
FogOfWar._posEps2    = 0.01 -- squared IGU — positions closer than this are "unchanged"
FogOfWar._shipHide   = {}   -- last tick's ship_hide map, for phase-2 skip

-- Fast squared-distance test between two positions
local function _pos_unchanged(p1, p2)
    if not p1 or not p2 then return false end
    local dx = (p1.x or p1[1]) - (p2.x or p2[1])
    local dy = (p1.y or p1[2]) - (p2.y or p2[2])
    local dz = (p1.z or p1[3]) - (p2.z or p2[3])
    return (dx*dx + dy*dy + dz*dz) < FogOfWar._posEps2
end

local function _copyPos(p)
    return { x = p.x or p[1], y = p.y or p[2], z = p.z or p[3] }
end

-- Invalidate classification scan on spawn/destroy
local function fow_invalidateScan()
    FogOfWar._scan = nil
end

-- Classification pass: iterate getAllObjects once, bucket by role.
-- Cache for FogOfWar._scanTTL seconds; invalidate on spawn/destroy.
local function fow_scan()
    if FogOfWar._scan and (Time.time - FogOfWar._scanTime) < FogOfWar._scanTTL then
        return FogOfWar._scan
    end
    local s = {
        ships = {},
        objectives = {},     -- both Objective and CenterObjective
        obstacles = {},
        gasClouds = {},
        cloakTokens = {},    -- tokens with __XW_TokenType == 'cloak'
        hideableTokens = {}, -- focus, stress, etc. (by name match)
        revealNamed = {},    -- non-ship objects whose name matches a reveal
    }
    for _, obj in ipairs(getAllObjects()) do
        if obj then
            if obj.hasTag('Ship') then
                table.insert(s.ships, obj)
            else
                local isObjective = obj.hasTag('Objective') or obj.hasTag('CenterObjective')
                local isObstacle  = obj.hasTag('Obstacle')
                if isObjective then
                    table.insert(s.objectives, obj)
                end
                if isObstacle then
                    table.insert(s.obstacles, obj)
                end
                -- Only call the expensive getName/getVar for non-trivial objects.
                -- Skip big containers / decks / dice quickly by tag.
                local t = obj.tag
                if t ~= 'Board' and t ~= 'Deck' and t ~= 'Dice' and t ~= 'Bag'
                   and t ~= 'Infinite' and t ~= 'Stack' and t ~= 'Card' then
                    local okN, name = pcall(function() return obj.getName() or "" end)
                    if okN and name ~= "" then
                        local lower = name:lower()
                        -- Gas cloud
                        if isObstacle and lower:find('gas', 1, true) and lower:find('cloud', 1, true) then
                            table.insert(s.gasClouds, obj)
                        end
                        -- Hideable token (whitelist)
                        if FOW_HIDEABLE_TOKENS[lower] then
                            table.insert(s.hideableTokens, obj)
                        else
                            for k in pairs(FOW_HIDEABLE_TOKENS) do
                                if lower:sub(1, #k) == k then
                                    table.insert(s.hideableTokens, obj)
                                    break
                                end
                            end
                        end
                        -- Reveal source by name (not a ship)
                        if fow_nameMatchesReveal(name) then
                            table.insert(s.revealNamed, obj)
                        end
                    end
                    -- Cloak token
                    local okV, tt = pcall(function() return obj.getVar('__XW_TokenType') end)
                    if okV and tt == 'cloak' then
                        table.insert(s.cloakTokens, obj)
                    end
                end
            end
        end
    end
    FogOfWar._scan = s
    FogOfWar._scanTime = Time.time
    return s
end

if EventSub and EventSub.Register then
    EventSub.Register('onObjectSpawned', fow_invalidateScan)
    EventSub.Register('onObjectDestroyed', fow_invalidateScan)
end

local function fog_check_impl()
    local all_ships = getObjectsWithTag('Ship')
    local player_colors = {}
    for _, p in ipairs(Player.getPlayers()) do
        if not fow_isSpectator(p.color) then
            table.insert(player_colors, p.color)
        end
    end

    -- === IDLE SHORT-CIRCUIT ===
    -- If no ship has moved since last tick AND the classification scan is
    -- still valid AND we have a previous ship_hide result, skip everything.
    -- This makes stationary ticks essentially free.
    local shipPosCache = FogOfWar._shipPosCache or {}
    local anyShipMoved = false
    local currentGuids = {}
    for _, s in pairs(all_ships) do
        local g = s.getGUID()
        currentGuids[g] = true
        local prev = shipPosCache[g]
        local cur = s.getPosition()
        if not prev or not _pos_unchanged(prev, cur) then
            anyShipMoved = true
            shipPosCache[g] = _copyPos(cur)
        end
    end
    -- Ship count changed?
    for g in pairs(shipPosCache) do
        if not currentGuids[g] then
            shipPosCache[g] = nil
            anyShipMoved = true
        end
    end
    FogOfWar._shipPosCache = shipPosCache
    if not anyShipMoved
        and FogOfWar._scan
        and next(FogOfWar._shipHide or {}) ~= nil
        and not FogOfWar._forceNext then
        return -- nothing to do
    end
    FogOfWar._forceNext = false

    -- Reuse the cross-tick classification scan.
    local scan = fow_scan()

    -- Persistent pairwise distance cache with position-change invalidation.
    -- A pair stays cached until either ship moves more than posEps.
    local dCache = FogOfWar._distCache
    local function cached_dist(a, b)
        local ag, bg = a.getGUID(), b.getGUID()
        local key = (ag < bg) and (ag .. ":" .. bg) or (bg .. ":" .. ag)
        local e = dCache[key]
        local pa = a.getPosition()
        local pb = b.getPosition()
        if e and _pos_unchanged(e.pa, pa) and _pos_unchanged(e.pb, pb) then
            return e.d
        end
        local d = fow_baseDistMm(a, b)
        dCache[key] = { d = d, pa = _copyPos(pa), pb = _copyPos(pb) }
        return d
    end

    -- Persistent pairwise LOS cache with position-change invalidation.
    -- Physics.cast is the slowest single call in TTS; cache aggressively.
    local lCache = FogOfWar._losCache
    local function cached_los(a, b)
        local key = a.getGUID() .. ":" .. b.getGUID()
        local e = lCache[key]
        local pa = a.getPosition()
        local pb = b.getPosition()
        if e and _pos_unchanged(e.pa, pa) and _pos_unchanged(e.pb, pb) then
            return e.r
        end
        local r = fow_losStatus(a, b)
        lCache[key] = { r = r, pa = _copyPos(pa), pb = _copyPos(pb) }
        return r
    end

    local alwaysVisible    = fow_collectAlwaysVisible(all_ships, scan.revealNamed)
    local cloakedShips     = fow_collectCloaked(scan.cloakTokens)
    local lockReveals      = fow_collectLockReveals(all_ships)
    local claimedObjectives = fow_collectClaims()
    local gasClouds        = scan.gasClouds

    -- Precompute per-ship gas concealment
    local gasConcealedMap = {}
    for _, s in pairs(all_ships) do
        local concealed = false
        for _, c in ipairs(gasClouds) do
            if cached_dist(s, c) < FogOfWar.claimRangeMm then concealed = true; break end
        end
        gasConcealedMap[s.getGUID()] = concealed
    end

    local dbg = FogOfWar.debug
    if dbg then
        FogOfWar.debug = false
        local pcs = ""
        for _, c in ipairs(player_colors) do pcs = pcs .. c .. "," end
        printToAll("[Fog] seated: " .. pcs
            .. "| ships=" .. #all_ships
            .. "| alwaysVis=" .. (next(alwaysVisible) and "yes" or "no")
            .. "| cloaked=" .. (next(cloakedShips) and "yes" or "no")
            .. "| claims=" .. #claimedObjectives
            .. "| locks=" .. (next(lockReveals) and "yes" or "no")
            .. "| gas=" .. #gasClouds,
            { 1, 0.8, 0.2 })
    end

    -- Phase 1: compute per-ship hide_from and apply to the ship itself
    local ship_hide = {}
    for _, ship in pairs(all_ships) do
        local owner = ship.getVar('owningPlayer')
        if owner then
            local shipGuid = ship.getGUID()
            local hide_from = {}

            if not alwaysVisible[shipGuid] then
                local lockSet = lockReveals[shipGuid] or {}
                local gasHidden = gasConcealedMap[shipGuid]
                for _, pc in ipairs(player_colors) do
                    if not fow_sameTeam(owner, pc) then
                        local visible = false

                        -- Target lock overrides everything
                        if lockSet[pc] then visible = true end

                        -- Range + LOS check via friendlies
                        if not visible then
                            local spotMm = cloakedShips[shipGuid] and FogOfWar.cloakRangeMm or FogOfWar.rangeMm
                            for _, friendly in pairs(all_ships) do
                                if friendly.getGUID() ~= shipGuid then
                                    local fo = friendly.getVar('owningPlayer')
                                    if fo and fow_sameTeam(fo, pc) then
                                        if cached_dist(ship, friendly) < spotMm then
                                            if cached_los(friendly, ship) == 'clean' then
                                                visible = true
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        -- Gas cloud concealment: if target is inside R1 of a gas
                        -- cloud, it's hidden unless a viewer is within R1 of it.
                        if visible and gasHidden then
                            local viewerNear = false
                            for _, friendly in pairs(all_ships) do
                                if friendly.getGUID() ~= shipGuid then
                                    local fo = friendly.getVar('owningPlayer')
                                    if fo and fow_sameTeam(fo, pc) then
                                        if cached_dist(ship, friendly) < FogOfWar.claimRangeMm then
                                            viewerNear = true
                                            break
                                        end
                                    end
                                end
                            end
                            -- Lock still sees them regardless of gas
                            if not viewerNear and not lockSet[pc] then
                                visible = false
                            end
                        end

                        -- Claim R1 vision from a claimed objective
                        if not visible then
                            for _, entry in ipairs(claimedObjectives) do
                                if fow_sameTeam(entry.by, pc) then
                                    if cached_dist(ship, entry.obj) < FogOfWar.claimRangeMm then
                                        visible = true
                                        break
                                    end
                                end
                            end
                        end

                        if not visible then table.insert(hide_from, pc) end
                    end
                end
            end

            ship_hide[shipGuid] = hide_from
            ship.setInvisibleTo(hide_from)

            if ship.UI then
                pcall(function()
                    if #hide_from > 0 then
                        ship.UI.setAttribute('Plate', 'visibility', owner)
                    else
                        ship.UI.setAttribute('Plate', 'visibility', '')
                    end
                end)
            end

            if dbg then
                local hs = ""
                for _, c in ipairs(hide_from) do hs = hs .. c .. "," end
                printToAll("[Fog] " .. ship.getName() .. " owner=" .. tostring(owner)
                    .. " hide_from=" .. (hs == "" and "(none)" or hs), { 0.8, 0.8, 1 })
            end
        end
    end

    -- Phase 2 skip: if no ship's hide list changed since last tick, skip the
    -- whole token pass entirely — nothing to update.
    local prevHide = FogOfWar._shipHide or {}
    local anyChanged = false
    if next(prevHide) == nil then
        anyChanged = true
    else
        for g, hf in pairs(ship_hide) do
            local prev = prevHide[g]
            if not prev or #prev ~= #hf then anyChanged = true; break end
            for i = 1, #hf do
                if prev[i] ~= hf[i] then anyChanged = true; break end
            end
            if anyChanged then break end
        end
        if not anyChanged then
            for g in pairs(prevHide) do
                if not ship_hide[g] then anyChanged = true; break end
            end
        end
    end
    FogOfWar._shipHide = ship_hide
    if not anyChanged then return end

    -- Phase 2: only whitelisted token types follow their parent ship's hide.
    -- Uses the pre-filtered hideableTokens bucket from the classification
    -- scan — no per-object getName() calls here.
    local new_managed = {}
    for _, obj in ipairs(scan.hideableTokens) do
        local parent = nil
        -- 1. TokenModule assignment (authoritative)
        if type(TokenModule) == "table" and type(TokenModule.tokenAssignments) == "table" then
            local a = TokenModule.tokenAssignments[obj.getGUID()]
            if a then parent = a end
        end
        -- 2. Cloak-style: assignedShip var
        if not parent then
            local ok, s = pcall(function() return obj.getVar('assignedShip') end)
            if ok and s then parent = s end
        end
        -- 3. Proximity fallback — nearest ship within nearbyHideIgu
        if not parent then
            local opos = obj.getPosition()
            local best, bestD = nil, FogOfWar.nearbyHideIgu
            for _, s in pairs(all_ships) do
                local d = s.getPosition():distance(opos)
                if d < bestD then bestD = d; best = s end
            end
            parent = best
        end

        if parent then
            local ok, pg = pcall(function() return parent.getGUID() end)
            if ok and pg and ship_hide[pg] then
                obj.setInvisibleTo(ship_hide[pg])
                new_managed[obj.getGUID()] = true
            end
        end
    end

    -- Clear hiding on objects that were managed last tick but aren't this tick
    local prev = FogOfWar._managedTokens or {}
    for guid, _ in pairs(prev) do
        if not new_managed[guid] then
            local o = getObjectFromGUID(guid)
            if o then o.setInvisibleTo({}) end
        end
    end
    FogOfWar._managedTokens = new_managed
end

-- Minimum seconds between polling-driven fog checks. The Wait.time scheduler
-- in Global fires fog_check every 0.3s, but we rate-limit it internally so it
-- effectively runs at most once per second when idle. Event-driven calls
-- bypass this limit via FogOfWar.scheduleCheck() below.
FogOfWar.minPollInterval = 2.0
FogOfWar._lastRunTime    = 0
FogOfWar._pendingCheck   = false

local function fow_run_now()
    FogOfWar._lastRunTime = Time.time
    local ok, err = pcall(fog_check_impl)
    if not ok then
        printToAll("[Fog] error: " .. tostring(err), { 1, 0.2, 0.2 })
    end
end

-- Called by the Wait.time polling scheduler (every 0.3s). Intentionally a
-- no-op: fog checks are entirely event-driven now. If you toggle fog on and
-- visibility doesn't update for something, it's because the trigger for that
-- change isn't hooked yet — tell me which action and I'll wire it up.
FogOfWar.fog_check = function()
    -- passive polling disabled
end

-- Event-driven: schedule a debounced fog check. Multiple events in the same
-- burst coalesce into one update ~10 frames later. Bypasses the poll rate
-- limit so ship movement / token drops update immediately.
FogOfWar.scheduleCheck = function()
    if not FogOfWar.enabled then return end
    if FogOfWar._pendingCheck then return end
    FogOfWar._pendingCheck = true
    Wait.frames(function()
        FogOfWar._pendingCheck = false
        if FogOfWar.enabled then
            FogOfWar._forceNext = true -- bypass idle short-circuit
            fow_run_now()
        end
    end, 10)
end

-- Register a global onObjectDropped handler that triggers fog check when a
-- fog-relevant object is dropped. Uses the mod's EventSub system.
local function fow_onDropped(player_color, obj)
    if not obj or not FogOfWar.enabled then return end
    if obj.hasTag('Ship') then
        FogOfWar.scheduleCheck()
        return
    end
    if obj.hasTag('Objective') or obj.hasTag('CenterObjective') then
        FogOfWar.scheduleCheck()
        return
    end
    local name = obj.getName() or ''
    if fow_nameMatchesReveal(name) or fow_isHideableToken(obj) then
        FogOfWar.scheduleCheck()
        return
    end
end
if EventSub and EventSub.Register then
    EventSub.Register('onObjectDropped', fow_onDropped)
end

-- Lightweight ship-movement poller. Scripted moves (dial/template) don't
-- fire onObjectDropped, so we have to detect them by watching positions.
-- This does NOT run the full fog check — only reads positions and, if any
-- ship moved, schedules the real check. Typical cost per tick: ~N
-- getPosition() calls for N ships. Idle cost: essentially zero.
-- Direct activity poller. Every 0.5s:
--   - Check ship positions → if any moved, run fog_check_impl
--   - Check objective tints → if any changed (claim/unclaim), run fog_check_impl
-- Idle cost: ~N getPosition + ~M getColorTint calls, then return.
FogOfWar._movePollCache = {}
FogOfWar._tintPollCache = {}
FogOfWar._activityRunning = false

FogOfWar.activityPoll = function()
    if not FogOfWar.enabled then return end
    local dirty = false

    local shipCache = FogOfWar._movePollCache
    local seen = {}
    for _, s in ipairs(getObjectsWithTag('Ship')) do
        local g = s.getGUID()
        seen[g] = true
        local cur = s.getPosition()
        local prev = shipCache[g]
        if not prev or not _pos_unchanged(prev, cur) then
            shipCache[g] = _copyPos(cur)
            dirty = true
        end
    end
    for g in pairs(shipCache) do
        if not seen[g] then shipCache[g] = nil; dirty = true end
    end

    local tintCache = FogOfWar._tintPollCache
    local seenT = {}
    for _, tag in ipairs({ 'Objective', 'CenterObjective' }) do
        for _, o in ipairs(getObjectsWithTag(tag)) do
            local g = o.getGUID()
            seenT[g] = true
            local ok, tint = pcall(function() return o.getColorTint() end)
            if ok and tint then
                local r, gc, b =
                    tint[1] or tint.r or 0,
                    tint[2] or tint.g or 0,
                    tint[3] or tint.b or 0
                local key = string.format("%.2f,%.2f,%.2f", r, gc, b)
                if tintCache[g] ~= key then
                    tintCache[g] = key
                    dirty = true
                end
            end
        end
    end
    for g in pairs(tintCache) do
        if not seenT[g] then tintCache[g] = nil; dirty = true end
    end

    if dirty then
        FogOfWar._forceNext = true
        fow_run_now()
    end
end

FogOfWar.startActivityPoller = function()
    if FogOfWar._activityRunning then return end
    FogOfWar._activityRunning = true
    Wait.time(FogOfWar.activityPoll, 0.5, -1)
end
-- Start immediately on module load (top-level call)
FogOfWar.startActivityPoller()

FogOfWar.toggle = function()
    FogOfWar.enabled = not FogOfWar.enabled
    for _, ship in pairs(getObjectsWithTag('Ship')) do
        ship.setInvisibleTo({})
    end
    -- Wipe caches on every toggle so state is clean.
    FogOfWar._distCache = {}
    FogOfWar._losCache  = {}
    FogOfWar._shipHide  = {}
    FogOfWar._scan      = nil
    FogOfWar._managedTokens = {}
    FogOfWar._shipPosCache = {}
    if FogOfWar.enabled then
        FogOfWar.debug = true
        FogOfWar._lastRunTime = 0
        FogOfWar._forceNext = true
        FogOfWar.startActivityPoller()
        FogOfWar.scheduleCheck()
    end
    printToAll("Fog of War [" .. FogOfWar.BUILD .. "]: " .. (FogOfWar.enabled and "ON" or "OFF"), {1, 0.4, 0})
end

function API_ToggleFogOfWar()
    FogOfWar.toggle()
end