-- PlaymatTile.lua
-- Minimal spawner for reusable Custom_Tile "Playmat" objects.

local M = {}

-- Configure once via M.configure{ ... } in Global/onLoad
local cfg = {
    DummyEpicFace = "https://dummyimage.com/180x90/ffffff",
    DummyStandardFace = "https://dummyimage.com/90x90/ffffff",
    EpicBottom = "https://i.imgur.com/sR2dTak.png",
    StandardBottom = "https://i.imgur.com/ScTLBup.png",
    Scale = { x = 1, y = 1, z = 1 },
    NamePrefix = "Playmat"
}

function M.configure(opts)
    if not opts then
        return
    end
    for k, v in pairs(opts) do
        cfg[k] = v
    end
end

local function spawnTile(name, topURL, bottomURL, pos, rot)
    local o = spawnObject({
        type = "Custom_Tile",
        position = pos or { 0, 2, 0 },
        rotation = rot or { 0, 180, 0 },
        scale = { 1, 1, 1 },
    })
    o.setCustomObject({
        image = topURL,
        image_bottom = bottomURL,
        thickness = 0.05,
        stackable = true,
        type = 3
    })
    o = o.reload() -- ensure images show for all clients
    o.setName(name)
    o.setLock(false)
    o.interactable = true
    o.setScale(cfg.Scale)
    return o
end

local function spawn(isEpic, params)
    params = params or {}
    local name = string.format("%s [%s]", cfg.NamePrefix, isEpic and "Epic 6x3" or "Standard 3x3")
    local top = isEpic and cfg.EpicBottom or cfg.StandardBottom
    local back = isEpic and cfg.DummyEpicFace or cfg.DummyStandardFace
    return spawnTile(name, top, back, params.pos, params.rot)
end

function M.spawnStandard(params)
    return spawn(false, params)
end

function M.spawnEpic(params)
    return spawn(true, params)
end

return M
