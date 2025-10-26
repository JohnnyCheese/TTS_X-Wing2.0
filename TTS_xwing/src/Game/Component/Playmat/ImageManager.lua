-- Game/Component/Playmat/ImageManager.lua
-- Minimal image rotation manager for TTS playmats.
require( "TTS_Lib.Util.Table")
require( "TTS_Lib.Util.String")

local M = {}

local function detectBeforeSwitch(obj, provided)
    if type(provided) == "function" then return provided end
    local f = obj.getVar and (obj.getVar("deleteAll") or obj.getVar("deleteAllEpic"))
    return (type(f) == "function") and f or function() end
end

function M.attach(obj, opts)
    opts = opts or {}
    local state = {
        obj    = obj,
        images = (opts.images and { table.unpack(opts.images) }) or {},
        curr   = tonumber(opts.curr) or 1,
        before = detectBeforeSwitch(obj, opts.beforeSwitch),
    }
    
    local function persist()
        obj.script_state = JSON.encode({ curr = state.curr, images = state.images })
    end
    
    local function clamp()
        if #state.images == 0 then return end
        if state.curr < 1 then state.curr = 1 end
        if state.curr > #state.images then state.curr = #state.images end
    end
    
    local function apply(idx)
        local custom = obj.getCustomObject()
        custom.diffuse = state.images[idx]
        obj.setCustomObject(custom)
        state.curr = idx
        persist()
        obj.reload()
    end
    
    function state:onLoad(saved)
        local s = (type(saved) == "string" and saved ~= "") and saved or obj.script_state
        if type(s) == "string" and s:sub(1,1) == "{" then
            local t = JSON.decode(s) or {}
            if type(t.images) == "table" and #t.images > 0 then
                self.images = t.images
            elseif type(opts.images) == "table" and #opts.images > 0 then
                self.images = { table.unpack(opts.images) }
            end
            self.curr = tonumber(t.curr) or self.curr or 1
        else
            self.curr = tonumber(s) or self.curr or 1 -- legacy numeric
            if (#self.images == 0) and type(opts.images) == "table" then
                self.images = { table.unpack(opts.images) }
            end
        end
        clamp()
    end
    
    function state:onSave()
        return obj.script_state or JSON.encode({ curr = self.curr, images = self.images })
    end
    
    function state:next()
        if #self.images == 0 then return false, "no images" end
        self.before()
        self.curr = (self.curr % #self.images) + 1
        apply(self.curr)
        return true, self.curr
    end
    
    function state:prev()
        if #self.images == 0 then return false, "no images" end
        self.before()
        self.curr = ((self.curr - 2) % #self.images) + 1
        apply(self.curr)
        return true, self.curr
    end
    
    function state:add(arg)
        local url = (type(arg) == "table") and (arg.url or arg[1]) or arg
        if type(url) ~= "string" then return false, "addImage: missing url" end
        url = url:trim()
        local idx = table.index_of and table.index_of(self.images, url)
        if not idx then table.insert(self.images, url); idx = #self.images end
        self.before()
        apply(idx)
        return true, idx
    end
    
    function state:remove(arg)
        local idx, url
        if type(arg) == "number" then
            idx = math.floor(arg)
        else
            url = (type(arg) == "table") and (arg.idx and nil or (arg.url or arg[1])) or arg
            if type(url) == "string" and table.index_of then
                idx = table.index_of(self.images, url:trim())
            end
        end
        if not idx or idx < 1 or idx > #self.images then
            if url then printToAll("removeImage: url not found: " .. tostring(url), Color.Red) end
            return false, "removeImage: not found"
        end
        if #self.images == 1 then return false, "removeImage: cannot remove the last image" end
        
        table.remove(self.images, idx)
        if idx < self.curr then
            self.curr = self.curr - 1
        elseif idx == self.curr then
            self.curr = ((self.curr - 2) % #self.images) + 1
        end
        
        self.before()
        apply(self.curr)
        return true, self.curr
    end
    
    function state:exportGlobals(map)
        map = map or {}
        _G[map.next or "NextImage"]   = function() return state:next() end
        _G[map.prev or "PrevImage"]   = function() return state:prev() end
        _G[map.add  or "addImage"]    = function(a) return state:add(a) end
        _G[map.rem  or "removeImage"] = function(a) return state:remove(a) end
        return self
    end
    
    return state
end

function M.install(obj, opts)
    return M.attach(obj, opts):exportGlobals(opts and opts.export)
end

return M
