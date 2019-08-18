-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: https://github.com/tjakubo2/TTS_xwing
--
-- This script (pasted on anything) will allow for some permission management
-- (like locking off colors and promoting players)
-- ~~~~~~

dz_tableGuard = true

-- Default settings
function defaultState()
    local state = {
        menuKey = 'main',   -- currently selected menu
        active = true,      -- if this si working at all
        colorLock = true,   -- if only promoted players can take colors
        hostOnly = false,   -- if only host can mess with the buttons
        whitelist = {},     -- list of names to promote on join
    }
    return state
end
state = defaultState()

-- On load, restore saved settings and start a timer updating player list
-- If there is a copy of guard on the table, disable self
function onLoad(saveState)
    unique = true
    for k,obj in pairs(getAllObjects()) do
        if obj.getVar('dz_tableGuard') and obj ~= self then
            Display.PrintToAdmins('Table guard already present on the table', {1, 0, 0})
            unique = false
            self.setColorTint({1, 0, 0})
            self.setName('Use the one already loaded instead')
            break
        end
    end

    if unique then
        if saveState ~= nil and saveState ~= '' then
            state = JSON.decode(saveState)
            for k in pairs(defaultState()) do
                if state[k] == nil then
                    state[k] = defaultState()[k]
                end
            end
        else
            state = defaultState()
        end
        Display.Update()
        lastPlayerState = ''
        Timer.create({identifier=self.getGUID(), function_name='updatePlayers', function_owner=self, delay=2, repetitions=0})
    end
end

-- On save, save the settings
function onSave()
    return JSON.encode(state)
end

-- On destroy, clear up timers (if that guard was active)
function onDestroy()
    if unique then
        Timer.destroy(self.getGUID())
    end
end

-- Quick player state lookup
-- For determining if something changed and player list may need updating
-- This will be obsolete when we get onPlayerConnected and onPlayerPromoted triggers
function playerCheckState()
    local stateString = ''
    local promoteCount = 0
    local playersTable = Player.getPlayers()
    for k,pl in ipairs(playersTable) do
        stateString = stateString .. pl.steam_name:sub(1,1)
        if pl.promoted then promoteCount = promoteCount + 1 end
    end
    return stateString .. promoteCount .. #playersTable
end

-- Update the promote and whitelist player lists
-- If forceUpdate set to true, update regardless
function updatePlayers(forceUpdate)
    if not state.active or Display == nil then return end
    local playerState = playerCheckState()
    if forceUpdate or (playerState ~= lastPlayerState) then
        lastPlayerState = playerState
        Display.ApplyWhitelist()
        Display.Update()
    end
end

-- If a color can take an action according to state
-- If hostOnly set to true, only return true for host
function AllowedToUse(playerColor, hostOnly)
    local promoted = Player[playerColor].promoted
    local host = Player[playerColor].host
    local allowed = host or ((not state.hostOnly) and promoted and (not hostOnly))
    if not allowed then
        broadcastToColor('You don\'t have permissions to do that', playerColor, {1, 0.3, 0.3})
    end
    return allowed
end

-- I liked this name
Display = {}

-- Broadcast a message to host
Display.BroadcastToHost = function(msg, color)
    color = color or {1, 1, 0}
    for k,pl in pairs(Player.getPlayers()) do
        if pl.host then
            pl.broadcast(msg, color)
            break
        end
    end
end
-- Print a message to host
Display.PrintToHost = function(msg, color)
    color = color or {1, 1, 0}
    for k,pl in pairs(Player.getPlayers()) do
        if pl.host then
            pl.print(msg, color)
            break
        end
    end
end
-- Broadcast a message to host and every promoted player
Display.BroadcastToAdmins = function(msg, color)
    color = color or {1, 1, 0}
    for k,pl in pairs(Player.getPlayers()) do
        if pl.admin then
            pl.broadcast(msg, color)
        end
    end
end
-- Print a message to host and every promoted player
Display.PrintToAdmins = function(msg, color)
    color = color or {1, 1, 0}
    for k,pl in pairs(Player.getPlayers()) do
        if pl.admin then
            pl.print(msg, color)
        end
    end
end

-- Promote peeps from whitelist
Display.ApplyWhitelist = function()
    for k, pl in pairs(Player.getPlayers()) do
        if (not pl.promoted) and state.whitelist[pl.steam_name] then
            pl.promote()
        end
    end
end
-- Parse a whitelist from some object script
-- Object script format: "-- playerNick" in each line, nothing else
-- If overwrite set to true, delete current whitelist before
Display.ParseWhitelist = function(obj, overwrite)
    if overwrite then
        state.whitelist = {}
    end
    local count = 0
    local snippet = obj.getLuaScript()
    snippet = snippet or ''
    snippet = snippet:gsub('%-%-', '')
    for nick in snippet:gmatch('[^%s]+') do
        if not state.whitelist[nick] then
            state.whitelist[nick] = true
            count = count+1
        end
    end
    if count > 0 then
        Display.BroadcastToHost('Whitelist updated (' .. count .. ') new entries')
    end
    return count
end
-- Try to parse a whitelist from every object that has "whitelist" in name (case insensitive)
Display.UpdateWhitelist = function()
    local count = 0
    for k,obj in pairs(getAllObjects()) do
        if string.lower(obj.getName()):find('whitelist') then
            count = count + Display.ParseWhitelist(obj)
        end
    end
    if count == 0 then
        Display.BroadcastToHost('No whitelist objects or none have new entries')
    end
end

-- Table with buttons names (and optionally data) for each menu entry
Display.buttons = {}
-- Create functions for each button from evey menu entry
Display.buttonCreate = {}

-- Possible menus list
Display.menus = {'main', 'whitelist'}
-- Change manu to next one
Display.NextMenu = function()
    local cKey = 1
    for k,menuName in ipairs(Display.menus) do
        if menuName == state.menu then
            cKey = k
            break
        end
    end
    cKey = cKey+1
    if cKey > #Display.menus then
        cKey = 1
    end
    state.menu = Display.menus[cKey]
end

-- Create menu choice button
Display.buttonCreate.menuChoice = function()
    local menuButton = {
        position = {0, 0.2, 2},
        width = 1800,
        height = 400,
        font_size = 200,
        scale = {0.5, 0.5, 0.5},
        color = {0.3, 0.3, 1},
        click_function = 'Click_CycleMenu',
        function_owner = self,
        label = 'Menu: ' .. state.menu
    }
    self.createButton(menuButton)
end
function Click_CycleMenu(_, playerColor)
    if AllowedToUse(playerColor, true) then
        Display.NextMenu()
        Display.Update()
    end
end

-- MAIN MENU BUTTONS
Display.buttons.main = {}

-- Toggle on/off
Display.buttons.main.toggleActive = {position={-2.2, 0.2, 1}, width=1500, height=400, font_size=180, click_function='Click_ToggleActive', function_owner=self}
Display.buttonCreate.toggleActive = function()
    local newButton = Display.buttons.main.toggleActive
    newButton.color = {0.2, 1, 0.2}
    newButton.label = 'Active: ON'
    if not state.active then
        newButton.color = {1, 0.2, 0.2}
        newButton.label = 'Active: OFF'
    end
    self.createButton(newButton)
end
function Click_ToggleActive(_, playerColor)
    if AllowedToUse(playerColor) then
        state.active = not state.active
        Display.Update()
    end
end

-- Toggle colors lock
Display.buttons.main.toggleColorLock = {position={-2.2, 0.2, 0}, width=1500, height=400, font_size=180, click_function='Click_ToggleColorLock', function_owner=self}
Display.buttonCreate.toggleColorLock = function()
    local newButton = Display.buttons.main.toggleColorLock
    newButton.color = {0.2, 1, 0.2}
    newButton.label = 'Lock colors: ON'
    if not state.colorLock then
        newButton.color = {1, 0.2, 0.2}
        newButton.label = 'Lock colors: OFF'
    end
    self.createButton(newButton)
end
function Click_ToggleColorLock(_, playerColor)
    if AllowedToUse(playerColor) then
        state.colorLock = not state.colorLock
        Display.Update()
        if state.colorLock then
            local msg = 'Non-promoted players will NOT be able to take colors with \"Lock colors\" toggled ON'
            Display.BroadcastToAdmins(msg)
        end
    end
end

-- Toggle use permissions
Display.buttons.main.togglePermissions = {position={-2.2, 0.2, -1}, width=1500, height=400, font_size=180, click_function='Click_TogglePermissions', function_owner=self}
Display.buttonCreate.togglePermissions = function()
    local newButton = Display.buttons.main.togglePermissions
    newButton.color = {0.3, 0.3, 1}
    newButton.label = 'Only host can use'
    if not state.hostOnly then
        newButton.color = {0.2, 1, 0.2}
        newButton.label = 'Promoted can use'
    end
    self.createButton(newButton)
end
function Click_TogglePermissions(_, playerColor)
    if AllowedToUse(playerColor, true) then
        state.hostOnly = not state.hostOnly
        Display.Update()
    end
end

-- Click-to-promote players table
Display.buttons.main.promoteTable = {
    label = {position={2.2, 0.2, 0}, width=1500, height=400, font_size=180, label='Click to promote:', click_function='Click_PromoteLabel', function_owner=self},
    playerEntry = {position={2.2, 0.2, 0}, width=1200, height=400, font_size=180, function_owner=self}
}
Display.buttonCreate.promoteTable = function()
    Display.BuildPromoteData()
    local data = Display.promoteData
    if #data == 0 then return end

    local bNum = #data + 1
    local spacing = 1
    local initPos = -1*spacing*(bNum-1)/2
    Display.buttons.main.promoteTable.label.position[3] = initPos - 0.25
    self.createButton(Display.buttons.main.promoteTable.label)

    for k,pTable in ipairs(data) do
        local newButton = Display.buttons.main.promoteTable.playerEntry
        newButton.click_function = 'Click_PromoteSlot' .. k
        if not _G['Click_PromoteSlot' .. k] then
            _G['Click_PromoteSlot' .. k] = function(_, playerColor)
                if AllowedToUse(playerColor) then
                    Click_PromoteSlot(k)
                end
            end
        end
        newButton.label = pTable.name
        newButton.position[3] = initPos + k*spacing
        newButton.color = stringColorToRGB(pTable.player.color)
        self.createButton(newButton)
    end
end
function Click_PromoteSlot(ind)
    Display.promoteData[ind].player.promote()
    Display.Update()
end
function Click_PromoteLabel()
    Display.Update()
end

-- Data builder for click-to-promote player list
Display.promoteData = {}
Display.GetShortName = function(playerName)
    if playerName:len() > 15 then
        return playerName:sub(1,12) .. '...'
    else
        return playerName
    end
end
Display.BuildPromoteData = function()
    Display.promoteData = {}
    for k,pl in ipairs(Player.getPlayers()) do
        if not pl.promoted and not pl.admin then
            table.insert(Display.promoteData, {player=pl, name=Display.GetShortName(pl.steam_name)})
        end
    end
end

-- WHITELIST MENU
Display.buttons.whitelist = {}

-- Update whitelist (from objects on the table)
Display.buttons.whitelist.updateWhitelist = {position={-2.2, 0.2, -1}, color={0.3, 0.3, 1}, width=1200, height=280, font_size=120, click_function='Click_UpdateWhitelist', label='Update whitelist', function_owner=self}
Display.buttonCreate.updateWhitelist = function()
    self.createButton(Display.buttons.whitelist.updateWhitelist)
end
function Click_UpdateWhitelist(_, playerColor)
    if AllowedToUse(playerColor, true) then
        Display.UpdateWhitelist()
    end
    Display.Update()
end
-- Clear whitelist
Display.buttons.whitelist.clearWhitelist = {position={-2.2, 0.2, -1*(1/3)}, color={0.3, 0.3, 1}, width=1200, height=280, font_size=120, click_function='Click_ClearWhitelist', label='Clear whitelist', function_owner=self}
Display.buttonCreate.clearWhitelist = function()
    self.createButton(Display.buttons.whitelist.clearWhitelist)
end
function Click_ClearWhitelist(_, playerColor)
    if AllowedToUse(playerColor, true) then
        state.whitelist = {}
        Display.BroadcastToHost('Whitelist cleared')
    end
    Display.Update()
end
-- Print whitelist (to host only)
Display.buttons.whitelist.printWhitelist = {position={-2.2, 0.2, 1/3}, color={0.3, 0.3, 1}, width=1200, height=280, font_size=120, click_function='Click_PrintWhitelist', label='Print whitelist', function_owner=self}
Display.buttonCreate.printWhitelist = function()
    self.createButton(Display.buttons.whitelist.printWhitelist)
end
function Click_PrintWhitelist(_, playerColor)
    if AllowedToUse(playerColor, true) then
        if next(state.whitelist) == nil then
            Display.BroadcastToHost('Whitelist empty')
        else
            Display.PrintToHost('Whitelisted players (promote on join):')
            for name in pairs(state.whitelist) do
                Display.PrintToHost('-- ' .. name)
            end
        end
    end
end
-- Spawn some how-to on whitelist usage
Display.buttons.whitelist.helpWhitelist = {position={-2.2, 0.2, 1}, color={0.3, 0.3, 1}, width=1200, height=280, font_size=120, click_function='Click_HelpWhitelist', label='How to use?', function_owner=self}
Display.buttonCreate.helpWhitelist = function()
    self.createButton(Display.buttons.whitelist.helpWhitelist)
end
function Click_HelpWhitelist(_, playerColor)
    if AllowedToUse(playerColor, true) then
        local notePos = self.getPosition()
        notePos.y = notePos.y+1
        local exWlPos = self.getPosition()
        exWlPos.y = exWlPos.y+2

        if Display.whitelistHelpNote == nil then
            local helpText = [[Host can set up a list of players to be promoted on join called "whitelist".

This list is held in (any) piece script, so only host can set up one. An example whitelist object was created (Rook chess piece) - take a look at its script (Right click -> Scripting -> Lua Editor) to see how to add more names to it. After spawning your whitelist object, click "Update whitelist".
            ]]

            local noteParams = {type = 'Notecard'}
            local noteObj = spawnObject(noteParams)
            noteObj.setName('[b]Whitelist help[/b]')
            noteObj.setDescription(helpText)
            noteObj.setPosition(notePos)
            Display.whitelistHelpNote = noteObj
        else
            Display.whitelistHelpNote.setPositionSmooth(notePos, false, false)
        end

        if Display.exampleWhitelistObj == nil then
            local exWhitelist = [[-- dzikakulka
-- Knils
-- someOtherGuy
-- myFriendsNick
-- joinUsAt
-- discord.gg/WHKXDBD
            ]]
            local exWlParams = {type = 'Chess_Rook'}
            local exWlObj = spawnObject(exWlParams)
            exWlObj.setScale({0.4, 0.4, 0.4})
            exWlObj.setName('Whitelist (example)')
            exWlObj.setLuaScript(exWhitelist)
            exWlObj.setPosition(exWlPos)
            Display.exampleWhitelistObj = exWlObj
        else
            Display.exampleWhitelistObj.setPositionSmooth(exWlPos, false, false)
        end
    end
end
-- Clic-to-whitelist players table
Display.buttons.whitelist.whitelistTable = {
    label = {position={2.2, 0.2, 0}, width=1500, height=400, font_size=180, label='Click to whitelist:', click_function='Click_WhitelistLabel', function_owner=self},
    playerEntry = {position={2.2, 0.2, 0}, width=1200, height=400, font_size=180, function_owner=self}
}
Display.buttonCreate.whitelistTable = function()
    Display.BuildWhitelistData()
    local data = Display.whitelistData
    if #data == 0 then return end

    local bNum = #data + 1
    local spacing = 1
    local initPos = -1*spacing*(bNum-1)/2
    Display.buttons.whitelist.whitelistTable.label.position[3] = initPos - 0.25
    self.createButton(Display.buttons.whitelist.whitelistTable.label)

    for k,pTable in ipairs(data) do
        local newButton = Display.buttons.whitelist.whitelistTable.playerEntry
        newButton.click_function = 'Click_WhitelistSlot' .. k
        if not _G['Click_WhitelistSlot' .. k] then
            _G['Click_WhitelistSlot' .. k] = function(_, playerColor)
                if AllowedToUse(playerColor, true) then
                    Click_WhitelistSlot(k)
                end
            end
        end
        newButton.label = pTable.name
        newButton.position[3] = initPos + k*spacing
        newButton.color = stringColorToRGB(pTable.player.color)
        self.createButton(newButton)
    end
end
function Click_WhitelistSlot(ind)
    local name = Display.whitelistData[ind].player.steam_name
    if not state.whitelist[name] then
        state.whitelist[name] = true
        Display.BroadcastToHost('Player \'' .. name .. '\' added to whitelist')
    end
    Display.Update()
end
function Click_WhitelistLabel()
    Display.Update()
end

-- Data builder for whitelist-on-click
Display.whitelistData = {}
Display.GetShortName = function(playerName)
    if playerName:len() > 15 then
        return playerName:sub(1,12) .. '...'
    else
        return playerName
    end
end
Display.BuildWhitelistData = function()
    Display.whitelistData = {}
    for k,pl in ipairs(Player.getPlayers()) do
        if pl.admin and (not state.whitelist[pl.steam_name]) then
            table.insert(Display.whitelistData, {player=pl, name=Display.GetShortName(pl.steam_name)})
        end
    end
end


-- Update the display (recreate all buttons)
Display.Update = function()
    self.clearButtons()
    if state.active then
        Display.buttonCreate.menuChoice()
        for butName in pairs(Display.buttons[state.menu]) do
            Display.buttonCreate[butName]()
        end
    else
        Display.buttonCreate.toggleActive()
    end
end

-- If guarding colors, kick back to grey unless promoted or host
function onPlayerChangedColor(newColor)
    if not state.active then return end
    if newColor ~= 'Grey' and state.colorLock and (not Player[newColor].admin) then
        Player[newColor].broadcast('Table guard is set to lock color picks', {1, 0.1, 0.1})
        Player[newColor].changeColor('Grey')
    end
    Display.Update()
end