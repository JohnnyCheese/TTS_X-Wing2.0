-- Save self state
function onSave()
    local state = { shipData = self.getTable("Data") }
    return JSON.encode(state)
end

-- Restore self state
function onLoad(savedData)
    if savedData ~= "" then
        self.setTable("Data", JSON.decode(savedData).shipData)
    end
    self.addContextMenuItem("Enable", function(argument) setHyperspaceEnabled(true) end, false)
    self.addContextMenuItem("Disable", function(argument) setHyperspaceEnabled(false) end, false)
end

function setHyperspaceEnabled(isEnabled)
    data = self.getTable("Data") or {}
    data.enabled = isEnabled
    self.setTable("Data", data)
end

function getHyperspaceEnabled()
    data = self.getTable("Data") or {}
    return data.enabled or false
end

---

-- constant data - no need to save/restore

exit_point = {
    eye   = { x = 3.0, y = 0, z = 0, angle = 0, backangle = 180 },
    blank = { x = -1.5, y = 0, z = 2.6, angle = 120, backangle = 60 },
    hit   = { x = -1.5, y = 0, z = -2.6, angle = -120, backangle = -60 }
}

---
function onCollisionEnter(collision_info)
    if not self.getLock() or not getHyperspaceEnabled() then
        return
    end
    obj = collision_info.collision_object
    if obj.type ~= 'Figurine' or obj.getLock() then
        return
    end
    local size = obj.getTable("Data").Size

    hyperspace_exit = 'eye'
    if #collision_info.contact_points > 0 then
        contact = self.positionToLocal(collision_info.contact_points[1])
        dists = {}
        for k, v in pairs(exit_point) do
            table.insert(dists, { name = k, dist = vectorDistSq(v, contact) })
        end
        table.sort(dists, function(a, b) return a.dist < b.dist end)
        hyperspace_exit = dists[1].name
    end
    -- debugOutput('exit point',hyperspace_exit)
    distance = 0.47
    if size == "medium" then
        distance = 0.575
    elseif size == "large" then
        distance = 0.67
    end
    angle = exit_point[hyperspace_exit].angle
    -- debugOutput('dist',distance)
    -- debugOutput('angle',angle)
    pos = { distance * math.cos(angle * math.pi / 180), 0, distance * math.sin(angle * math.pi / 180) }
    if self.is_face_down then
        angle = exit_point[hyperspace_exit].backangle
    end
    rot = { 0, self.getRotation().y - 90 - angle, 0 }

    obj.setRotationSmooth(rot, false, true)
    obj.setPositionSmooth(self.positionToWorld(pos), false, true)
    obj.setLock(true)
end

function debugOutput(tag, obj)
    success, msg = pcall(function(o) broadcastToAll(tag .. ': ' .. JSON.encode(obj)) end, obj)
    if not success then broadcastToAll('Error: ' .. msg) end
end

function vectorDistSq(a, b)
    x = a.x - b.x
    y = a.y - b.y
    z = a.z - b.z
    return x * x + y * y + z * z
end
