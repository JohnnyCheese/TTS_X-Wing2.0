-- Assumes the following are set
--color_by_id = false
--default_arc_direction = "front"
--double_arc = false
local Dim = require("Dim")

function onDropped()
    local spos = self.getPosition()
    local nearest = nil
    local nearest_mount = nil
    local nearest_mount_position = nil
    local minDist = Dim.Convert_mm_igu(100)

    local turretName = "singleturret"
    if double_arc then
        turretName = "double turret"
    end
    for _, ship in pairs(getObjects()) do
        if Global.call("API_IsShipType", { ship = ship }) then
            local turret = ship.getTable('Data').arcs.turret or {}
            for mount, turret in pairs(turret) do
                if turret and mount then
                    if (double_arc and (turret.type[1] == 'doubleturret')) or
                        (not double_arc) and (turret.type[1] ~= 'doubleturret') then
                        local pos = ship.call('GetMountingPosition', { mount = mount })
                        --print("GetMountingPosition " .. mount .. " " .. turret.name .. " " .. tostring(pos))
                        local dist = math.sqrt(math.pow((spos[1] - pos[1]), 2) + math.pow((spos[3] - pos[3]), 2))
                        if dist < minDist then
                            nearest = ship
                            nearest_mount = mount
                            minDist = dist
                            nearest_mount_position = pos
                        end
                    end
                end
            end
        end
    end
    if nearest ~= nil then
        local colorId = nearest.getTable('Data').ColorId
        if color_by_id and (colorId ~= nil) and (colorId.a > 0) then
            self.setColorTint(nearest.getTable('Data').ColorId)
        end
        self.setDescription(nearest_mount)
        self.setPosition(nearest_mount_position + vector(0, 0.15, 0))
        nearest.call("AttachArcIndicator", { indicator = self, mount = nearest_mount })
        --local mount_name = ""
        --if mount ~= "main" then
        --  mount_name = " " .. nearest_mount
        --end
        --if double_arc then
        --  nearest.AddContextMenuItem("Rotate arc" .. mount_name, function(player_color) Global.call("proxyPerformAction", {nearest, 'rotateright', player_color, {mount = nearest_mount} }) end, false)
        --else
        --  nearest.AddContextMenuItem("Rotate arc left" .. mount_name, function(player_color) Global.call("proxyPerformAction", {nearest, 'rotateleft', player_color, {mount = nearest_mount}}) end, false)
        --  nearest.AddContextMenuItem("Rotate arc right" .. mount_name, function(player_color) Global.call("proxyPerformAction", {nearest, 'rotateright', player_color, {mount = nearest_mount}}) end, false)
        --end
        --self.setRotation(nearest.getRotation())
        nearest.addAttachment(self)
    end
end
