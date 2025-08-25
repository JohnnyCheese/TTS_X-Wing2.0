-- the stub you set with setLuaScript:
-- obj.setLuaScript('require("PilotCard").attach(_G)'); obj.reload()

function castRayBelow(opts)
    opts                = opts or {}
    local origin_offset = opts.origin_offset or 2
    local max_distance  = opts.max_distance or 8
    local debug_draw    = opts.debug or false
    return function(ctx)
        local o = ctx.source
        local hits = Physics.cast({
            origin       = o.getPosition(), -- + Vector(0, origin_offset, 0),
            direction    = Vector(0, -1, 0),
            type         = 1,               -- Ray
            max_distance = max_distance,
            debug        = debug_draw
        })
        ctx.hits = hits
        return hits
    end
end

local function isPlaymat(o)
    return o.getVar("__XW_Mat") == true
end

local function handleDrop()
    local hits = castRayBelow({ origin_offset = 0.5, max_distance = 1, debug = true })({ source = self })
    for _, h in ipairs(hits) do
        if isPlaymat(h.hit_object) then
            local playmat = h.hit_object
            local url     = self.getCustomObject().image_bottom
            if playmat.getVar("addImage") == nil then
                printToAll("This Playmat doesn't currently support custom images.", { 1, 0, 0 })
                return
            end
            if self.is_face_down then
                playmat.call("addImage", { url = url })
            else
                playmat.call("removeImage", { url = url })
            end
            return
        end
    end
end

function onDrop()
    Wait.condition(function()
        handleDrop()
    end, function() return self.resting end)
end
