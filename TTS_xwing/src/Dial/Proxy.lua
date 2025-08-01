local obj = self

local P = {}

local active_proxies = {}

local function createOffsets(move_code, offsets)
    local outputs = {}

    if move_code:sub(1, 1) == "r" then
        move_code = move_code:sub(1, 2)
    elseif move_code:sub(1, 1) == "c" then
        move_code = move_code:sub(1, 2)
    elseif move_code:sub(1, 2) == "vt" then
        move_code = move_code:sub(1, 4)
    elseif move_code:sub(1, 1) == "v" then
        move_code = move_code:sub(1, 3)
    elseif move_code:sub(-1, -1) == "t" then
        move_code = move_code:sub(1, 3)
    end

    for c, v in pairs(offsets) do
        outputs[c] = move_code .. v
    end

    return outputs
end

local function isDone(proxy)
    return proxy.state == "term"
end

local function isReady(proxy)
    return proxy.state == "active"
end

local function setActiveProxies(proxies)
    for position, proxy in pairs(proxies) do
        active_proxies[position] = proxy.getGUID()
    end
end

local function unsetActiveProxies()
    active_proxies = {}
end

function P.isActive()
    if not active_proxies then return false end

    for k, v in pairs(active_proxies) do return true end
    return false
end

function P.cancel(ship_guid)
    Global.call("DeleteShipProxies", { ship_guid = ship_guid })
end

function P.isProxyable(move_code)
    if move_code:sub(1, 1) == "r" then
        return true
    elseif move_code:sub(1, 1) == "c" then
        return true
    elseif move_code:sub(1, 1) == "v" then
        return true
    end
    return false
end

function P.spawn(args)
    if P.isActive() then
        printToAll("Please finish this ship's active proxy maneuver before setting another one")
        return
    end

    local ship_guid              = args.ship_guid
    local move_code              = args.move_code
    local offsets                = args.offsets
    local cancellable            = args.cancellable
    local button_func            = args.button_func

    local move_codes             = createOffsets(move_code, offsets)
    local proxy_args             = {
        ship_guid  = ship_guid,
        move_codes = move_codes,
    }

    local proxy_objects, success = Global.call("SpawnProxyOptions", proxy_args)

    if not success then return end

    Wait.condition(function() setActiveProxies(proxy_objects.proxy_table) end, function() return isReady(proxy_objects) end)
    Wait.condition(function() button_func(true, cancellable, active_proxies) end, function() return isReady(proxy_objects) end)
    Wait.condition(unsetActiveProxies, function() return isDone(proxy_objects) end)
    Wait.condition(function() button_func(false) end, function() return isDone(proxy_objects) end)
    Wait.condition(function() obj.setVar("befAft", "_A") end, function() return isDone(proxy_objects) end)
end

return P
