local Dim = require("Dim")
local ShipVerification = require("Ship.ShipVerification")
local Vect = require("TTS_Lib.Vector.Vector")
local Decker = require("Game.Component.Spawner.Decker")

local Spawner = {}
local PILOT_CARD_SCRIPT_URL =
    "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/TTS_xwing/src/Game/Component/Spawner/PilotCard.lua"
local LIMITED_PILOT_BULLET = "•"
local cachedPilotCardScript = nil
local pendingSpawnRequests = {}
local isLoadingPilotCardScript = false

local function RotMatrix(axis, angDeg)
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

local function RotateVector(rotMat, vect)
    local out = { 0, 0, 0 }
    for i = 1, 3, 1 do
        for j = 1, 3, 1 do
            out[i] = out[i] + rotMat[i][j] * vect[j]
        end
    end
    return out
end

local function LocalPos(object, position)
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

local configTokenScript =
[[
__XW_Token = true
__XW_TokenIdle = true
__XW_TokenType = 'config'

self.addTag('Flippable')

function onFlip()
    local ship = Global.call("getShipTokenIsAssignedTo", { token = self })
    if ship and ship.getVar("SetConfiguration") then
        ship.call("SetConfiguration", { ConfigId = self.is_face_down and 1 or 2 })
    end
end
]]

--spawner function, checks for Pilots and Upgrades lists and spawn the respective objects

local legacyFactionKeys = {
    [0] = "dummy",
    [1] = "rebelalliance",
    [2] = "galacticempire",
    [3] = "scumandvillainy",
    [4] = "resistance",
    [5] = "firstorder",
    [6] = "galacticrepublic",
    [7] = "separatistalliance",
    Dum = "dummy",
    Reb = "rebelalliance",
    Imp = "galacticempire",
    Scu = "scumandvillainy",
    Res = "resistance",
    For = "firstorder",
    Rep = "galacticrepublic",
    Cis = "separatistalliance",
}

local function normalizeLegacySpawnerList(listTable)
    if listTable == nil then
        return
    end

    listTable.Faction = legacyFactionKeys[listTable.Faction] or listTable.Faction
    for _, pilot in pairs(listTable.Pilots or {}) do
        if pilot.Data ~= nil then
            pilot.Data.Faction = legacyFactionKeys[pilot.Data.Faction] or pilot.Data.Faction
        end
    end
end

local function createSpawnSession(spawnCard, anchorPosition, anchorRotation)
    local session = {
        spawnCard = spawnCard,
        anchorPosition = anchorPosition,
        anchorRotation = anchorRotation,
        spawnedGUIDs = {},
        spawnedGUIDLookup = {},
        waitIDs = {},
        pendingWaits = 0,
        synchronousPhaseComplete = false,
        failed = false,
        complete = false
    }

    function session:track(object)
        if object == nil then
            return object
        end

        local guid = object.getGUID()
        if guid ~= nil and not self.spawnedGUIDLookup[guid] then
            self.spawnedGUIDLookup[guid] = true
            table.insert(self.spawnedGUIDs, guid)
        end
        return object
    end

    function session:restoreAnchor()
        self.spawnCard.setPosition(self.anchorPosition)
        self.spawnCard.setRotation(self.anchorRotation)
    end

    function session:stopPendingWaits()
        for waitID, _ in pairs(self.waitIDs) do
            Wait.stop(waitID)
        end
        self.waitIDs = {}
        self.pendingWaits = 0
    end

    function session:destroySpawnedObjects()
        for index = #self.spawnedGUIDs, 1, -1 do
            local object = getObjectFromGUID(self.spawnedGUIDs[index])
            if object ~= nil then
                object.destruct()
            end
        end
        self.spawnedGUIDs = {}
        self.spawnedGUIDLookup = {}
    end

    function session:fail(spawnError)
        if self.failed or self.complete then
            return
        end

        self.failed = true
        self:stopPendingWaits()
        self:destroySpawnedObjects()
        self:restoreAnchor()
        printToAll("Spawner failed; created squad objects were removed.", { 1, 0.2, 0.2 })
        print("Spawner failure: " .. tostring(spawnError))
    end

    function session:tryComplete()
        if not self.failed and self.synchronousPhaseComplete and self.pendingWaits == 0 then
            self.complete = true
            self.spawnedGUIDs = {}
            self.spawnedGUIDLookup = {}
        end
    end

    function session:finishSynchronousPhase()
        self.synchronousPhaseComplete = true
        self:tryComplete()
    end

    function session:waitCondition(action, condition)
        if self.failed then
            return
        end

        self.pendingWaits = self.pendingWaits + 1
        local waitID
        local function executeAction()
            self.waitIDs[waitID] = nil
            self.pendingWaits = self.pendingWaits - 1
            if self.failed then
                return
            end

            local success, actionError = pcall(action)
            if not success then
                self:fail(actionError)
                return
            end
            self:tryComplete()
        end
        local function evaluateCondition()
            if self.failed then
                return false
            end

            local success, isReady = pcall(condition)
            if not success then
                self:fail(isReady)
                return false
            end
            return isReady
        end

        waitID = Wait.condition(executeAction, evaluateCondition)
        self.waitIDs[waitID] = true
    end

    function session:waitFrames(action, frameCount)
        if self.failed then
            return
        end

        self.pendingWaits = self.pendingWaits + 1
        local waitID
        local function executeAction()
            self.waitIDs[waitID] = nil
            self.pendingWaits = self.pendingWaits - 1
            if self.failed then
                return
            end

            local success, actionError = pcall(action)
            if not success then
                self:fail(actionError)
                return
            end
            self:tryComplete()
        end

        waitID = Wait.frames(executeAction, frameCount)
        self.waitIDs[waitID] = true
    end

    return session
end

local function initializeSpawnerAccessoryContext(context, spawnCard, bagPosition)
    context.bag = getObjectFromGUID(bagGuids['Accessories']).clone({ position = bagPosition })
    context.tokens = {}
    context.borrowedSources = {}
    context.accessories = context.bag.getObjects()

    for _, accessory in ipairs(context.accessories) do
        if accessory.name == 'Charge' or accessory.name == 'Force' or accessory.name == 'Shield' or
            accessory.name == 'Energy' then
            context.tokens[accessory.name] = context.bag.takeObject({
                rotation = spawnCard.getRotation(),
                guid = accessory.guid,
                smooth = false
            })
        end
    end

end

local function takeSpawnerAccessorySource(context, parameters)
    local source = context.bag.takeObject(parameters)
    context.borrowedSources[source.getGUID()] = true
    return source
end

local function returnSpawnerAccessorySource(context, source)
    local guid = source.getGUID()
    context.bag.putObject(source)
    context.borrowedSources[guid] = nil
end

local function destroySpawnerAccessoryContext(context)
    if context == nil then
        return
    end
    for guid, _ in pairs(context.borrowedSources or {}) do
        local source = getObjectFromGUID(guid)
        if source ~= nil then
            source.destruct()
        end
    end
    if context.bag ~= nil then
        context.bag.destruct()
    end
    for _, token in pairs(context.tokens or {}) do
        token.destruct()
    end
end

local function cloneSpawnerToken(session, template, position, ownerVar, owner, tokenName)
    local token = session:track(template.clone())
    token.setPosition(position)
    token.setVar(ownerVar, owner)
    if tokenName ~= nil then
        token.setVar("charge_name", tokenName)
    end
    return token
end

local function spawnPilotResourceTokens(session, pilot, spawnCard, tokens, hasMobileUpgrade)
    -- Spawn pilot and standardized-loadout charge tokens.
    if pilot.Charge > 0 or pilot.standardized_loadout then
        local chargeValue = pilot.Charge
        while chargeValue > 0 do
            chargeValue = chargeValue - 1
            local position
            if pilot.standardized_loadout then
                position = LocalPos(spawnCard, { 0.5 + 0.9 * chargeValue, 1, 3.4 })
                if chargeValue > 2 then
                    position = LocalPos(spawnCard, { 0.5 + 0.9 * (chargeValue - 3), 1, 2.5 })
                end
            elseif chargeValue == 3 then
                position = LocalPos(spawnCard, { -0.9, 1, 0.6 })
            elseif chargeValue == 2 then
                position = LocalPos(spawnCard, { 0.9, 1, 1.6 })
            elseif chargeValue == 1 then
                position = LocalPos(spawnCard, { 0, 1, 1.6 })
            elseif chargeValue == 0 then
                position = LocalPos(spawnCard, { -0.9, 1, 1.6 })
            else
                position = vector(0, 0, 0)
            end
            cloneSpawnerToken(session, tokens.Charge, position, "charge_owner", pilot.name)
        end

        if pilot.standardized_loadout and pilot.standardized_upgrades then
            local totalHeight = 3.0
            local step = totalHeight / #pilot.standardized_upgrades
            for index, upgrade in pairs(pilot.standardized_upgrades) do
                if upgrade.charge > 0 then
                    for chargeIndex = 1, upgrade.charge, 1 do
                        local token = cloneSpawnerToken(
                            session,
                            tokens.Charge,
                            LocalPos(spawnCard, { -2.7 - chargeIndex * 0.6, 1, 4 + step * (index - 1) + step / 2 }),
                            "charge_owner",
                            pilot.name,
                            upgrade.name
                        )
                        token.setScale(token.getScale() * 0.75)
                    end
                end
            end
        end
    end

    if pilot.Force > 0 then
        local forceValue = pilot.Force
        while forceValue > 0 do
            forceValue = forceValue - 1
            local position
            if pilot.standardized_loadout then
                position = LocalPos(spawnCard, { 3.2, 1, 4.5 + 0.9 * forceValue })
            elseif hasMobileUpgrade == 1 then
                position = LocalPos(spawnCard, { 1.7 + 0.9 * forceValue, 1, 3.4 })
                if forceValue > 2 then
                    position = LocalPos(spawnCard, { 1.7 + 0.9 * (forceValue - 3), 1, 2.5 })
                end
            else
                position = LocalPos(spawnCard, { 1.7, 1, 3.7 + 0.9 * forceValue })
            end
            cloneSpawnerToken(session, tokens.Force, position, "force_owner", pilot.name)
        end
    end

    if pilot.Energy > 0 then
        local energyValue = pilot.Energy
        while energyValue > 0 do
            energyValue = energyValue - 1
            local position
            if pilot.standardized_loadout then
                position = LocalPos(spawnCard, { 0.5 + 0.9 * energyValue, 1, 3.4 })
                if energyValue > 2 then
                    position = LocalPos(spawnCard, { 0.5 + 0.9 * (energyValue - 3), 1, 2.5 })
                end
            else
                position = LocalPos(spawnCard, { 1.7, 1, 3.7 + 0.9 * energyValue })
            end
            cloneSpawnerToken(session, tokens.Energy, position, "energy_owner", pilot.name)
        end
    end

    if pilot.Shield > 0 then
        local shieldValue = pilot.Shield
        while shieldValue > 0 do
            shieldValue = shieldValue - 1
            local position
            if pilot.standardized_loadout then
                position = LocalPos(spawnCard, { -2.2 + 0.9 * shieldValue, 1, 3.4 })
                if shieldValue > 5 then
                    position = LocalPos(spawnCard, { -2.2 + 0.9 * (shieldValue - 6), 1, 1.6 })
                elseif shieldValue > 2 then
                    position = LocalPos(spawnCard, { -2.2 + 0.9 * (shieldValue - 3), 1, 2.5 })
                end
            else
                position = LocalPos(spawnCard, { -1 + 0.9 * shieldValue, 1, 3.4 })
                if shieldValue > 5 then
                    position = LocalPos(spawnCard, { -1 + 0.9 * (shieldValue - 6), 1, 1.6 })
                elseif shieldValue > 2 then
                    position = LocalPos(spawnCard, { -1 + 0.9 * (shieldValue - 3), 1, 2.5 })
                end
            end
            cloneSpawnerToken(session, tokens.Shield, position, "shield_owner", pilot.name)
        end
    end
end

local function cloneSpawnerAccessory(session, accessoryContext, accessory, position, rotation)
    local source = takeSpawnerAccessorySource(accessoryContext, {
        position = position,
        rotation = rotation,
        guid = accessory.guid,
        smooth = false
    })
    local clone = session:track(source.clone())
    clone.setPosition(position)
    returnSpawnerAccessorySource(accessoryContext, source)
    return clone
end

local function cloneAllMatchingSpawnerAccessories(session, accessoryContext, accessoryName, position, rotation)
    local clones = {}
    for _, accessory in pairs(accessoryContext.accessories) do
        if accessory.name == accessoryName then
            table.insert(clones, cloneSpawnerAccessory(session, accessoryContext, accessory, position, rotation))
        end
    end
    return clones
end

local function spawnAssignableAccessories(session, accessoryContext, accessoryName, position, rotation)
    for _, clone in ipairs(cloneAllMatchingSpawnerAccessories(session, accessoryContext, accessoryName, position,
        rotation)) do
        clone.addTag("Assignable")
    end
end

local function spawnPilotAccessories(session, pilot, spawnCard, accessoryContext, faction, rotation, arcPosition)
    for mount, turret in pairs(pilot.Data.arcs.turret or {}) do
        local indicatorName = 'Arc Indicator' .. tostring(faction)
        if turret.type[1] == 'doubleturret' then
            indicatorName = 'Dual Arc Indicator' .. tostring(faction)
        end
        local mountingPoint = pilot.Data.mountingPoints[mount]
        local offset = LocalPos(spawnCard, { mountingPoint[1], 0, mountingPoint[2] + 9 })
        for _, indicator in ipairs(cloneAllMatchingSpawnerAccessories(session, accessoryContext, indicatorName, offset,
            rotation)) do
            indicator.setPosition(arcPosition)
            indicator.setName(string.gsub(indicator.getName(), faction, ''))
        end
    end

    local markerPosition = LocalPos(spawnCard, { -1.5, 1, 8.7 })
    if pilot.Bomb == true then
        for _, bombDrop in ipairs(cloneAllMatchingSpawnerAccessories(session, accessoryContext, 'Bomb drop token (unassigned)',
            markerPosition, rotation)) do
            bombDrop.setDescription(pilot.bombD)
        end
    end
    if pilot.Docking == true then
        cloneAllMatchingSpawnerAccessories(session, accessoryContext, 'Shuttle Launcher (assigned to mothership)',
            markerPosition,
            rotation)
    end
    if pilot.wingleader == true then
        cloneAllMatchingSpawnerAccessories(session, accessoryContext, 'Epic Wing Token', markerPosition, rotation)
    end
end

local function spawnSpawnerRemotes(session, remotes, spawnCard, accessoryContext)
    for _, remote in pairs(remotes or {}) do
        local remoteName = type(remote) == 'table' and remote.name or remote
        local remoteCharge = type(remote) == 'table' and (remote.Charge or 0) or 0
        print("Spawning remote:" .. remoteName)
        for _, accessory in ipairs(accessoryContext.accessories) do
            if accessory.name == remoteName then
                local position = LocalPos(spawnCard, { 1, 1, 0 })
                print("Found remote, spawning pos: " .. tostring(position[1]) .. "," ..
                    tostring(position[2]) .. "," .. tostring(position[3]))
                cloneSpawnerAccessory(session, accessoryContext, accessory, position, spawnCard.getRotation())

                local charge = remoteCharge
                while charge > 0 do
                    local chargePosition
                    if charge == 2 then
                        chargePosition = LocalPos(spawnCard, { 1.45, 1, -2.2 })
                    elseif charge == 1 then
                        chargePosition = LocalPos(spawnCard, { 0.55, 1, -2.2 })
                    end
                    charge = charge - 1
                    cloneSpawnerToken(session, accessoryContext.tokens.Charge, chargePosition, "charge_owner", remoteName,
                        remoteName)
                end

                spawnCard.setPosition(LocalPos(spawnCard, { -3, 0, 0 }))
                break
            end
        end
    end
end

local function spawnSpawnerObstacles(session, obstacles, spawnCard, bagPosition)
    if obstacles == nil then
        return
    end

    local obstacleBag = getObjectFromGUID(bagGuids['Obstacles']).clone({ position = bagPosition })
    local borrowedObstacles = {}
    local success, spawnError = pcall(function()
        local availableObstacles = obstacleBag.getObjects()
        for _, obstacleName in ipairs(obstacles) do
            local found = false
            for _, obstacle in ipairs(availableObstacles) do
                if obstacle.name == obstacleName then
                    print("Found obstacle: " .. obstacle.name .. " - " .. obstacleName)
                    local position = LocalPos(spawnCard, { 0, 1, 0 })
                    local obstacleToken = obstacleBag.takeObject({
                        rotation = spawnCard.getRotation(),
                        guid = obstacle.guid,
                        smooth = false
                    })
                    local obstacleGuid = obstacleToken.getGUID()
                    borrowedObstacles[obstacleGuid] = true
                    local obstacleClone = session:track(obstacleToken.clone())
                    obstacleClone.setPosition(position)
                    obstacleBag.putObject(obstacleToken)
                    borrowedObstacles[obstacleGuid] = nil
                    found = true
                    break
                end
            end
            if not found then
                print("Couldnt find obstacle: " .. obstacleName)
            else
                spawnCard.setPosition(LocalPos(spawnCard, { -4, 0, 0 }))
            end
        end
    end)
    obstacleBag.destruct()
    for guid, _ in pairs(borrowedObstacles) do
        local source = getObjectFromGUID(guid)
        if source ~= nil then
            source.destruct()
        end
    end

    if not success then
        error(spawnError)
    end
end

local function spawnPilotCardAndDial(context, pilot, pilotName, pilotCustomization, tint)
    local session = context.session
    local accessoryContext = context.accessoryContext
    local spawnCard = context.spawnCard
    local dialSkin = context.dialSkin
    local pilotCardScript = context.pilotCardScript

    local card = pilotCustomization.face or pilot.card
    local cardB = pilotCustomization.back or pilot.cardB
    local pos = LocalPos(spawnCard, { 0, 1.2, 5.5 })
    local rot = spawnCard.getRotation()
    local pilotCard = nil

    if card ~= '' and cardB ~= nil then
        local deck = Decker.Asset(card, cardB)
        local spawnedCard = Decker.Card(deck, 1, 1)
        pilotCard = session:track(spawnedCard:spawn({ position = pos, rotation = rot }))
        pilotCard.setName(pilotName)
        pilotCard.setDescription(pilot.list)
        pilotCard.setLuaScript(pilotCardScript)
        pilotCard.setTable("PointsTrackerConfig", {
            landscape = pilot.standardized_loadout == true,
            visible = ShouldShowShipPointsTrackerForCurrentLayout()
        })
        pilotCard.setLock(true)

        local idpos = pos
        local idrot = rot
        local trackedCard = pilotCard
        local pilotIdSpawnFunc = function()
            local pilotId = session:track(spawnObject({
                type = "Custom_Model",
                position = idpos,
                rotation = idrot,
                scale = Dim.mm_ship_scale,
                sound = false,
                snap_to_grid = false,
            }))
            pilotId.setCustomObject({
                mesh =
                '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/cardid.obj',
                convex = true,
                material = 1,
                type = 0
            })
            pilotId.setColorTint(tint)
            trackedCard.addAttachment(pilotId)
            trackedCard.setLock(false)
        end
        session:waitCondition(pilotIdSpawnFunc, function()
            return not trackedCard.spawning
        end)
    end

    if pilotName ~= '' then
        for _, acc in pairs(accessoryContext.accessories) do
            if acc.name == 'Unassigned Dial' then
                local dialpos = LocalPos(spawnCard, { 0, 1, 13.2 })
                local dialrot = rot
                local dial = takeSpawnerAccessorySource(accessoryContext, {
                    position = dialpos,
                    rotation = dialrot,
                    guid = acc.guid
                })
                local newDial = session:track(dial.clone())
                newDial.setPosition(pos)
                returnSpawnerAccessorySource(accessoryContext, dial)
                local conditionFunc = function()
                    return pilotCard ~= nil and (not pilotCard.spawning) and (not newDial.spawning)
                end
                local executeFunc = function()
                    newDial.setCustomObject({ ['diffuse'] = dialSkin })
                    newDial = session:track(newDial.reload())
                    newDial.setColorTint(tint)
                    newDial.setPosition(dialpos)
                    newDial.setRotation(dialrot)
                    if pilotCard ~= nil then
                        pilotCard.call('addTintObject', { 'dial', newDial })
                    end
                end
                session:waitCondition(executeFunc, conditionFunc)
            end
        end
    end

    return pilotCard
end

local function resolvePilotTexture(pilot, pilotCustomization, pilotName)
    if pilotCustomization.texture ~= nil then
        return pilotCustomization.texture
    end

    local textureKey = pilot.Data.texture
    local textureUrl
    if textureKey ~= nil and pilot.Data.textures ~= nil then
        textureUrl = pilot.Data.textures[textureKey]
    end
    if textureUrl ~= nil then
        return '{verifycache}' .. textureUrl
    end
    if textureKey ~= nil then
        print("Missing ship texture '" .. tostring(textureKey) .. "' for " .. tostring(pilotName) ..
            " (" .. tostring(pilot.Data.shipId) .. ")")
    end
    return nil
end

local function spawnCompositeShipBase(context, pilot, pilotName, texture, modeltint)
    local session = context.session
    local spawnCard = context.spawnCard
    local faction = context.faction
    local spawnPrefix = context.spawnPrefix
    local factionnames = context.factionnames

    local shipoffset = vector(0, 2.2, 0)
    local size = pilot.Size
    local arcs = pilot.Data.arcs
    local fixedarc = "none"
    if arcs.fixed then
        fixedarc = arcs.fixed.type[1] or "none"
    end

    local pos
    if size == "huge" then
        pos = LocalPos(spawnCard, { 0, 0, 13.2 })
    else
        pos = LocalPos(spawnCard, { 0, 0, 10.2 })
    end
    local rot = spawnCard.getRotation()
    local base_prototype = getObjectFromGUID(CompositeBase_GUID)
    local factionName = factionnames[faction]
    if factionName == nil then
        print("Missing faction base texture for faction " .. tostring(faction) .. " on " .. tostring(pilotName))
        factionName = factionnames[1]
    end
    local baseDiffuse = spawnPrefix .. "bases/" .. size .. "/" .. fixedarc .. "/" .. factionName .. ".png"
    local newShip = session:track(base_prototype.clone())
    -- Move without collisions; dependent attachments wait until the fast smooth move completes.
    newShip.setPositionSmooth(pos, false, true)
    newShip.setRotationSmooth(rot, false, true)
    newShip.setScale(Dim.mm_ship_scale)

    newShip.setCustomObject({
        mesh = spawnPrefix .. "bases/" .. size .. "/base.obj?1",
        collider = ShipVerification.colliders[size],
        diffuse = baseDiffuse,
        convex = true,
        material = 1,
        type = 1
    })
    newShip.setTable("Data", pilot.Data)
    newShip.setLock(true)
    if pilot.Data.ProximityHider then
        newShip.addTag("ProximityHider")
    end

    local base_name_str = pilotName
    if pilot.Data.limited and pilot.Data.limited > 0 then
        base_name_str = string.rep(LIMITED_PILOT_BULLET, pilot.Data.limited) .. " " .. pilotName
    end
    newShip.setTable("UiData", {
        name = base_name_str,
        icon = pilot.Ship,
        init = "init" .. pilot.Data.initiative
    })

    local pegtype = pilot.peg or size
    local pegCustomObject = {
        mesh = spawnPrefix .. "bases/pegs/" .. pegtype .. ".obj",
        diffuse = baseDiffuse,
        collider =
        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/minisculebox.obj',
        convex = true,
        material = 1,
        type = 1
    }
    local shippos = pos
    local shiprot = rot
    local ship = newShip
    local shipCustomObject
    if pilot.Data.mesh then
        shipCustomObject = {
            mesh = '{verifycache}' .. pilot.Data.mesh,
            diffuse = texture,
            collider =
            '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/minisculebox.obj',
            convex = true,
            material = 1,
            type = 1
        }
    end

    local pegAndShipSpawnFunction = function()
        local pegModel = session:track(spawnObject({
            type         = "Custom_Model",
            position     = shippos,
            rotation     = shiprot,
            scale        = Dim.mm_ship_scale,
            sound        = false,
            snap_to_grid = false,
        }))
        pegModel.setName("Peg")
        pegModel.setCustomObject(pegCustomObject)
        ship.addAttachment(pegModel)
        if shipCustomObject then
            local shipModel = session:track(spawnObject({
                type         = "Custom_Model",
                position     = vector(shippos[1], shippos[2], shippos[3]) + shipoffset,
                rotation     = shiprot,
                scale        = Dim.mm_ship_scale,
                sound        = false,
                snap_to_grid = false,
            }))
            shipModel.setName("Ship")
            shipModel.setCustomObject(shipCustomObject)
            shipModel.setColorTint(modeltint)
            ship.addAttachment(shipModel)
        end
    end
    session:waitCondition(pegAndShipSpawnFunction,
        function() return (not ship.spawning) and (not ship.isSmoothMoving()) end)

    return {
        ship = ship,
        shipOffset = shipoffset,
        shipPosition = pos,
        shipRotation = rot,
    }
end

local function shipIdCustomObjectForSize(size)
    local customObj = {
        convex = true,
        material = 1,
        type = 1,
        collider =
        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/minisculebox.obj',
    }
    if size == "small" then
        customObj.mesh =
        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base_ID_Marker.obj'
    elseif size == "medium" then
        customObj.mesh =
        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base%20ID%20MED.obj'
    elseif size == "large" then
        customObj.mesh =
        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base%20ID%20LAR.obj'
    elseif size == "huge" then
        customObj.mesh =
        '{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/models/Base_ID_HUGE.obj'
    end
    return customObj
end

local function spawnShipIdentifiersAndConfig(context, pilot, pilotCard, tint, modeltint, texture, shipSpawnResult)
    local session = context.session
    local spawnCard = context.spawnCard

    local ship = shipSpawnResult.ship
    local shipoffset = shipSpawnResult.shipOffset
    local pos = shipSpawnResult.shipPosition
    local rot = shipSpawnResult.shipRotation

    local idpos = pos
    local idrot = rot
    local customObj = shipIdCustomObjectForSize(pilot.Size)

    local shipIdSpawnFunc = function()
        local shipId = session:track(spawnObject({
            type = "Custom_Model",
            position = idpos,
            rotation = idrot,
            scale = Dim.mm_ship_scale * 0.99,
            sound = false,
            snap_to_grid = false,
        }))
        shipId.setCustomObject(customObj)
        shipId.setColorTint(tint)
        shipId.setName("ColorId")
        ship.addAttachment(shipId)
        ship.setLock(false)
        ship.addTag("Ship")
        ship.drag_selectable = true
        ship.interactable = true

        if pilotCard ~= nil then
            pilotCard.call('addTintObject', { 'ship', ship })
        end
        ship.call('initContextMenu')
    end
    session:waitCondition(shipIdSpawnFunc,
        function()
            return (not ship.spawning) and (not ship.isSmoothMoving()) and (pilotCard == nil or not pilotCard.spawning)
        end)

    if pilot.Data.Config and pilot.Data.Config.States then
        for k, config in pairs(pilot.Data.Config.States) do
            if config.Model then
                local customObject = ship.getCustomObject()
                customObject.mesh = config.Model
                customObject.diffuse = texture
                local configSpawnFunction = function()
                    local configModel = session:track(spawnObject({
                        type = "Custom_Model",
                        position = vector(idpos[1], idpos[2], idpos[3]) + shipoffset,
                        rotation = idrot,
                        scale = Dim.mm_ship_scale,
                        sound = false,
                        snap_to_grid = false,
                    }))
                    configModel.setName("Config")
                    configModel.setDescription(tostring(k))
                    configModel.setCustomObject(customObject)
                    configModel.setColorTint(modeltint)
                    if k ~= 1 then
                        configModel.setScale(vector(0.0001, 0.0001, 0.0001))
                    end
                    ship.addAttachment(configModel)
                    session:waitFrames(function()
                        ship.call("DisableAttachedColliders")
                    end, 2)
                    session:waitFrames(function()
                        ship.call("DisableAttachedColliders")
                    end, 10)
                    session:waitFrames(function()
                        ship.call("DisableAttachedColliders")
                    end, 30)
                end
                session:waitCondition(configSpawnFunction,
                    function()
                        return (not ship.spawning) and (not ship.isSmoothMoving())
                    end)
            end
        end
        if pilot.Data.Config and pilot.Data.Config.Token then
            pos = LocalPos(spawnCard, { -1.5, 1, 8.7 })
            local configToken = session:track(spawnObject({
                type = "Custom_Model",
                scale = { 0.38, 0.38, 0.38 },
                rotation = { 0, 270, 0 },
                position = pos,
            }))
            configToken.setCustomObject({
                mesh =
                "https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/Items/tokens/flip/flipToken.obj",
                diffuse = pilot.Data.Config.Token,
                type = 5,
                material = 1,
                specular_intensity = 0
            })
            configToken.setLuaScript(configTokenScript)
        end
    end

    return {
        shipPosition = shipSpawnResult.shipPosition,
        shipRotation = shipSpawnResult.shipRotation,
    }
end

local function spawnPilotShipBundle(context, pilot, upgradeResult, pilotName, pilotCustomization, tint, modeltint, pilotCard)
    local configCardGUID = upgradeResult.configCardGUID
    local texture = resolvePilotTexture(pilot, pilotCustomization, pilotName)

    pilot.Data.ColorId = tint
    if pilot.Data.Config then
        pilot.Data.Config.CardGUID = configCardGUID
    end

    local shipSpawnResult = spawnCompositeShipBase(context, pilot, pilotName, texture, modeltint)

    return spawnShipIdentifiersAndConfig(context, pilot, pilotCard, tint, modeltint, texture, shipSpawnResult)
end

local function spawnPilotBundle(context, pilot, upgradeResult)
    if pilot.id == '' then
        return
    end

    local session = context.session
    local accessoryContext = context.accessoryContext
    local spawnCard = context.spawnCard
    local faction = context.faction
    local customization = context.customization
    local tokens = context.tokens

    local hasMob = upgradeResult.hasMobileUpgrade
    local upNum = upgradeResult.count

    local pilotName = pilot.name
    local pilotCustomization = customization[pilotName] or {}
    local tint = color(0, 0, 0, 0)
    local modeltint = color(1, 1, 1, 1)
    tint = pilotCustomization.tint or tint
    modeltint = pilotCustomization.modeltint or modeltint

    local pilotCard = spawnPilotCardAndDial(context, pilot, pilotName, pilotCustomization, tint)

    if pilot.Condition ~= nil then
        spawnAssignableAccessories(session, accessoryContext, pilot.Condition,
            LocalPos(spawnCard, { -2 - 1.78 * upNum, 1, 8 }), spawnCard.getRotation())
    end

    local shipBundleResult = spawnPilotShipBundle(context, pilot, upgradeResult, pilotName, pilotCustomization, tint,
        modeltint, pilotCard)

    spawnPilotAccessories(session, pilot, spawnCard, accessoryContext, faction, shipBundleResult.shipRotation,
        shipBundleResult.shipPosition)
    spawnPilotResourceTokens(session, pilot, spawnCard, tokens, hasMob)
end

local function isExtendedWidthUpgrade(upgrade)
    return upgrade.extended_width == true
end

local function extendedWidthOffset(upgrade, direction, extendedWidthTuck)
    if isExtendedWidthUpgrade(upgrade) then
        return extendedWidthTuck * direction
    end
    return 0
end

local function upgradeCardLayout(cursor, upgrade, upgradeStepX, upgradeStepY, extendedWidthTuck, extendedWidthStep)
    local widthOffset = extendedWidthOffset(upgrade, -1, extendedWidthTuck)
    local layout = {
        x = cursor.x + widthOffset,
        y = cursor.y,
        z = cursor.z,
    }
    if isExtendedWidthUpgrade(upgrade) then
        cursor.x = cursor.x - extendedWidthStep
    else
        cursor.x = cursor.x - upgradeStepX
    end
    cursor.y = cursor.y - upgradeStepY
    return layout
end

local function configCardLayout(upgrade, configCardAnchorX, extendedWidthTuck)
    local layout = {
        x = configCardAnchorX + extendedWidthOffset(upgrade, 1, extendedWidthTuck),
        y = 0,
        z = 5.5,
    }
    return layout
end

local function localLayoutPos(spawnCard, layout, dx, dy, dz)
    return LocalPos(spawnCard, {
        layout.x + (dx or 0),
        layout.y + (dy or 0),
        layout.z + (dz or 0),
    })
end

local function spawnUpgradeCharges(session, tokenTemplate, spawnCard, upgrade, pilot, layout, isConfiguration)
    local charges = upgrade.Charge
    while charges > 0 do
        local position
        if isConfiguration then
            if charges == 5 then
                position = localLayoutPos(spawnCard, layout, 0.88, 0, -3.6)
            elseif charges == 4 then
                position = localLayoutPos(spawnCard, layout, 0.88, 0, -2.7)
            elseif charges == 3 then
                position = localLayoutPos(spawnCard, layout, -0.02, 0, -2.7)
            elseif charges == 2 then
                position = localLayoutPos(spawnCard, layout, 0.88, 0, -1.8)
            elseif charges == 1 then
                position = localLayoutPos(spawnCard, layout, -0.02, 0, -1.8)
            end
        else
            if charges == 5 then
                position = localLayoutPos(spawnCard, layout, -0.28, 1 - layout.y, -3.6)
            elseif charges == 4 then
                position = localLayoutPos(spawnCard, layout, -0.28, 1 - layout.y, -2.7)
            elseif charges == 3 then
                position = localLayoutPos(spawnCard, layout, -1.18, 1 - layout.y, -2.7)
            elseif charges == 2 then
                position = localLayoutPos(spawnCard, layout, -0.28, 1 - layout.y, -1.8)
            elseif charges == 1 then
                position = localLayoutPos(spawnCard, layout, -1.18, 1 - layout.y, -1.8)
            end
        end
        if position == nil then
            break
        end
        charges = charges - 1
        cloneSpawnerToken(session, tokenTemplate, position, "charge_owner", pilot.name, upgrade.name)
    end
end

local function spawnPilotUpgrades(context, pilot, upgrades)
    local session = context.session
    local accessoryContext = context.accessoryContext
    local spawnCard = context.spawnCard
    local customization = context.customization
    local upgradeStepX = context.upgradeStepX
    local upgradeStepY = context.upgradeStepY
    local extendedWidthTuck = context.extendedWidthTuck
    local extendedWidthStep = context.extendedWidthStep
    local configCardAnchorX = context.configCardAnchorX
    local configCardShiftX = context.configCardShiftX

    local result = {
        configCardGUID = nil,
        hasMobileUpgrade = 0,
        count = 0,
        layoutCursor = { x = -1.42, y = 1, z = 5.5 }
    }

    for _, upgrade in pairs(upgrades) do
        if upgrade.Config == true then
            local layout = configCardLayout(upgrade, configCardAnchorX, extendedWidthTuck)
            spawnCard.setPosition(LocalPos(spawnCard, { configCardShiftX, 0, 0 }))
            local position = localLayoutPos(spawnCard, layout)
            local rotation = spawnCard.getRotation()
            local cardLink = upgrade.card
            local cardBackLink = upgrade.cardB
            if customization[upgrade.name] ~= nil then
                cardLink = customization[upgrade.name].face or upgrade.card
                cardBackLink = customization[upgrade.name].back or upgrade.cardB
            end
            local deck = Decker.Asset(cardLink, cardBackLink)
            local card = Decker.Card(deck, 1, 1)
            local spawnedUpgrade = session:track(card:spawn({
                position = position,
                rotation = rotation,
                scale = { 0.68, 0.68, 0.68 }
            }))
            spawnedUpgrade.setName(upgrade.name)
            spawnedUpgrade.addTag("ConfigCard")
            result.configCardGUID = spawnedUpgrade.getGUID()
            result.hasMobileUpgrade = 1
            spawnUpgradeCharges(session, accessoryContext.tokens.Charge, spawnCard, upgrade, pilot, layout, true)
        end
    end

    for _, upgrade in pairs(upgrades) do
        if upgrade.Config ~= true then
            local layout = upgradeCardLayout(result.layoutCursor, upgrade, upgradeStepX, upgradeStepY,
                extendedWidthTuck, extendedWidthStep)
            local position = localLayoutPos(spawnCard, layout)
            local rotation = spawnCard.getRotation()
            local cardLink = upgrade.card
            local cardBackLink = upgrade.cardB
            if customization[upgrade.name] ~= nil then
                cardLink = customization[upgrade.name].face or upgrade.card
                cardBackLink = customization[upgrade.name].back or upgrade.cardB
            end
            local deck = Decker.Asset(cardLink, cardBackLink)
            local card = Decker.Card(deck, 1, 1)
            local spawnedUpgrade = session:track(card:spawn({
                position = position,
                rotation = rotation,
                scale = { 0.68, 0.68, 0.68 }
            }))
            spawnedUpgrade.setName(upgrade.name)
            if upgrade.Condition ~= nil then
                spawnAssignableAccessories(session, accessoryContext, upgrade.Condition,
                    localLayoutPos(spawnCard, layout, -0.58, 0, 2.5), spawnCard.getRotation())
            end
            spawnUpgradeCharges(session, accessoryContext.tokens.Charge, spawnCard, upgrade, pilot, layout, false)
            result.count = result.count + 1
        end
    end

    return result
end

local function advancePilotSpawnCursor(spawnCard, pilot, upgradeLayoutCursor)
    if pilot.standardized_loadout then
        local charges = 0
        for _, upgrade in pairs(pilot.standardized_upgrades) do
            charges = math.max(charges, upgrade.charge)
        end
        spawnCard.setPosition(LocalPos(spawnCard, { -(5.5 + charges * 0.7), 0, 0 }))
    else
        spawnCard.setPosition(LocalPos(spawnCard, { upgradeLayoutCursor.x - 2.58, 0, 0 }))
    end
end

local function createSpawnRequest(listTable)
    local spawnCard = listTable.spawnCard
    return {
        listTable = listTable,
        anchorPosition = spawnCard.getPosition(),
        anchorRotation = spawnCard.getRotation()
    }
end

local function spawnSquad(request, pilotCardScript)
    local listTable = request.listTable
    normalizeLegacySpawnerList(listTable)
    --listTable contains :

    --Pilots[x] = table

    --Upgrades[x] = {string1, string2...}
    --spawnCard = Object reference used to position the spawned material
    --Faction = String

    local Pilots = listTable.Pilots
    local Upgrades = listTable.Upgrades
    local spawnCard = listTable.spawnCard
    local Faction = listTable.Faction
    local Customization = listTable.Customization or {}
    local dialSkin = listTable.factionDial
    local spawnPrefix =
    "{verifycache}https://raw.githubusercontent.com/JohnnyCheese/TTS_X-Wing2.0/master/assets/ships-v2/"
    local factionnames = {
        rebelalliance = "rebel",
        galacticempire = "empire",
        scumandvillainy = "scum",
        resistance = "resistance",
        firstorder = "first-order",
        galacticrepublic = "republic",
        separatistalliance = "separatists"
    }

    local bagPosition = { 15, 15, 0 }
    local storePos = request.anchorPosition
    local storeRot = request.anchorRotation
    local session = createSpawnSession(spawnCard, storePos, storeRot)
    local accessoryContext = { tokens = {} }

    local spawnSuccess, spawnError = pcall(function()
        -- An initial script download can defer spawning; preserve the click-time anchor.
        spawnCard.setPosition(storePos)
        spawnCard.setRotation(storeRot)
        initializeSpawnerAccessoryContext(accessoryContext, spawnCard, bagPosition)
        local tokens = accessoryContext.tokens

        local UPGRADE_STEP_X = 1.78
        local UPGRADE_STEP_Y = 0.2
        local UPGRADE_EXTENDED_WIDTH_TUCK = 0.6
        local UPGRADE_EXTENDED_WIDTH_STEP = UPGRADE_STEP_X + UPGRADE_EXTENDED_WIDTH_TUCK
        local CONFIG_CARD_ANCHOR_X = 1.42
        local CONFIG_CARD_SHIFT_X = -1.9

        local shipIndex = 1 --Sets index of ship being spawned

        while Pilots[shipIndex] ~= nil do
            local pilot = Pilots[shipIndex]
            if pilot.standardized_loadout then
                spawnCard.setPosition(LocalPos(spawnCard, { -1.1, 0, 0 }))
            end

            local upgradeResult = spawnPilotUpgrades({
                session = session,
                accessoryContext = accessoryContext,
                spawnCard = spawnCard,
                customization = Customization,
                upgradeStepX = UPGRADE_STEP_X,
                upgradeStepY = UPGRADE_STEP_Y,
                extendedWidthTuck = UPGRADE_EXTENDED_WIDTH_TUCK,
                extendedWidthStep = UPGRADE_EXTENDED_WIDTH_STEP,
                configCardAnchorX = CONFIG_CARD_ANCHOR_X,
                configCardShiftX = CONFIG_CARD_SHIFT_X,
            }, pilot, Upgrades[shipIndex])
            local upgradeLayoutCursor = upgradeResult.layoutCursor

            spawnPilotBundle({
                session = session,
                accessoryContext = accessoryContext,
                spawnCard = spawnCard,
                faction = Faction,
                customization = Customization,
                dialSkin = dialSkin,
                pilotCardScript = pilotCardScript,
                spawnPrefix = spawnPrefix,
                factionnames = factionnames,
                tokens = tokens,
            }, pilot, upgradeResult)


            advancePilotSpawnCursor(spawnCard, pilot, upgradeLayoutCursor)
            shipIndex = shipIndex + 1
        end

        spawnCard.setPosition(LocalPos(spawnCard, { 0, 0, 5.5 }))

        spawnSpawnerRemotes(session, listTable.Remotes, spawnCard, accessoryContext)

        spawnSpawnerObstacles(session, listTable.Obstacles, spawnCard, bagPosition)
    end)

    -- Temporary source objects and the spawn anchor must be released on success or failure.
    local cleanupSuccess, cleanupError = pcall(function()
        destroySpawnerAccessoryContext(accessoryContext)
        session:restoreAnchor()
    end)

    if not spawnSuccess then
        session:fail(spawnError)
        error(spawnError)
    end
    if not cleanupSuccess then
        session:fail(cleanupError)
        error(cleanupError)
    end
    session:finishSynchronousPhase()
end

local function loadPilotCardScript()
    if isLoadingPilotCardScript then
        return
    end

    isLoadingPilotCardScript = true
    WebRequest.get(PILOT_CARD_SCRIPT_URL, function(request)
        if request.is_error then
            local hadQueuedSpawns = #pendingSpawnRequests > 0
            pendingSpawnRequests = {}
            isLoadingPilotCardScript = false
            if hadQueuedSpawns then
                printToAll("Failed to download pilot card script; squad was not spawned.", { 1, 0.2, 0.2 })
            end
            return
        end
        if not request.is_done then
            return
        end
        if request.text == nil or request.text == "" then
            local hadQueuedSpawns = #pendingSpawnRequests > 0
            pendingSpawnRequests = {}
            isLoadingPilotCardScript = false
            if hadQueuedSpawns then
                printToAll("Downloaded pilot card script was empty; squad was not spawned.", { 1, 0.2, 0.2 })
            end
            return
        end

        cachedPilotCardScript = request.text
        isLoadingPilotCardScript = false
        local queuedSpawns = pendingSpawnRequests
        pendingSpawnRequests = {}
        for _, queuedRequest in ipairs(queuedSpawns) do
            spawnSquad(queuedRequest, cachedPilotCardScript)
        end
    end)
end

function Spawner.newSpawner(listTable)
    local compositeBase = nil
    if CompositeBase_GUID ~= nil then
        compositeBase = getObjectFromGUID(CompositeBase_GUID)
    end
    if compositeBase == nil then
        printToAll(
            "Unable to spawn squad: the composite ship base object is missing from this save. " ..
            "Restore the deleted object or load a save that still contains it.",
            { 1, 0.2, 0.2 }
        )
        print("Spawner aborted: no object found for CompositeBase_GUID " .. tostring(CompositeBase_GUID))
        return
    end

    local request = createSpawnRequest(listTable)
    if cachedPilotCardScript ~= nil then
        spawnSquad(request, cachedPilotCardScript)
        return
    end

    table.insert(pendingSpawnRequests, request)
    loadPilotCardScript()
end

-- Fetch while Global loads so normal player-initiated spawns remain synchronous.
loadPilotCardScript()


return Spawner
