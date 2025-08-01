--------------------------
-- ANNOUNCEMENTS MODULE --
--------------------------

-- For writing out stuff in chat

local AnnModule = {
    announceColor = {
        -- color configuration for announcements
        moveClear = { 0.1, 1, 0.1 },     -- Green
        moveCollision = { 1, 0.7, 0.1 }, -- Orange
        action = { 0.3, 0.3, 1 },        -- Blue
        historyHandle = { 0.1, 1, 1 },   -- Cyan
        error = { 1, 0.15, 0.15 },       -- Red
        warn = { 1, 0.4, 0 },            -- Red-orange
        info = { 0.8, 0.1, 0.8 }         -- Purple
    },
    -- Record of players that already got note of some ID
    -- Key: playerSteamID
    -- Value: table of true's on keys of received noteIDs
    notifyRecord = {}
}

-- Notify color or all players of some event
-- announceInfo: {type=typeOfEvent, note=notificationString}
AnnModule.Announce = function(info, target, shipPrefix)
    local annString = ''
    local annColor = { 1, 1, 1 }
    local shipName = ''

    if shipPrefix ~= nil then
        if type(shipPrefix) == 'string' then
            shipName = shipPrefix .. ' '
        elseif type(shipPrefix) == 'userdata' then
            shipName = shipPrefix.getName() .. ' '
        end
    end
    if info.type == 'move' or info.type == 'stationary' then
        if info.collidedShip == nil then
            annString = shipName .. info.note .. ' (' .. info.code .. ')'
            annColor = AnnModule.announceColor.moveClear
        else
            local coltype = nil
            if info.friendlyCollission then
                coltype = "[ff2222]friendly[ffb219]"
            else
                coltype = "[2222ff]only enemy[ffb219]"
            end
            annString = shipName ..
                info.note ..
                ' (' ..
                info.code ..
                ') but it ended overlapping ' ..
                coltype .. ' ship(s) and is now touching ' .. info.collidedShip.getName()
            annColor = AnnModule.announceColor.moveCollision
        end
    elseif info.type == 'overlap' then
        annString = shipName .. info.note .. ' (' .. info.code .. ') but there was no space to complete the move'
        annColor = AnnModule.announceColor.moveCollision
    elseif info.type == 'historyHandle' then
        annString = shipName .. info.note
        annColor = AnnModule.announceColor.historyHandle
    elseif info.type == 'action' then
        annString = shipName .. info.note
        annColor = AnnModule.announceColor.action
    elseif info.type:find('error') ~= nil then
        annString = shipName .. info.note
        annColor = AnnModule.announceColor.error
    elseif info.type:find('warn') ~= nil then
        annString = shipName .. info.note
        annColor = AnnModule.announceColor.warn
    elseif info.type:find('info') ~= nil then
        annString = shipName .. info.note
        annColor = AnnModule.announceColor.info
    end

    if target == 'all' then
        printToAll(annString, annColor)
    else
        printToColor(target, annString, annColor)
    end
end


-- Print note to playerColor
-- Any further calls with same noteID will not notify same player
-- Print to everyone if playerColor is 'all'
AnnModule.NotifyOnce = function(note, noteID, playerColor)
    if playerColor == 'all' then
        local seatedPlayers = getSeatedPlayers()
        for _, color in pairs(seatedPlayers) do
            AnnModule.NotifyOnce(note, noteID, color)
        end
    else
        local steamID = Player[playerColor].steam_id
        if AnnModule.notifyRecord[steamID] == nil then
            AnnModule.notifyRecord[steamID] = {}
        end
        if AnnModule.notifyRecord[steamID][noteID] ~= true then
            broadcastToColor(note, playerColor, AnnModule.announceColor.info)
            AnnModule.notifyRecord[steamID][noteID] = true
        end
    end
end

return AnnModule
