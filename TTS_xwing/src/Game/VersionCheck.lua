current_version = 113      -- mod version (workshop update count)
workshop_id = '2486128992' -- mod workshop ID

-- To read above numbers, open your mod workshop page
--  current_version corresponds to XX in "XX Change Notes (view)"
--  (set it to 1 above it when updating the mod)
--  workshop ID is the number following "filedetails/?id=" in the page link

-- A version check is triggered on object load
function onLoad()
    -- script carrier object hiding
    self.interactable = false
    self.tooltip = false
    self.tooltip = false
    self.lock()
    self.setPosition({ 0, -5, 0 })
    CheckVersion()
end

-- Initiate version check
function CheckVersion()
    local req = WebRequest.get('https://steamcommunity.com/sharedfiles/filedetails/?id=' .. workshop_id)
    Wait.condition(
        function() ParseRequest(req) end,
        function() return (req.is_done and not req.is_error) end, 6, ReportCheck)
end

-- Extract version from workshop page request
function ParseRequest(req)
    local parsed_version = tonumber(req.text:match('(%d+) Change Notes'))
    ReportCheck(parsed_version)
end

-- Report status with given workshop version
-- Argument being nil means version coudn't be read
function ReportCheck(workshop_version)
    if not workshop_version then
        printToAll('Couldn\'t read mod version from Steam Workshop', { 0.4, 0.4, 1 })
    elseif workshop_version > current_version then
        broadcastToAll('A newer version of this mod is available on Steam Workshop!', { 1, 0.2, 0.2 })
    elseif workshop_version < current_version then
        -- for mod author convenience
        if current_version - workshop_version == 1 then
            broadcastToAll('Ready to push to Steam Workshop', { 0.2, 1, 1 })
        else
            broadcastToAll('Workshop version more than 1 behind mod version?', { 1, 0.2, 0.2 })
        end
    else
        printToAll('Mod is up to date', { 0.1, 1, 0.1 })
    end
end
