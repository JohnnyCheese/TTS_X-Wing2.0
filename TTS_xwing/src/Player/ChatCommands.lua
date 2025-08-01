-- ~~~~~~
-- Script by dzikakulka
-- Issues, history at: http://github.com/tjakubo2/TTS_xwing
--
-- Module handling chat-based commands
-- ~~~~~~

ChatCmd = {}

ChatCmd.prefix = '!'

ChatCmd.colors = {}
ChatCmd.colors.ok = { 0.5, 1, 0.5 }
ChatCmd.colors.warn = { 1, 0.5, 0 }
ChatCmd.colors.error = { 1, 0.4, 0.4 }

ChatCmd.IsCommand = function(msg)
    local pLen = ChatCmd.prefix:len()
    return (msg:sub(1, pLen) == ChatCmd.prefix)
end

ChatCmd.DecodeCommand = function(cmd, player)
    cmd = cmd:sub(ChatCmd.prefix:len() + 1, -1)
    local words = {}
    for word in cmd:gmatch('[%w]+') do
        table.insert(words, word)
    end
    local name = table.remove(words, 1)
    return {
        name = name,
        args = words,
        giver = player,
        raw = ChatCmd.prefix .. cmd
    }
end

ChatCmd.RawPrint = function(cmd)
    printToAll(cmd.giver.steam_name .. ': [ffffff]' .. cmd.raw, stringColorToRGB(cmd.giver.color))
end

ChatCmd.HasPermissions = function(player, permission)
    if permission == 'everyone' then
        return true
    elseif permission == 'player' then
        return (player.color ~= 'Grey' or player.admin)
    elseif permission == 'admin' then
        return player.admin
    elseif permission == 'host' then
        return player.host
    end
    return false
end

ChatCmd.AssertPermissions = function(player, permission)
    if not ChatCmd.HasPermissions(player, permission) then
        player.broadcast('You don\'t have permissions (' .. permission .. ') to execute this command!',
            ChatCmd.colors.error)
        return false
    end
    return true
end

ChatCmd.BroadcastUsage = function(cmd)
    cmd.giver.broadcast('Usage: ' .. ChatCmd.commands[cmd.name].usage, ChatCmd.colors.warn)
end

ChatCmd.AddCommand = function(info)
    assert(type(info.name) == 'string', 'ChatCmd.AddCommand: no name specified')
    assert(ChatCmd.commands[info.name] == nil, 'ChatCmd.AddCommand: command \'' .. info.name .. '\' already defined')
    assert(type(info.fcn) == 'function', 'ChatCmd.AddCommand: no function specified')
    ChatCmd.commands[info.name] = {
        usage = (info.usage and info.usage:gsub('<p>', ChatCmd.prefix)) or (ChatCmd.prefix .. info.name),
        examples = info.examples or {},
        desc = info.desc or '(no description)',
        fcn = info.fcn,
        permissions = info.perm or 'everyone'
    }
end

ChatCmd.fcns = {}
ChatCmd.commands = {}

ChatCmd.AddCommand({

})
ChatCmd.fcns.coin = function(cmd)
    local result = 'HEADS'
    if math.random() > 0.5 then
        result = 'TAILS'
    end
    ChatCmd.RawPrint(cmd)
    printToAll(cmd.giver.steam_name .. ' flipped a coin and it was ' .. result, ChatCmd.colors.ok)
    return false
end

ChatCmd.AddCommand(
    'roll',
    'Roll a number of specified die (generic or X-Wing)',
    '<p>roll [number][att | def | d3-d100], e.g. "<p>roll 3att", "<p>roll 5d20"',
    'player'
)
ChatCmd.fcns.roll = function(cmd)
    if not cmd.args[1] then
        ChatCmd.BroadcastUsage(cmd)
        return false
    end
    local dieNum, dieType = cmd.args[1]:match('^([%d]*)(.-)$')
    dieNum = tonumber(dieNum) or 1
    local dieFaces = 8
    if dieType ~= 'att' and dieType ~= 'def' then
        dieFaces = tonumber(dieType:match('^d([%d]+)$'))
    end
    if not dieType or not dieFaces then
        ChatCmd.BroadcastUsage(cmd)
        return false
    end

    if dieNum > 10 then dieNum = 10 end
    if dieFaces > 100 then dieFaces = 100 end
    if dieFaces < 3 then dieFaces = 3 end

    local results = {}
    for _ = 1, dieNum do
        table.insert(results, math.random(1, dieFaces))
    end
    local dieName = ((dieNum > 1 and (dieNum .. ' D' .. dieFaces .. '\'s')) or 'a D' .. dieFaces)
    if dieType == 'att' then
        dieName = ((dieNum > 1 and (dieNum .. ' attack dice')) or 'an attack die')
    end
    if dieType == 'def' then
        dieName = ((dieNum > 1 and (dieNum .. ' defense dice')) or 'a defense die')
    end
    local out = cmd.giver.steam_name .. ' rolled ' .. dieName .. ': [ '

    if dieType == 'att' or dieType == 'def' then
        local translate = {
            att = { 4, 3, 2, 2, 4, 3, 2, 1 },
            def = { 3, 2, 1, 1, 3, 3, 1, 3 },
        }
        for k, res in pairs(results) do
            results[k] = translate[dieType][res]
        end
    end
    table.sort(results)
    if dieType == 'att' or dieType == 'def' then
        local translate = {
            att = { 'crit', 'hit', 'eye', 'blank' },
            def = { 'evade', 'eye', 'blank' },
        }
        for k, res in pairs(results) do
            results[k] = translate[dieType][res]
        end
    end

    for _, res in ipairs(results) do
        out = out .. res .. ', '
    end
    out = out:sub(1, -3) .. ' ]'
    if dieType ~= 'att' and dieType ~= 'def' and dieNum > 1 then
        local sum = 0
        for _, res in ipairs(results) do
            sum = sum + res
        end
        out = out .. ', sum: ' .. sum
    end
    ChatCmd.RawPrint(cmd)
    printToAll(out, ChatCmd.colors.ok)
end

ChatCmd.AddCommand(
    'help',
    'List all available commands with their usage',
    'everyone'
)
ChatCmd.fcns.help = function(cmd)
    local out = '\nAVAILABLE COMMANDS:\n'
    for _, info in pairs(ChatCmd.commands) do
        out = out .. info.usage .. '\n'
    end
    cmd.giver.print(out, ChatCmd.colors.ok)
end

ChatCmd.Process = function(cmd)
    if ChatCmd.commands[cmd.name] then
        local info = ChatCmd.commands[cmd.name]
        local fcn = info.fcn or ChatCmd.fcns[cmd.name]
        if not ChatCmd.AssertPermissions(cmd.giver, info.permissions) then
            return false
        end
        return fcn(cmd)
    else
        cmd.giver.broadcast('\'' .. cmd.name .. '\' is not a valid command, use ' .. ChatCmd.prefix .. 'help to list all commands', ChatCmd.colors.warn)
        return false
    end
end

assert(onChat == nil, 'ChatCommands lib: redefine onChat event!')
function onChat(msg, player)
    if ChatCmd.IsCommand(msg) then
        if ChatCmd.Process(ChatCmd.DecodeCommand(msg, player)) then
            return true
        else
            return false
        end
    end
end
