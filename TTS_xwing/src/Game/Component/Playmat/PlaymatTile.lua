-- PlaymatTile.lua
-- Minimal spawner for reusable Custom_Tile "Playmat" objects.

local M = {}

-- Configure once via M.configure{ ... } in Global/onLoad
local cfg = {
    DummyEpicFace = "https://dummyimage.com/180x90/000/fff.png",
    DummyStandardFace = "https://dummyimage.com/90x90/000/fff.png",
    EpicTop = "https://i.imgur.com/Xem5plC.png",
    StandardTop = "https://i.imgur.com/ewJMn8c.jpeg",
    Scale = { x = 1 / 2, y = 1 / 2, z = 1 / 2 },
    NamePrefix = "Playmat",
    GMNote = "playmattile",
    Description = [[
Right-Click [b]Custom[/b]. Change [b]Bottom Image[/b]. If prompted to change others, click [b]Cancel[/b].
Drop face-up on a playmat to add the Image.
Drop face-down on a playmat to remove the Image.
]]
}

function M.configure(opts)
    if not opts then
        return
    end
    for k, v in pairs(opts) do
        cfg[k] = v
    end
end

local function spawnTile(name, topURL, bottomURL, params)
    local scale = params.scale or cfg.Scale
    local o = spawnObject({
        type = "Custom_Tile",
        position = params.pos or { 0, 2, 0 },
        rotation = params.rot or { 0, 180, 0 },
        scale = scale
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
    o.setScale(scale)
    o.setGMNotes(cfg.GMNote)
    o.setDescription(cfg.Description)
    return o
end

local function spawn(isEpic, params)
    params = params or {}
    local name = string.format("%s [%s]", cfg.NamePrefix, isEpic and "Epic 6x3" or "Standard 3x3")
    local top = isEpic and cfg.EpicTop or cfg.StandardTop
    local bottom = isEpic and cfg.DummyEpicFace or cfg.DummyStandardFace
    return spawnTile(name, top, bottom, params)
end

function M.spawnStandard(params)
    params.scale = { x = 1 / 2, y = 1, z = 1 / 2 }
    return spawn(false, params)
end

function M.spawnEpic(params)
    params.scale = { x = 1 / 2, y = 1, z = 1 / 2 }
    return spawn(true, params)
end

return M
